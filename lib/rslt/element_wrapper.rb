module RSLT
  class ElementWrapper

    attr_reader :element, :builder, :stylesheet

    def initialize(stylesheet, element, builder)
      @stylesheet = stylesheet
      @element = element
      @builder = builder
    end

    def child_content(selector=nil)
      elements = selector ? @element.css(selector) : @element.children
      elements.map do |child|
        stylesheet.generate_element(child)
      end.join
    end

    def method_missing(sym, *args)
      begin
        @element.send(sym, *args)
      rescue Exception => e
        raise e.exception("Error delegating method '#{sym}' to #{@element.class.name}: #{e.message}\n\n#{e.backtrace.join("\n")}")
      end
    end

    def add(*content)
      @builder << content.join('')
    end

    def error(string)
      stylesheet.errors << string
    end

  end

end
