//
//  JSONManager.swift
//  POCdataPersistence
//
//  Created by Giovani de Oliveira Coutinho on 06/11/20.
//

import Foundation
import UIKit

class JSONManager<Entity> where Entity:Codable{
    private func getURL(fileName: String) -> URL?{
        do {
            var url = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            url.appendPathComponent(fileName)
            return url
        }catch {
            print(error)
            return nil
        }
    }
    
    func saveJSON(json: Entity, fileName: String, completion: ((Entity?, Error?) ->())? = nil){
        let block = JSONOperation(block: {[self] in
            do {
                if let url = getURL(fileName: fileName) {
                    let data = try JSONEncoder().encode(json)
                    let myJson = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                    // SALVAR ARQUIVO
                    try myJson.write(to: url)
                    completion?(json,nil)
                }else{
                    print("Failed generating url")
                }
            } catch {
                print(error)
            }
        })
        block.queuePriority = .veryHigh
        block.kind = .save
        
        QueueManager.sharedInstance.executeBlock(block, queueType: .serial)
        
    }
    
    func getJSON(fileName: String, completion: @escaping (Entity?, Error?) ->()){
        let block = JSONOperation(block: { [self] in
            do {
                if let url = getURL(fileName: fileName){
                    let file = NSDictionary(contentsOf: url)
                    // LER ARQUIVO
                    let readJSON = try JSONSerialization.data(withJSONObject: file!, options: [])
                    let decoded = try JSONDecoder().decode(Entity.self, from: readJSON)
                    completion(decoded, nil)
                }else{
                    print("Failed generating url")
                    completion(nil,nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        })
        block.queuePriority = .veryLow
        block.kind = .read
        if let op = QueueManager.sharedInstance.getQueue(.serial).operations.first(where: {($0 as? JSONOperation)?.kind == .save}){
            block.addDependency(op)
        }
        QueueManager.sharedInstance.executeBlock(block, queueType: .serial)
    }
    
    func getJSON(url: URL?, completion: @escaping (Entity?, Error?) ->()){
        let block = JSONOperation(block: { [self] in
            do {
                if let url = url{
                    let data = try Data(contentsOf: url)
                    // LER ARQUIVO
                    let readJSON = try JSONSerialization.jsonObject(with: data, options: []) 
                    let jsonData = try JSONSerialization.data(withJSONObject: readJSON, options: [])
                    let decoded = try JSONDecoder().decode(Entity.self, from: jsonData)
                    completion(decoded, nil)
                }else{
                    print("Failed generating url")
                    completion(nil,nil)
                }
            } catch {
                print(error)
                completion(nil, error)
            }
        })
        block.queuePriority = .veryLow
        block.kind = .read
        if let op = QueueManager.sharedInstance.getQueue(.serial).operations.first(where: {($0 as? JSONOperation)?.kind == .save}){
            block.addDependency(op)
        }
        QueueManager.sharedInstance.executeBlock(block, queueType: .serial)
    }
}


enum JSONOperationKind {
    case save
    case read
}
class JSONOperation: BlockOperation{
    var kind: JSONOperationKind = .save
}
