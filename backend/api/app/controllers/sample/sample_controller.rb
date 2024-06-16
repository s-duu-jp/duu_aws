class Sample::SampleController < ApplicationController
  include SampleGuard

  def index
    # Userモデルからデータを取得します
    user = User.first
    if user.present?
      render json: user
    else
      render json: { message: 'データが見つかりませんでした' }
    end
  end
end
