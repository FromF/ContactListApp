//
//  ContactModel.swift
//  ContactListApp
//
//  Created by 藤治仁 on 2022/03/16.
//

import Foundation
import Contacts

class ContactModel: NSObject {
    // 連絡帳を収める空の配列
    var contacts: [CNContact] = []
    
    private let store = CNContactStore()

    func fetch() -> Bool {
        //連絡先から取得する種類を指定する
        let keysToFetch: [CNKeyDescriptor] = [
            CNContactGivenNameKey,
            CNContactFamilyNameKey,
            CNContactPhoneNumbersKey,
        ]  as [CNKeyDescriptor]
        
        do {
            // 連絡先データベースから取得
            try store.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keysToFetch)) { [weak self] (contact, cursor) -> Void in
                // 電話番号が保持されている連絡先だったら
                if (!contact.phoneNumbers.isEmpty){
                   // 取得したデータをpeople に収める
                    self?.contacts.append(contact)
                }
            }
        }
        catch{
            print("連絡先データの取得に失敗しました")
            return false
        }
        
        return true
    }

}
