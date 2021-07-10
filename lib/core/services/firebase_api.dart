import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';

class FirebaseApi implements Api {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future getQuestions(int quizId) {
    // TODO: implement getQuestions
    throw UnimplementedError();
  }

  @override
  Future getQuizzes() {
    // TODO: implement getQuizzes
    throw UnimplementedError();
  }

  @override
  Future getUserById(int uid) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return LoginResponse(success: true);
      } else {
        return LoginResponse(success: false);
      }
    } on FirebaseAuthException catch (e) {
      return LoginResponse(success: false, error: e);
    }
  }

  @override
  Future<String>? getPhotoFromPath(String url) async {
    var download = await FirebaseStorage.instance.ref(url).getDownloadURL();
    return download;
  }
}
