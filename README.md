# UserList📱Mobile Engineer Assignment – Scrollable List & Detail View (iOS) coveragex Test task

A simple iOS application built with **Swift 5.0** and **UIKit** that demonstrates consuming a public API, managing navigation, and building a clean, testable architecture.

---

## 🚀 Features

- Scrollable list of users fetched from the [Random User API](https://randomuser.me/api/?results=20)
- Each user shows their **name** and **thumbnail image**
- Tapping a user navigates to a **detail view** with:
  - Full name
  - Email
  - Phone number
  - Large profile picture
- Pull-to-refresh to reload the user list
- **Search by name** in real time
- Loading indicator & graceful error handling
- Clean **MVVM architecture** and dependency injection
- Unit test coverage for ViewModel and networking logic

---

## 📸 Screenshots

| User List | User Detail | Search |
|-----------|-------------|--------|
| ![](screenshots/list.png) | ![](screenshots/detail.png) | ![](screenshots/search.png) |

---

## 🛠 Tech Stack

- **Language**: Swift 5.0
- **UI Framework**: UIKit (100% programmatic, no Storyboards)
- **Architecture**: MVVM (Model-View-ViewModel)
- **Networking**: `URLSession`
- **Testing**: XCTest with mock networking

---


