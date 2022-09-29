import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/chat_screen.dart';
import 'package:whatsapp_clone/pages/phone_provider_screen.dart.dart';
import 'package:whatsapp_clone/pages/profile_info_page.dart';
import 'package:whatsapp_clone/pages/verify_with_otp.dart';
import 'package:whatsapp_clone/pages/welcome_page.dart';
import 'package:whatsapp_clone/utils/route_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.welcomeScreen:
        return MaterialPageRoute(builder: (context) => const WelcomeScreen());

      case RouteName.profileInfo:
        return MaterialPageRoute(builder: (context) => const ProfileInfo());

      case RouteName.verifyWithOTP:
        return MaterialPageRoute(
            builder: (context) => VerifyWithOTP(
                  data: settings.arguments as Map,
                ));

      case RouteName.phoneProviderScreen:
        return MaterialPageRoute(
            builder: (context) => const PhoneProviderScreen());

      case RouteName.chatScreen:
        return MaterialPageRoute(builder: (context) => const ChatScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('No route found!'),
            ),
          );
        });
    }
  }
}
