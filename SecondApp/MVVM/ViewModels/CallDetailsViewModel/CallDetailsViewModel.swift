//
//  CallDetailsViewModel.swift
//  SecondApp
//
//  Created by MacBook27 on 22/12/23.
//

import Foundation

class CallDetailsViewModels: ObservableObject {
    var allCallDetails = [CallDetail]()
    @Published var callDetails = [CallDetail]()
    
    init() {
        getAllCallDetails()
    }
    
    func getAllCallDetails() {
        let call1 = CallDetail(callType: .video, callerType: .incoming, user:  User.getMockuser(), date: Date())
        let call2 = CallDetail(callType: .video, callerType: .outgoing, user:  User.getMockuser(), date: Date())
        let call3 = CallDetail(callType: .voice, callerType: .missed, user:  User.getMockuser(), date: Date())
        let call4 = CallDetail(callType: .voice, callerType: .incoming, user:  User.getMockuser(), date: Date())
        let call5 = CallDetail(callType: .voice, callerType: .outgoing, user:  User.getMockuser(), date: Date())
        let call6 = CallDetail(callType: .video, callerType: .missed, user:  User.getMockuser(), date: Date())
        
        allCallDetails = [call1, call2, call3, call4, call5, call6, call1, call2, call3, call4, call5, call6, call1, call2, call3, call4, call5, call6]
        callDetails = allCallDetails
    }
    
    func filterCallType(filterType: CallFilerType) {
        if filterType == .incoming || filterType == .outgoing || filterType == .missed {
            callDetails = allCallDetails.filter { $0.callerType == filterType.callerType }
        } else if filterType == .voice, filterType == .video {
            callDetails = allCallDetails.filter { $0.callType == filterType.callType }
        } else {
            callDetails = allCallDetails
        }
    }
}
