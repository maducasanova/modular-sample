# iOS Modular App Sample
This repository demonstrates a modular architecture for iOS applications using Swift. It serves as a practical example of how to structure a scalable, maintainable, and testable iOS app using modular design principles.

- **Modular Architecture**: Showcases how to break down an app into independent, reusable modules.
- **Swift Package Manager**: Utilizes SPM for managing dependencies and creating local packages.
- **MVVM Design Pattern**: Implements the Model-View-ViewModel pattern for clear separation of concerns.
- **Dependency Injection**: Demonstrates loose coupling between modules using dependency injection.
- **Unit Testing**: Includes examples of unit tests for individual modules.
- **CI/CD Setup**: Includes a basic CI/CD configuration using GitHub Actions.

## 📚 Modules

The app is divided into the following modules:

1. **Core**: Contains shared utilities, extensions, and protocols used across the app.
2. **Networking**: Handles all network-related operations.
3. **Authentication**: Manages user authentication and session handling.
4. **DesignSystem**: Centralizes UI components, styles, and theming for consistent look and feel.
5. **Analytics**: Manages tracking and reporting of user interactions and app events.
6. **Home**: Implements the main home screen of the app.
7. **Notifications**: Handles push notifications and in-app messaging.
8. **FeatureA**: An example feature module (e.g., user profile).
9. **FeatureB**: Another example feature module (e.g., settings).

## 🛠 Technologies Used

- Swift 6+
- SwiftUI for UI
- Swift Package Manager for dependency management
- XCTest for unit and UI testing

## 🏗 Architecture Overview

Our modular architecture follows these key principles:

- Each module is a separate Swift Package
- Modules communicate through well-defined interfaces
- The main app integrates all modules
- Dependency injection is used to provide dependencies to modules
- The DesignSystem module ensures UI consistency across all features
- The Analytics module provides a centralized way to track events across all modules

## 🚀 Getting Started

### Prerequisites

- Xcode 16.0+
- iOS 16.0+ (for deployment)
