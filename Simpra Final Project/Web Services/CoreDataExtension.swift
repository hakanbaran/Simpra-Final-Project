//
//  CoreDataExtension.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation
import UIKit

class DataPersistenceManager {
    
    
    enum DatabaseError: Error {
        case failedToSavedData
        
    }
    
    
    static let shared = DataPersistenceManager()
    
    func saveGameWith(model: Game, completion: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let item = GameItem(context: context)
        
        item.id = Int32(model.id ?? 3498)
        item.name = model.name
        item.background_image = model.background_image
        item.released = model.released
        
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSavedData))
            //print(error.localizedDescription)
        }
    }
    
    
}
