//
//  ShowJokeView.swift
//  pia12iosv3mond
//
//  Created by Mohamad Hleihel on 2023-11-16.
//

import SwiftUI

struct ShowJokeView: View {
    
    @Environment (\.dismiss) var dismiss
    
    //@State var bigjoke : Chucknorrisinfo?
    
   // @StateObject var apistuff = ChuckAPI()
    @State var bigapi : ChuckAPI
    var body: some View {
        VStack{
            Text(bigapi.thejoke!.value)
                .font(.largeTitle)
            
            Button(action: {
                bigapi.loadapiRandom()
            }, label: {
                Text("Random")
            })
            
            Button(action: {
                dismiss()
            }, label: {
                Text("Close")
            })
        }
    }
}

#Preview {
    ShowJokeView ()
}
