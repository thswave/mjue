class AddReferencesToVotes < ActiveRecord::Migration
  def change
    change_table :votes do |t|
      t.integer :user_id
      t.integer :assessment_id
    end
  end
end
