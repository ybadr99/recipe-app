class RecipeFood < ActiveRecord::Migration[7.0]
  def change
    create_table :recipe_foods do |t|
      t.references :recipe, null: false, foreign_key: true
      t.references :food, null: false, foreign_key: true
      t.float :quantity, null: false

      t.timestamps
    end
    add_index :recipe_foods, [:recipe_id, :food_id], unique: true
  end
end
