class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :tests do |t|
      t.date :date_entered, null: false
      t.string :student_name, null: false
      t.integer :student_id
      t.string :tutor_name
      t.integer :tutor_id
      t.string :form
      t.integer :total
      t.integer :reading_writing
      t.integer :reading
      t.integer :writing
      t.integer :math
      t.boolean :extended
    end
  end
end
