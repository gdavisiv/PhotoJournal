//
//  ContentView.swift
//  PhotoJournal
//
//  Created by George Davis IV on 8/14/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    var body: some View{
        ScrollView(.vertical, showsIndicators: true){
            VStack{
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "rectangle.grid.1x2")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                }
            }
        }
    }
}
