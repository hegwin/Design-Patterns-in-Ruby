require_relative '../lib/file_finder'

# PATH = ARGV[0]

# raise RuntimeError, 'Path not specified!' if PATH.nil?

def all
  All.new
end

def bigger_than(size)
  BigFile.new(size)
end

def name(pattern)
  FileName.new(pattern)
end

def except(expression)
  Not.new(expression)
end

def writable
  Writable.new
end

class Expression
  def |(other)
    Or.new([self, other])
  end

  def &(other)
    And.new([self, other])
  end
end

# big_pdf_files = bigger_than(2000) & name('*.pdf')
# p big_pdf_files.evaluate(PATH)
