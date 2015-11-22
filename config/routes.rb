Rails.application.routes.draw do
    root :to => 'feed#index'
    get 'feed/show' => "feed#show"
    post 'feed/preview' => "feed#preview"
    post 'feed/add' => "feed#add"
end
