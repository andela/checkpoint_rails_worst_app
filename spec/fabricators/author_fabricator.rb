Fabricator(:author) do
  name { Faker::Name.name }
  articles(count: rand(3))
end
