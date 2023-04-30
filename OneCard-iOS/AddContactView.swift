//
//  AddContactView.swift
//  OneCard-iOS
//
//  Created by Omer Ifrah on 4/26/23.
//

import SwiftUI
import ContactsUI

struct AddContactView: UIViewControllerRepresentable {
    let contact: CNMutableContact

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> CNContactViewController {
        let viewController = CNContactViewController(forUnknownContact: contact)
        viewController.delegate = context.coordinator
        return viewController
    }

    func updateUIViewController(_ uiViewController: CNContactViewController, context: Context) {
    }

    class Coordinator: NSObject, CNContactViewControllerDelegate {
        var parent: AddContactView

        init(_ parent: AddContactView) {
            self.parent = parent
        }

        func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
            viewController.dismiss(animated: true)
        }
    }
}
