# 📱 ChatBoat

A real-time messaging application built with **Flutter** and **Firebase**.  
Designed with clean architecture principles and a seamless user experience.

---

## ✨ Features

- 🔐 **Authentication**: Secure email/password registration and login with Firebase Authentication.
- 👥 **Contacts Management**: Add and search contacts by phone number.
- 💬 **Real-time Messaging**: Instant message sending and receiving with Firestore.
- 🔔 **Unread Message Counters**: Keep track of unread messages in the chat list.
- ⚙️ **Profile Settings**: Edit name and phone number, logout, or delete account.
- 🎨 **Smooth Animations**: Custom page transitions and animated UI elements.
- 📲 **Onboarding Flow**: New users are guided through an intuitive onboarding experience.
- 🌙 **Dark Mode Support**: Adapts automatically based on system theme.
- 🔥 **Optimized Architecture**: Bloc (Cubit) pattern, clean code, dependency injection (`get_it`).

---

## 🛠️ Tech Stack

- **Flutter** (latest stable version)
- **Firebase Authentication**
- **Cloud Firestore**
- **Firebase Cloud Messaging** (FCM token handling prepared)
- **Cubit State Management** (`flutter_bloc`)
- **Service Locator** (`get_it`)
- **Shared Preferences**
- **Material Design 3**

---

## 📱 Screenshots
<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/19e0a502-a15f-4f6c-abb7-f06e06135f28" alt="…" width="300" /></td>
    <td><img src="https://github.com/user-attachments/assets/3022304f-1998-477d-bed0-e0ad4a2a5c66" alt="…" width="300" /></td>
   <td><img src="https://github.com/user-attachments/assets/71e253b5-8df1-445d-b157-44ccdf657d55" alt="…" width="300" /></td>
   <td><img src="https://github.com/user-attachments/assets/893aaade-3a42-4660-a795-c481fec21270" alt="…" width="300" /></td>
   <td><img src="https://github.com/user-attachments/assets/376393fd-4bd6-4529-9035-6ffe68f14a67" alt="…" width="300" /></td>
  </tr>
</table>

---

## 🚀 Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/Kareem-Mahfouz1/chatboat.git
   ```
2. Navigate into the project directory:
   ```bash
   cd chatboat
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Set up Firebase:
   - Create a project in Firebase Console.
   - Add Android and/or iOS app credentials.
   - Download `google-services.json` / `GoogleService-Info.plist` and place them properly.
   - Enable **Authentication** and **Cloud Firestore** in Firebase.

5. Run the app:
   ```bash
   flutter run
   ```

---

## 📚 Project Structure Overview

```
lib/
├── core/
│   ├── services/          # NotificationService, UserService
│   ├── utils/             # Constants, router, styles
│   └── widgets/           # Shared custom widgets
├── features/
│   ├── auth/
│   ├── chats/
│   ├── contacts/
│   ├── home/
│   ├── onboarding/
│   ├── settings/
│   └── splash/
```
