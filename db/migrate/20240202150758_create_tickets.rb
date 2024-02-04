class CreateTickets < ActiveRecord::Migration[7.1]
  def change
    create_table :tickets do |t|
      t.string :requester_email
      t.string :requester_name
      t.string :subject
      t.integer :status, index: true, default: 0
      t.text :content

      t.timestamps
    end
  end
end
