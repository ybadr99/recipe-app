class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable
  
  has_many :recipes, class_name: "Recipe", foreign_key: "user_id"
  has_many :foods, join_table: :recipe_foods, through: :recipes
  has_many :recipe_foods, through: :recipes, join_table: :recipe_foods

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :password_confirmation, presence: true
end
