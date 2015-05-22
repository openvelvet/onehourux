json.array!(@reviews) do |review|
  json.extract! review, :id, :rating, :title, :comment
  json.url review_url(review, format: :json)
end
