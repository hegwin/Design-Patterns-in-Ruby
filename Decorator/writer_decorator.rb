require 'forwardable'

class SimpleWriter
  def initialize(path)
    @file = File.open(path, 'w')
  end

  def write_line(line)
    @file.print line
    @file.print "\n"
  end

  def pos
    @file.pos
  end

  def rewind
    @file.rewind
  end

  def close
    @file.close
  end
end

class WriterDecorator
  extend Forwardable

  def_delegators :@real_writer, :write_line, :pos, :rewind, :close

  def initialize(real_writer)
    @real_writer = real_writer
  end
end

class NumberingWriter < WriterDecorator
  def initialize(real_writer)
    @line_number = 1
    super
  end

  def write_line(line)
    @real_writer.write_line "#{@line_number}\t#{line}"
    @line_number += 1
  end
end

class TimestampWriter < WriterDecorator
  def write_line(line)
    @real_writer.write_line "#{Time.now}\t#{line}"
  end
end

class CheckSummingWriter < WriterDecorator
  attr_reader :char_sum

  def initialize(real_writer)
    @char_sum = 0
    super
  end

  def write_line(line)
    @char_sum += line.length
    @real_writer.write_line line
  end
end

writer = CheckSummingWriter.new(TimestampWriter.new(NumberingWriter.new SimpleWriter.new('log.txt')))
writer.write_line('Hello')
writer.write_line('This is Cat')

p writer.char_sum
writer.close
