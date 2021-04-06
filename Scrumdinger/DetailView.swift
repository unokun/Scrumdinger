//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Masaaki Uno on 2021/04/06.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(scrum: DailyScrum.data[0])
    }
}
