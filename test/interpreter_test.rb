require 'test_helper'
require_relative '../lib/interpreter'

class InterpreterTest < ActiveSupport::TestCase

    box_output = <<HTML

<div class='box'>
  <div class='box'>
    <div class='box'>
      <div class='box'>
        something
      </div>
    </div>
  </div>
</div>
HTML

  test "the truth" do
    ops = ["something", "BOX", "BOX", "BOX", "BOX"]
    assert_equal(Interpreter.parse(ops), box_output)
  end
end
