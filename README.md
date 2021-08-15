# quiz app

A quiz app offering quizzes related to various programming topics.

## Get Started
* set up flutter [https://flutter.dev/docs/get-started/install]
* clone the repository
* run ```flutter pub get``` in the command line
* start the app using ```flutter run```

## Inspiration

This app is inspired by Fireship's flutter firebase full stack course, during which he also creates a quiz app. The full course is at https://fireship.io/courses/flutter-firebase/. I thought this was a great idea for an intermediate level project and tried to build the app on my own. I did not take Fireship's course, but I'm sure the final product would be much better than mine. 

## Architecture 

This app is built using the MVVM (Model - View - ViewModel) architecture. Most of the architecture is taken from https://www.filledstacks.com/. FilledStacks has an amazing youtube channel full of production grade flutter code. 

The MVVM model is great for separating the roles of the view, model, and view model, and keeping the codebase clean and maintainable. It is very similar to MVP and MVC.

#### Differences between MVP, MVC, and MVVM (as I understand it)
Most of my information is sourced from https://academy.realm.io/posts/eric-maxwell-mvc-mvp-and-mvvm-on-android/.

MVC
- View signals the controller when there is user interaction
- Model does not depend on anything and communicates only with the controller
- Controller communicates with the model and sets up the view

MVP
- View signals the presenter when there is user interaction and handles its own building
- Model is similar to MVC, communicating only with the presenter
- Presenter is essentailly the communication between the model and the view, both handle their own logic. i.e. View tells Presenter what happened, Presenter relays that to the Model, the Model handles that and tells Presenter the result, Presenter tells the View what to display according to that result.

MVVM
- View watches / observes / binds to variables in the view model, handles its own building and relays user interaction 
- Model is similar to MVC and MVP
- ViewModel handles communication between the View and the Model, and takes care of all business logic. Whenever the ViewModel changes an observed attribute, the View automatically rebuilds itself accordingly. This is very similar to MVP but reduces the amount of code needed to connect the View with the ViewModel / Presenter.


#### Some lessons learned about architecture
  While I was building part of this app, I noticed that it did not easily mesh with the MVVM architecture. For context, I was trying to implement a nested Navigator flow inside the app. In flutter, this is done by creating a Widget which returns a Scaffold in the build method. The body of this Scaffold is a Navigator widget, more implementation details can be found here: https://flutter.dev/docs/cookbook/effects/nested-nav. This didn't work well with the MVVM model at all, since the Widget containing the Scaffold is a sort of hybrid widget; it's not exactly business logic but it's not UI logic either. I spend two days thinking of different solutions to try and get this to fit the architecture, eventually, I decided that I'll keep the Scaffold inside of the ViewModel. 

  Although the solution worked, I felt that it was unsatisfactory since it didn't fit in with the rest of the app. I later found this article (https://blog.pragmaticengineer.com/software-architecture-is-overrated/). A quote that really stood out to me was _"the last thing you want to do is taking one or more architecture pattern, using it as a hammer, looking for nails to use it on"_. In addition to realizing that architecture is a means to help simplify and structure your program, I realized that my planning was very lacking compared to professionals. For my next project, I plan to spend far more time planning my app abstractly, using diagrams and documents, before starting any coding. 
 
#### Using Flutter Built-in Widgets
  This project has introduced me into uses of simple Flutter built-ins to create beautiful designs. For example, using [DecoratedBox] to wrap a button and create a gradient, or using a [Container] with a [BoxShadow] to create an elevated card. 
  
## Todo 
[ ] Write Firestore security rules
[ ] Change profile pictures using image_picker plugin
[ ] Write more quizzes and questions; create art for quizzes
