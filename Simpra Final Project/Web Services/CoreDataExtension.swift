//
//  CoreDataExtension.swift
//  Simpra Final Project
//
//  Created by Hakan Baran on 25.01.2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistenceManager {
    
    enum DatabaseError: Error {
        case failedToSavedData
        case failedToFetchData
        case failedToDeleteData
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
    
    func fetchingGamesFromDataBase(completion: @escaping((Result<[GameItem], Error>) -> Void)) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<GameItem>
        request = GameItem.fetchRequest()
        do {
            let games = try context.fetch(request)
            completion(.success(games))
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
            //print(error.localizedDescription)
        }
    }
    
    func deleteGameWith(model: GameItem, completion: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
    
    func addGameComment(model: GameComment, completion: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let item = GameComments(context: context)
        item.gameName = model.gameName
        item.gameComment = model.gameComment
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToSavedData))
            //print(error.localizedDescription)
        }
    }
    
    func fetchingGamesCommentsFromDataBase(completion: @escaping((Result<[GameComments], Error>) -> Void)) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let request : NSFetchRequest<GameComments>
        request = GameComments.fetchRequest()
        do {
            let gameCommentss = try context.fetch(request)
            completion(.success(gameCommentss))
        }catch {
            completion(.failure(DatabaseError.failedToFetchData))
            //print(error.localizedDescription)
        }
    }
    
    func deleteGameCommentWith(model: GameComments, completion: @escaping(Result<Void, Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do {
            try context.save()
            completion(.success(()))
        }catch {
            completion(.failure(DatabaseError.failedToDeleteData))
        }
    }
}
