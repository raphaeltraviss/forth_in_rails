module Interpreter
  RenderState = Struct.new(:html, :depth, :remaining_ops)

  def self.parse(rpn_bytecode)
    start_state = RenderState.new("", 0, rpn_bytecode.reverse())
    render(start_state)[:html] + "\n"
  end

  def self.render(curr_state)
    return curr_state[:html] if curr_state[:remaining_ops].empty?

    content, depth, ops = curr_state.values
    curr_op, *next_ops = ops
    next_depth = depth + 1

    # Each op prints out a line: before each, return and indent.
    spaces = "  " * depth
    newline = "\n#{spaces}"

    case curr_op
    when 'AND'
      l_state = RenderState.new("", next_depth, next_ops)
      l_result = render(l_state)
      r_state = RenderState.new("", next_depth, l_result[:remaining_ops])
      r_result = render(r_state)
      content = "#{newline}<div class='container'>#{l_result[:html]}#{r_result[:html]}#{newline}</div>"
      return RenderState.new(content, next_depth, r_result[:remaining_ops])
    when 'BOX'
      child_state = RenderState.new("", next_depth, next_ops)
      child_result = render(child_state)
      content = "#{newline}<div class='box'>#{child_result[:html]}#{newline}</div>"
      return RenderState.new(content, next_depth, child_result[:remaining_ops])
    when 'CARD'
      child_state = RenderState.new("", next_depth, next_ops)
      child_result = render(child_state)
      content = "#{newline}<div class='card'>#{child_result[:html]}#{newline}</div>"
      return RenderState.new(content, next_depth, child_result[:remaining_ops])
    else
      return RenderState.new("#{newline}#{curr_op}", next_depth, next_ops)
    end
  end
end
