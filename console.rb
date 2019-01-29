require_relative('models/property_tracker.rb')
require("pry")

PropertyTracker.delete_all

property_1 = PropertyTracker.new({
  'value' => 100,
  'number_of_bedrooms' => 3,
  'year_built' => 2018,
  'buy_let_status' => true

  })


  property_2 = PropertyTracker.new({
    'value' => 200,
    'number_of_bedrooms' => 2,
    'year_built' => 2010,
    'buy_let_status' => true

    })

    property_1.save
    property_2.save

    property_1.value = 300
    property_1.update

    orders = PropertyTracker.all
    property_1.delete()

    property_2.find()

    property_2.find_by_number_of_bedrooms()

    binding.pry
    nil
