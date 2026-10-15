require 'gem'
string = "a string"
symbol = :symbol
fixnum = 666
float = 0.00
array = Array.new
array = ["black", 'metal', 666]
hash = { beast: 666, "666" => "beast" }
regex = /[abc]/

# this is a comment
class Person
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def self.greet
    "Hail"
  end
end

person1 = Person.new(name: "Varg")
puts Person::greet, " ", person1.name, "In"
