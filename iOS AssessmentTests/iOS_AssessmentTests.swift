//
//  iOS_AssessmentTests.swift
//  iOS AssessmentTests
//
//  Created by Kundan Jadhav on 17/10/18.
//  Copyright © 2018 Quick Heal Technologies Ltd. All rights reserved.
//

import XCTest

class iOS_AssessmentTests: XCTestCase {

    public typealias completionHandlerType = (NSArray?, Error?) -> Void
    let API_KEY = "3dae7e066a9e4120b3525a8056fc2771"

    override func setUp() {
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.

        let expectation = XCTestExpectation(description: "Download NY times articles")
        
        func getArticleList(completion : @escaping completionHandlerType){
            let url = URL.init(string: "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/all-sections/7.json?api-key=\(API_KEY)")!
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    
                    XCTAssertNotNil("No data was downloaded.")
                    // Fulfill the expectation to indicate that the background task has finished successfully.
                    expectation.fulfill()
                    return
                    
                }
                
                XCTAssertNotNil("data was downloaded successfully.")
                // Fulfill the expectation to indicate that the background task has finished successfully.
                expectation.fulfill()
                do {
                    if let array = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]{
                        
                        let results = array["results"] as! NSArray
                        
                        completion(results, nil)
                        print(array)
                    }
                } catch {
                    print(error)
                    completion(nil, error)
                }
            }
            task.resume()
            wait(for: [expectation], timeout: 10.0)
        }
        
        }
    }

}
