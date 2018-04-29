class CreateMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :members do |t|
    	t.string :name
    	t.string :email
    	t.integer :age
    	t.boolean :married
    	
      t.timestamps
    end
  end
end
