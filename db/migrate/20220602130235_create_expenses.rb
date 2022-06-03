class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :title, null: false
      t.integer :amount_cents, null: false
      t.belongs_to :category
      t.timestamps
    end
  end
end
