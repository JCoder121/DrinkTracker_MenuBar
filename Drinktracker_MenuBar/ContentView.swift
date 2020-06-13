//
//  ContentView.swift
//  Drinktracker_MenuBar
//
//  Created by Jeffrey Chen on 6/11/20.
//  Copyright © 2020 Jeffrey Chen. All rights reserved.
//

import SwiftUI

/*
 
 To do:
 1. buttons, progress bar, text display done
 2. make everything pretty, change icon in menubar done
 3. package and make app need to finish
 4. coredata and save no
 5. daily goals -> view old log, see if day thing is met no
 6. push notifications? no
 
 sources:
 medium (primary): https://medium.com/@acwrightdesign/creating-a-macos-menu-bar-application-using-swiftui-54572a5d5f87
 
 other one: https://8thlight.com/blog/casey-brant/2019/05/21/macos-menu-bar-extras.html
 
 ray wen: https://www.raywenderlich.com/450-menus-and-popovers-in-menu-bar-apps-for-macos
 */

struct ContentView: View {
  
    //only integers for counting, no half ounces etc.
    @State var total_water = 0
    @State var entered_water = ""
    @State var isInt = true
  
    let prog_bar_height = CGFloat(20)
    let prog_bar_width = CGFloat(320)
    
    let font_name = "Marker Felt Thin"
    let font_size = CGFloat(50)
    
    let number_check = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    
    var body: some View {
        
        VStack {

            //total water to keep track of
            Text("Total: " + String(total_water) + " oz").font(.custom(font_name, size: font_size)).frame(maxWidth: .infinity, maxHeight: .infinity)
            
            //progress bar
            ZStack(alignment: .leading) {
                Rectangle().frame(maxWidth: prog_bar_width, maxHeight: prog_bar_height)
                    .opacity(0.3)
                    .foregroundColor(Color.red)
            
                Rectangle().frame(maxWidth: CGFloat(5), maxHeight: prog_bar_height)
                    .foregroundColor(Color.blue)
                
                //amount consumed scaled to fit window
                Rectangle().frame(maxWidth: min((prog_bar_width*CGFloat(Float(self.total_water)/128)), CGFloat(320)), maxHeight: prog_bar_height)
                        .foregroundColor(Color.blue)
                        .animation(.linear)
             
            }.cornerRadius(45.0)
            .padding()
            
            //input
            TextField("... oz", text: $entered_water).padding()
            
            HStack {
                
                //add water button, disabled if nothing entered in field
                Button(action: {
                    
                    //check if entered value contains only numbers
                    self.isInt = true
                    
                    //very inefficient way
                    for char in self.entered_water {
                        if !(self.number_check.contains(String(char))) {
                            self.isInt = false
                            self.entered_water = ""
                        }
                    }
                    
                    if self.isInt {
                        self.total_water += Int(self.entered_water)!
                        self.entered_water = ""
                    }
                    
                })
                {
                    Text("Add")
                }.disabled(self.entered_water == "")
                
                //reset button
                Button(action: {
                    self.total_water = 0
                })
                {
                    Text("Reset")
                }.disabled(self.total_water == 0)
            
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





