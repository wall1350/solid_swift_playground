/*:
 # Interface Segregation Principle
 ## Clients shouldn’t be forced to depend on methods they do not use.
客戶端不應該被強迫依賴於不使用的方法
 
 請見圖
 
 ![pic1](dip1.png)
*/

import UIKit
//我使用protcol 請將其視為interface
protocol CloudProvider{
    func storeFile(name:String)
    func getFile(name:String)
    func createServer(region:String)
    func listServers(region:String)
    func getCDNAddress()
}

class Amazon: CloudProvider {
    func storeFile(name:String){
        print("storeFile:" , name)
    }
    func getFile(name:String){
        print("getFile:" , name)
    }
    func createServer(region:String){
        print("createServer in :" , region)
    }
    func listServers(region:String){
        print("listServers:" , region)
    }
    func getCDNAddress(){
        print("CDNAddress:")
    }
}

class DropBox: CloudProvider {
    func storeFile(name:String){
        print("storeFile:" , name)
    }
    func getFile(name:String){
        print("getFile:" , name)
    }
    func createServer(region:String){
        //empty
    }
    func listServers(region:String){
        //empty
    }
    func getCDNAddress(){
       //empty
    }
}

//:在這邊可以看到有三個方法沒有實作，而且如果今天CloudProvider又有新功能的時候
//:實作CloudProvider的Class全部都需要修改



/*:
## 解決方案：拆分成不同interface
 ![pic2](dip2.png)
*/

//我使用protcol 請將其視為interface
protocol CloudHostingProvider{
    func createServer(region:String)
    func listServers(region:String)
}

protocol CDNProvider{
    func getCDNAddress()
}

protocol CloudStorageProvider {
    func storeFile(name:String)
    func getFile(name:String)
}


class Amazon2: CloudHostingProvider,CDNProvider,CloudStorageProvider{
    func storeFile(name:String){
        print("storeFile:" , name)
    }
    func getFile(name:String){
        print("getFile:" , name)
    }
    func createServer(region:String){
        print("createServer in :" , region)
    }
    func listServers(region:String){
        print("listServers:" , region)
    }
    func getCDNAddress(){
        print("CDNAddress:")
    }
}

class DropBox2: CloudStorageProvider {
    func storeFile(name:String){
        print("storeFile:" , name)
    }
    func getFile(name:String){
        print("getFile:" , name)
    }
}
//: 這樣DropBox2可以不需要實作一些不必要的方法，讓程式碼更為精簡

//:但要注意如果interface過多，可能會過度複雜，導致難以維護!!  (By: 郭老師)
