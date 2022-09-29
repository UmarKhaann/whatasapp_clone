import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:whatsapp_clone/utils/route_name.dart';
import 'package:whatsapp_clone/utils/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WhatsAppClone());
}

class WhatsAppClone extends StatelessWidget {
  const WhatsAppClone({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsApp Clone',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const ProfileInfo(),
      initialRoute: RouteName.profileInfo,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
