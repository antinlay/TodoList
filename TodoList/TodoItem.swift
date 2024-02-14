//
//  TodoItem.swift
//  TodoList
//
//  Created by Ляхевич Александр Олегович on 14.02.2024.
//

import Foundation

enum Importance: Decodable {
  case noMatter
  case usually
  case important
}

struct TodoItem: Decodable {
  let id: String
  let text: String
  let importance: Importance
  let deadline: Date?
  
  init(id: String = UUID().uuidString, text: String, importance: Importance, deadline: Date?) {
    self.id = id
    self.text = text
    self.importance = importance
    self.deadline = deadline
  }
}

extension TodoItem {
  static func parse(json: Any) -> TodoItem? {
    guard let jsonData = try? JSONSerialization.data(withJSONObject: json, options: []), 
          let item = try? JSONDecoder().decode(TodoItem.self, from: jsonData) else {
      return nil
    }
    return item
  }
  
  var json: Any {
    var jsonObject: [String: Any] = [
      "id": id,
      "text": text
    ]
    
    if importance != .usually {
      jsonObject["importance"] = importance
    }
    
    if let deadline = deadline {
      let dateFormatter = DateFormatter()
      dateFormatter.dateStyle = .long
      let dateString = dateFormatter.string(from: deadline)
      
      jsonObject["deadline"] = dateString
    }
    return jsonObject
  }
  
}
