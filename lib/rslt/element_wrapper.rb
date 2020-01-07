# frozen_string_literal: true

module RSLT
  class ElementWrapper
    attr_reader :element, :builder, :stylesheet

    def initialize(stylesheet, element, builder)
      @stylesheet = stylesheet
      @element = element
      @builder = builder
    end

    def child_content(selector = nil)
      elements = selector ? @element.css(selector) : @element.children
      elements.each do |child|
        stylesheet.generate_element(child)
      end
    end

    def method_missing(sym, *args)
      @element.send(sym, *args)
    rescue Exception => e
      message = "#{e.message}\n\n#{e.backtrace.join("\n")}"
      raise e.exception("Error delegating method '#{sym}' to #{@element.class.name}: #{message}")
    end

    def add(*content)
      @builder << content.join('')
    end

    def error(string)
      stylesheet.errors << string
    end
  end
end
