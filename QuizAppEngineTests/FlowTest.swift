//
//  FlowTest.swift
//  QuizAppEngineTests
//
//  Created by Juno James on 2024-06-21.
//

import Foundation
import XCTest
@testable import QuizAppEngine

class FlowTest: XCTestCase {
    func test_start_withNoQuestions_doesNotRouteToQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: [], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestionCount, 0)
    }
    
    func test_start_withOneQuestion_routesToQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1"], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestionCount, 1)
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions: ["Q1"], router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestion, "Q1")
    }
    
    class RouterSpy: Router {
        var routedQuestionCount: Int = 0
        var routedQuestion: String? = nil
        
        func routeTo(question: String) {
            routedQuestionCount += 1
        }
    }
}
