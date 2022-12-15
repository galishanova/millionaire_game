//
//  Question.swift
//  millionaire
//
//  Created by Regina Galishanova on 15.05.2021.
//

import Foundation

struct Question: Codable {
    var question: String
    var answers: [String]
    var correctAnswer: String
}

extension Question: Equatable {
    static func == (lhs: Question, rhs: Question) -> Bool {
        return lhs.question == rhs.question
    }
}

let question = Question(question: "", answers: [], correctAnswer: "")

class QuestionService {
    func getQuestions() -> [Question] {
        return [
            Question(question: "Какой город объявлен официальной родиной русского Деда Мороза?",
                     answers: ["Малая Вишера", "Нижний Новгород", "Вышний Волочек"],
                     correctAnswer: "Великий Устюг"),
            Question(question: "Что проводит боксер, наносящий удар противнику снизу?",
                     answers: ["Свинг", "Хук", "Джэб"],
                     correctAnswer: "Апперкот"),
            Question(question: "К кому первому обратились за помощью дед и бабка, не справившись с репкой?",
                     answers: ["К Жучке", "К дочке", "К залу"],
                     correctAnswer: "К внучке"),
            Question(question: "Кого нет среди смешариков?",
                     answers: ["Свиньи", "Лося", "Барана"],
                     correctAnswer: "Коня"),
            Question(question: "Как называется ближайшая к Земле звезда?",
                     answers: ["Проксиома Центавра", "Полярная", "Солнце"],
                     correctAnswer: "Солнце")
        ]
    }
}
