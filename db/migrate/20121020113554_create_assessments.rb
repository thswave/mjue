class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.integer :lecture_id
      t.integer :user_id
      t.integer :overall_score
      t.integer :presentation_score
      t.integer :workload_score
      t.integer :grading_score
      t.text :content

      t.timestamps
    end
  end
end
