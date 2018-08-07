require 'observer'

class Employee
  include Observable

  attr_reader :name, :address, :salary

  def initialize(name, address, salary)
    @name = name
    @address = address
    @salary = salary
  end

  def salary=(new_salary)
    if @salary != new_salary
      @salary = new_salary
      changed
      notify_observers(self)
    end
  end

  def address=(new_address)
    return if @address == new_address
    @address = new_address
    changed
    notify_observers(self)
  end
end

class Payroll
  def update(subject)
    p "#{subject.name}'s new salary is #{subject.salary}!"
  end
end

class TaxMan
  def update(subject)
    if subject.salary > 4000
      p "Tax is #{subject.salary * 0.05}"
    end
  end
end

employee = Employee.new('Jane', '618 May Street', 3000)
payroll = Payroll.new
tax_man = TaxMan.new

employee.add_observer payroll
employee.add_observer tax_man

p employee.count_observers

employee.salary = 3500
employee.salary = 4200
