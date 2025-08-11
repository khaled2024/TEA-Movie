//
//  SearchViewText.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import SwiftUI
struct SearchViewText: View {
    @Binding var searchString: String
    @Binding var searchPlaceholder: String
    @Binding var isSearching: Bool{
        didSet{
            if isSearching {
                
            }else{
                searchString = ""
            }
                
        }
    }
    var body: some View{
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField(searchPlaceholder, text: $searchString)
                .foregroundColor(.primary)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            if searchString.isEmpty {
                
            }else{
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .foregroundColor(.gray)
                    .padding(.trailing, 2)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        isSearching = false
                        searchString = ""
                    }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 0)
        .padding(.horizontal)
        .padding(.vertical, 20)
    }
}
