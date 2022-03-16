//
//  ContactView.swift
//  ContactListApp
//
//  Created by 藤治仁 on 2022/03/16.
//

import SwiftUI

struct ContactView: View {
    @StateObject private var viewModel = ContactViewModel()
    var body: some View {
        VStack {
            Text("電話帳")
            List(viewModel.contactItems) { contactItem in
                VStack {
                    Text("\(contactItem.familyName) \(contactItem.givenName)")
                    ForEach(contactItem.phoneNumbers, id: \.self) { phoneNumber in
                        Button {
                            guard let url = URL(string: "tel://" + phoneNumber) else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            Text("\(phoneNumber)")
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.onApeear()
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
    }
}
