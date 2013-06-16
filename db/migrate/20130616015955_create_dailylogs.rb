class CreateDailylogs < ActiveRecord::Migration
  def change
    create_table :dailylogs do |t|
      t.date    :logged_on
      t.integer :score
      t.text    :node
      t.integer :topic_id
      t.index   [:topic_id, :logged_on], :unique => true

      t.timestamps
    end
  end
end
