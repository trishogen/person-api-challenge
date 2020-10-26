class Person < ApplicationRecord
  # hooks the model up to the versions table/paper trail gem allowing us to track versions
  has_paper_trail

  # validations on Person model to handle bad inputs
  validates :first_name,
    presence: true,
    length: { minimum: 2 },
    format: { without: /[0-9]/, message: "Does not allow numbers" }
  validates :middle_name,
    # presence not needed for middle name
    # no validation on length to allow middle initials
    format: { without: /[0-9]/, message: "Does not allow numbers" }
  validates :last_name,
    presence: true,
    length: { minimum: 2 },
    format: { without: /[0-9]/, message: "Does not allow numbers" }
  validates :email,
    presence: true,
    uniqueness: true,
    # "with" enables you to use regex to check the input
    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Invalid email"}
  validates :age,
    # numericality validation defaults to requiring the age field to not be nil
    # i.e. presence: true, but having presence explicitly set helps standardize error messages
    presence: true,
    numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 130,
      only_integer: true, message: "Age must be a number between 0 and 130" }

  def self.find_version(id, version)
    # finds a person by their ID and version number
    # people/:person_id/versions/:id is implemented so that you can pass in
    # people/1/versions/1 and expect to get the first version of the first person

    id_n, version_n = id.to_i, version.to_i #convert to ints, will return 0 if invalid
    return nil if !self.version_request_valid(id_n, version_n) # return if inputs are invalid

    potential_person = Person.find_by(id: id_n) # if the person currently exists, find them
    # otherwise we need to temporarily re-establish the link to grab them at a point in time
    person = potential_person ? potential_person : Person.new(id: id_n)
    # filter out destroys to make numbering consistent even when someone gets deleted
    # recreation still counts as a new version
    versions = person.versions.where.not(event: "destroy")

    # if searching for the latest version we can return the person
    return person if person.versions.size == version_n
    person_version = person.versions[version_n] # otherwise try to select the right version

    # if there was no corresponding person or version this will return nil
    # if we don't save the reified person they won't be restored
    return person_version ? person_version.reify : person_version
  end

  def self.version_request_valid(id, version)
    # makes sure both values are positive integers
    [id, version].each do |num|
      return false if !num.is_a?(Integer) || !num.positive?
    end

    return true
  end

end
