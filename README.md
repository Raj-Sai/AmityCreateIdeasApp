# AmityCreateIdeasApp

## Application Name -> Limelight

Limelight keeps ideas alive in one place and grows every day. App daily provides new ideas and ways to enhance others' opinions, Life hack tips, and many more...

Limelight’s also provides the opportunity to those who have creative ideas but never got the chance to express/explore to the group.

Limelight allows us to share[create/submit] ideas with peers, and in turn, everyone can add their opinion/comments for each idea to make them bigger.

The app will automatically display the top ideas, based on the user's comments/likes trend.

## Server: Firebase Cloud Functions 

Cloud Functions for Firebase is a serverless framework that lets you automatically run backend code in response to events triggered by Firebase features and HTTPS requests. Your JavaScript or TypeScript code is stored in Google's cloud and runs in a managed environment. There's no need to manage and scale your own servers.

### Create a Firebase Project
Create app in firebase console 
https://console.firebase.google.com/

after create app in firebase, Firebase automatically provisions resources for your Firebase project. When the process completes, you'll be taken to the overview page for your Firebase project in the Firebase console.

### Set up Node.js and the Firebase CLI

First install the Node.js and npm, Once you have Node.js and npm installed, install the Firebase CLI via your preferred method. To install the CLI via npm, use 

`npm install -g firebase-tools`

### Initialize your project

1. Run `firebase login` to log in via the browser and authenticate the firebase tool.
2. Go to your Firebase project directory.
3. Run `firebase init` then select required services in terminal.

### Deploy Firebase function
Run below command in created project location in terminal
`firebase deploy --only functions`


| Back End Environment |      |
| ---------------------- | ------ |
| Services Used      | 1.     Firebase cloud Function for server less REST API  2. Fire store DB used to store the app data   3.  Firebase Storage for storing image       |
| Tools Used & version   | 1.   Node JS – 14.10.1      2.  NPM – 6.14.8        |


## Client: iOS Application

Used Tools
------------
> - Xcode - 11.3.1
> - Target veriosn from iOS 11
> - Swift 5.0

Used Design Pattern
-------------------
> - The client project is build by VIP design pattern

Screens
-------
1. Display Onboard Screen's
2. Provides features to Signup, Login to user account.
3. Displays all ideas posted on the application
4. Feature to post ideas into different categories
5. User can update description with photos/images
6. Ability to view, comment on ideas and like.
7. View user profile
8. Logout 
