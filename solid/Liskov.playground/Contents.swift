/*:
 # Liskov Substitution principle
 ## When extending a class, remember that you should be able to pass objects of the subclass in place of objects of the parent class without breaking the client code.
 
 ## 當我們繼承一個Class的時候，應該要在不修改客戶端程式碼的狀況下，將sub Class的物件作為super class的物件進行傳遞
 ![Liv1](Liv1.png)
*/
//import Cocoa

import UIKit

class Document_E{
    var data = ""
    var fileName = ""
    func open(){
        print("open document")
    }
    func save(){
        print("save document")
    }
}

class Project_E{
    init(documents:[Document_E]){
        self.documents = documents
    }
    var documents:[Document_E]=[]
    func openAll(){
        for doc in documents{
            doc.open()
        }
    }
    func saveAll(){
        for doc in documents{
            doc.save()
        }
    }
}
//: 這裡的save() 其實並沒有意義，而且削弱了父類別的後置條件

class ReonlyDocument_E:Document_E {
    override
    func save(){
        print("錯誤，無法保存唯獨文件")
    }
}

var doc:Document_E = Document_E()
var readOnlyDoc:Document_E = ReonlyDocument_E()
var documentList:[Document_E]=[]
documentList.append(doc)
documentList.append(readOnlyDoc)

var proj =  Project_E(documents:documentList)

proj.saveAll()

/*: 在執行 proj.saveAll()時發生了錯誤
 
子類別不應該增加父類別的前置條件
 
子類別不應該削弱父類別的後置條件
*/

/*:
 以下是改良版，符合里式替換原則
 把ReadOnly docuement 作為Base Class ，Readable 作為Extend Classs
 ![Liv2](Liv2.png)
*/

class Document{
    var data = ""
    var fileName = ""
    func open(){
        print("open document")
    }
}

class Project{
    
    var all_documents:[Document]=[]
    var writable_documents:[WritableDocument]=[]
    init(documents:[Document]){
        self.all_documents = documents
        for doc in all_documents {
            if let writableDocument =  doc as? WritableDocument{ //如果可以downcast 就添加到writable_documents
                writable_documents.append(writableDocument)
            }
        }
    }
    func openAll(){
        for doc in all_documents{
            doc.open()
        }
    }
    func saveAll(){
        for doc in writable_documents{
            doc.save()
        }
    }
}
class WritableDocument:Document {
    func save(){
        print("save document")
    }
}

print("＝＝＝＝＝＝改良版＝＝＝＝＝＝")
var doc2:Document = Document()
var writableDocument2:Document = WritableDocument()
var documentList2:[Document]=[]
documentList2.append(doc2)
documentList2.append(writableDocument2)

var proj2 =  Project(documents:documentList2)

proj2.saveAll()
