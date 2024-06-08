Rails.application.routes.draw do
  get '/', to: 'hello_world#index'
  get '/sample', to: 'sample/sample#index'
end
