class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :title
      t.belongs_to :platform
      t.belongs_to :year
      t.belongs_to :make
      t.belongs_to :model_name

      t.timestamps null: false
    end
  end
end
