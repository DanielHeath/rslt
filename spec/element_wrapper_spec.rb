# frozen_string_literal: true

require 'spec_helper'

describe Rslt::ElementWrapper do
  before do
    @stylesheet = Object.new
    @element = Object.new
    @builder = Object.new
    @wrapper = Rslt::ElementWrapper.new(@stylesheet, @element, @builder)
  end

  describe 'passing through method calls' do
    describe 'when an error is raised in a passed through call' do
      it 'should raise an error' do
        expect do
          @wrapper.foo
        end.to raise_error(NoMethodError)
      end
    end
  end
end
