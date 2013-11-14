class AddVoteCountToAssessments < ActiveRecord::Migration
  def change
    change_table :assessments do |t|
      t.integer :upvote_count, default: 0
      t.integer :downvote_count, default: 0
    end
  end
end
