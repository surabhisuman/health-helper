class CreateClaimStatusHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :claim_status_histories do |t|
      t.references :claim, index: true, foreign_key: true
      t.string :transition_from
      t.string :transition_to
      t.timestamps
    end
  end
end
