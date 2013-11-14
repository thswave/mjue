class AddLevelToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :level, :string
  end
end
