json.array!(@profiles) do |profile|
  json.extract! profile, :id, :years_of_experience, :experience_level, :price, :field
  json.url profile_url(profile, format: :json)
end
