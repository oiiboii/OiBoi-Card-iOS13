//  ContactViewModel.swift
//  OiBoi-Card-iOS13
//
//  Created by Omer Ifrah on 4/19/23.
//

import SwiftUI
import ContactsUI

// MARK: - ContactViewModel
// A view model that manages the contact information.
class ContactViewModel: ObservableObject {
    // The contact information.
    var contact: CNMutableContact {
        createContact()
    }
    
    // Creates a new CNMutableContact object with the information from K.Info.
    private func createContact() -> CNMutableContact {
        let contact = CNMutableContact()
        contact.givenName = K.Info.firstName
        contact.familyName = K.Info.lastName
        contact.emailAddresses = [CNLabeledValue(label: CNLabelHome, value: K.Info.emailAddress as NSString)]
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: K.Info.phoneNumber))]
        return contact
    }
}

// MARK: - AddContactView
// A view that presents the CNContactViewController for adding the contact to the user's contacts.
struct AddContactView: UIViewControllerRepresentable {
    let contact: CNMutableContact

    // Creates a new coordinator object for the view.
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    // Creates the CNContactViewController with the given contact and sets the delegate to the coordinator.
    func makeUIViewController(context: Context) -> CNContactViewController {
        let viewController = CNContactViewController(forUnknownContact: contact)
        viewController.delegate = context.coordinator
        return viewController
    }

    // Does nothing when the view controller is updated.
    func updateUIViewController(_ uiViewController: CNContactViewController, context: Context) {
    }

    // The coordinator for the view.
    class Coordinator: NSObject, CNContactViewControllerDelegate {
        var parent: AddContactView

        init(_ parent: AddContactView) {
            self.parent = parent
        }

        // Dismisses the view controller when the user is done adding the contact.
        func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
            viewController.dismiss(animated: true)
        }
    }
}

// MARK: - ContactInfoView
// A view that displays a contact information label and value as a button that can be copied to the clipboard.
struct ContactInfoView: View {
    let label: String
    let value: String
    let symbol: String

    var body: some View {
        VStack {
            Button(action: {
                UIPasteboard.general.string = value
            }) {
                ZStack {
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 40)
                    HStack(spacing: 20) {
                        Image(systemName: symbol)
                            .foregroundColor(.white)

                        Text(value)
                            .foregroundColor(.white)
                            .font(.system(size: 18))
                            .fontWeight(.regular)
                    }
                }
            }
        }
    }
}
