import UIKit

protocol FoodProtocol {
    var name: String {get set}
    var count: Int {get set}
}

protocol BakeryProtocol {
    func startMakeFood(count: Int, name: String)
    func endMakeFood()
}

protocol BakeryDelegate {
    func foodReady(food: Food)
}

protocol DeliveryDelegate {
    func getProduct(food: Food)
}

class Food: FoodProtocol {
    var count: Int
    var name: String

    init(count: Int, name: String) {
        self.count = count
        self.name = name
    }
}

class Bakery: BakeryProtocol {
    var delegate: BakeryDelegate? = nil
    let foods = Food(count: 0, name: "")
    
    func startMakeFood(count: Int, name: String){
        foods.count = count
        foods.name = name
        print("Пекарня: Печем \(foods.name) \(foods.count) штук")
    }

    func endMakeFood(){
        print("Пекарня: \(foods.name) в количестве \(foods.count) штук готов!")
        delegate?.foodReady(food: foods)
    }
}

class Delivery: BakeryDelegate {
    var delegate: DeliveryDelegate?
    var delivery = Food(count: 0, name: "")
    
    func foodReady(food: Food) {
        delivery.count = food.count
        delivery.name = food.name
        if delivery.count == 0 {
            print("Извините! Забирать нечего!")
        } else {
            print("Доставка: \(food.name) в количестве \(food.count) забираем!")
        }
    }
    
    func deliveryProduct() {
        if delivery.count == 0 {
            print("Извините! Доставлять нечего!")
        } else {
            print("Доставка: \(delivery.name) в количестве \(delivery.count) доставляем в магазин!")
            delegate?.getProduct(food: delivery)
        }
    }
}

class Shop: DeliveryDelegate {
    var delivery = Food(count: 0, name: "")
    
    func getProduct(food: Food) {
        delivery.count = food.count
        delivery.name = food.name
        if delivery.count == 0 {
            print("Магазин: Извините! Принимать нечего!")
        } else {
            print("Магазин: \(food.name) в количестве \(food.count) приняли!")
        }
    }
}

let bakery = Bakery()
let delivery = Delivery()
let shop = Shop()

bakery.startMakeFood(count: 100, name: "Хлеб")

bakery.delegate = delivery
bakery.endMakeFood()

delivery.delegate = shop
delivery.deliveryProduct()









