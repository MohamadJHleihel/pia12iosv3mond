//
//  ContentView.swift
//  pia12iosv3mond
//
//  Created by Mohamad Hleihel on 2023-11-13.
//

import SwiftUI




struct ContentView: View {
    

    
    @State var searchtext = ""
    

    
    @StateObject var apistuff = ChuckAPI()
    
    @State var showjoke = false
    
    
    
    var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    var body: some View {
        
        ZStack {
            VStack {

                VStack {
                    if apistuff.thejoke != nil {
                        Text(apistuff.thejoke!.created_at)
                        Text(apistuff.thejoke!.value)
                        
                        Button(action: {
                            showjoke = true
                        }, label: {
                            Text("Show Joke")
                        })
                        .sheet(isPresented: $showjoke, content: {
                            ShowJokeView(bigjoke: apistuff.thejoke)
                            Button(action: {
                                showjoke = false
                            }, label: {
                                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
                            })
                        })
                    }
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(height: 200.0)
                .background(Color.gray)

                if apistuff.errormessage != "" {
                    VStack {
                        Text(apistuff.errormessage)
                            .foregroundColor(Color.white)
                    }
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                    .frame(height: 100.0)
                    .background(Color.red)

                }

                
                HStack {
                    TextField("Search joke...", text: $searchtext)
                    
                    Button(action: {
                        apistuff.loadapiForSearch(jokesearch: searchtext)
                    }, label: {
                        Text("Search")
                    })
                }
                
                Button(action: {
               
                    apistuff.loadapiRandom()
                }, label: {
                    Text("Random joke")
                })
                
                List {
                    ForEach(apistuff.jokecategories, id: \.self) { cat in
                        /*
                        Button(action: {
                            loadapiForCategory(jokecat: cat)
                        }, label: {
                            Text(cat)
                        })
                        */
                        
                        VStack {
                            Text(cat)
                        }
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .frame(height: 80)
                        .onTapGesture {
                            apistuff.loadapiForCategory(jokecat: cat)
                        }
                        
                    }
                }
                
                
                
            }
            .padding()
            
            if apistuff.isloading {
                VStack {
                    Text("LOADING...")
                    ProgressView()
                }
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                .frame(maxHeight: .infinity)
                .background(Color.gray)
                .opacity(0.5)
            }
            
        }
        .onAppear() {
            Task {
                await apistuff.loadcategories()
            }
        }
        
        
    }
    

}

#Preview {
    ContentView()
}



