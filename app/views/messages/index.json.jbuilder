json.array!(@messages) do |message|
  json.extract! message, :id, :content, :read_at, :sender_id, :recipient_id
  json.url message_url(message, format: :json)
end
