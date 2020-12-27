/*:
 # Dependency Inversion Principle
 ## High-level classes shouldn’t depend on low-level class- es. Both should depend on abstractions. Abstractions shouldn’t depend on details. Details should depend on abstractions.
 高階層的類別不應該依賴於低階層的類別，兩者都應該依賴於抽象介面，抽象介面不應該仰賴實作，實作應該仰賴於抽象介面．
 
 請見圖
 
 ![pic1](dip1.png)
 
 在這邊可以高階的Class仰賴低階的Class，
 當低階層的資料庫版本變動時，可能會影響到高階層的服務
*/

import UIKit

class MySQLDatabase{
    func inset(){
        print("MySQL insert")
    }
    func update(){
        print("MySQL update")
    }
    func delete(){
        print("MySQL delete")
    }
}

class BudgetReport{
    var database:MySQLDatabase = MySQLDatabase()
    func open(date:TimeInterval){
        print("open")
    }
    func save(){
        print("save")
    }
    
}
/*:

## 解決方案：抽象化
 ![pic2](dip2.png)
*/

//我使用protcol 請將其視為interface
protocol Database{
    func inset()
    func update()
    func delete()
}

class MySQL:Database{
    func inset(){
        print("MySQL insert")
    }
    func update(){
        print("MySQL update")
    }
    func delete(){
        print("MySQL delete")
    }
}


class MongoDB:Database{
    func inset(){
        print("MongoDB insert")
    }
    func update(){
        print("MongoDB update")
    }
    func delete(){
        print("MongoDB delete")
    }
}

class BudgetReport2{
    var database:Database!
    func open(date:TimeInterval){
        print("open")
    }
    func save(){
        print("save")
    }
    func setDB(database:Database){
        self.database = database
    }
}

var br = BudgetReport2()
var mongo = MongoDB()
br.setDB(database: mongo)
