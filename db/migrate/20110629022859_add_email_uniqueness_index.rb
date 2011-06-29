class AddEmailUniquenessIndex < ActiveRecord::Migration
  def up
    add_index :users, :email, unique: true
  end

  def down
    remove_index :usrs, :email
  end
end

