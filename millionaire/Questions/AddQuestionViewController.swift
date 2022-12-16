//
//  SettingsViewController.swift
//  millionaire
//
//  Created by Regina Galishanova on 06.06.2021.
//

import UIKit


class AddQuestionViewController: UIViewController {
    @IBOutlet weak var addQuestionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet var answersTextFields: [UITextField]!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var difficulty: Difficulty = .consistent
    
    private var createQuestionStrategy: CreateQuestionsStrategy {
        switch self.difficulty {
        case .consistent:
            return ConsistentQuestionStrategy()
        case .random:
            return RandomQuestionStrategy()
        }
    }
    
    var usersQuestions: [Question] = [] {
        didSet {
            let userQuestion = Game.shared.questions
            usersQuestions.append(contentsOf: userQuestion)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnScroll))
        scrollView?.addGestureRecognizer(tapGesture)
        scrollView.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func getUsersQuestion() {
        let addedQuestion = questionTextField.text ?? ""
        let addedAnswers = answersTextFields.map { $0.text ?? "" }

        let usersQuestion = Question(question: addedQuestion,
                                     answers:  addedAnswers,
                                     correctAnswer: addedAnswers.last ?? "")
        Game.shared.addQuestion(usersQuestion)
    }
    
    func showSuccessAlert() {
        let successMessage = "Вопрос '\(questionTextField.text!)' успешно добавлен"
        let alert = UIAlertController(title: "Добавлено",
                                      message: successMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func showErrorAlert() {
        let errorMessage = "Для добавления вопроса необходимо заполнить все пустые поля"
        let alert = UIAlertController(title: "Ошибка",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func clearTextFields() {
        questionTextField.text = ""
        answersTextFields.forEach { $0.text = "" }
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        guard let kbSize = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: kbSize.size.height, right: 0)
        scrollView.contentInset = insets
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        let insets = UIEdgeInsets.zero
        scrollView.contentInset = insets
    }
    
    @objc func didTapOnScroll() {
        view.resignFirstResponder()
        self.scrollView?.endEditing(true)
    }
    
    @IBAction func closeButtonTaped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addQuestion(_ sender: UIButton) {
        if questionTextField.text == "" || answersTextFields.map({ $0.text }).isEmpty {
            showErrorAlert()
        } else {
            getUsersQuestion()
            showSuccessAlert()
            clearTextFields()
        }
    }
}
