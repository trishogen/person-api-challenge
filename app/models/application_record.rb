class ApplicationRecord < ActiveRecord::Base
  # base model to inherit from (for ORM)
  self.abstract_class = true
end
