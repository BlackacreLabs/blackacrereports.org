require 'fabrication'

module Turnip::Steps
  def with_ivars(fabricator)
    @they = yield fabricator
    model = @they.last.class.to_s.underscore
    instance_variable_set("@#{model.pluralize}", @they)
    instance_variable_set("@#{model.singularize}", @they.last)
    Fabrication::Cucumber::Fabrications[model.singularize.gsub(/\W+/,'_').downcase] = @they.last
  end

  step ':count :model' do |count, model|
    ivars = Fabrication::Cucumber::StepFabricator.new(model)
    with_ivars(ivars) { |fab| fab.n(count.to_i) }
  end

  step 'a :model as follows:' do |model, table|
    ivars = Fabrication::Cucumber::StepFabricator.new(model)
    with_ivars(ivars) { |fab| fab.from_table(table) }
  end

  step 'I should see :count :model in the database' do |count, model|
    Fabrication::Cucumber::StepFabricator.new(model)
      .klass.count.should == count.to_i
  end

  step 'I should see the following :model in the database:' do |model, table|
    klass = Fabrication::Cucumber::StepFabricator.new(model).klass
    klass.where(table.rows_hash.symbolize_keys).count.should == 1
  end
end
