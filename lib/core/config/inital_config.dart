import 'package:firebase_core/firebase_core.dart';
import 'package:jiffy/jiffy.dart';

Future<void> initalConfig() async {
  await Firebase.initializeApp();
  await Jiffy.locale('es');
}
