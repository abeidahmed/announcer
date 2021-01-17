class CreateMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :memberships, id: :uuid do |t|
      t.datetime :join_date, null: false, default: ""
      t.string :role, null: false, default: "editor"
      t.references :project, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_index :memberships, :role
    add_index :memberships, %i[project_id user_id], unique: true
  end
end
