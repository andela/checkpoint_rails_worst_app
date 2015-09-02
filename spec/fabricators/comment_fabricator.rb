Fabricator(:comment) do
  author { Faker::Name.name }
  body { Faker::Lorem.sentence(3) }
end
