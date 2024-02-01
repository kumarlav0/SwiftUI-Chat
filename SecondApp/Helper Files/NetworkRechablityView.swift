//
//  NetworkRechablityView.swift
//  SecondApp
//
//  Created by MacBook27 on 28/12/23.
//

import Network
import SwiftUI

struct NetworkRechablityView: View {
    @StateObject var networkMonitor = NetworkMonitor()
    
    var body: some View {
        ZStack {
            Color.clear
            VStack {
                    Text("No Internet Connection")
                        .fontWeight(.bold)
                        .font(.system(size: 26))
                
                Text("Please connect your device to network or wifi")
                    .multilineTextAlignment(.center)
                    .font(.system(size:20))
                    .padding(.top, 5)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    
                
            }
        }
    }
}

struct NetworkRechablityView_Previews: PreviewProvider {
    static var previews: some View {
        NetworkRechablityView()
    }
}

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")

    @Published var isConnected: Bool = true

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
