//
//  ContentView.swift
//  UI-TEMPLETE
//
//  Created by 윤형석 on 2023/08/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
      RoundedTextField(showKeyboard: .constant(false), title: "Title", placeHolder: "PlaceHolder", maxCount: 5)
      
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
