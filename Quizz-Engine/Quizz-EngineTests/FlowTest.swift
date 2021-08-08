//
//  FlowTest.swift
//  Quizz-EngineTests
//
//  Created by Kelvin Birikorang on 08/08/2021.
//

import Foundation
import XCTest
@testable import Quizz_Engine

class FlowTest: XCTestCase{
    
    func test_start_withNoQuestion_doesNotRouteToQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:[],router: router)
        sut.start()
        XCTAssertTrue(router.routedQuestions.isEmpty)
    }
    

    func test_start_withOneQuestion_routeToCorrectQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1"],router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestion_routeToCorrectQuestion_2(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q2"],router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1","Q2"],router: router)
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_startTwice_withTwoQuestions_routesToFirstQuestionTwice(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1","Q2"],router: router)
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerQuestion_withTwoQuestions_routesToSecondQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1","Q2"],router: router)
        sut.start()
        router.answerCallback("A1")
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    
    class RouterSpy:Router{
        var routedQuestions:[String] = []
        var answerCallback: ((String) -> Void) = {_ in}
        func routeToQuestion(question: String,answerCallback: @escaping (String) -> Void) {
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    
    }
}
