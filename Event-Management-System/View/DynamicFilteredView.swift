//
//  DynamicFilteredView.swift
//  Event-Management-System
//
//  Created by Leng Mouyngech on 4/6/22.
//

import SwiftUI
import CoreData

struct DynamicFilteredView<Content: View, T>: View where T: NSManagedObject{
    @FetchRequest var request: FetchedResults<T>
    let content: (T)->Content
    
    // MARK: Building Custom ForEach Which Will Give CoreData Object View
    init(dataToFilter: Date, @ViewBuilder content: @escaping (T)->Content){
        
        // MARK: Predicate to Filter current date Task
        let calendar = Calendar.current
        
        let today = calendar.startOfDay(for: dataToFilter)
        let tomorrow = calendar.date(byAdding: .day,value: 1, to: today)!
        
        // Filter key
        let filterKey = "taskDate"
        // This will fetch betweet today and tomorrow which is 24h
        let predicate = NSPredicate(format: "\(filterKey) >= %@ AND \(filterKey) < %@", argumentArray: [today, tomorrow])
        
        // Intializing Request with NPredicate
        // Adding Sort
        _request = FetchRequest(entity: T.entity(), sortDescriptors: [.init(keyPath: \Task.taskDate, ascending: false)], predicate: predicate)
        self.content = content
    }
    
    var body: some View {
        if request.isEmpty{
            Text("No tasks found!!!")
                .font(.system(size: 16))
                .fontWeight(.light)
                .offset(y:100)
        }
        else{
            ForEach(request,id: \.objectID) { object in
                self.content(object)
            }
        }
    }
}

