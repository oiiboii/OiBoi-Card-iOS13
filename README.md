# Personal Contact Card App

This SwiftUI app allows users to create a personal contact card containing their name, role title, phone number, email address, and a QR code. Users can also add their contact information to their contacts list.

## Customizing the App

To customize the app to display your own information, you'll need to update the `Constants.swift` file. This file contains the `K` struct, which holds your personal information.

### Constants.swift

Here's a sample `Constants.swift` file:

```swift
struct K {
    struct Info {
        static let firstName = "John"
        static let lastName = "Doe"
        static let roleTitle = "Software Engineer"
        static let phoneNumber = "123-456-7890"
        static let emailAddress = "john.doe@example.com"
        static let photoName = "profile_photo"
    }
}
![Screenshot](Assets/screenshot.png)

### Customization Steps
1. Replace the values of **firstName, lastName, roleTitle, phoneNumber**, and **emailAddress** with your own information.
2. Update the **photoName** value to the name of your profile photo file. Make sure to add the photo file (in a supported format such as .jpg or .png) to the project's assets.

## Further Customizations
You can also customize the appearance of the app, such as the color scheme and button styles, by editing the corresponding views and styles in the **ContentView.swift** and **ContactViewModel.swift** files.

Feel free to explore the code and make any changes you see fit to create a unique and personal contact card app!

