require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

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

  def hash_for(string)
    Hash.from_xml("<container>#{string.to_s.gsub('  ', '').gsub("\n", '')}</container>")['container']
  end

  match do |actual_xml_string|
    expected_hash = hash_for(expected_xml_string)
    actual_hash = hash_for(actual_xml_string)
    expected_hash == actual_hash
  end
end
