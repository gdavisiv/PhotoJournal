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
    
    @State var scrolled = 0
    @State var index1 = 0
    
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
                    
                    Text("20+ Stories")
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
                            ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)){
                                Image(story.image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: calculateWidth(), height: (UIScreen.main.bounds.height / 1.8) - CGFloat(story.id - scrolled) * 50)
                                    .cornerRadius(15)
                                
                                VStack(alignment: .leading, spacing: 18) {
                                    HStack {
                                        Text(story.title)
                                            .font(.title)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                        Spacer()
                                    }
                                    
                                    Button(action: {}) {
                                        Text("Read Now")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
                                            .padding(.vertical,6)
                                            .padding(.horizontal, 25)
                                            .background(Color("Color1"))
                                            .clipShape(Capsule())
                                    }
                                }
                                .frame(width: calculateWidth() - 40)
                                .padding(.leading, 20)
                                .padding(.vertical, 20)
                            }
                            .offset(x: story.id - scrolled <= 2 ? CGFloat(story.id - scrolled) * 30 : 60)
                        }
                        .contentShape(Rectangle())
                        //Add Gesture
                        .offset(x: story.offset)
                        //Adding Drag Gesture
                        .gesture(DragGesture().onChanged({ (value) in
                            
                            withAnimation{
                                
                                //Disable drag gesture for last card
                                if value.translation.width < 0 && story.id != stories.last!.id {
                                    stories[story.id].offset = value.translation.width
                
                                }
                                //restore cards
                                else{
                                    if story.id > 0{
                                        stories[story.id - 1].offset = -(calculateWidth() + 60) + value.translation.width
                                    }
                                }
                            }
                        }).onEnded({ (value) in
                            
                            withAnimation{
                                
                                if value.translation.width < 0{
                                    
                                    if -value.translation.width > 180 && story.id != stories.last!.id{
                                        //Moves the View Away
                                        stories[story.id].offset = -(calculateWidth() + 60)
                                        scrolled += 1
                                    }
                                    else{
                                        stories[story.id].offset = 0
                                    }
                                }
                                else{
                                    
                                    //Restore the cards
                                    if story.id > 0{
                                        
                                        if value.translation.width > 180{
                                            stories[story.id - 1].offset = 0
                                            scrolled -= 1
                                        }
                                        else{
                                            stories[story.id - 1].offset = -(calculateWidth() + 60)
                                            scrolled -= 1
                                        }
                                    }
                                }
                            }
                        }))
                    }
                }
                .frame(height: UIScreen.main.bounds.height / 1.8)
                .padding(.horizontal,25)
                .padding(.top,25)
                
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
                .padding(.top, 25)
                
                HStack{
                    Text("Latest")
                        .font(.system(size: 15))
                        .foregroundColor(index1 == 0 ? .white : Color("Color").opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color("Color").opacity(index1 == 0 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index1 = 0
                        }
                    
                    Text("5+ Stories")
                        .font(.system(size: 15))
                        .foregroundColor(index1 == 1 ? .white : Color("Color").opacity(0.85))
                        .fontWeight(.bold)
                        .padding(.vertical,6)
                        .padding(.horizontal,20)
                        .background(Color("Color").opacity(index1 == 1 ? 1 : 0))
                        .clipShape(Capsule())
                        .onTapGesture {
                            index1 = 1
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 10)
                
                HStack{
                    Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: UIScreen.main.bounds.width - 80, height: 250)
                        .cornerRadius(15)
                    
                    Spacer(minLength: 0)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                .padding(.bottom)
                
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
