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
    
    @State var index = 0
    @State var stories = [
        Story(id: 0, image: "p0", offset: 0, title: "Jack the Persian and the Black Castle"),
        Story(id: 1, image: "p1", offset: 0, title: "The Dreamer"),
        Story(id: 2, image: "p2", offset: 0, title: "Love found again"),
        Story(id: 3, image: "p3", offset: 0, title: "The Haunted Grounds")
    ]
    
    var body: some View{
        ScrollView(.vertical, showsIndicators: true){
            VStack{
                //Top: Menu options
                HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName: "rectangle.3.offgrid")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass.circle")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                }
                .padding()
                
                //Secondary: Main Trending Bar with menu options
                HStack{
                    Text("Trending")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    
                    Spacer(minLength: 0)
                    
                    Button(action: {}) {
                        Image(systemName: "rectangle.grid.1x2")
                            .renderingMode(.template)
                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                    }
                }
                .padding(.horizontal)
                
                //Third: Story Bar
                HStack{
                    Text("Animated")
                        .font(.system(size: 15))
                        .foregroundColor(index == 0 ? .white : Color("Color").opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color("Color1").opacity(index == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index = 0
                        }
                    
                    Text("20+ Series")
                        .font(.system(size: 15))
                        .foregroundColor(index == 1 ? .white : Color("Color").opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color("Color1").opacity(index == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index = 1
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                //Car View
                ZStack{
                    ForEach(stories.reversed()){ story in
                        HStack {
                            Image(story.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(story.id * 50))
                                .cornerRadius(15)
                                .offset(x: story.id <= 2 ? CGFloat(story.id * 30) : 60)
                        }
                        .contentShape(Rectangle())
                        //Add Gesture
                        .offset(x: story.offset)
                        //Adding Drag Gesture
                        .gesture(DragGesture().onChanged({ (value) in
                            
                            withAnimation{
                                
                                stories[story.id].offset = value.translation.width
                            }
                            
                        }).onEnded({(value) in
                            
                            withAnimation{
                                
                            stories[story.id].offset = 0
                            
                            }
                        }))
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .padding(.horizontal,25)
                .padding(.top,25)
                
                Spacer()
            }
        }
        .background(
            LinearGradient(gradient: .init(colors: [Color("top"),Color("bottom")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }
    
    //Creating a Dynamic View
    func calculateWidth()->CGFloat{
        let screen = UIScreen.main.bounds.width - 30
        
        let width = screen - (2 * 30)
        
        return width
    }
    
}

//Sample Data for UI

struct Story : Identifiable {
    
    var id : Int
    var image : String
    var offset : CGFloat
    var title : String
    
}
