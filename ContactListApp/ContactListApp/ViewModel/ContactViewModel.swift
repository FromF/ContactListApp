//
//  ContactViewModel.swift
//  ContactListApp
//
//  Created by 藤治仁 on 2022/03/16.
//

import SwiftUI
import Contacts

class ContactViewModel: ObservableObject {
    @Published var contactItems: [ContactItem] = []
    private let contactModel = ContactModel()
    
    init() {
        Task {
            // 連絡帳アクセス可否状態を取得
            let status = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
            
            switch status {
            case .notDetermined , .restricted:
                print("許可が必要")
                // このアプリが連絡先を使ってもいいかをユーザーが選択していない場合に、連絡先の使用を許可を得る
                if try await CNContactStore().requestAccess(for: .contacts) {
                    print("利用可能")
                    onApeear()
                }
            case .denied:
                print("拒否状態")
            case .authorized:
                print("利用可能")
            @unknown default:
                fatalError()
            }
        }
    }
    
    func onApeear() {
        if contactModel.fetch() {
            contactItems = []
            contactModel.contacts.forEach { contact in
                var phoneNumbers: [String] = []
                for phoneNumber in contact.phoneNumbers {
                    //スペースを削除しつつ電話番号リスト（配列）に追加する
                    phoneNumbers.append(phoneNumber.value.stringValue.replacingOccurrences(of: " ", with: ""))
                }
                contactItems.append(ContactItem(familyName: contact.familyName, givenName: contact.givenName, phoneNumbers: phoneNumbers))
            }
        }
    }
}
