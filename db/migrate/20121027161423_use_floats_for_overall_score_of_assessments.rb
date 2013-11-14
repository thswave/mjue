class UseFloatsForOverallScoreOfAssessments < ActiveRecord::Migration
  def change
    change_table :assessments do |t|
      t.remove :overall_score
      t.float :overall_score
    end
  end
end
