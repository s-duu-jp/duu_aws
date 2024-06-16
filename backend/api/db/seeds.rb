# Userモデルがない場合は、適切なモデル名に置き換えてください
if defined?(User)
  # 既に存在するユーザーを削除してから新しいユーザーを作成する場合
  User.destroy_all

  # 初期データを作成します
  User.create!(
    uid: 'admin',
    name: '管理者',
    email: 'admin@hoge.jp',
    role_type: 'admin',
    status_type: 'active',
    oauth_type: 'local',
    password_digest: '$2a$10$HOn8WTUwZFj6CtT0rOktluNjyLjd1kennkRZWOmKn7TpBXmY7J8Qq' # 事前に生成されたパスワードハッシュ
  )

  puts "初期ユーザーを作成しました。"
else
  puts "Userモデルが見つかりませんでした。"
end
