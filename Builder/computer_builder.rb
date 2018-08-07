class CPU
  # ...
end

class BasicCPU < CPU; end
class TurboCPU < CPU; end

class MotherBoard
  attr_accessor :cpu
  attr_accessor :memory_size

  def initialize(cpu=BasicCPU.new, memory_size=1024)
    @cpu = cpu
    @memory_size = memory_size
  end
end

class Drive
  attr_reader :type # :hard_disk, :dvd or :camera
  attr_reader :size # in MB
  attr_reader :writable # true if this drive is writable

  def initialize(type, size, writable)
    @type = type
    @size = size
    @writable = writable
  end
end

class Computer
  attr_accessor :display, :motherboard
  attr_reader :drives

  def initialize(display=:crt, motherboard=MotherBoard.new, drives=[])
    @display = display
    @motherboard = motherboard
    @drives = drives
  end
end

class ComputerBuilder
  def initialize
    @computer = Computer.new
  end

  def reset
    @computer = Computer.new
  end

  def computer
    raise 'Not enough memory' if @computer.motherboard.memory_size < 250
    raise 'Too many drives' if @computer.drives.size > 4
    raise 'No hard disk' unless @computer.drives.find {|drive| drive.type == :hard_disk }

    @computer
  end

  def display=(display)
    @computer.display = display
  end

  def turbo(has_turbo_cpu=true)
    @computer.motherboard.cpu = TurboCPU.new
  end

  def memory_size=(size_in_mb)
    @computer.motherboard.memory_size = size_in_mb
  end

  def add_hard_disk(size_in_mb)
    @computer.drives << Drive.new(:hard_disk, size_in_mb, true)
  end

  def add_dvd(writer=false)
    @computer.drives << Drive.new(:dvd, 760, writer)
  end

  def add_camera(writer=false)
    @computer.drives << Drive.new(:camera, 1000, writer)
  end

  def method_missing(name, *args)
    words = name.to_s.split '_'
    words.each do |word|
      next if word == 'add'
      self.display = :lcd if word == 'lcd'
      add_dvd if word == 'dvd'
      add_carema if word == 'carema'
      add_hard_disk(320_000) if word == 'harddisk'
      turbo if word == 'turbo'
    end
  end
end


builder = ComputerBuilder.new

builder.turbo
builder.add_dvd(true)
builder.add_camera
builder.add_hard_disk(400_000)

computer = builder.computer
p computer

builder.reset

builder.add_lcd_and_dvd_and_harddisk
another_computer = builder.computer
p another_computer
