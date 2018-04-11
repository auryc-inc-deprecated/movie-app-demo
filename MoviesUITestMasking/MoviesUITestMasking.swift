//
//  MoviesUITests.swift
//  MoviesUITests
//
//  Created by Sarah Wang on 1/4/18.
//  Copyright © 2018 iKode Ltd. All rights reserved.

import XCTest

class MoviesUITestMasking: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func tapOntheCell(cellNumber:Int, onTable:String){
        
        let myTable = self.app.tables[onTable]
        let cell = myTable.cells.element(boundBy: cellNumber)
        cell.tap()
    }
    
    
    func tapOntheCollection(collectionName:String){
        
        let myCollection = self.app.collectionViews[collectionName]
        let firstChild = myCollection.cells.children(matching: .any).element(boundBy: 0)
        
        //self.app.collectionViews.children().element(boundBy:0)
        
        if firstChild.exists {
            firstChild.tap()
        }
    }
    
    func swipeRightOntheCollection(){
        let firstChild = app.collectionViews.children(matching:.any).element(boundBy:0)
        if firstChild.exists {
            firstChild.tap()
        }
    }
    
    
    //        func testDeleteItem() {
    //            app.collectionViews.staticTexts["Item"].tap()
    //            app.buttons["Delete"].tap()
    //
    //            XCTAssertEqual(app.collectionViews.cells.countForHittables, 2)
    //            XCTAssertFalse(app.collectionViews.cells.staticTexts["Item"].hittable)
    //        }
    
    
    
    func backButton() {
        self.app.buttons["Back Button"].tap()
    }
    
    
    func goToBackground(){
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(3)
        
        self.app.activate()
        //        if #available(iOS 11.2, *) {
        ////            self.app.activate()
        //            XCUIDevice.shared.accessibilityActivate()(voiceRecognitionText: "Open {Movies}")
        //
        //        } else {
        //            assertionFailure("Fail because Siri service is not activated")
        //        }
        
    }
    
    
    func popNavigationBar(){
        self.app.navigationBars.buttons.element(boundBy: 0).tap()
    }
    
    
    func tapOnElement(element: XCUIElement){
        
        if(element.exists){
            element.tap()
        }else{
            print(" element does not exist %@", element.description)
        }
    }
    
    func gestures(){
        app.swipeUp()
        app.swipeDown()
        app.swipeLeft()
        app.swipeRight()
        let image = app.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1) // zoom in
        image.pinch(withScale: 2, velocity: 1) // zoom out
        //        XCUIDevice.shared.orientation = .landscapeLeft
        //        XCUIDevice.shared.orientation = .portrait
        //
    }
    
    func performanceTest(){
        
        tapOntheCell(cellNumber:2, onTable: "movies table")
        gestures()
        
        //        self.tapOnElement(element: self.app.images["posterImageView"])
        
        
        
        tapOntheCollection(collectionName:"similar movie collection")
        
        self.backButton()
        
        
        tapOntheCell(cellNumber:1, onTable: "movies table")
        
        for index in 1...7 {
            
            self.app.swipeUp()
            self.app.buttons["view similar movie"].tap()
            self.swipeRightOntheCollection()
            
        }
        
        for index2 in 1...7 {
            self.backButton()
            self.popNavigationBar()
        }
        
        
        self.app.swipeDown()
        //        tapOntheCell(cellNumber:1, onTable: "movies table")
        
        self.app.buttons["bookmark"].tap()
        self.app.buttons["watchTrailer"].tap()
        self.tapOnElement(element: self.app.otherElements["Description Label"])
        
        self.app.swipeUp()
        sleep(1)
        
        self.goToBackground()
        self.backButton()
        
        
        
    }
    
    //    func swipeFromVeryLeft(){
    //not working
    //        let fromCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 20))
    //        let toCoordinate = app.coordinate(withNormalizedOffset: CGVector(dx: 600, dy: 20))
    //        fromCoordinate.press(forDuration:0, thenDragTo: toCoordinate)
    //
    //    }
    func testExample() {
        
        
        var index = 0
        for index in 1...3 {
            performanceTest()
        }
        
        XCUIDevice.shared.press(XCUIDevice.Button.home)
        sleep(100)
        //
        
    }
    
    
    //      pinch(withScale: CGFloat, velocity: CGFloat)
    //    rotate(CGFloat, withVelocity: CGFloat)
}
