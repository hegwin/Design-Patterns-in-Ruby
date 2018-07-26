require 'madeleine'

class Employee
  attr_accessor :number, :name, :address

  def initialize(number, name, address)
    @number  = number
    @name    = name
    @address = address
  end

  def to_s
    "Employee: #{number} name: #{name} addr: #{address}"
  end
end

class EmployeeManager
  def initialize
    @employees = {}
  end

  def add_employee(e)
    @employees[e.number] = e
  end

  def delete_employ(number)
    @employees.delete(number)
  end

  def change_address(number, new_address)
    employee = find_employee number
    raise 'No Such Employee' if employee.nil?
    employee.address = new_address
  end

  def find_employee(number)
    @employees[number]
  end
end

class AddEmployee
  def initialize(employee)
    @employee = employee
  end

  def execute(system)
    system.add_employee @employee
  end
end

class DeleteEmployee
  def initialize(number)
    @number = number
  end

  def execute(system)
    system.delete_employ @number
  end
end

class ChangeAddress
  def initialize(number, address)
    @number = number
    @address = address
  end

  def execute(system)
    system.change_address @number, @address
  end
end

class FindEmployee
  def initialize(number)
    @number = number
  end

  def execute(system)
    system.find_employee @number
  end
end

store = SnapshotMadeleine.new('employees') { EmployeeManager.new }

Thread.new do
  while true
    sleep 20
    store.take_snapshot
  end
end

tom   = Employee.new '1001', 'tom', '1 Division Street'
harry = Employee.new '1002', 'harry', '3435 Sunnyside Ave'

store.execute_command AddEmployee.new(tom)
store.execute_command AddEmployee.new(harry)

puts store.execute_command FindEmployee.new('1001')
puts store.execute_command FindEmployee.new('1002')

store.execute_command ChangeAddress.new('1001', '555 Main Street')

puts store.execute_command FindEmployee.new('1001')
