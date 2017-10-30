# TweetleDumb
Mock (dumb) Twitter client

## Thought Process
Even though this is a mock client I wanted to approach it with the mindset that the mock components (network/auth) could be swapped out for their 'real' counterparts and the app would essentially 'just work'™. The core components and view models have included tests.

## What's not included
There is no persistence layer included however if I was to include one I would approach it in a similar fashion to the other services. A protocol would sit over whatever implementation was chosen (core data/realm etc). For this application I might also pass the persistence layer to the API component. This would allow auto-storing of incoming data then, should the app be offline or simply fail, the stored data would be provided so the application would have a better chance of not being empty.

## Architecture
The application takes advantage of a variety of techniques including:

- **Navigation Coordinators**: provides decoupled navigation. View controller are more modular when they don't know about each other - navigation technically becomes view model to view model and the UI is a 'dumb' layer on top, only performing assignments and sending actions.
- **MVVM**: provides decoupled logic. When we extract the logic from views into view models we are able to easily test the behaviour of each screen. We can put the view model into any state we want and assert on it without actually needing to load the view at all.
- **Dependency Injection**: provides explicit references. When we enforce that all dependencies are injected it becomes easy to reason about the dependency graph in our application. It act as documentation and allow us to very quickly recognise when functionality should be refactored into a separate component.
- **Delegate**: I chose delegates as a pub/sub system instead of something like Rx simply to be pragmatic, I haven't used Rx heavily since version 2. I have included a simple `MulticastDelegate` to support multiple observers where required. This system still allows communication between obejcts to be explicit.
- **Result\<T>**: provides unified success/failure type. The result type is a fantastic choice for async callbacks and far better than either separate success/failure callbacks or a single with 2 optional values. It provides all of the benefits of a single callback, allowing for actions to be performed regardless of result. It also removes the issues with a single callback using 2 optionals by reducing the possible states to _only_ success and failure.
- **TableViewCellRepresentable**: This is a responsibility inversion pattern I developed and use frequently to remove almost all table view boilerplate from view controllers. It also allows view controllers to scale to any number of different cell types without any change to the datasource code. [Original article](https://medium.com/@IanKeen/separation-of-concerns-ui-edition-1916a35a6899)
- **KeyPathAccessible**: Provides type safe deserialization of dictionary and arrays. This is a lite wrapper that gives meanigful errors when the value cannot be extracted (similar to the recent `Codable` tools in swift 4)

## Service Layer
The application includes a few simple service objects which the view models use to supply the functionality.

- **KeyValueStore**: Provides a common interface to key/value data for the app. It can be applied to `UserDefaults`, the keychain or even a dictionary for testing.
- **Network**: Provides access to raw HTTP requests/responses. The protocol sits on top of the underlying network implementation which can be `URLSession`, something like `AFNetwork` or in this case `MockNetwork`. It allows for the implementation to easily be swapped out if required.
- **API**: Provides logic on top of `Network` that adds the domain specific parts of network access. This includes signing requests or handling API specific errors.
- **Authentication**: This provides all the components of auth or user 'session's.
	- `Authenticator` represents an external authenticator (i.e. twitter/facebook).
	- `AuthenticationState` holds the current `Authentication` data and is responsible for clearing or persisting it between sessions.
	- `AuthenticationController` handles bringing all the pieces together. It uses an `Authenticator` to get an external token, then `API` to swap that token for `Authentication` data which is stored in `AuthenticationState`
