class CreateDailylogs < ActiveRecord::Migration
  def change
    create_table :dailylogs do |t|
      t.date    :logged_on, null: false
      t.integer :score
      t.text    :memo
      t.integer :topic_id, null: false
      t.index   [:topic_id, :logged_on], unique: true

      t.timestamps
    end
  end
end
