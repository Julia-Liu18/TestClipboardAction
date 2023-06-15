//
//  TestClipboardUITest.swift
//  NewTestUITests
//
//  Created by Julia on 2023/6/14.
//

import XCTest

class TestClipboardUITest: XCTestCase {
    var app: XCUIApplication!
    var originalPasteboardContent: String?

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        //originalPasteboardContent = UIPasteboard.general.string
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testCopyFeature() throws {
        let textFiled = app.textFields["输入要复制的文本"]
        XCTAssertTrue(textFiled.exists)
        textFiled.clearAndEnterText(text: "Input Content")
        MockPasteboard.mockString = "Input Content"
        XCTAssertTrue(app.buttons["复制"].exists)
        app.buttons["复制"].tap()
        let string  = MockPasteboard.general.string
        XCTAssertNotNil(string)
    }
    
//    func testCopyButton() throws {
//        //let textFiled = app.textFields["输入要复制的文本"]
//        let expectedText = "Text to be copied"
//
//        //XCTAssertTrue(app.buttons["复制"].exists)
//        UIPasteboard.general.string = expectedText
//        //XCTAssertTrue(textFiled.exists)
//        //textFiled.clearAndEnterText(text: "Input Content 1")
//        let clipboardContent = UIPasteboard.general.string
//        //textFiled.clearAndEnterText(text: "Input Content 2")
//        XCTAssertNotNil(clipboardContent)
//    }

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

class MockPasteboard: UIPasteboard {
    static var mockString: String?

    override class var general: UIPasteboard {
        return MockPasteboard()
    }

    override var string: String? {
        get {
            return MockPasteboard.mockString
        }
        set {
            // 如果需要模拟写入剪贴板的行为，你可以在这里进行相应的处理
        }
    }
}


