# ThirdFloor

Leveraging powerful technologies to advance peace, order, law, and data protection.

## 📱 About

ThirdFloor is a modern iOS application built with SwiftUI, demonstrating best practices in mobile development including clean architecture, robust testing, and secure coding practices.

## ✨ Features

- Modern SwiftUI architecture
- Clean and maintainable code structure
- Comprehensive testing coverage
- CI/CD pipeline with GitHub Actions
- Code quality enforcement with SwiftLint
- Security best practices

## 🛠 Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## 🚀 Getting Started

### Installation

1. Clone the repository:
```bash
git clone https://github.com/coxdoj/ThirdFloor.git
cd ThirdFloor
```

2. Open the project in Xcode:
```bash
open ThirdFloor.xcodeproj
```

3. Build and run the project (⌘+R)

### Development

#### Code Quality

The project uses SwiftLint to enforce code quality standards. Install SwiftLint:

```bash
brew install swiftlint
```

Run SwiftLint:
```bash
swiftlint
```

#### Testing

Run tests using Xcode (⌘+U) or via command line:

```bash
xcodebuild test -project ThirdFloor.xcodeproj -scheme ThirdFloor -destination 'platform=iOS Simulator,name=iPhone 15'
```

## 🏗 Architecture

The app follows a clean architecture pattern:

- **Views**: SwiftUI views for the user interface
- **ViewModels**: Business logic and state management
- **Models**: Data structures and entities
- **Services**: API communication and data persistence

## 🔒 Security

- No hardcoded secrets or sensitive data
- Secure coding practices following OWASP guidelines
- Regular dependency updates
- Code signing and provisioning profiles

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is part of an initiative to advance peace, order, law, and data protection through technology.

## 👨‍💻 Author

David - [GitHub](https://github.com/coxdoj)

## 📞 Support

For support, please open an issue in the GitHub repository.