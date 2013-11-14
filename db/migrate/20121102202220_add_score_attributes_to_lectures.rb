class AddScoreAttributesToLectures < ActiveRecord::Migration
  def change
    change_table :lectures do |t|
      t.float :difficulty_score
      t.float :insight_score
    end
  end
end
