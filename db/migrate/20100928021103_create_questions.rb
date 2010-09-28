class CreateQuestions < ActiveRecord::Migration

  def self.up
    create_table :questions do |t|
      t.text        :text
      t.text        :answer
      t.timestamp   :answered_at
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end

end
