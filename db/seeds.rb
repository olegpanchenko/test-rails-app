Item.create([
  {
    name: "Smart Hub",
    price: "49.99",
    unit: "GBP"
  },{
    name: "Motion Sensor",
    price: "24.99",
    unit: "GBP"
  },{
    name: "Wireless Camera",
    price: "99.99",
    unit: "GBP"
  },{
    name: "Smoke Sensor",
    price: "19.99",
    unit: "GBP"
  },{
    name: "Water Leak Sensor",
    price: "14.99",
    unit: "GBP"
  }
])

PercentageDiscount.create([
  {
    promo_code: "20%OFF",
    value: 20,
    can_be_conjunction: false
  },{
    promo_code: "5%OFF",
    value: 5,
    can_be_conjunction: true
  }
])

FixedDiscount.create([{
    promo_code: "20POUNDSOFF",
    value: 20,
    can_be_conjunction: true
  }
])
