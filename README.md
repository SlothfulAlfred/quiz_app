# quiz app

A quiz app offering quizzes related to various programming topics.

## Inspiration

This app is inspired by Fireship's flutter firebase full stack course, during which he
also creates a quiz app. The full course is at https://fireship.io/courses/flutter-firebase/.
I thought this was a great idea for an intermediate level project and tried to build the app
on my own. I did not take Fireship's course, but I'm sure the final product would be much
better than mine. 

## Architecture 

This app is built using the MVVM (Model - View - ViewModel) architecture. Most of the architecture 
is taken from https://www.filledstacks.com/. FilledStacks has an amazing youtube channel full of
production grade flutter code. 

The MVVM model is great for separating the roles of the view, model, and view model, and keeping
the codebase clean and maintainable. It is very similar to MVP and MVC.

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
