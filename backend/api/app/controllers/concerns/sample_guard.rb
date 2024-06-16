module SampleGuard
  extend ActiveSupport::Concern

  included do
    before_action :check_guard
  end

  private

  def check_guard
    return if guard

    render json: { message: 'アクセスが許可されていません' }, status: :forbidden
  end

  def guard
    # ここで実際のガードロジックを実装します
    true
  end
end
