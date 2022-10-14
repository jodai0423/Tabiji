class CreateFootprints < ActiveRecord::Migration[6.1]
  def change
    create_table :footprints do |t|
      t.integer :user_id
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
