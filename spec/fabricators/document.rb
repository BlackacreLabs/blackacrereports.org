require 'faker'

Fabricator(:document) do |f|
  type { ['Court', 'Concurring', 'Dissenting'].sample }
  author { Faker::Name.name }
  page { 1 + rand(1000) }
  f.case
end
