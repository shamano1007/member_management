class CreateSkillVersions < ActiveRecord::Migration[5.2]
  def change
    create_table :skill_versions, comment: 'スキルバージョン' do |t|
      t.belongs_to :skill
      t.string :version, comment: 'バージョン', null: false
      t.text :remarks, comment: '備考'

      t.timestamps
    end
  end
end
