# Suppose you have an Encrypter class
# It reads and encrypts char one by one from a file and outputs to another file
class Encrypter
  def initialize(key)
    @key = key.unpack('U*')
  end

  def encrypt(reader, writer)
    key_index = 0
    while !reader.eof?
      clear_char = reader.getc
      encrypted_char = (clear_char.ord ^ @key[key_index]).chr
      writer.putc(encrypted_char)
      key_index = (key_index + 1) % @key.length
    end
  end
end

begin
  reader = File.open('message.txt')
  writer = File.open('message.encrypted.txt', 'w')
  encrypter = Encrypter.new('my secret key')
  encrypter.encrypt(reader, writer)
ensure
  reader.close
  writer.close
end


# What if we need encrypt a string instead of a file?
class StringIOAdapter
  def initialize(string)
    @string = string
    @position = 0
  end

  def getc
    raise EOFError if eof?
    char = @string[@position]
    @position += 1
    char
  end

  def eof?
    @position >= @string.length
  end
end

begin
  string = StringIOAdapter.new('This is a secret I will not tell others')
  output = File.open('string.encrypted.txt', 'w')
  encrypter = Encrypter.new('my secret key')
  encrypter.encrypt(string, output)
ensure
  output.close
end
