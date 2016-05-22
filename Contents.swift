
import Foundation

class SomeTestClass {
    
    dynamic class func forTesting_SaveSomeThings(someThings: [String]) {
        
        print("forTesting_SaveReportCategories called")
    }
    
    static let originalMethod = class_getClassMethod(SomeClass.self, #selector(SomeClass.saveSomeThings(_:)))
    static let swizzledMethod = class_getClassMethod(SomeTestClass.self, #selector(SomeTestClass.forTesting_SaveSomeThings(_:)))

    func someTestMethod() {
        
        // swapped out the real code with the fake code
        method_exchangeImplementations(SomeTestClass.originalMethod, SomeTestClass.swizzledMethod)
        SomeClass.saveSomeThings(["some Things", "and more"])

        // put the real code back
        method_exchangeImplementations(SomeTestClass.originalMethod, SomeTestClass.swizzledMethod)
        SomeClass.saveSomeThings(["some Things", "and more"])
    }
}

class SomeClass {
    
    dynamic class func saveSomeThings(someThings: [String]) {
        
        print("real code getting called")
    }
}

let runTest = SomeTestClass()
runTest.someTestMethod()
