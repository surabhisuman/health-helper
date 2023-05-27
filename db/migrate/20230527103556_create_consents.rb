class CreateConsents < ActiveRecord::Migration[7.0]
  def change
    create_table :consents do |t|
      t.timestamp :registered_on
      t.string :requested_by
      t.string :access_modules, array: true # to be used later
      t.references :person, index: true, foreign_key: true
      t.timestamps
    end
  end
end
