class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.belongs_to :user
      t.date :birthdate, comment: '生年月日'
      t.string :address, comment: '住所'
      t.string :closest_line, comment: '最寄線'
      t.string :closest_station, comment: '最寄駅'

      t.timestamps
    end
  end
end
