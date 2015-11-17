json.array!(@subscription_lists) do |subscription_list|
  # json.extract! subscription_list, :id
  json.id subscription_list.id
  json.name subscription_list.name
  #json.description subscription_list.description
  #json.url subscription_list_url(subscription_list, format: :json)
end
