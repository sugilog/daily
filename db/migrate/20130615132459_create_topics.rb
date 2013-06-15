class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string  :title, :null => false
      t.text    :description
      t.integer :user_id, :null => false

      t.timestamps
    end
  end
end
