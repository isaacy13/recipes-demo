### Steps to Run the App
Clone project
- git clone git@github.com:isaacy13/recipes-demo.git
- git clone https://github.com/isaacy13/recipes-demo.git

Open project
-  Open project in Xcode with simulators running >= iOS 16.0
- Select appropriate scheme (DEV, CERT, PROD) with desired simulator
- Run project by pressing play button or (cmd + R)

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?

I did my best to try to cover all areas mentioned (architecture, concurrency, UI/UX, and performance optimization) to demonstrate knowledge over each area.

Architecture
- Created maintainable folder structure which could be easily added onto in the future
- Usage of protocols, enums, reusable components, helpers, dedicated API classes, and utilities to maximize reusability and clean structure
- Simulated a "production-like" project setup (different targets per environment, log helpers, preprocessor directives for DEBUG, MVVM pattern, etc.)

Concurrency
- Usage of @MainActor in unit tests to ensure data reads in XCTest happen after business logic
- Actual application usage utilizes thread pools for maximum performance
- Ensured state updates are on main thread to prevent unexpected behavior

UI/UX
- Attempted to demonstrate optimal usage of @StateObject, @State, @Published, @ObservedObject, ObservableObject
- Separated UI components for reusability and added previews for quicker development
- Clean UX with easy-to-digest UI (list / grid views, allow user to pinch & zoom, standard refresh patterns, good usage of colors & whitespace)

Performance
- Used Proxyman to validate lazy loading and image caching (3rd party library)
- Ensured API call only on app launch or when user takes action to reload (swipe to to refresh or manual refresh button)

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?

I spent ~5.5 hours on this project and did not use any AI tools (though I do use them in my day-to-day). 

PDF in email mentioned to not use any AI tools while the prompt gave the thumbs up for AI. To be safe, I just didn't use AI.

My time log looked like this:
- digest information in PDF & think of ideas -> 15 minutes
- setup Xcode project configuration, setup tools & settings -> 45 minutes (longer than expected setting up new project, tools & settings I didn't have on my personal laptop, etc.)
- worked on API functionality and basic architecture -> 2 hrs (since it was the most straight forward)
- started working on page and components views -> 2 hrs (played around with designs, ensuring efficiency, etc.)
- wrapped up with unit tests -> 30 mins

I took some timegaps in my development (to take calls, make & eat food, work on other projects), but the work was largely completed in ~2.5 hr sessions on two separate days. The README writeup was done on another day.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?

I made a few decisions I think could have been better:
- HomeViewModel's `func loadRecipes(...)` could've been better for unit testing (actually throw & test for specific exceptions)
- Test target is only for DEV, but can be cloned for each environment
- Normally, plist wouldn't live in the repository, but be built in pipeline
- Compromised the look of error handling (e.g.: alerts, "image failed to load", etc.) for time

### Weakest Part of the Project: What do you think is the weakest part of your project?

Of the compromises, I think my sacrifice of a good user experience in favor of time (e.g.: suboptimal error messages) is the weakest part of my project.

### External Code and Dependencies: Did you use any external code, libraries, or dependencies?

- [swiftui-cached-async-image](https://github.com/lorenzofiamingo/swiftui-cached-async-image)
- Used [stack overflow code](https://stackoverflow.com/questions/58341820/isnt-there-an-easy-way-to-pinch-to-zoom-in-an-image-in-swiftui) for InspectableImageView

### Additional Information: Is there anything else we should know? Feel free to share any insights or constraints you encountered.
I wish I could've used EnvironmentObject or Actors in some way to demonstrate state management / concurrency. Of course, in retrospect I wish I didn't make any trade-offs in favor of time. Also, I should've prepped my new personal laptop better ahead of time (disable Xcode AI, download Proxyman, CLI tools, etc.) in order to save more time.