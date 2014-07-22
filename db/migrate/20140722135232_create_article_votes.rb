class CreateArticleVotes < ActiveRecord::Migration
  def change
    create_table :article_votes do |t|
    	t.belongs_to :article
    	t.belongs_to :user
    	t.integer :value

    	t.timestamps
    end
    add_index :article_votes, :article_id
    add_index :article_votes, :user_id
  end
end
