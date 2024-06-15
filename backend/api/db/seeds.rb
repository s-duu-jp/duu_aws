# Userモデルが存在することを確認します
# Userモデルがない場合は、適切なモデル名に置き換えてください
if defined?(User)
  # 既に存在するユーザーを削除してから新しいユーザーを作成する場合
  User.destroy_all

  # 初期データを作成します
  User.create!(
    id: 1,
    name: 'admin',
    age: 41
  )

  puts "初期ユーザーを作成しました。"
else
  puts "Userモデルが見つかりませんでした。"
end
