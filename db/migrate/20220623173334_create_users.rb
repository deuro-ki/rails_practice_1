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

# class CreateUsers < ActiveRecord::Migration[5.1]
#   def change
#     create_table :users do |t|
#       t.string :name, null: false
#       t.string :email, null: false
#       t.string :password_digest
#       t.string :remember_digest
#       t.boolean :admin, null: false, default: false
#       t.string  :department
#       t.datetime :basic_time, null: false, default: Time.current.change(hour: 8, min: 0, sec: 0)
#       t.datetime :work_time,  null: false, default: Time.current.change(hour: 7, min: 30, sec: 0)
#       t.boolean :superior, null: false, default: false
#       t.datetime :designated_work_start_time, null: false, default: Time.current.change(hour: 9, min: 0, sec: 0)
#       t.datetime :designated_work_end_time, null: false,  default: Time.current.change(hour: 18, min: 0, sec: 0)
#       t.datetime :finish_time
#       t.string   :affiliation
#       t.integer :employee_number
#       t.string :uid
#       t.string :title
#       t.timestamps
#     end
#       add_index :users, :email, unique: true
      
#   end
# end

# rm db/development.sqlite3
# bin/rails db:create db:migrate

# rails db:migrate
# rails db:seed