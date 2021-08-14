class AddMoreFieldsToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :description, :text
    add_column :articles, :status, :string
    add_column :articles, :image, :string
  end
end
