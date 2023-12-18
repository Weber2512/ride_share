import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:ride_share/services/firebase_auth_methods.dart';
import 'package:ride_share/signinsignupscreen/signinsignup.dart';
import 'package:flutter/material.dart';
import 'package:ride_share/mainscreen/sumeetscreen.dart';
import "package:flutter/services.dart";
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) => runApp(
        MultiProvider(
          providers: [
            Provider<FirebaseAuthMethods>(
              create: (_) => FirebaseAuthMethods(FirebaseAuth.instance),
            ),
            StreamProvider(
                create: (context) =>
                    context.read<FirebaseAuthMethods>().authState,
                initialData: null),
          ],
          child: MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 161, 190, 203),
              ),
            ),
            home: const AuthWrapper(),
          ),
        ),
      ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    if (firebaseUser != null) {
      return const Sumeet();
    } else {
      return const SigninLogin();
    }
  }
}
