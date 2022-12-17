class AddInviteIdsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :parent
    add_column :users, :children_members, :integer, default: 0
  end
end
