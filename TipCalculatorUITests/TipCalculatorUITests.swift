//
//  TipCalculatorUITests.swift
//  TipCalculatorUITests
//
//  Created by RaviShankarKushwaha on 19/01/26.
//

import XCTest

final class when_content_view_is_shown: XCTestCase {
    
    private var app: XCUIApplication!

    
    override func setUp() {
        app = XCUIApplication()

        continueAfterFailure = false
        app.launch()
    }

    func test_should_make_sure_that_the_total_text_field_contains_default_value() {
        
        let totalTextField = app.textFields["totalTextField"]
        
        XCTAssertEqual(totalTextField.value as! String, "Enter total")
    }
        
    func test_should_make_sure_the_20_percent_tip_option_is_selected() {
        
        let tipPercentageSegmentedControl = app.segmentedControls["tipPercentageSegmentedControl"]
        let segmentedControlButton = tipPercentageSegmentedControl.buttons.element(boundBy: 1)
        
        XCTAssertEqual(segmentedControlButton.label, "20%")
        XCTAssertTrue(segmentedControlButton.isSelected)
    }
    
    override func tearDown() {
        // clean up
    }
}

class when_calculate_tip_buuton_is_pressed_for_invalid_input: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let totalTextField = app.textFields["totalTextField"]
        totalTextField.tap()
        totalTextField.typeText("-100")
        
        let calculateTipButton = app.buttons["calculateTipButton"]
        calculateTipButton.tap()
    }
    
    func test_should_clear_tip_label_for_invalid_input() {
        
        let tipText = app.staticTexts["tipText"]
        let _ = tipText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(tipText.label, "")
    }
    
    func test_should_display_error_message_for_invalid_input() {
        
        let messageText = app.staticTexts["messageText"]
        let _ = messageText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(messageText.label, "Invalid Input")
    }
}



class when_calculate_tip_buuton_is_pressed_for_valid_input: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launch()
        
        let totalTextField = app.textFields["totalTextField"]
        totalTextField.tap()
        totalTextField.typeText("100")
        
        let calculateTipButton = app.buttons["calculateTipButton"]
        calculateTipButton.tap()
    }
    
    func test_should_make_sure_that_tip_is_displayed_on_the_screen() {
                
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        let tip = formatter.string(from: NSNumber(value: 20.00))
        
        let tipText = app.staticTexts["tipText"]
        let _ = tipText.waitForExistence(timeout: 0.5)
        
        XCTAssertEqual(tipText.label, tip)
    }
}
