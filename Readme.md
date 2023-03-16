# Enviroment
- XCode 13.4.1
- Cocoapod 1.11.3

# Get Started
- Get all dependency by Cocoapods:
```
    pod install
```

- Run app by XCode.


# Project Architecture
Project is using MVVM + RxSwift. MVVM stands for Model-View-ViewModel, and it is a design pattern commonly used in iOS projects. The goal of the MVVM pattern is to separate the concerns of the different components of the app, making it easier to maintain and test.

RxSwift is a library for reactive programming in Swift. It provides a way to handle asynchronous and event-driven code in a declarative manner.

When using MVVM with RxSwift, the basic idea is to have a model layer that represents the data used in the app, a view layer that handles the user interface, and a view model layer that connects the two.

The view model layer is responsible for exposing the data from the model layer to the view layer in a way that is easy to consume, as well as for handling any user input and transforming it into actions that can be performed on the model layer.

RxSwift can be used to make the communication between the different layers of the app more reactive. For example, the view model can observe changes in the model layer using RxSwift's Observable, and the view layer can subscribe to these changes to update the user interface.

Here's a brief summary of the responsibilities of each layer in MVVM + RxSwift:

Model layer: Represents the data used in the app.

View layer: Handles the user interface.

View model layer: Connects the model and view layers, exposing data and handling user input.

RxSwift: Used to make the communication between the different layers of the app more reactive.