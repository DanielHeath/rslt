require 'spec_helper'

describe RSLT::ElementWrapper do

  before do
    @stylesheet = Object.new
    @element = Object.new
    @builder = Object.new
    @wrapper = RSLT::ElementWrapper.new(@stylesheet, @element, @builder)
  end

  describe "passing through method calls" do
    describe "when an error is raised in a passed through call" do
      it "should raise an error" do
        expect {
          @wrapper.foo
        }.to raise_error(NoMethodError)
      end
    end
  end

end
