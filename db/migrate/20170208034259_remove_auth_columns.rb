class RemoveAuthColumns < ActiveRecord::Migration[5.0]
  def change
    remove_column :menus, :email, :string
    remove_column :menus, :encrypted_password, :string
    remove_column :menus, :reset_password_token, :string
    remove_column :menus, :reset_password_sent_at, :datetime
    remove_column :menus, :remember_created_at, :datetime
    remove_column :menus, :sign_in_count, :integer
    remove_column :menus, :current_sign_in_at, :datetime
    remove_column :menus, :last_sign_in_at, :datetime
    remove_column :menus, :current_sign_in_ip, :inet
    remove_column :menus, :last_sign_in_ip, :inet

    remove_column :reports, :email, :string
    remove_column :reports, :encrypted_password, :string
    remove_column :reports, :reset_password_token, :string
    remove_column :reports, :reset_password_sent_at, :datetime
    remove_column :reports, :remember_created_at, :datetime
    remove_column :reports, :sign_in_count, :integer
    remove_column :reports, :current_sign_in_at, :datetime
    remove_column :reports, :last_sign_in_at, :datetime
    remove_column :reports, :current_sign_in_ip, :inet
    remove_column :reports, :last_sign_in_ip, :inet

    remove_column :orders, :email, :string
    remove_column :orders, :encrypted_password, :string
    remove_column :orders, :reset_password_token, :string
    remove_column :orders, :reset_password_sent_at, :datetime
    remove_column :orders, :remember_created_at, :datetime
    remove_column :orders, :sign_in_count, :integer
    remove_column :orders, :current_sign_in_at, :datetime
    remove_column :orders, :last_sign_in_at, :datetime
    remove_column :orders, :current_sign_in_ip, :inet
    remove_column :orders, :last_sign_in_ip, :inet
  end
end
