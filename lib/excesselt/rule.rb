module Excesselt
  class Rule
    
    attr_reader :stylesheet, :element, :block, :selector

    def initialize(stylesheet, selector, extensions, &block)
      @stylesheet = stylesheet
      @selector = selector
      @extensions = extensions
      @block = block
    end
    
    def matching_elements(document)
      @selector_cache ||= {}
      @selector_cache[document] ||= document.css(@selector)
    end
    
    def applies_to_element?
      matching_elements(element.document).include? element
    end
    
    def matches?(element)
      @element = element
      if applies_to_element?
        self # if it matches, nil otherwise
      else
        nil
      end
    end
    
    def generate(builder)
      # Call the block in the elements context
      wrapper = ElementWrapper.new(stylesheet, element, builder)
      @extensions.each {|e| wrapper.extend e }
      wrapper.instance_eval(&@block)
    rescue Exception => e
      if e.message =~ /With selector .* and included modules/
        raise e
      else
        raise e.class, "With selector #{selector} and included modules: #{@extensions.inspect}\n#{e.message}\n#{e.backtrace.join("\n")}"
      end
    end
    
  end
end