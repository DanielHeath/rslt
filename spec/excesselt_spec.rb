require File.dirname(__FILE__) + '/spec_helper.rb'

describe "excesselt" do
  
  describe "When a developer wants to transform their hello world xml" do
    before do
      
      @xml = 
      
      @stylesheet = Class.new(Excesselt::Stylesheet) do
        def rules
          render('parent > child')     { builder.p(:style => "child_content" ) { child_content } }
          render('parent')             { builder.p(:style => "parent_content") { child_content } }
          render('text()')             { _ self.to_xml.upcase                                    }
        end
      end
      
    end
    
    it "should transform a hello world document according to a stylesheet" do
      xml = <<-XML
        <parent>
          <child>Hello World</child>
        </parent>
      XML
      expected = <<-EXPECTED
        <p style="parent_content">
          <p style="child_content">HELLO WORLD</p>
        </p>
      EXPECTED
      @stylesheet.transform(xml).should match_the_dom_of(expected)
    end
    
    it "should transform a goodbye document according to a stylesheet" do
      xml = <<-XML
        <parent>
          <parent>
            <child>Goodbye</child>
          </parent>
        </parent>
      XML
      expected = <<-EXPECTED
        <p style="parent_content" >
          <p style="parent_content" >
            <p style="child_content" >
              GOODBYE
            </p>
          </p>            
        </p>
      EXPECTED
      @stylesheet.transform(xml).should match_the_dom_of(expected)
    end
  end
  
end
