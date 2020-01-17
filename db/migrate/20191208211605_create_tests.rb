class CreateTests < ActiveRecord::Migration[5.2]
  def change
    create_table :sats do |t|
      t.datetime :date_entered, null: false
      t.integer :student_id, null: false
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

    create_table :acts do |t|
      t.datetime :date_entered, null: false
      t.integer :student_id, null: false
      t.string :tutor_name
      t.integer :tutor_id
      t.string :form
      t.integer :english
      t.integer :math
      t.integer :reading
      t.integer :writing
      t.integer :composite
      t.boolean :extended
    end
  end
end
