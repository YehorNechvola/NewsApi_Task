# News Feed iOS App

---

## Overview
This is a test iOS application developed as a candidate assignment for the iOS Developer position.  
The app provides a **news feed** using `newsapi.org` (or any other open API). Users can scroll through the latest news, search for articles by keyword locally, and view full news details. The app has **two main screens**.

---

## Features

### News Feed Screen
- Displays a list of news articles in **cards**:
  - **Image** (with placeholder if unavailable)
  - **Title**
  - **Short description** (maximum 2 lines)
- **Search bar**:
  - Allows searching news articles **locally** in the already loaded news feed.
  - Implements **debounced search** with a loading indicator in the search bar.
- **Pull-to-refresh**:
  - Updates the news feed with new articles without replacing the existing list.
- Tapping a news card navigates to the **detail screen**.

### Detail Screen
- Displays the selected article:
  - Full **image**
  - **Title**
  - **Description**
- Optionally opens the original news in a **WebView**.
- Ability to navigate back to the news feed screen.

---

## API
"https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey={APIKey}"
- Fetch the latest news:
-  **Note:** Search is performed **locally** on the loaded articles array. There is no separate API endpoint for search.

---

## Technical Requirements

- Language: **Swift**
- IDE: **Xcode**
- Network requests are performed **asynchronously** 
- Architecture: **MVVM + Coordinator**
- **ViewModel** handles data fetching, business logic, and filtering.
- **ViewController** binds to the ViewModel for UI updates.
- **Coordinator** handles navigation between screens.
- Supports **pull-to-refresh** and **debounced search**
- UI elements use **constants and extensions** for maintainable layout and styling.

---

## Notes

- Search shows a **loading indicator** while debouncing
