class CreateClaims < ActiveRecord::Migration[7.0]
  def change
    create_table :claims do |t|
      t.string :amount
      t.references :person, index: true, foreign_key: true
      t.references :insurance_policy, index: true, foreign_key: true
      t.timestamps
    end
  end
end
