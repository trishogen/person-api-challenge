require 'rails_helper'

RSpec.describe PeopleController, type: :request do
  let(:gandalf) {
    Person.create(
      :first_name => "Gandalf",
      :last_name => "The Grey",
      :email => "mithrandir@wizardoo.com",
      :age => 60 # google says apparently over 2000 but let's go with 60
    )
  }

  it "has a method #index which returns a list of people" do
    gandalf
    get people_path
    expect(response).to be_successful
    expect(response.body).to include("Gandalf")
  end

  it "has a method #show which returns one person" do
    get person_path(gandalf.id)
    expect(response).to be_successful
    expect(response.body).to include("Gandalf")
  end

  it "has a method #show which returns not found if the person doesn't exist" do

  end

  it "has a method #show_version which returns a version of a person if they exist" do

  end

  it "has a method #show_version which returns not found if they don't exist" do

  end

  #...etc
end
