//
//  Flow.swift
//  Quizz-Engine
//
//  Created by Kelvin Birikorang on 08/08/2021.
//

import Foundation

protocol Router{
    func routeToQuestion(question:String,answerCallback: @escaping (String) -> Void)
}

class Flow {
    let router:Router
    let questions:[String]
    init(questions:[String],router:Router) {
        self.questions = questions
        self.router = router
    }
    
    func start() {
        if let firstQuestion = questions.first{
            router.routeToQuestion(question: firstQuestion){[weak self]_ in
                guard let strongSelf = self else{return}
                let firstQuestionIndex = strongSelf.questions.firstIndex(of: firstQuestion)!
                let nextQuestion = strongSelf.questions[firstQuestionIndex+1]
                
                strongSelf.router.routeToQuestion(question:nextQuestion){_ in}
                
               
            }
            
                
                
            }
        }
        
    }

