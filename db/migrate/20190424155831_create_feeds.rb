# frozen_string_literal: true

class CreateFeeds < ActiveRecord::Migration[5.2]
  def change
    create_table :feeds do |t|
      t.string :type1
      t.string :type2
      t.string :type3
      t.string :type4

      t.timestamps
    end
  end
end
