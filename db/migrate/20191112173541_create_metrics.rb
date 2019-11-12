class CreateMetrics < ActiveRecord::Migration[6.0]
  def change
    create_table :metrics do |t|
      t.string :category
      t.string :value
      t.string :machine_id

      t.timestamps
    end

    add_index :metrics, :category
    add_index :metrics, :machine_id
  end
end
