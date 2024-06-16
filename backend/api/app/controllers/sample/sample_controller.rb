class Sample::SampleController < ApplicationController
  include SampleGuard

  def index
    # 通過した証を表示
    puts @user # インスタンス変数の名前を変更

    # Userモデルからデータを取得します
    user = User.first
    if user.present?
      render json: user
    else
      render json: { message: 'データが見つかりませんでした' }
    end
  end
end
