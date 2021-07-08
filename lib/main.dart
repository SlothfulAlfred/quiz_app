import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'quiz_app.dart';
import 'package:quiz_app/locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(QuizApp());
}
