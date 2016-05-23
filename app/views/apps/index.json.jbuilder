json.array!(@apps) do |app|
  json.extract! app, :id
  json.url app_url(app, format: :json)
end
