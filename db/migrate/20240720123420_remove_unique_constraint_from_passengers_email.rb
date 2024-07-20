class RemoveUniqueConstraintFromPassengersEmail < ActiveRecord::Migration[7.1]
  def change
    remove_index :passengers, :email
    add_index :passengers, :email, unique: false
  end
end
