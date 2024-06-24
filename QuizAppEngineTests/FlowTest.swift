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
    let router = RouterSpy()
    
    func test_start_withNoQuestions_doesNotRouteToQuestion(){
        makeSUT(questions:[]).start()
        
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    
    
    func test_start_withOneQuestion_routesToCorrectQuestion(){
        makeSUT(questions:["Q1"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routesToCorrectQuestion_2(){
        makeSUT(questions:["Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestion_routesToFirstQuestion(){
        makeSUT(questions:["Q1", "Q2"]).start()
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice(){
        let sut = makeSUT(questions:["Q1", "Q2"])

        sut.start()
        sut.start()

        XCTAssertEqual(router.routedQuestions, ["Q1", "Q1"])
    }
    
    func test_startAndAnswerFirstquestion_withTwoQuestion_routesToSecondQuestion(){
        let sut = makeSUT(questions:["Q1", "Q2"])
        sut.start()
        
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1", "Q2"])
    }
    
    
    
    // MARK: Helpers
    
    func makeSUT(questions: [String])-> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        var routedQuestions: [String] = []
        var answerCallback: ((String) -> Void) = {_ in }
        
        func routeTo(question: String,
                answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}
