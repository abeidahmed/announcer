class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name, null: false, default: ""
      t.string :subdomain, default: ""
      t.string :plan_type, null: false, default: "free"

      t.timestamps
    end

    add_index :projects, :subdomain, unique: true
    add_index :projects, :plan_type
  end
end
