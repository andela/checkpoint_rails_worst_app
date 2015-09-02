Fabricator(:article) do
  name { Faker::Lorem.sentence }
  body { Faker::Lorem.paragraph }
  comments(count: rand(10))
end
