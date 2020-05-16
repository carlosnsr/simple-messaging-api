class MakeUserNameNotNullable < ActiveRecord::Migration[6.0]
  def change
    User.where(name: nil).update_all(name: 'Anonymous')
    change_column_null :users, :name, false
  end
end
