/*:
 # open close principle
 ## Classes should be open for extension but closed for modification.
 在添加新功能時，能保持原本的程式碼不變
 
 情境說明：
 
 某電商平台的程式當中，包含一個計算運費的Order Class，
 該Class當中所有的運輸方法都用Hard-code方法來撰寫，
 如果要添加一個新的運輸方式，
 能可能會讓原本仰賴Order物件的其他Class 產生錯誤
 
 請見圖
 
 ![pic1](ocp1.png)
*/

import UIKit

class Item{
    var price = 0.0
    var weight = 0.0
    init(price:Double,weight:Double) {
        self.price = price
        self.weight = weight
    }
   
}

class Order_mud{
    init(items:[Item]) {
        lineItems = items
    }
    var lineItems:[Item]=[]
    var shipping=""
    func getTotal()->Double{
        var sum = 0.0
        for item in lineItems {
            sum += item.price
        }
        return sum
    }
    func getTotalWeight()->Double{
        var sum = 0.0
        for item in lineItems {
            sum += item.weight
        }
        return sum
    }
    
    func setShippingType(shipping :String){
        self.shipping = shipping
    }
//:請看這邊，如果需要新增運輸方式，就只能改動整個Order物件，這看起來不是個好主意
    
    func getShippingCost()->Double{
        if shipping=="ground" {
            // 大額訂單免費陸運
            if getTotal()>100{
                return 0.0
            }
            return max(10,getTotalWeight()*1.5)
        }
        else if shipping=="air" {
            return max(20,getTotalWeight()*3)
        }
        return -1 //if error
    }
//:這裡也要跟著修改...太糟糕了
    func getShippingDate()->String{
        if shipping=="ground" {
            return "10 day after"
        }
        else if shipping=="air" {
            return "1 day after"
        }
        return "error" //if error
    }
}

/*:
## 解決方案：使用interface
 ![pic2](ocp2.png)
*/
//我使用protcol 請將其視為interface

protocol Shipping{
    func getCost(order:Order)->Double
    func getShippingDate(order:Order)->String
}

class Ground: Shipping {
    func getCost(order:Order)->Double {
        if order.getTotal()>100{
            return 0.0
        }
        return max(10,order.getTotalWeight()*1.5)
    }
    func getShippingDate(order:Order)->String {
        return "10 day after"
    }

}

class Air: Shipping {
    func getCost(order:Order)->Double {
        return max(20,order.getTotalWeight()*3)
    }
    func getShippingDate(order:Order)->String {
        return "1 day after"
    }
}

//修改Order Class
class Order{
    init(items:[Item],shipping:Shipping) {
        lineItems = items
        self.shipping = shipping
    }
    var lineItems:[Item]=[]
    var shipping:Shipping
    func getTotal()->Double{
        var sum = 0.0
        for item in lineItems {
            sum += item.price
        }
        return sum
    }
    func getTotalWeight()->Double{
        var sum = 0.0
        for item in lineItems {
            sum += item.weight
        }
        return sum
    }
    
    func setShippingType(shipping:Shipping){
        self.shipping = shipping
    }
    
    func getShippingCost()->Double{
        return shipping.getCost(order: self)
    }
    
    func getShippingDate()->String{
        return shipping.getShippingDate(order: self)
    }
}

var air = Air()
var items:[Item] = []
items.append(Item(price: 50, weight: 100))
var order:Order = Order(items:items,shipping:air)

print(order.getShippingCost())
print(order.getShippingDate())
