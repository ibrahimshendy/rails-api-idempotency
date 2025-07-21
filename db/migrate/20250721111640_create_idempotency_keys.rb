class CreateIdempotencyKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :idempotency_keys do |t|
      t.text :key
      t.string :method
      t.text :endpoint
      t.string :status_code
      t.string :resource_type, null: true
      t.bigint :resource_id, null: true
      t.datetime :created_at, null: false
    end

    add_index :idempotency_keys, [:key, :method, :endpoint], unique: true
    add_index :idempotency_keys, [:resource_type, :resource_id, :created_at]
  end
end
