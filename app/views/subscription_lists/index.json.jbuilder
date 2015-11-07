json.array!(@subscription_lists) do |subscription_list|
  json.extract! subscription_list, :id
  json.url subscription_list_url(subscription_list, format: :json)
end
