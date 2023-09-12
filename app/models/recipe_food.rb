class RecipeFood < ApplicationRecord
  belongs_to :Recipe, class_name
  belongs_to :Food
end
