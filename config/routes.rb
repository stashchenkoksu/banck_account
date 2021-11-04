Rails.application.routes.draw do
  root 'users#index'

  resources :users do
    resources :accounts
  end

  resources :tags

  get 'accounts_management', to: 'accounts_management#index', as: 'accounts_management'
  get 'accounts_management/deposit', to: 'accounts_management#deposit', as: 'account_management_deposit'
  post 'accounts_management/deposit', to: 'accounts_management#deposit', as: 'account_management_deposit_action'

  get 'accounts_management/transfer', to: 'accounts_management#transfer', as: 'account_management_transfer'
  post 'accounts_management/transfer', to: 'accounts_management#transfer', as: 'account_management_transfer_action'

  get 'reports/new', to: 'reports#new', as: 'new_report'
  post 'reports/new', to: 'reports#create'
  get 'reports', to: 'reports#show', as: 'report'
end
