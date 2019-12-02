import UIKit




var str = "Hello, playground"

print("any String ---- \(str)")

/* Explaination on variable's*/
struct completeEgOnVar {
    /* if Structures, enumeration  & classes are have any variables or let means they are called as properties
     
      1 ---> two types of properties stored properties & computed
     
     
     */
    var cuteness = "natural" //stored properites
    let lookGood = true // stoted properites ---- Type Annoations will be provided by swit itself

    var languageName : String //  variableName : DataType ------ datatype should be mandatory
    let introducedYear : Int // contantName: DataType ----- 
    
    
}

//Creating Struct Object using Default initializers

let someVar = completeEgOnVar(cuteness:"", languageName:"", introducedYear:22)
//



struct varDemo {
    let firstName : String
    var lastName : String
    /*
     Points to be noted --- regards to let and var --- ()
     1 ---> let values cannot be changed --- (i.e., Immutable object)
     2 ---> var values can be changed    --- (i.e., Mutable object)
     
     Eg :
     
     */
    
    /*
        Points to be noted --- regards to Structures --- 
        1 ---> Structures are value types in swift -- explain in detail later
     
        2 ---> Structures will have default initializers
            EG : In this Structure we have
                init( firstName : String, lastName : String) {
                    self.firstName = firstName
                    self.lastName = lastName
                     }
            NOTE :  --- self --->  means current class object
                        
     
        */
    

}





