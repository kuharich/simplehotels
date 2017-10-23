//
//  SimpleHotelsTests.swift
//  SimpleHotelsTests
//
//  Created by Paul Kite on 6/18/17.
//  Updated by Mark Kuharich on 10/21/17.
//  Copyright © 2017 Expedia, Inc. All rights reserved.
//

import XCTest
import Foundation
import UIKit

protocol MenuItemsReader {
    func readMenuItems() -> ([[String : String]]?, NSError?)
}

let MenuItemsPlistReaderErrorDomain = "MenuItemsPlistReaderErrorDomain"

enum MenuItemsPlistReaderErrorCode : Int {
    case FileNotFound
}

class MenuItemsPlistReader: MenuItemsReader {
    var plistToReadFrom: String? = nil
    
    func readMenuItems() -> ([[String : String]]?, NSError?) {
        let errorMessage =
        "\(plistToReadFrom!).plist file doesn't exist in app bundle"
        
        let userInfo = [NSLocalizedDescriptionKey: errorMessage]
        
        let error = NSError(domain: MenuItemsPlistReaderErrorDomain,
                            code: MenuItemsPlistReaderErrorCode.FileNotFound.rawValue,
                            userInfo: userInfo)
        
        return ([], error)
    }
}

public class ViewController: UIViewController {
    
    public var content: String!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

@testable import SimpleHotels

class SimpleHotelsTests: XCTestCase {
    var sessionUnderTest: URLSession!
    var controllerUnderTest: HotelsViewController!
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        
        UIApplication.shared.keyWindow!.rootViewController = viewController
        
        // Test and Load the View at the Same Time!
        XCTAssertNotNil(navigationController.view)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testErrorIsReturnedWhenPlistFileDoesNotExist() {
        let plistReader = MenuItemsPlistReader()
        plistReader.plistToReadFrom = "notFound"
        
        let (_, error) = plistReader.readMenuItems()
        XCTAssertNotNil(error, "Error is returned when plist doesn't exist")
    }
    
    func testCorrectErrorDomainIsReturnedWhenPlistDoesNotExist() {
        let plistReader = MenuItemsPlistReader()
        plistReader.plistToReadFrom = "notFound"
        
        let (_, error) = plistReader.readMenuItems()
        let errorDomain = error?.domain
        
        XCTAssertEqual(errorDomain!, MenuItemsPlistReaderErrorDomain,
                       "Correct error domain is returned")
    }
    
    func testFileNotFoundErrorCodeIsReturnedWhenPlistDoesNotExist() {
        let plistReader = MenuItemsPlistReader()
        plistReader.plistToReadFrom = "notFound"
        
        let (_, error) = plistReader.readMenuItems()
        let errorCode = error?.code
        
        XCTAssertEqual(errorCode!,
                       MenuItemsPlistReaderErrorCode.FileNotFound.rawValue,
                       "Correct error code is returned")
    }
    
    func testCorrectErrorDescriptionIsReturnedWhenPlistDoesNotExist() {
        let plistReader = MenuItemsPlistReader()
        plistReader.plistToReadFrom = "notFound"
        
        let (_, error) = plistReader.readMenuItems()
        let userInfo = error?.userInfo
        let description: String =
            userInfo![NSLocalizedDescriptionKey]! as! String
        
        XCTAssertEqual(description,
                       "notFound.plist file doesn't exist in app bundle",
                       "Correct error description is returned")
    }
}
