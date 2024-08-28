class AddStarsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :sweetness, :float
    add_column :posts, :looks, :float
    add_column :posts, :cost_performance, :float
    add_column :posts, :price, :integer
    add_column :posts, :shop_name, :string
  end
end
