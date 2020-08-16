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
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass.circle")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                }
                .padding()
                
                
                HStack{
                    Text("Trending")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "circle.grid.2x2")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
}
