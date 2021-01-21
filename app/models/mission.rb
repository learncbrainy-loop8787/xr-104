class Mission < ApplicationRecord
    belongs_to :user
    belongs_to :soldier
  
    validates :importances, presence: true
    validates :objectives, presence: true
    validates :soldier_id, presence: true
end
