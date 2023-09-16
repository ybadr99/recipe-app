class RecipeFood < ApplicationRecord
  belongs_to :recipe, class_name: 'Recipe', foreign_key: 'recipe_id'
  belongs_to :food, class_name: 'Food', foreign_key: 'food_id'

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :recipe_id, presence: true, uniqueness: { scope: :food_id }
  validates :food_id, presence: true, uniqueness: { scope: :recipe_id }
end
