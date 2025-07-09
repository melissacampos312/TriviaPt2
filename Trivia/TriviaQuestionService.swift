//
//  TriviaQuestionService.swift
//  Trivia
//
//  Created by Melissa Campos Huallanca on 7/8/25.
//

import Foundation

class TriviaQuestionService {
    func fetchTriviaQuestions(completion: @escaping ([TriviaQuestion]) -> Void) {
        let urlString = "https://opentdb.com/api.php?amount=5"
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            guard let data = data else{return}
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(TriviaResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
                
            }catch{
                print("Decoding error: \(error)")
            }
            
        }.resume()
        
    }
}
