class AddCreditToLectures < ActiveRecord::Migration
  def change
    add_column :lectures, :credit, :string
  end
end
