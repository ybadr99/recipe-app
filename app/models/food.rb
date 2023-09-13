class Food < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', dependent: :destroy
  has_and_belongs_to_many :recipes, join_table: :recipe_foods

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :measurement_unit, presence: true, length: { minimum: 1, maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
