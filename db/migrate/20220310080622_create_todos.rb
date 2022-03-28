class CreateTodos < ActiveRecord::Migration[5.2]
  def change
    create_table :todos do |t|
      t.string :content
      t.text :memo
      t.boolean :complete, default: false
      t.references :folder, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
