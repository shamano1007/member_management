class CreateBusinessCareers < ActiveRecord::Migration[5.2]
  def change
    create_table :business_careers, comment: '業務経歴' do |t|
      t.belongs_to :user
      t.date :start_date, comment: '作業開始日'
      t.date :end_date, comment: '作業終了日'
      t.string :industries, comment: '業種'
      t.string :overview, comment: '概要'
      t.string :role, comment: '役割'
      t.text :work, comment: '作業内容'
      t.text :memo, comment: 'メモ'

      t.timestamps
    end
  end
end
