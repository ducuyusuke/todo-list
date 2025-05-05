class AddAuthorToTasks < ActiveRecord::Migration[7.1]
  def change
    # TODO: change the default to something else or remove it?
    add_column :tasks, :author, :string, default: ""
  end
end
