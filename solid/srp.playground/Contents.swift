/*:
 
# Single Respoibility Principle
 
 ## 改變一個Class的原因只能唯一
 
 需求：今天老版要求工程師完成一個打卡程式，輸入員工姓名之後，
 會顯示目前時間，並且將這個時間作為下班打卡時間戳，最後將這筆資訊寫入回資料庫當中
*/
import UIKit
// 宣告類別（mub架構）
class Employee_mub {
    var name:String=""
    init(name: String) {
        self.name = name
    }
    func getName() ->String{
        return name
    }
    
    func printTimeSheetReport(){
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        print(getName(),"時間:",time.description)
        writeToDB(t: myTimeInterval)
    }
    
    func writeToDB(t:TimeInterval){
        //write to db
        print("已寫入資料庫")
    }
}

var employee = Employee_mub(name: "William Hsu")
employee.printTimeSheetReport()

/*:一切看起來很美好，但今天老闆聽說mysql要付錢，想要改採用免費的 postgres sql
 
同時其他部門表示，紀錄資訊的格式需要修改，最起碼要顯示這筆資訊是上班還是下班

oops 看起來程式應該要拆分了
*/

//宣告類別（遵循srp原則）
class Sheet{
    var info:String=""
    func setSheetContent(kind:Int,name:String){
        let timestamp = NSDate().timeIntervalSince1970
        let myTimeInterval = TimeInterval(timestamp)
        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
        self.info = "name: "+name+",time: "+String(time.description)+",kind: "+String(kind)
    }
    func getSheetContent()->String{
        return self.info
    }
}

class DB{
    //init connection etc.
    
    func writeToDB(info:String){
        //write to db
        print(info)
        print("已寫入postgres資料庫")
    }
}

class Employee {
    var name:String=""
    init(name: String) {
        self.name = name
    }
    func getName() ->String{
        return name
    }
}

var employee2 = Employee(name: "William Hsu")
var sheet =  Sheet()
var db = DB()

sheet.setSheetContent(kind: 1, name: employee2.getName())
db.writeToDB(info: sheet.getSheetContent())

/*:
 ## 在這樣的架構之下不論是
 * 換DB
 * 表單格式又改了
 * 或者是Employee需要新的屬性
## 彼此之間都不影響
*/
