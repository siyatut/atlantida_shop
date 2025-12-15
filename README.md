# Atlantida

## 📝 Description

**Atlantida** is a mobile application for a local pet shop in Nizhny Novgorod. The app helps customers explore products, browse categories, read detailed product descriptions, and quickly contact the store or build a route using external map services. The project focuses on a clean UI, clear navigation, and real-world usability for a small business. It is built with Flutter and structured to be easy to extend and maintain.

## 📱 Screenshots

Below are static screenshots highlighting the main screens and overall layout of the app.
Animated previews are placed further down due to file size limitations.

![image](https://github.com/user-attachments/assets/c9b97488-3f5a-41af-a224-40b7700c0467)

## 🚀 Key Features

- Product catalog with categories and subcategories
- Product details screen with formatted descriptions
- Contact screen with:
  - One-tap phone calls
  - Telegram and email links
  - Quick route opening in Yandex Maps and Google Maps
- About screen with structured content and expandable sections
- Unified paddings and spacing across all screens
- Optimized text layout (line splitting, non-breaking spaces for prepositions)

## 🛠 Technologies

- **Flutter / Dart**
- Material UI
- REST API integration (WooCommerce)
- URL Launcher (phone, email, external links)
- Custom UI components and helpers
- Clean widget-based structure (presentation / domain / data separation)
- Git-based environment configuration (API keys are not committed)

## 🧱 Architecture

The project follows a simple layered structure:

- **data** — API clients, repositories, DTOs
- **domain** — business models
- **screens** — UI screens
- **widgets** — reusable UI components
- **utils** — helpers for spacing, text processing, launchers

This approach keeps UI logic readable while allowing the project to grow without overengineering.

## 🔮 Future Improvements

- Search and filtering in the catalog
- Favorites / saved products
- Improved product image gallery
- Admin-driven content updates from the website

## 🎥 Animated Preview

Animated walkthroughs demonstrating navigation and interactions within the app.
GIFs are placed separately to reduce initial load time and preserve quality.

Please note: The GIF may take a few seconds to load, depending on your connection. Thank you for your patience!

![Demo 1](assets/demo1.gif) ![Demo 2](assets/demo2.gif)

