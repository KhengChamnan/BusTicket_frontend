# Product Requirements Document (PRD): City Bus Ticket

## 1. Executive Summary
The **City Bus Ticket** application is designed to streamline public transportation access by allowing users to purchase bus tickets digitaly and manage their travel history. This document outlines the functional requirements, design system usages, and strict technical coding standards required for the development of the application.

## 2. Product Goals
- **Simplicity**: Minimize the steps required to purchase a ticket.
- **Reliability**: ensuring data consistency and strict typing in the codebase.
- **Maintainability**: Adhere to a strict folder structure and naming convention to ensure the codebase remains scalable.

## 3. Target Audience
- Daily commuters requiring quick access to bus passes.
- Occasional travelers needing a simple way to buy tickets without physical cash.

## 4. Key Features & Functional Requirements

### 4.1 Ticket Purchase
- **FR-01**: Users shall be able to select a **Start Date** and **End Date** for their ticket/pass.
- **FR-02**: Users shall be able to specify quantities (e.g., number of days or travelers).
- **FR-03**: The interface must validate inputs (e.g., end date cannot be before start date).

### 4.2 Ticket History
- **FR-04**: Users shall be able to view a history of purchased tickets.
- **FR-05**: Users shall be able to interaction with past items (e.g., reuse or view details).

## 5. Design System

You can find in the `/doc` folder a link to a start **Figma Design System** and **user flows**.

- You can create your **own copy** to it along the development.
- This file allows you to **identify each widget settings** (color, spaces, icons) and anticipate generic app widget needs.

### 5.1 Theme Implementation
- Themes are defined in the `/theme` folder.
- `theme.dart` file defines:
  - `ColorsCityBusColors`
  - `TextStylesCityBusTextStyles`
  - `SpacingCityBusSpacings`
  - `IconsCityBusIcons`
- All widgets should reference `theme.dart` for styling instead of hardcoding styles.

## 6. Technical Architecture & Coding Conventions

The application follows strict coding conventions to ensure consistency.

### 6.1 Folder Structure
The project shall be organized around the following folders:

| Folder   | Description                                      |
|----------|--------------------------------------------------|
| model    | Contains data models                             |
| data/dto | Contains data transfer objects (DTOs)            |
| data/repository/abstract | Contains abstract data sources and repositories  |
| data/repository/rails | Contains Rails-specific data repositories |
| theme    | Contains theming and styling constants           |
| utils    | Contains utility functions and helper classes    |
| widgets  | Contains reusable app widgets                    |
| screens  | Contains UI screens and their related components |

### 6.2 Data Models
- Model classes are located in the `/model` folder.
- Models should be immutable whenever possible and include:
  - `copyWith()` method
  - Proper implementations of `==` (equals) and `hashCode` for comparison
  - A `toString()` method for debugging purposes
- Models should only manage the data structure and its manipulation.
- **Constraint**: No persistence, Flutter, or networking code should be present in models.
- Model classes should be grouped into subfolders based on logical topics:
  - `/model/users`
  - `/model/buses`
  - `/model/bus_schedules`

### 6.3 Utilities
- Utility classes are placed in the `/utils` folder.
- These classes contain static methods for common tasks:
  - Formatting dates
  - Handling screen animations, etc.

### 6.4 Widget Hierarchy

#### App Widgets (Reusable)
- Placed in the `/widgets` folder.
- Grouped into subfolders based on UI categories:
  - `actions/` (e.g., buttons)
  - `inputs/` (e.g., text fields)
  - `display/` (e.g., cards, lists)
  - `notifications/` (e.g., snackbars, alerts)
- **Naming Config**: App Widgets should be prefixed with the app's short name (e.g., `citybus_button.dart`).

#### Screen Widgets (Specific)
- Located in `/screens/{screen_name}/widgets/`
- Example: `/screens/ticket_purchase/widgets/ticket_purchase_form.dart`
- **Naming Config**: Screen widgets should be prefixed with the screen name (e.g., `ticket_purchase_history_tile.dart`).

#### Architecture Diagram (Description)
The App Theme is used by App Widgets, which in turn are used by Screen Widgets. Screen Widgets are then used by the Screen. Additionally, all screens and widgets shall refer to the App Theme constants for color, text styles, and other styling elements.

### 6.5 Documentation & Comments
Three types of comments are required:

**1. Explaining a Class**
```dart
/// This screen allows users to:
/// - Purchase bus tickets and submit them.
/// - View previous ticket purchases and reuse them.
```

**2. Explaining Statements**
```dart
startDate = null;                   // User must select the start date
requestDate = DateTime.now();       // Defaults to now
```

**3. Clarifying Steps**
```dart
// 1 - Notify the listener
widget.onRequestChanged(newText);
// 2 - Update the cross icon
setState(() {});
```

### 6.6 Naming Conventions

#### Identifiers
| Type       | Convention                     |
|------------|--------------------------------|
| Class      | UpperCamelCase                |
| Methods    | lowerCamelCase                |
| Variables  | lowerCamelCase                |
| File Names | lowercase_with_underscores.dart |

#### Best Practices
- **Getters**: Use getters to expose computed values.
  ```dart
  bool get showEndDatePlaceholder => endDate == null;
  ```
- **Explicit Types**: Always specify types explicitly.
  ```dart
  // Good
  final TicketPurchase initTicketPurchases;
  ```
- **Consistency**: Use terms consistently (e.g., if using `pageCount`, use `updatePageCount()`).