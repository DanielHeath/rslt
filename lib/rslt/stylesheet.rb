require 'active_support/core_ext/hash/except' rescue nil
require 'builder'

module RSLT
  class Stylesheet

    attr_reader :builder, :errors

    def self.transform(xml)
      self.new.transform(xml)
    end

    def initialize(options={})
      @builder = options[:builder] || Builder::XmlMarkup.new
      @helper_modules = options[:helper_modules] || []
      @errors = options[:errors] || []
      @within = []
    end

    # Pass in a string or a Nokogiri Node or Document.
    def transform(xml)
      xml = xml.root if xml.is_a? Nokogiri::XML::Document
      xml = Nokogiri::XML(xml, nil, nil, Nokogiri::XML::ParseOptions.new).root unless xml.is_a? Nokogiri::XML::Node
      generate_element(xml)
    end

    def generate_element(element)
      return '' if element.instance_of? Nokogiri::XML::Comment
      rule = rule_for(element)
      raise "Attempted to generate #{self.name} with parents #{self.parents.inspect} but no rule was found." unless rule
      rule.generate(builder)
    end

    private

    def rule_for(element)
      # Look up the rule that is used to render this.
      # Should fold into stylesheet.rules (collection) .find(:matches?, element)
      # TODO: Patch enumerable#find etc to take a plain symbol and some arguments?
      rule = get_rules.find {|rule| rule.matches? element }

      rule or raise [
        "There is no style defined to handle this element.",
        "CSS Path: '#{element.css_path}'",
        "Xpath: '#{element.path}'",
        "Context: '#{element.ancestors.map(&:name).reverse.join(", ")}'"
      ].join("\n")
    end

    def helper(*mods, &block)
      @helper_modules.push(mods).flatten!
      block.call
      @helper_modules -= [mods].flatten
    end

    def within(selector)
      @within.push(selector)
      yield
      @within.pop
    end

    def selector_for_current_within
      @within.map {|e| e + ' '}.join('')
    end

    def render(selector, opts={}, &block)
      raise "Neither a block nor a :with option were provided for '#{selector}'" unless (opts[:with] or block)
      mappings << Rule.new(self, selector_for_current_within + selector, @helper_modules) do
        if opts[:with]
          if method(opts[:with]).arity == 0
            self.send(opts[:with])
          else
            self.send(opts[:with], opts.except(:with))
          end
        else
          instance_eval &block
        end
      end
    end

    def mappings
      @mappings ||= []
    end

    def get_rules
      unless @rules_generated
        rules # Generates the mappings
        @rules_generated = true
      end
      mappings
    end

  end
end
