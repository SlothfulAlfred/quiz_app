import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/home_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/shared/base_view.dart';
import 'package:quiz_app/ui/shared/ui_helper.dart';
import 'package:quiz_app/ui/widgets/quiz_tile.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeViewModel model = locator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: model.openSettings,
            tooltip: 'open settings',
          )
        ],
      ),
      drawer: _buildDrawer(),
      // When the drawer opens, update it so that it builds with the
      // newest information.
      onDrawerChanged: (bool opened) =>
          (opened == true) ? setState(() {}) : null,
      body: BaseView(
        builder: (BuildContext context, HomeViewModel model, Widget? chlild) {
          if (model.state == ViewState.idle) {
            return Center(
              child: GridView.count(
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                // Take the quizzes from the model and map them all to [QuizTile]s
                children: model.quiz
                    .map<QuizTile>((quiz) => QuizTile(
                          id: quiz.id,
                          imagePath: quiz.imagePath,
                          title: quiz.title,
                          length: quiz.length,
                          completed: model.getCompletedForQuiz(quiz.id),
                          onTap: () {
                            // Pushes a [QuizView] initialized with the given quiz.
                            // After the page is popped, calls [notifyListeners] to
                            // rebuild [HomeView].
                            model.heroTapped(quiz);
                          },
                        ))
                    .toList(),
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 24),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text(
              'Your Progress',
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
            ),
          ),
          for (var quiz in model.quiz)
            Column(
              children: [
                Divider(
                  color: Colors.black,
                ),
                Text(
                  quiz.title,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                VerticalSpace.small,
                Container(
                  child: ProgressBar(
                      quiz.length, model.getCompletedForQuiz(quiz.id)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(),
                  ),
                ),
                VerticalSpace.small,
              ],
            ),
          Divider(
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
