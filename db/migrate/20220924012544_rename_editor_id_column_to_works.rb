class RenameEditorIdColumnToWorks < ActiveRecord::Migration[6.1]
  def change
    rename_column :works, :editor_id, :user_id
  end
end
