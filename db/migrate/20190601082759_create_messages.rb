class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body
      t.datetime :sent_at

      t.timestamps
    end
  end
end
