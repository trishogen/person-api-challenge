class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      # id field is implied (integer)
      t.string :first_name, null: false
      t.string :middle_name # this field can be null
      t.string :last_name, null: false
      t.string :email, null: false
      t.integer :age, null: false

      t.timestamps # sets created_at and updated_at timestamps
    end
  end
end
