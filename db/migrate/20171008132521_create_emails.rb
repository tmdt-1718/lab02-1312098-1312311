class CreateEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :emails do |t|
      t.integer :from
      t.integer :to
      t.string :subject
      t.string :body
      t.timestamps
    end
  end
end
