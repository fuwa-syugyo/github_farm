class UserAnimalStat < ApplicationRecord
  belongs_to :user
  belongs_to :animal

  validates :animal_id, uniqueness: { scope: :user_id }
end
