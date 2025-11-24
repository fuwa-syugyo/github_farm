class UserAnimal < ApplicationRecord
  belongs_to :user
  belongs_to :animal
  enum :status, { active: 0, inactive: 1 }
end
