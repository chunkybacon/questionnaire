class AddDeltasToQuestions < ActiveRecord::Migration

  def self.up
    add_column :questions, :delta, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :questions, :delta
  end

end
