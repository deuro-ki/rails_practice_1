class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :remember_digest
      t.boolean :admin, default: false
      t.string :department
      t.datetime :basic_time, default: Time.current.change(hour: 8, min: 0, sec: 0)
      t.datetime :work_time, default: Time.current.change(hour: 7, min: 30, sec: 0)
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
