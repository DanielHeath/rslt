require File.dirname(__FILE__) + '/spec_helper.rb'

describe "excesselt" do
  
  describe "When a developer wants to transform their hello world xml" do
    before do
      
      @xml = <<-XML
        <parent>
          <child>Some Text</child>
        </parent>
      XML
      
      @stylesheet = Class.new(Excesselt::Stylesheet) do
        def rules
          render('parent > child')     { builder.p(child_content, :style => "child_content")  }
          render('parent')             { builder.p(child_content, :style => "parent_content") }
          render('text()')             { _ node.to_xml.upcase                                 }
        end
      end
      
    end
    it "should transform xml according to a stylesheet" do
      @stylesheet.transform(@xml).should match_the_dom_of <<-EXPECTED
        <p style="parent_content">
          <p style="child_content">SOME TEXT</p>
        </p>
      EXPECTED
    end
  end
  
end
