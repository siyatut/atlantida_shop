# Atlantida

## 📝 Description

**Atlantida** is a production-oriented mobile application for a local pet shop in Nizhny Novgorod.

The app allows customers to explore products and categories, view detailed product descriptions, and quickly contact the store or build a route using external map services. It focuses on clean UI, intuitive navigation, and real-world usability for a small business.

The project is built with Flutter and designed with maintainability in mind: UI, domain models, data access, and reusable components are clearly separated. The codebase was incrementally refactored to keep files small, readable, and easy to extend without overengineering.

## 📱 Screenshots

Below are static screenshots highlighting the main screens and overall layout of the app.
Animated previews are placed further down due to file size limitations.

![image](https://github.com/user-attachments/assets/c9b97488-3f5a-41af-a224-40b7700c0467)

## 🚀 Key Features

- Product catalog with categories and subcategories
- Product details screen with formatted and cleaned HTML descriptions
- Contact screen with:
  - One-tap phone calls
  - Telegram and email links
  - Quick route opening in Yandex Maps and Google Maps
- About screen with structured content and expandable sections
- Unified paddings and spacing across all screens
- Optimized text layout:
  - Automatic title line splitting
  - Non-breaking spaces for short prepositions (Russian typography)
- Smooth tab navigation with animated transitions

## 🛠 Technologies

- **Flutter / Dart**
- Material 3
- REST API integration (WooCommerce)
- Cached network images
- URL Launcher (phone, email, external links)
- Custom reusable widgets and UI helpers
- Git-based environment configuration (.env, API keys not committed)

## 🧱 Architecture

The project follows a simple, pragmatic layered architecture:

- core — app configuration and environment loading
- data — API clients, repositories, DTOs (WooCommerce)
- domain — business models
- screens — feature screens, composed of small widgets
- widgets — reusable UI components
- utils — spacing, text processing, launchers, and helpers
- theme — centralized colors, typography, and light/dark themes

This structure keeps UI code readable, encourages reuse, and allows the app to grow without introducing unnecessary architectural complexity.

## 🔮 Future Improvements

- Search and advanced filtering in the catalog
- Favorites / saved products
- Improved product image gallery
- Admin-driven content updates from the website
- Basic analytics and error reporting

## 🎥 Animated Preview

Animated walkthroughs demonstrating navigation and interactions within the app.
GIFs are placed separately to reduce initial load time and preserve quality.

Please note: The GIF may take a few seconds to load, depending on your connection. Thank you for your patience!

![Demo 1](assets/demo1.gif) ![Demo 2](assets/demo2.gif)

