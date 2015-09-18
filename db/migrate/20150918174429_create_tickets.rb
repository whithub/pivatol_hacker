class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string  :name
      t.text    :description
      t.integer :status, default: 0
      t.references :board, index: true

      t.timestamps null: false
    end
  end
end
