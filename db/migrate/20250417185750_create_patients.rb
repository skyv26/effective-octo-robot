class CreatePatients < ActiveRecord::Migration[8.0]
  def change
    create_table :patients do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :phone
      t.string :email
      t.string :blood_group
      t.text :address
      t.text :medical_history
      t.text :allergies
      t.string :emergency_contact

      t.timestamps
    end
  end
end
