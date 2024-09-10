### Rick and Morty Character Viewer App

This iOS application fetches and displays characters from the Rick and Morty API. The application is built using Swift, UIKit, and SwiftUI, and follows the MVVM architecture with Combine for reactive programming. The app displays a list of characters in a paginated manner and provides filtering options to display characters by status (Alive, Dead, Unknown). The detailed character view combines UIKit and SwiftUI.

<img width="437" alt="Screenshot 2024-09-10 at 17 15 36" src="https://github.com/user-attachments/assets/8ea4eb6d-b93f-4875-b480-1bbcc330a19d">
<img width="428" alt="Screenshot 2024-09-10 at 17 15 49" src="https://github.com/user-attachments/assets/fc8332a5-1b93-425e-a5bf-478f4c0716e4">
https://github.com/user-attachments/assets/a15ba9fc-6005-4adb-8404-865117b96f8d



## Features

Fetches characters from the Rick and Morty API and displays them in a paginated list.
Allows filtering characters by status (Alive, Dead, Unknown).
Displays detailed character information in a separate screen.
Combines UIKit and SwiftUI for modern and responsive UI design.

## Instructions for Building and Running the Application

_For development, I used Xcode 16beta_

Prerequisites
Xcode 12+
Swift 5+

## Build and Run
Clone or download the repository.
Open the .xcodeproj file in Xcode.
Set your build target to an iOS Simulator or a physical iOS device.
Press Cmd + R or click Run in Xcode to build and run the application.

## API Configuration
This app uses the Rick and Morty API. No additional setup is required to use the API. The base URL is already embedded in the project.

## swift
[Copy code](https://github.com/clemwek/rickNmorty)


## Assumptions and Decisions Made During Development

**Pagination:** Each API call fetches 20 characters at a time. The app uses infinite scrolling to load more characters as the user scrolls down.

**Filtering:** The filtering functionality is based on the status of characters (Alive, Dead, Unknown). When the user selects a filter, the app refines the list of characters in real-time without making additional API requests.

**Combine and SwiftUI:** The project uses Combine to observe changes in the data (e.g., character list and filter changes). SwiftUI is integrated to create a modern UI with small reusable components embedded into UIKit using UIHostingController.

**Error Handling:** Basic error handling is implemented. If the API fails or no results are available, an empty state is shown.

## Challenges Encountered and How I Addressed Them

Integrating SwiftUI with UIKit:
**Challenge:** Combining SwiftUI views with a UIKit-based app structure.

**Solution:** I used UIHostingController to embed small SwiftUI views (like the character details) into the main UIKit view controllers, allowing for a flexible and modern user interface while maintaining the UIKit lifecycle.

## Pagination:
**Challenge:** Implementing infinite scrolling while making sure that the UI is responsive.
**Solution:** I used a simple check-in scrollViewDidScroll to detect when the user is near the bottom of the list and then trigger an API call to load more characters.

## Data Filtering:
**Challenge:** Efficiently filtering the list of characters without making extra API requests.
**Solution:** I implemented local filtering by observing the status filter with Combine and updating the list in real time, which ensures that the data is filtered without additional network calls.

## Image Loading:
**Challenge:** Loading images efficiently without affecting performance.
**Solution:** Depending on the project, I used a simple image-loading mechanism with URLSession and caching. This can be improved with more functionality or even use a third party library.

## How to Run Tests
This is for when they are added.

Open the Xcode project.
In the Xcode menu, select Product > Test or press Cmd + U.
Xcode will run the unit tests and display the results in the Test Navigator.

## Future Improvements
**UI Improvements: ** I would be nice to polish the UI 
**Better Error Handling:** Add better user feedback for errors such as network failures, API issues, etc.
**UI Enhancements:** Improve the UI for edge cases like empty states and loading indicators.
**Add Tests:** It would be nice to have tests, for future improvements.
