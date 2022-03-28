class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.string :place
      t.date :start
      t.time :timestart
      t.date :end
      t.time :timeend
      t.string :memo
      t.references :folder, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
