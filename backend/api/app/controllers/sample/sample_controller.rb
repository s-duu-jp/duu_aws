class Sample::SampleController < ApplicationController
  def index
    render json: { message: 'sample' }
  end
end
