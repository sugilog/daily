json.array!(@dailylogs) do |dailylog|
  json.extract! dailylog, :logged_on, :score, :memo, :topic_id
  json.url dailylog_url(dailylog, format: :json)
end
