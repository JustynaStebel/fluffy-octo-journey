class AddRemoteIdToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :remote_id, :integer
  end
end
