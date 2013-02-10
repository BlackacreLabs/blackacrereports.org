require 'faker'

Fabricator(:case) do |f|
  style { Faker::Name.name + ' v. ' + Faker::Name.name }
end
