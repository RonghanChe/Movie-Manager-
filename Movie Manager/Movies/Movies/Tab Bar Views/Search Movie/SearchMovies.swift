//
//  SearchMovies.swift
//  Movies
//
//  Created by Ronghan Che on 11/17/20.
//  Copyright © 2020 Ronghan Che. All rights reserved.
//

import SwiftUI

struct SearchMovies: View {
    
    @State private var searchFieldValue = ""
    @State private var showMissingInputDataAlert = false
    @State private var searchCompleted = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.gray.opacity(0.1).edgesIgnoringSafeArea(.all)
                Form {
                    Section(header: Text("Enter Movie Title To Search")) {
                        HStack {
                            TextField("Enter Search Query", text: $searchFieldValue)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .disableAutocorrection(true)
                            // Button to clear the text field
                            Button(action: {
                                self.searchFieldValue = ""
                                self.showMissingInputDataAlert = false
                                self.searchCompleted = false
                            }) {
                                Image(systemName: "clear")
                                    .imageScale(.medium)
                                    .font(Font.title.weight(.regular))
                            }
                        }   // End of HStack
                        .frame(minWidth: 300, maxWidth: 500)
                    }
                    
                    Section(header: Text("Search Movies")) {
                        HStack {
                            Button(action: {
                                if self.inputDataValidated() {
                                    self.searchApi()
                                    self.searchCompleted = true
                                } else {
                                    self.showMissingInputDataAlert = true
                                }
                            }) {
                                Text(self.searchCompleted ? "Search Completed" : "Search")
                            }
                            .frame(width: 240, height: 36, alignment: .center)
                            .background(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(Color.black, lineWidth: 1)
                            )
                        }   // End of HStack
                    }
                    
                    if searchCompleted {
                        Section(header: Text("List Movies Found")) {
                            NavigationLink(destination: showSearchResults) {
                                HStack {
                                    Image(systemName: "list.bullet")
                                        .imageScale(.medium)
                                        .font(Font.title.weight(.regular))
                                        .foregroundColor(.blue)
                                    Text("List Movies Found")
                                        .font(.system(size: 16))
                                }
                            }
                            .frame(minWidth: 300, maxWidth: 500)
                        }
                    }
                    
                }   // End of Form
                .padding(.top, 100)
                .navigationBarTitle(Text("Search Movies"), displayMode: .inline)
                .alert(isPresented: $showMissingInputDataAlert, content: { self.missingInputDataAlert })
            }
        }   // End of ZStack
        
        // End of NavigationView
        
    }   // End of body
    
    /*
     ------------------
     MARK: - Search API
     ------------------
     */
    func searchApi() {
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Public function obtainCountryDataFromApi is given in CountryApiData.swift
        searchMovieAPI(query: queryTrimmed)
    }
    
    /*
     ---------------------------
     MARK: - Show Search Results
     ---------------------------
     */
    var showSearchResults: some View {
        
        // Global variable countryFound is given in CountryApiData.swift
        if searchedMovieList.isEmpty {
            return AnyView(notFoundMessage)
        }
        
        return AnyView(SearchResults())
    }
    
    /*
     ---------------------------------
     MARK: - Movie Not Found Message
     ---------------------------------
     */
    var notFoundMessage: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .imageScale(.large)
                .font(Font.title.weight(.medium))
                .foregroundColor(.red)
                .padding()
            Text("No Movie Found!\nThe entered query Invalid Name did not return any movie from the API!Please enter another search query.")
                .fixedSize(horizontal: false, vertical: true)   // Allow lines to wrap around
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 1.0, green: 1.0, blue: 240/255))     // Ivory color
    }
    
    /*
     --------------------------------
     MARK: - Missing Input Data Alert
     --------------------------------
     */
    var missingInputDataAlert: Alert {
        Alert(title: Text("Movie Search Field is Empty!"),
              message: Text("Please enter a search query!"),
              dismissButton: .default(Text("OK")) )
        /*
         Tapping OK resets @State var showMissingInputDataAlert to false.
         */
    }
    
    /*
     -----------------------------
     MARK: - Input Data Validation
     -----------------------------
     */
    func inputDataValidated() -> Bool {
        
        // Remove spaces, if any, at the beginning and at the end of the entered search query string
        let queryTrimmed = self.searchFieldValue.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if queryTrimmed.isEmpty {
            return false
        }
        return true
    }
    
}

