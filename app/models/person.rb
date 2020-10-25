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

end
