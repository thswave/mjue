class RemoveUnusedScoresFromLecturesAndAssessments < ActiveRecord::Migration
  def change
    change_table :lectures do |t|
      t.remove :difficulty_score
      t.remove :insight_score
    end

    change_table :assessments do |t|
      t.remove :difficulty_score
      t.remove :insight_score
    end
  end
end
