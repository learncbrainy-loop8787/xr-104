class Soldier < ApplicationRecord
    belongs_to :general, foreign_key: "user_id", class_name: "User"
    has_many :missions
    has_many :missioners, through: :missions, source: :user

  
        validates :name, presence: true
        validates :social_security, presence: true, length: { is: 9 }
        validates :combat_experience, presence: true, length: { in: 0..82 }

        scope :sort_by_name, -> {self.order(name: :asc)}
        scope :sort_by_kills, -> {self.order(confirmed_kills: :desc)}
        scope :soldier_search, -> (soldier) {self.where("name LIKE ?", "%#soldier{}%")}



    def danger_level
        Mission.where(soldier_id: id).average(:importances).to_i
    end

    def general_name
        general.code_name
    end 

    def self.sorted_asc
        order(name: :asc)
      end

      def self.sorted_asc
        order(confirmed_kills: :asc)
      end


end