# NextUpp 🎬🎮

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/Riverpod-%232D3748.svg?style=for-the-badge&logo=riverpod&logoColor=white)
![Drift](https://img.shields.io/badge/Drift%20(SQLite)-%2300599C.svg?style=for-the-badge&logo=sqlite&logoColor=white)

**NextUpp** is a modern, premium-designed media backlog tracker built with Flutter. It allows users to seamlessly discover, track, and manage their favorite **Movies** and **Video Games** in one unified application.

Currently in **Phase 2 (Local Prototype)**, NextUpp offers a fully functional local experience with offline support, robust search capabilities, and a polished glassmorphic UI.

---

## ✨ Features

### 🔍 Unified Discovery Engine
- **Cross-Platform Search**: Instantly search for movies (via TMDB) and games (via RAWG) from a single search bar.
- **Smart Filters**: Toggle between Movies, Games, or both to refine your results.
- **Detailed Info**: Rich metadata including ratings, release dates, and high-quality artwork.

### 📚 Personal Library (Local-First)
- **Status Tracking**: Organize media into **Pending** (To Watch/Play) and **Completed** lists.
- **Time Tracking**: Log hours played or minutes watched.
- **Offline Capable**: All library data is persisted locally using **Drift (SQLite)**, ensuring your collection is always accessible.

### 🎨 Premium UI/UX
- **Glassmorphism Design**: Modern, translucent aesthetics with blur effects.
- **Dynamic Theming**: Custom dark theme with vibrant accent colors.
- **Interactive Feedback**: Custom Snackbars and fluid animations for a responsive feel.

---

## 🛠️ Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Riverpod](https://riverpod.dev/) (Providers, StateNotifiers)
- **Local Database**: [Drift](https://drift.simonbinder.eu/) (SQLite abstraction)
- **Networking**: [Dio](https://pub.dev/packages/dio) (HTTP client with interceptors)
- **APIs**:
  - [The Movie Database (TMDB)](https://www.themoviedb.org/)
  - [RAWG Video Games Database](https://rawg.io/)
- **Architecture**: Clean Architecture-inspired separation (Data, Domain, Presentation).

---

## 📱 Screenshots

| Dashboard | Search | Library |
|:---:|:---:|:---:|
| *(Place screenshot here)* | *(Place screenshot here)* | *(Place screenshot here)* |

> *Note: Screenshots will be added as the UI is finalized.*

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.x or higher)
- TMDB API Key
- RAWG API Key

### Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/yourusername/nextupp.git
    cd nextupp
    ```

2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Configure Environment:**
    Create a `.env` file in the root directory and add your API keys:
    ```env
    TMDB_API_KEY=your_tmdb_key_here
    RAWG_API_KEY=your_rawg_key_here
    ```

4.  **Run databases generation:**
    ```bash
    dart run build_runner build
    ```

5.  **Run the app:**
    ```bash
    flutter run
    ```

---

## 🗺️ Roadmap

- [x] **Phase 1: Foundation** - Basic Setup, API Integration.
- [x] **Phase 2: Local Polish** - Offline support, UI refinements, Main functionalities.
- [ ] **Phase 3: Cloud & Social** (In Progress)
    - [ ] Firebase Auth Integration.
    - [ ] User Profiles & Statistics.
    - [ ] Cloud Sync (Firestore).

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
