class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.string :health_id, index: {unique: true}
      t.string :email
      t.string :phone
      t.string :aadhar_number
      t.timestamps
    end
  end
end
