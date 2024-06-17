if defined?(User)
  # 全ユーザー削除
  User.destroy_all

  # ユーザー作成
  User.create!(
    uid: 'admin',
    name: '管理者',
    email: 'admin@hoge.jp',
    role_type: 'admin',
    status_type: 'active',
    oauth_type: 'local',
    password_digest: '$2a$10$HOn8WTUwZFj6CtT0rOktluNjyLjd1kennkRZWOmKn7TpBXmY7J8Qq'
  )

  puts "初期ユーザーを作成しました。"
else
  puts "Userモデルが見つかりませんでした。"
end
