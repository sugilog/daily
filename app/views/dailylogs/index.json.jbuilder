json.array!(@dailylogs) do |dailylog|
  json.extract! dailylog, :logged_on, :score, :node, :topic_id
  json.url dailylog_url(dailylog, format: :json)
end
