# ChapterChat AI

Cross-platform Flutter application designed to combine digital reading with interactive storytelling. The project provides the foundation for a digital library where readers can manage books and, in future versions, interact with story characters through an AI-powered chat experience.

## Overview

ChapterChat AI is a mobile and desktop application concept focused on making reading more interactive. The platform is designed around two main user roles: readers who access and organize a digital library, and writers who can publish works and define character information for future AI interactions.

The current version focuses on the core Flutter application structure, including a functional library interface, book search, reusable UI components, and a centralized theme system with light and dark modes.

## Key Features

* Cross-platform Flutter application
* Digital library interface
* Book listing with title, author, cover, and reading status
* Search functionality by book title or author
* Light and dark theme support
* Centralized theme management
* Reusable book cards and common UI widgets
* Modular project structure
* Foundation for future AI chat integration
* Planned support for persistent storage and book metadata editing

## Tech Stack

* Flutter
* Dart
* Provider
* ChangeNotifier
* Material Design

## Architecture

The project follows a standard Flutter architecture, with the main application logic organized inside the `lib/` directory. The structure separates app initialization, theme management, data models, screens, and reusable widgets.

### App Entry Point

The application starts from `main.dart`, where the Flutter app is initialized and the main `MaterialApp` configuration is defined.

### Theme System

The theme system uses a centralized provider to manage light and dark modes. This allows the UI to react to theme changes and keep visual consistency across the application.

### Data Models

The main data model is the `Book` class, which represents the basic information needed for library management, including title, author, cover image, and reading status.

### Screens

The main screen is the home/library dashboard. It displays the list of books, provides search functionality, and connects user actions with each book card.

### Reusable Widgets

The project includes reusable components such as book cards, search input, and a theme toggle button. This helps keep the interface modular and easier to maintain.

## Current Functionality

The current version includes:

* A functional home screen
* A sample book library
* Search and filtering logic
* Theme switching between light and dark mode
* Reusable UI components
* Basic action handlers prepared for future features

## Planned Features

Future improvements may include:

* AI-powered character chat
* Persistent database storage
* Book upload and management
* Writer interface for editing book and character metadata
* Reading progress tracking
* Navigation to individual chat or book detail screens

## Getting Started

Install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

Run tests:

```bash
flutter test
```

## Project Purpose

This project was created to explore cross-platform application development with Flutter while building the foundation for an AI-assisted reading experience. It demonstrates skills in mobile UI development, state management, theme architecture, reusable component design, and planning for future AI and database integration.
