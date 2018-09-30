User.seed(:id) do |s|
  s.id    = 1
  s.login_id = 'admin'
  s.password = '12345678'
  s.name = 'テスト管理者'
  s.role = :admin
end
