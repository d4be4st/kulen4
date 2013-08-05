Kulen4::Application.routes.draw do

  namespace :admin do
    resources :pages
  end
  get '/*url' => 'pages#pages'

end
