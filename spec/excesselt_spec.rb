# frozen_string_literal: true

require File.dirname(__FILE__) + '/spec_helper.rb'
require 'json'
describe 'rslt' do
  describe 'When a developer wants to transform their hello world xml' do
    before do
      module TestHelper
        def error_text_in_parent(options = nil)
          error("Text is not allowed within a parent node! Options were #{options.to_json}") unless text.strip == ''
        end

        def uppercase_text
          add text.upcase
        end

        def text
          to_xml
        end
      end

      @stylesheet = Class.new(Rslt::Stylesheet) do
        def rules
          render('parent > child')     { builder.p(style: 'child_content') { child_content } }
          render('parent')             { builder.p(style: 'parent_content') { child_content } }
          helper TestHelper do
            render('parent.explode > text()', with: :a_method_that_doesnt_exist)
            within 'parent' do
              render('> text()', with: :error_text_in_parent, passing: 'a custom option')
            end
            render('text()', with: :uppercase_text)
          end
        end
      end
    end

    it 'should transform a hello world document according to a stylesheet' do
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
      expect(@stylesheet.transform(xml)).to match_the_dom_of(expected)
    end

    it 'should ignore comments' do
      xml = <<-XML
        <parent>
          <!-- Ignore me -->
        </parent>
      XML
      expected = <<-EXPECTED
        <p style="parent_content"/>
      EXPECTED
      expect(@stylesheet.transform(xml)).to match_the_dom_of(expected)
    end

    it 'should transform a goodbye document according to a stylesheet' do
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
      expect(@stylesheet.transform(xml)).to match_the_dom_of(expected)
    end

    describe 'error handling' do
      it 'should record errors encountered during processing' do
        xml = <<-XML
          <parent>foo</parent>
        XML
        @instance = @stylesheet.new
        @instance.transform(xml)
        expect(@instance.errors).to eql(
          ['Text is not allowed within a parent node! Options were {"passing":"a custom option"}']
        )
      end

      it 'should record errors encountered during processing' do
        xml = <<-XML
          <parent><unexpected></unexpected></parent>
        XML
        @instance = @stylesheet.new
        expect { @instance.transform(xml) }.to(raise_exception do |e|
          message = e.message
          expect(message).to match(/With selector '.*' and included modules: \[TestHelper\]/)
          expect(message).to match(/There is no style defined to handle this element/)
          expect(message).to match(/CSS Path: 'parent > unexpected'/)
          expect(message).to match(%r{Xpath: '/parent/unexpected'})
          expect(message).to match(/Context: 'document, parent'/)
        end)
      end
    end
  end

  # This section showcases the use of Rslt::Stylesheet#safe_helper.
  # If you're interested in the origins of `safe_helper`, check out:
  # - https://trello.com/c/HVJmdbLz (LP access only)
  # - https://github.com/lonelyplanet/rslt/pull/2
  describe 'safe processing' do
    before do
      module T800
        def emit(label = '(unlabeled)')
          add "#{label}: come with me if you want to live"
        end
      end

      module T1000
        def emit(label = '(unlabeled)')
          add "#{label}: say... that's a nice bike..."
        end
      end

      class HelperClass < Rslt::Stylesheet
        def rules
          within 'bundle' do
            # if `safe_helper` was `helper`, we could `T800#emit` here
            render('>text():first', w1th: :emit) { child_content }

            safe_helper T800 do
              # if `safe_helper` was `helper`, we would `T1000#emit` here
              render('>parent') do
                emit('nested T800')
                child_content
              end

              safe_helper T800, T1000 do
                within '>parent' do
                  render('>parent') do
                    emit('nested T1000')
                    child_content
                  end
                end
              end
              # if if `safe_helper` was `helper`, `emit` would be missing'
              # render('child')                     { emit('after nested T800') }
            end
          end

          render('bundle, parent, child, text()') { child_content }
        end
      end
    end

    let(:stylesheet) { HelperClass.new(builder: []) }

    let(:xml) do
      <<-XML
      <bundle>
        <parent>
            <parent>
              <child/>
            </parent>
          </parent>
        </bundle>
      XML
    end

    let(:results) do
      stylesheet.transform(xml.strip)
      stylesheet.builder
    end

    {
      'T800' => 'come with me if you want to live',
      'T1000' => "say... that's a nice bike"
    }.each_pair do |who, what|
      it "#{who} always says \"#{what}\"" do
        hits = results.select { |r| r.include? what }
        expect(hits).to eq(hits.select { |h| h.include? who })
      end
    end

    describe 'error handling' do
      let(:xml) { '<parent><unexpected></unexpected></parent>' }

      it 'should record errors encountered during processing' do
        expect { results }.to raise_error do |error|
          expect(error.message).to match(/With selector '.*' and included modules: \[\]/)
        end
      end
    end
  end
end
