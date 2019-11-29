//
//  KB_advent2018_day1Tests.swift
//  KB_advent2018_day1Tests
//
//  Created by Kangyoon Bae on 11/27/19.
//  Copyright © 2019 appforcivil. All rights reserved.
//
import Foundation
import XCTest

@testable import KB_advent2018_day1

class KB_advent2018_day1Tests: XCTestCase {
    var viewController: ViewController!
    
    override func setUp() {
        super.setUp()
        //Loading ViewController to test
        let storyboard = UIStoryboard(name: "Main",
                                      bundle: Bundle.main)
        viewController = storyboard.instantiateInitialViewController() as! ViewController
        UIApplication.shared.keyWindow!.rootViewController = viewController
    }
    
    func testCalculateFinalFrequency(){
        //Testing with examples
        let exampleOneArrayOfFrequencychanges = ["+1", "-2", "+3", "+1"]
        XCTAssertTrue(viewController.calculateFinalFrequency(changeOfFrequencyArray: exampleOneArrayOfFrequencychanges) == 3)
        
        let exampleTwoArrayOfFrequencychanges = ["+1", "+1", "+1"]
        XCTAssertTrue(viewController.calculateFinalFrequency(changeOfFrequencyArray: exampleTwoArrayOfFrequencychanges) == 3)
        
        let exampleThreeArrayOfFrequencychanges = ["+1","+1","-2"]
        XCTAssertTrue(viewController.calculateFinalFrequency(changeOfFrequencyArray: exampleThreeArrayOfFrequencychanges) == 0)
        
        let exampleFourArrayOfFrequencychanges = ["-1", "-2", "-3"]
        XCTAssertTrue(viewController.calculateFinalFrequency(changeOfFrequencyArray: exampleFourArrayOfFrequencychanges) == -6)
    }
    
    func testFindFirstDuplicatedFrequency(){
        //Testing with examples
        let exampleOneArrayOfFrequencychanges = ["+1", "-2", "+3", "+1"]
        XCTAssertTrue(viewController.findFirstDuplicatedFrequency(changeOfFrequencyArray: exampleOneArrayOfFrequencychanges) == 2)
        
        let exampleTwoArrayOfFrequencychanges = ["+1", "-1"]
        XCTAssertTrue(viewController.findFirstDuplicatedFrequency(changeOfFrequencyArray: exampleTwoArrayOfFrequencychanges) == 0)
        
        let exampleThreeArrayOfFrequencychanges = ["+3","+3","+4","-2","-4"]
        XCTAssertTrue(viewController.findFirstDuplicatedFrequency(changeOfFrequencyArray: exampleThreeArrayOfFrequencychanges) == 10)
        
        let exampleFourArrayOfFrequencychanges = ["-6","+3","+8","+5","-6"]
        XCTAssertTrue(viewController.findFirstDuplicatedFrequency(changeOfFrequencyArray: exampleFourArrayOfFrequencychanges) == 5)
        
        let exampleFiveArrayOfFrequencychanges = ["+7","+7","-2","-7","-4"]
        XCTAssertTrue(viewController.findFirstDuplicatedFrequency(changeOfFrequencyArray: exampleFiveArrayOfFrequencychanges) == 14)
    }
    
}
