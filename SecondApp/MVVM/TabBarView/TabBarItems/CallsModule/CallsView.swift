//
//  CallsView.swift
//  SecondApp
//
//  Created by MacBook27 on 19/12/23.
//

import SwiftUI
import UIKit

struct CallsView: View {
    
    @StateObject var viewModel = CallDetailsViewModels()
    @State private var picketStates: [CallFilerType] = [.all, .outgoing, .incoming, .missed]
    @State private var defaultPickerSelectedState: CallFilerType = .all
    @State private var selectedCallDetail: CallDetail?
    @State private var showAlert = false
    
    var body: some View {
        NavigationStack {
            Picker("Picker Filter", selection: $defaultPickerSelectedState ) {
                ForEach(picketStates,id: \.self) {
                    Text($0.text)
                }
            }.pickerStyle(.segmented)
                .onChange(of: defaultPickerSelectedState) { filterType in
                    viewModel.filterCallType(filterType: filterType)
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 20, trailing: 20))
            
            List {
                Section("Recent") {
                    ForEach(viewModel.callDetails, id: \.id) { callDetail in
                        CallDetailCellView(callDetail: callDetail)
                            .onTapGesture {
                                // Store the selected call detail
                                selectedCallDetail = callDetail
                                // Show the alert
                                showAlert.toggle()
                            }
                    }
                    .onDelete { offsets in
                        deleteCallDetail(at: offsets)
                    }
                    
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Call Details")
            .toolbar {
                EditButton()
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Call Confirmation"),
                    message: Text("Are you sure you want to call \(selectedCallDetail?.user.name ?? "")?"),
                    primaryButton: .default(Text("Call").bold().foregroundColor(.green)) {
                        // Handle the "Yes" action
                        // For example, you can initiate a call
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
        }
    }
}

extension CallsView {
    func deleteCallDetail(at offsets: IndexSet) {
        viewModel.callDetails.remove(atOffsets: offsets)
    }
    
}

struct CallsView_Previews: PreviewProvider {
    static var previews: some View {
        CallsView()
    }
}
