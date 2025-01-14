require './lib/food_truck'
require './lib/item'
require './lib/event'

RSpec.describe Event do
  before :each do
    @event = Event.new("South Pearl Street Farmers Market")
  end

  it "exists" do
    expect(@event).to be_instance_of(Event)
  end

  it "can return event name and food truck array" do
    expect(@event.name).to eq("South Pearl Street Farmers Market")
    expect(@event.food_trucks).to eq([])
  end

  it "can add a food truck and return information" do
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @food_truck3.stock(@item1, 65)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expect(@event.food_trucks.count).to eq(3)
    expect(@event.food_truck_names.count).to eq(3)
  end

  it "will return an array of food trucks that sell a given item" do
    @food_truck1 = FoodTruck.new("Rocky Mountain Pies")
    @item1 = Item.new({name: 'Peach Pie (Slice)', price: "$3.75"})
    @item2 = Item.new({name: 'Apple Pie (Slice)', price: '$2.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @food_truck1.stock(@item1, 35)
    @food_truck1.stock(@item2, 7)
    @food_truck2 = FoodTruck.new("Ba-Nom-a-Nom")
    @food_truck2.stock(@item4, 50)
    @food_truck2.stock(@item3, 25)
    @food_truck3 = FoodTruck.new("Palisade Peach Shack")
    @food_truck3.stock(@item1, 65)
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expect(@event.food_trucks_that_sell(@item1).count).to eq(2)
    expect(@event.food_trucks_that_sell(@item4).count).to eq(1)
  end

  it "return list of overstocked items" do
    expect(@event.overstocked_items.count).to eq(1)
  end

  it "will return a sorted list of names for event" do
    expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
  end

  it "will return a hash of total inventory" do
    expect(event.total_inventory.count).to eq(4)
  end

  describe "iteration 3" do
    before :each do
      @food_truck3.stock(@item3, 10)
    end
#suggested to do total_inventory first
    it "can calculate overstocked_items" do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.overstocked_items).to eq([@item1])
    end

    it "can return an alphabetical list of item names" do
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)

      expect(@event.sorted_item_list).to eq(["Apple Pie (Slice)", "Banana Nice Cream", "Peach Pie (Slice)", "Peach-Raspberry Nice Cream"])
    end
  end

#student expect example
  # it "can return a total_inventory hash" do
  #   expect(@event.total_inventory).to eq({@item1 => {quantity: 100, food_trucks: [@food_truck1, @food_truck3]}, @item2 => {quantity: 7, food_trucks: [@food_truck1]}, @item_3 => {quantity: 35, food_trucks: [@food_truck2, @food_truck3]}, @item4 => {quantity: 50, food_trucks: [@food_truck2]}})
  # end
  it "can return a total_inventory hash" do
    @event.add_food_truck(@food_truck1)
    @event.add_food_truck(@food_truck2)
    @event.add_food_truck(@food_truck3)

    expected = {
      @item1 => {
        quantity:100,
        food_trucks: [@food_truck1, @food_truck3]
      },
      @item2 => {
        quantity: 7,
        food_trucks:[@food_truck1]
      },
      @item3 => {
        quantity: 35,
        food_trucks:[@food_truck2, @food_truck3]
      },
      @item4 => {
        quantity: 50,
        food_trucks [@food_truck2]
      },
    }

    expect(@event.total_inventory).to eq(expected)

    # expect(@event.total_inventory).to eq({@item1 => {quantity: 100, food_trucks: [@food_truck1, @food_truck3]}, @item2 => {quantity: 7, food_trucks: [@food_truck1]}, @item_3 => {quantity: 35, food_trucks: [@food_truck2, @food_truck3]}, @item4 => {quantity: 50, food_trucks: [@food_truck2]}})
  end

  describe  "iteration 4" do
    before :each do
      item5 = Item.new({name: 'Onion Pie', price: '$25.00'})
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it "can sell an item from any food truck that has it in stock" do
      #should fail because we don't have 200 of item 1
      expect(@event.sell(@item1, 200)).to eq(false)

    end
  end

end
