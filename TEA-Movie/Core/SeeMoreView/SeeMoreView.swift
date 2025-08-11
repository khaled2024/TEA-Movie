//
//  SeeMoreView.swift
//  TEA-Movie
//
//  Created by KhaleD HuSsien on 11/08/2025.
//


import SwiftUI

struct SeeMoreView: View {
    let title: String
    let shows: [ShowModel]
    
    @State private var selectedShow: ShowModel?
    
    var body: some View {
        List {
            ForEach(shows) { show in
                Button {
                    selectedShow = show
                } label: {
                    ListRowView(show: show)
                        .padding(.vertical, 8)
                        .contentShape(Rectangle()) // يوسع منطقة اللمس
                }
                .buttonStyle(PlainButtonStyle())
                .listRowSeparator(.hidden)
                .listRowInsets(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .background(Color.clear)
        .scrollContentBackground(.hidden)
        .navigationTitle(title)
        .navigationDestination(isPresented: Binding(
            get: { selectedShow != nil },
            // when go back return to nil
            set: { newValue in
                if !newValue { selectedShow = nil }
            }
        )) {
            if let show = selectedShow {
                ShowDetailsView(show: show)
            }
        }
    }
}
