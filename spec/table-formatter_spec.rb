# frozen_string_literal: true

require 'spec_helper'

RSpec.describe TableFormatter do
  describe 'formatting Markdown table' do
    context 'when source values include newline code' do
      specify 'newline code should be replaced with \'<br>\'' do
        formatter = TableFormatter.new(
          labels: ['foo', 'bar', 'baz'],
          source: [["foo0\nfoo1", "bar0\nbar1\n", "\nbaz0\nbaz1"]],
          markdown: true
        )
        expect(formatter.display).to eq <<~'CODE'
          | foo          | bar              | baz              |
          |:-------------|:-----------------|:-----------------|
          | foo0<br>foo1 | bar0<br>bar1<br> | <br>baz0<br>baz1 |
        CODE
      end

      specify 'vertical bar \'|\' should be replaced with \'&#124;\'' do
        formatter = TableFormatter.new(
          labels: ['foo', 'bar', 'baz'],
          source: [['foo0|foo1', 'bar0|bar1|', '|baz0|baz1']],
          markdown: true
        )
        expect(formatter.display).to eq <<~'CODE'
          | foo            | bar                  | baz                  |
          |:---------------|:---------------------|:---------------------|
          | foo0&#124;foo1 | bar0&#124;bar1&#124; | &#124;baz0&#124;baz1 |
        CODE
      end
    end
  end
end
