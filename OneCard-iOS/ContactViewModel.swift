//  ContactViewModel.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/19/23.
//

import SwiftUI
import ContactsUI
import PDFKit

import Foundation
import ContactsUI

class ContactViewModel: ObservableObject {
    var contact: CNMutableContact {
        createContact()
    }
    
    private func createContact() -> CNMutableContact {
        let contact = CNMutableContact()
        contact.givenName = K.Info.firstName
        contact.familyName = K.Info.lastName
        contact.emailAddresses = [CNLabeledValue(label: CNLabelHome, value: K.Info.emailAddress as NSString)]
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: K.Info.phoneNumber))]
        return contact
    }
}
