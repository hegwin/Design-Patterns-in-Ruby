class AdapterGenerator
  def initialize(name)
    @class_name = "#{name.capitalize}Adapter"
    @file_name = File.join(File.dirname(__FILE__), '..', 'adapters', name + '.rb')
  end

  def scaffold
%Q{class #{@class_name}
  def send_message(message)
    # Implement you message sending here!
  end
end}
  end

  def execute!
    File.open(@file_name, 'w') do |f|
      f.write(scaffold)
    end
  end
end

AdapterGenerator.new(ARGV[0]).execute!
