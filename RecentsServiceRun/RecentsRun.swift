//
//  RecentsRun.swift
//  RecentsServiceRun
//
//  Created by Jaeyoung Choi on 9/12/24.
//

import Foundation
import ArgumentParser
import RecentsService

@main
struct RecentsRun: AsyncParsableCommand {
    
    @Argument(help: "Mode: clear")
    var mode: String?
    
    @Option
    var add: String? = nil
    
    func run() throws {
        let service = RecentsService()
        
        if mode == "clear" {
            service.clear()
            print("Clear Done.")
        } else if let add = add {
            service.add(term: add)
            print("New Item Added:", add)
        }
        
        let all = service.recentsAll()
        if all.count > 0 {
            print(all)
        } else {
            print("No Search History")
        }
    }
}
