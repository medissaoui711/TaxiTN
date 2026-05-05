# TaxiTN Flutter App

TaxiTN Mobile Application - Built with Flutter for iOS and Android.

## 🚀 Features

- **Clean Architecture**: Separation of concerns with Layered Architecture
- **State Management**: BLoC pattern for predictable state management
- **Navigation**: Go Router for declarative routing
- **Localization**: Arabic & English support
- **Maps Integration**: Google Maps for location services
- **Real-time Updates**: WebSocket for live tracking
- **Dependency Injection**: GetIt + Injectable
- **Responsive UI**: Flutter ScreenUtil for adaptive design

## 🏗️ Project Structure

```
lib/
├── core/
│   ├── bloc/                 # BLoC observer
│   ├── constants/            # App constants
│   ├── errors/               # Exception classes
│   ├── injection/            # Dependency injection
│   ├── routes/               # Go Router configuration
│   ├── theme/                # App themes
│   └── utils/                # Utility functions
├── data/
│   ├── datasources/          # API & Local data sources
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
├── domain/
│   ├── entities/             # Domain entities
│   ├── repositories/         # Repository interfaces
│   └── usecases/             # Use cases
└── presentation/
    ├── bloc/                 # BLoCs
    ├── pages/                # UI Screens
    └── widgets/              # Reusable widgets
```

## 📦 Dependencies

### State Management
- `flutter_bloc` - BLoC pattern
- `bloc` - Core BLoC library

### Networking
- `dio` - HTTP client
- `retrofit` - Type-safe HTTP client

### Navigation
- `go_router` - Declarative routing

### Storage
- `hive` - Local database
- `shared_preferences` - Key-value storage

### UI
- `flutter_screenutil` - Responsive design
- `flutter_svg` - SVG support
- `cached_network_image` - Image caching
- `google_maps_flutter` - Maps
- `geolocator` - Location services

### Utils
- `equatable` - Equality comparison
- `dartz` - Functional programming
- `logger` - Logging
- `injectable` - Dependency injection
- `get_it` - Service locator

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.0+
- Dart SDK 3.0+
- Android Studio / Xcode
- Google Maps API Key

### Installation

1. Clone the repository:
```bash
git clone https://github.com/medissaoui711/TaxiTN.git
cd TaxiTN/flutter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Set up environment variables:
```bash
cp .env.example .env
# Edit .env with your configuration
```

4. Generate code:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5. Run the app:
```bash
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# Android App Bundle
flutter build appbundle --release

# iOS
flutter build ios --release
```

## 🗂️ Architecture

This project follows **Clean Architecture** principles:

### Layers

1. **Presentation Layer**
   - Pages (UI screens)
   - BLoCs (Business Logic Components)
   - Widgets (Reusable components)

2. **Domain Layer**
   - Entities (Business objects)
   - Use Cases (Business logic)
   - Repository Interfaces

3. **Data Layer**
   - Models (DTOs)
   - Repositories (Implementation)
   - Data Sources (API, Local DB)

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## 🌐 Localization

The app supports:
- 🇸🇦 Arabic (Default)
- 🇬🇧 English

To add new translations:
1. Add keys to `assets/translations/`
2. Run `flutter pub run easy_localization:generate`

## 📱 Screens

| Screen | Description |
|--------|-------------|
| Splash | App launch animation |
| Login | Phone number authentication |
| Register | New user registration |
| Home | Main dashboard with services |
| Ride Booking | Request a taxi |
| Ride Tracking | Real-time ride tracking |
| Restaurants | Food ordering |
| Profile | User settings |

## 🎨 Design System

### Colors
- Primary: `#3DC56A` (Green)
- Secondary: `#10B981`
- Accent: `#7C3AED` (Purple)
- Background: `#F8FAFC`
- Text: `#1E293B` / `#64748B`

### Typography
- Font Family: Tajawal
- Weights: Light (300) to Black (900)

## 🤝 Contributing

1. Fork the repository
2. Create feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open Pull Request

## 📝 License

MIT License - see LICENSE file

## 📞 Support

For support, email contacteinfo71@gmail.com
