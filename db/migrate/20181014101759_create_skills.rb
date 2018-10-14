class CreateSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :skills do |t|
      t.string :name, comment: 'スキル名'
      t.text :remarks, comment: '備考'

      t.timestamps
    end
  end
end
