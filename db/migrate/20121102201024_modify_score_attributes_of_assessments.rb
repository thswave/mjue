class ModifyScoreAttributesOfAssessments < ActiveRecord::Migration
  def change
    change_table :assessments do |t|
      t.integer :difficulty_score
      t.integer :insight_score
    end
  end
end
