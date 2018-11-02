require_relative '../lib/file_finder'

PATH = ARGV[0]

raise RuntimeError, 'Path not specified!' if PATH.nil?

class Parser
  def initialize(text)
    @tokens = text.scan /\(\)|[\w\.\*]+/
  end

  def expression
    token = next_token

    return nil if token.nil?

    case token
    when '('
      result = expression
      raise 'Expected )' unless next_token == ')'
    when 'all'
      return All.new
    when 'writable'
      return Writable.new
    when 'bigger_than'
      return BigFile.new(next_token.to_i)
    when 'filename'
      return FileName.new(next_token)
    when 'not'
      return Not.new(expression)
    when 'and'
      return And.new([expression, expression])
    when 'or'
      return Or.new([expression, expression])
    else
      raise "Unexpected Token: #{token}"
    end
  end

  private

  def next_token
    @tokens.shift
  end
end

parser = Parser.new "and (and (bigger_than 1024) ( filename *.pdf )) writable"

expression = parser.expression
p expression.evaluate(PATH)
