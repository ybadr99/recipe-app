class Recipe < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :recipe_foods, class_name: 'RecipeFood', dependent: :destroy
  has_and_belongs_to_many :foods, join_table: :recipe_foods

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :description, presence: true, length: { minimum: 10, maximum: 500 }
  validates :public, inclusion: { in: [true, false] }
end
