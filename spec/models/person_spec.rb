require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:frodo) {
    Person.create(
      :first_name => "Frodo",
      :last_name => "Baggins",
      :email => "masterfrodo@hobbitmail.com",
      :age => 50
    )
  }

  it "is valid with a first name, last name, email, and age" do
    expect(frodo).to be_valid
  end

  it "is also valid with a middle name" do
    frodo.middle_name = "The Ring Bearer"
    expect(frodo).to be_valid
  end

  it "is not valid without a first_name, last_name, email, or age" do
    unknown = Person.new
    expect(unknown).not_to be_valid

    # check that all the fields got filled with the appropriate error when valid? was called
    ["first_name", "last_name", "email", "age"].each do |attribute|
      expect(unknown.errors[attribute].include?("can't be blank")).to be true
    end
  end

  it "is not valid with an invalid email" do
    frodo.email = "not an email"
    expect(frodo).not_to be_valid
    expect(frodo.errors[:email].include?("Invalid email")).to be true
  end

  it "must have a unique email address" do
    duplicate_frodo = Person.new(first_name: frodo.first_name,
      last_name: frodo.last_name,
      email: frodo.email,
      age: frodo.age
    )
    expect(duplicate_frodo).not_to be_valid
    expect(duplicate_frodo.errors[:email].include?("has already been taken")).to be true
  end

  it "is not valid when age is below 0, above 130, or not a number" do
    # check that each age is considered invalid, and has appropriate error message
    [-1, 131, "banana"].each do |age|
      frodo.age = age
      expect(frodo).not_to be_valid
      expect(frodo.errors[:age].include?("Age must be a number between 0 and 130")).to be true
    end
  end

end
