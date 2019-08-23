class AddUserNameToIdea < ActiveRecord::Migration[5.1]
  def change
    add_column :ideas, :name_of_user, :string
  end
end
