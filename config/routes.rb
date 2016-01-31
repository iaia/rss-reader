Rails.application.routes.draw do
    root :to => 'feed#index'
    get 'feed/show' => "feed#show"
    post 'feed/preview' => "feed#preview"
    post 'feed/add' => "feed#add"
    
    get 'feed/site' => "feed#site"
    get 'feed/site/:id' => "feed#site"
end
