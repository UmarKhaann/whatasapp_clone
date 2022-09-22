import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/phone_auth_page.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Expanded(child: Container()),
              Text(
                'Welcome to WhatsApp',
                style: TextStyle(
                  color: kWhatsAppColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              Expanded(child: Container()),
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/welcomepage.jpeg'),
                radius: 120,
              ),
              Expanded(child: Container()),
              const Text(
                'Read out Privacy Policy. Tap ""Agree and continue" to accept the Terms of Service.',
                style: TextStyle(),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: size.height * .04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneAuthPage()));
                  },
                  style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(
                        Size(double.infinity, size.height * .06)),
                    backgroundColor: MaterialStateProperty.all(kWhatsAppColor),
                  ),
                  child: const Text(
                    'AGREE AND CONTINUE',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Expanded(child: Container())
            ],
          ),
        ),
      ),
    );
  }
}
