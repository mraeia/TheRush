class AddIndexToSortableColumns < ActiveRecord::Migration[5.2]
  def change
    add_index :rush_stats, :name
    add_index :rush_stats, :total_rushing_yards
    add_index :rush_stats, :total_rushing_touchdowns
    add_index :rush_stats, [:longest_rush, :longest_rush_touchdown]
  end
end
