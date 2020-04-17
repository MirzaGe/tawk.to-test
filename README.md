  



# Gitt <img src="https://i.imgur.com/LwN6axb.png" width="30" height="30">

  
****Gitt**** is a project, an online assessment test, as part of my job application at [Tawkto.]([https://www.tawk.to/](https://www.tawk.to/))
---

---


Dark Mode                  |  Light Mode + Cache.      | Landscape.   
:-------------------------:|:-------------------------:|:-------------------------------:
![Dark Mode](https://media2.giphy.com/media/MAvQxCY0Wsb8bkQuYY/giphy.gif)  | ![Light Mode + Cache](https://media.giphy.com/media/kBxciWlYuA5FQ4q1rH/giphy.gif). | ![Landscape](https://media.giphy.com/media/eM1f11CLuDHWgkZDTC/giphy.gif)

---
## The Good Stuff
1. Offline feature via cache ✅
2. Save last state / data. ✅
3. Dark Mode support. ✅
4. Master-Detail layout.  ✅
5. Landscape orientation support  ✅
6. iPad support 🙋🏻‍♂️
7. Unit Tested  ✅
8. UI Tested  ✅
9. MVVM + RxSwift architecture.  🏛
10. Programmatically made UI 🤓
11. Made with ideas from Apple's iTunes Store app. 💡
---

## Tech Stacks

The project was built using **Xcode 11.3**, **Swift 5.0**. 
Dependencies are managed by [Cocoapods](https://cocoapods.org/).

**MVVM** is the architectural pattern used together with [RxSwift](https://github.com/ReactiveX/RxSwift) to maximize the utilization of the said pattern.

The important part of the project was **UI Tested**. And viewModels are **Unit Tested**, using the Apple's vanilla **XCTest** and **XCUITest** test frameworks.

**Moya** was used for additional networking layer. The project was made as if it will scale, hence the said library. Also, this awesome library makes Unit Testing easy.

Lastly, to do the views layout, **SnapKit** was used. Like what was mentioned above, the project was made with scaling in mind (only as if). Personally, I write constraints faster with the said library compared to LayoutConstraints. *Long time ago, I was fond of ~~VFL.~~.*

---
# NON TECHNICAL PART
This part of the document contains instructions on how to build and run the project **iSearch**

## Getting Started

You'll need the following software installed on your mac machine.

1. Xcode - You can download it from the App Store on your mac.

---

## Downloading the source codes

Download the project is pretty straight forward. Find the GREEN button that says Clone Or Download, and you're good to go.

![Clone or download](https://i.imgur.com/CZNfTCu.png)

---

## Building the project

Build and running the project on to your simulator is easy. Make sure you are using `.xcworkspace` (white icon) and NOT `.xcodeproject` (blue icon). 
There's a difference between these two project files.

Now click on the **PLAY** button in your Xcode. Or simple press `CMD` + `R` to run the project on to your selected simulator or device. When running the project on to your real device, you will need to setup some certificates on your local machine.

---

## TestFlight

Inviting an internal user (a user under your Apple Developer Account) is quite not simple. I wrote before a wiki for this:
[A Thorough Guide In Testing Apps Via TestFlight For Clients, Bosses, and Testers](https://github.com/glennposadas/TestFlight-Guide/wiki/A-Thorough-Guide-In-Testing-Apps-Via-TestFlight---For-Clients,-Bosses,-and-Testers).

---
## Support | Contact

Should there be questions or any discussions, you may contact me: https://www.glennvon.com/
