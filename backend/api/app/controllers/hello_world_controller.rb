# このIndexメソッドは、JSON形式で{ message: 'hello world' }というメッセージを返します。
class HelloWorldController < ApplicationController
  def index
    render json: { message: 'hello world' }
  end
end
