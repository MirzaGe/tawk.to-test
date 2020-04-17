  



# Gitt <img src="https://i.imgur.com/LwN6axb.png" width="30" height="30">

  
****Gitt**** is a project, an online assessment test, as part of my job application at [Tawkto.]([https://www.tawk.to/](https://www.tawk.to/))
---


Dark Mode                  |  Light Mode + Cache.
:-------------------------:|:-------------------------:
![Dark Mode](https://media.giphy.com/media/Kxi7nVisCSGX6uw9m5/giphy.gif)  | ![Light Mode](https://media.giphy.com/media/lRjy0syqLX5OunG9nD/giphy.gif)

---
## Accomplished Requirements
- User list in code.
- Profile viewer in IB.
- Dark Mode support.
- All media are cached.
- MVVM + RxSwift architecture.
- Programmatically made UI.
- No internet handling + Auto retry.
- Pagination with spinner.
- Shimmer/Skeleton.
- Exponential Backoff.
- Result types in networking.
- Codables.
- Search.
- Started Unit UI Test.

---

## TODOS
- Swift 5.1
- Coordinator (still studying)
- Finish Unit and UI Testing.
- Coredata / Offline mode.
- Limit to 1 request.
- Invert every 4th avatar.

## Tech Stacks

The project was built using **Xcode 11.3**, **Swift 5.0**. 
Dependencies are managed by [Cocoapods](https://cocoapods.org/).

**MVVM** is the architectural pattern used together with [RxSwift](https://github.com/ReactiveX/RxSwift) to maximize the utilization of the said pattern.

The important part of the project was **UI Tested**. And viewModels are **Unit Tested**, using the Apple's vanilla **XCTest** and **XCUITest** test frameworks.

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
