//
//  ContentView.swift
//  DistMobile Lab 02
//
//  Created by Jared Johnston on 2025-01-31.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject public var viewModel : HouseViewModel = HouseViewModel()
    @State public var search : String = ""
    
    
    var body: some View {
        NavigationView{
            VStack(alignment: .leading, spacing: 20){
                List{
                    ForEach(viewModel.houses){ house in
                        HouseCard(house: house)
                    }
                }
                .searchable(text: $search, prompt: "Search house by Id")
                .onChange(of: search) { newValue in
                    if let id = Int(newValue) {
                        viewModel.fetch(id: id)
                    }
                    else{
                        viewModel.fetch()
                    }
                }
                .onAppear(){
                    viewModel.fetch()
                }
                .refreshable {
                    viewModel.fetch()
                }
                
                Text(viewModel.error ?? "")
            }.navigationTitle("Houses")
        }
    }
}

struct HouseCard: View {
    @State public var house: House
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack(alignment: .bottom) {
                if let url = URL(string: house.imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    } placeholder: {
                        ProgressView()
                    }
                }
                HStack {
                    Text(house.sold ? "Sold" : "For Sale")
                        .padding(5)
                        .background(house.sold ? Color.red : Color.green)
                        .foregroundStyle(.white)
                        .cornerRadius(20)
                        .padding(7)
                    Spacer()
                    Text(house.postingDate)
                        .padding(5)
                        .background(Color.black)
                        .foregroundStyle(.white)
                        .cornerRadius(20)
                        .padding(7)
                }
            }
            HStack {
                Text("$\(house.price)")
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
                Text("\(Image(systemName: house.likes > 0 ? "heart.fill" : "heart")) \(house.likes)")
            }
            .padding([.leading, .trailing], 10)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(house.details)
                    .font(.caption)
                Text(house.address)
                    .font(.caption)
                Text(house.company)
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            .padding([.leading, .trailing, .bottom], 10)
        }
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
