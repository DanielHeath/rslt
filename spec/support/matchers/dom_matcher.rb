require 'nokogiri'

RSpec::Matchers.define :match_the_dom_of do |expected_xml_string|
  
  def describe(string)
    string ? string.to_s.gsub('"', "'").strip.inspect : 'NIL'
  end
  
  failure_message_for_should_not do |actual|
    "expected that #{describe(actual)} would not match the dom of #{describe(expected)}"
  end

  failure_message_for_should do |actual|
    <<-MESSAGE

expected first, but got second: 
#{describe(expected) }
#{describe(actual) }

  (compared using Nokogiri::XML::Node#==)
  MESSAGE
  end

  failure_message_for_should_not do |actual|
    <<-MESSAGE

expected actual not to equal expected:
#{describe(expected) }
#{describe(actual) }

  (compared using Nokogiri::XML::Node#==)
  MESSAGE
  end

  match do |actual_xml_string|
    begin
      container_document = Nokogiri::XML("<container/>")
      expected = container_document.root.add_child(expected_xml_string)
      actual   = container_document.root.add_child(actual_xml_string)
    rescue NoMethodError
      # Returns false immediately.
      next false
    end
    expected == actual
  end
end
