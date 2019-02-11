Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root to: 'feed#index'
  get 'feed/show' => 'feed#show'
  post 'feed/preview' => 'feed#preview'
  post 'feed/add' => 'feed#add'

  get 'feed/site' => 'feed#site'
  get 'feed/site/:id' => 'feed#site'
  get 'feed/new' => 'feed#new'

  get 'setting/setting' => 'settings#setting'
  get 'setting/import_opml' => 'settings#import_opml'
  post 'setting/preview_opml' => 'settings#preview_opml'
  post 'setting/regist_opml' => 'settings#regist_opml'
  get 'setting/regist_opml' => 'settings#regist_opml'

  get 'users/login'
end
