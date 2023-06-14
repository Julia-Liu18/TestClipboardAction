//
//  TestClipboardUITest.swift
//  NewTestUITests
//
//  Created by Julia on 2023/6/14.
//

import XCTest

class TestClipboardUITest: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testCopyFeature() throws {
        let textFiled = app.textFields["输入要复制的文本"]
        XCTAssertTrue(textFiled.exists)
        textFiled.clearAndEnterText(text: "Input Content")
        
        XCTAssertTrue(app.buttons["复制"].exists)
        app.buttons["复制"].tap()
        app.wait(for: .runningForeground, timeout: 5)
        let string = UIPasteboard.general.string
        print("Julia: \(string)")
        XCTAssertNotNil(string)
    }

}

extension XCUIElement {
    // remove any current text before typing new text in TextFiled
    func clearAndEnterText(text: String) {
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        self.tap()
        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        self.typeText(deleteString)
        self.typeText(text)
    }
}


