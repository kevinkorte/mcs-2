json.array!(@machines) do |machine|
  json.extract! machine, :id, :title
  json.url machine_url(machine, format: :json)
end
