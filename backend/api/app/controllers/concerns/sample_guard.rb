# このモジュールをincludeすると、コントローラーのアクションが実行される前に
# check_guardメソッドが実行されます。
module SampleGuard
  extend ActiveSupport::Concern

  included do
    before_action :check_guard
  end

  private

  def check_guard
    if guard
      @user = User.first
    else
      render json: { message: 'アクセスが許可されていません' }, status: :forbidden
    end
  end

  def guard
    # ここで実際のガードロジックを実装します
    true
  end
end
