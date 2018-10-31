require 'find'

PATH = ARGV[0]

raise RuntimeError, 'Path not specified!' if PATH.nil?

class Expression; end

class All < Expression
  def evaluate(dir)
    results = []

    Find.find(dir) do |p|
      next unless File.file? p
      results << p
    end

    results
  end
end

# expr_all = All.new
# files = expr_all.evaluate(PATH)
# p files

class FileName < Expression
  def initialize(pattern)
    @pattern = pattern
  end

  def evaluate(dir)
    results = []

    Find.find(dir) do |p|
      next unless File.file? p
      name = File.basename p
      results << p if File.fnmatch(@pattern, name)
    end

    results
  end
end

# expr_pdf = FileName.new '*.pdf'
# pdf_files = expr_pdf.evaluate(PATH)
# p pdf_files

class BigFile < Expression
  def initialize(size)
    @size = size
  end

  def evaluate(dir)
    results = []

    Find.find(dir) do |p|
      next unless File.file? p
      results << p if File.size(p) > @size
    end

    results
  end
end

class Writable < Expression
  def evaluate(dir)
    results = []
    
    Find.find(dir) do |p|
      next unless Find.file?(p)
      results << p if File.writable(p)
    end

    results
  end
end

class Not < Expression
  def initialize(expression)
    @expression = expression
  end

  def evaluate(dir)
    All.new.evaluate(dir) - @expression.evaluate(dir)
  end
end

# small_expr = Not.new BigFile.new(512 * 1024)
# small_files = small_expr.evaluate(PATH)
# p 'Small Files:', small_files

class And < Expression
  def initialize(expressions=[])
    @expressions = expressions
  end

  def evaluate(dir)
    @expressions.map {|expression| expression.evaluate(dir) }.reduce(:&)
  end
end

# small_pdf_expr = And.new [ small_expr, expr_pdf ]
# small_pdf_files = small_pdf_expr.evaluate(PATH)
# p 'Small PDF files:', small_pdf_files

class Or < Expression
  def initialize(expressions=[])
    @expressions = expressions
  end

  def evaluate(dir)
    @expressions.map {|expression| expression.evaluate(dir) }.reduce(:+).sort.uniq
  end
end

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

big_pdf_files = bigger_than(2000) & name('*.pdf')
p big_pdf_files.evaluate(PATH)
