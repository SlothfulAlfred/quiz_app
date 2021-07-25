import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/core/models/api_models.dart';
import 'package:quiz_app/core/services/api.dart';

/// Access point to Firebase authentication, cloud storage, and firestore
/// database.
class FirebaseApi implements Api {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  @override
  Future getQuestions(String quizId) async {
    List<Question> questions = [];
    // Access the 'question' collection, choose only the questions
    // where 'quizId' is equal to the given quizId.
    var query = await _db
        .collection('question')
        .where('quizId', isEqualTo: quizId)
        .get();
    // Accumulate the results in a list then return the list.
    query.docs.forEach((question) {
      questions.add(Question.fromjson(question));
    });
    return questions;
  }

  @override
  Future<List<Quiz>> getQuizzes() async {
    List<Quiz> quizzes = [];
    // Get all documents in collection 'quiz' then accumlate them
    // in a list. Return the list.
    await _db.collection('quiz').get().then((QuerySnapshot query) {
      query.docs.forEach((doc) {
        quizzes.add(Quiz.fromJson(doc));
      });
    });
    return quizzes;
  }

  @override
  Future getUserById(String uid) async {
    late var result;
    // Access the users collection, find the document with the correct uid,
    // retrieve it.
    var query =
        await _db.collection('users').where('uid', isEqualTo: uid).get();
    // Then check if it only has a single document (it should), then return its data.
    result = query.docs.single.data();
    return result;
  }

  @override
  Future<LoginResponse> login(String email, String password) async {
    // Try to sign in with email and password.
    try {
      var result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        // If the resulting user is not null, return a successful response.
        return LoginResponse(success: true, user: result.user);
      } else {
        // Otherwise, return a failing response.
        return LoginResponse(success: false);
      }
    } on Exception catch (e) {
      // If there is an error, return a failing response with error details.
      return LoginResponse(success: false, error: e);
    } catch (e) {
      print(e);
      return LoginResponse(success: false);
    }
  }

  @override
  Future<String>? getPhotoFromPath(String url) async {
    var download = await FirebaseStorage.instance.ref(url).getDownloadURL();
    return download;
  }
}
