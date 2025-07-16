# Open WebUI Community - iOS App

## Architecture Overview

This iOS app follows the **MVVM (Model-View-ViewModel)** pattern for clean separation of concerns and maintainable code.

## Directory Structure

```
Open WebUI Community/
├── Models/                    # Data models and entities
│   ├── WebUIStatusResponse.swift
│   └── NetworkError.swift
├── Views/                     # SwiftUI views (UI layer)
│   └── ConnectView.swift
├── ViewModels/               # Business logic and state management
│   └── ConnectViewModel.swift
├── Services/                 # Network and external services
│   └── ConfigService.swift
├── Utils/                    # Utilities and extensions
│   └── URLValidator.swift
├── Assets.xcassets/          # App assets
└── Open_WebUI_CommunityApp.swift
```

## MVVM Components

### Models
- **WebUIStatusResponse.swift**: Data model for server configuration response
- **NetworkError.swift**: Error types for network operations

### Views
- **ConnectView.swift**: Main UI for server connection interface
  - Uses `@StateObject` to observe the ViewModel
  - Handles UI state and user interactions
  - Displays loading states and connection status

### ViewModels
- **ConnectViewModel.swift**: Business logic for connection management
  - Manages connection state (`isConnected`, `isLoading`)
  - Handles URL validation
  - Coordinates with services for network operations
  - Provides error handling and user feedback

### Services
- **ConfigService.swift**: Network service for API communication
  - Implements `ConfigServiceProtocol` for testability
  - Handles HTTP requests to server configuration endpoint
  - Provides error handling and response parsing

### Utils
- **URLValidator.swift**: Reusable URL validation utilities
  - Static methods for URL validation and normalization
  - Can be extended for additional validation rules

## Key Features

1. **Separation of Concerns**: Clear boundaries between UI, business logic, and data
2. **Testability**: Services use protocols for easy mocking in tests
3. **Reusability**: Utilities and services can be reused across the app
4. **Maintainability**: Each component has a single responsibility
5. **Scalability**: Easy to add new features following the same pattern

## Usage

The app follows a simple flow:
1. User enters server URL in `ConnectView`
2. `ConnectViewModel` validates the URL
3. `ConfigService` makes network request
4. Response is handled and UI updates accordingly

## Adding New Features

To add new features, follow this pattern:
1. Create models in `Models/` directory
2. Add services in `Services/` directory
3. Create ViewModels in `ViewModels/` directory
4. Build UI in `Views/` directory
5. Add utilities in `Utils/` directory as needed 