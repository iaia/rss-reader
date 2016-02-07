Rails.application.routes.draw do
    root :to => 'feed#index'
    get 'feed/show' => "feed#show"
    post 'feed/preview' => "feed#preview"
    post 'feed/add' => "feed#add"
    
    get 'feed/site' => "feed#site"
    get 'feed/site/:id' => "feed#site"
    get 'feed/new' => "feed#new"

    get 'setting/setting' => "settings#setting"
    get 'setting/import_opml' => "settings#import_opml"
end
