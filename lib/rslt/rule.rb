# frozen_string_literal: true

module Rslt
  class Rule
    attr_reader :stylesheet, :element, :block, :selector

    def initialize(stylesheet, selector, extensions, &block)
      @stylesheet = stylesheet
      @selector = selector
      @extensions = extensions
      @block = block
    end

    def matching_elements(document)
      @selector_cache ||= document.css(@selector)
    end

    def applies_to_element?(document)
      matching_elements(document).include? element
    end

    def matches?(element, document)
      @element = element
      if applies_to_element? document
        self # if it matches, nil otherwise
      end
    end

    def generate(builder)
      # Call the block in the elements context
      wrapper = ElementWrapper.new(stylesheet, element, builder)
      @extensions.each { |e| wrapper.extend e }
      wrapper.instance_eval(&@block)
    rescue Exception => e
      if e.message =~ /With selector '.*' and included modules/
        raise e
      else
        modules = "#{@extensions.inspect}\n#{e.message}\n#{e.backtrace.join("\n")}"
        raise e.class, "With selector '#{selector}' and included modules: #{modules}"
      end
    end
  end
end
