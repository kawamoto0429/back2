class CreateFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :folders do |t|
      t.string :name
      t.references :format, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
