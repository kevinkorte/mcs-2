class CreateModelNames < ActiveRecord::Migration
  def change
    create_table :model_names do |t|
      t.string :model_name

      t.timestamps null: false
    end
  end
end
