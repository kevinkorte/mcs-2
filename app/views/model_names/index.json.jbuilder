json.array!(@model_names) do |model_name|
  json.extract! model_name, :id, :model_name
  json.url model_name_url(model_name, format: :json)
end
