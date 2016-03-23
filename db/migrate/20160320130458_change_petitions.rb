class ChangePetitions < ActiveRecord::Migration
  def change
    change_table :petitions do |t|
      t.boolean :checked
    end
  end
end
