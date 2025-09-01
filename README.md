# ✅ Todo App (DEPI Task)

A cross-platform Todo Application built with Flutter & Firebase

## ✨ Features

*   🔐 **Authentication** – Secure login & signup with Firebase Authentication
*   📝 **Todo Management** – Create, update, delete, and mark tasks as complete
*   📡 **Cloud Firestore** – Store and sync todos in real-time
*   🔄 **State Management** – Powered by Flutter **Bloc** for predictable state flow
*   🏗 **Clean Architecture** – Organized layers for testability and scalability

## 🛠 Technologies Used

*   **Flutter** – Cross-platform UI toolkit
*   **Firebase** – Authentication & Cloud Firestore
*   **Flutter Bloc** – State management with BLoC pattern
*   **Clean Architecture** – Modular and maintainable code

## 🚀 Installation & Setup

### Prerequisites

*   Flutter SDK (v3.x.x or higher)
*   Dart SDK (comes with Flutter)
*   Firebase CLI

### Steps

```shell
# 1. Clone the repository
git clone https://github.com/AhmedAbdelaal345/Todo_App_DEPI.git
cd Todo_App_DEPI

# 2. Install dependencies
flutter pub get

# 3. Configure Firebase
npm install -g firebase-tools
firebase login
flutterfire configure

# 4. Run the application
flutter run
```

## 📂 Project Structure

```bash
lib/
├── manager/             # BLoC (cubits & states)
├── model/               # Data models
├── pages/               # UI Screens
├── helper/              # Reusable widgets
├── firebase_core/       # Firebase config
├── constants.dart       # App constants
└── main.dart            # Entry point
```

## 📸 Screenshots

### Authentication Flow

| Get Started | Login | Register |
|---|---|---|
| ![Get Started](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/getstarted.png) | ![Login](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/login.png) | ![Register](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/splach1.png) |

### Todo Management

| Pending Tasks | Completed Tasks | Profile |
|---|---|---|
| ![Pending Tasks](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/pending%20task.png) | ![Completed Tasks](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/complet%20Task.png) | ![Profile](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/profile.png) |

### Splash & Refresh

| Refresh | Splash 2 | Splash 3 |
|---|---|---|
| ![Refresh](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/refreash.png) | ![Splash 2](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/splach2.png) | ![Splash 3](https://raw.githubusercontent.com/AhmedAbdelaal345/Todo_App_DEPI/main/assets/screanshot/splach3.png) |

## 📅 Project Info

Developed as part of DEPI Program

Timeline: 1 Week

Status: ✅ Completed

## 📥 Download

👉 Download APK (Upload to GitHub Releases or Google Drive and update this link)

## 👨‍💻 Contributors

Ahmed Abdel Aal (Author & Developer)

## 📌 License

This project is licensed under the MIT License.
