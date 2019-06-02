# frozen_string_literal: true

class CreateSchema < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :body
      t.datetime :sent_at

      t.timestamps
    end

    create_table :messengers do |t|
      t.references :message, null: false
      t.string :user_id, null: false
      t.string :type, null: false
      t.string :status, null: false, default: 'in_progress'
    end
  end
end
