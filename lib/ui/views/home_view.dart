import 'package:flutter/material.dart';
import 'package:quiz_app/core/viewModels/home_view_model.dart';
import 'package:quiz_app/core/viewstate_enum.dart';
import 'package:quiz_app/locator.dart';
import 'package:quiz_app/ui/shared/base_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final HomeViewModel model = locator<HomeViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BaseView(
        builder: (BuildContext context, HomeViewModel model, Widget? chlild) {
          if (model.state == ViewState.idle) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    color: Colors.grey[850],
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: (model.quiz.length > 0)
                          ? Image.network(
                              model.quiz[0].imagePath,
                              fit: BoxFit.cover,
                            )
                          : Placeholder(),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: model.fetchImage,
                    child: Text('Press Me'),
                  ),
                ],
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
}
