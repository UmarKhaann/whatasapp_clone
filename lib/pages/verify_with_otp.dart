import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class VerifyWithOTP extends StatefulWidget {
  const VerifyWithOTP(
      {required this.phoneNumber, required this.verificationId, super.key});
  final String? phoneNumber;
  final String? verificationId;

  @override
  State<VerifyWithOTP> createState() => _VerifyWithOTPState();
}

class _VerifyWithOTPState extends State<VerifyWithOTP> {
  TextEditingController phoneNumberController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Text(
          'Verify your number',
          style: TextStyle(color: kWhatsAppColor),
        ),
        actions: const [
          Icon(
            Icons.more_vert,
            color: Colors.grey,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        child: Column(
          children: [
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                ),
                children: [
                  const TextSpan(
                    text: 'Waiting to automatically detect an SMS sent to.',
                  ),
                  TextSpan(
                      text: widget.phoneNumber.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const TextSpan(
                      text: 'Wrong number?',
                      style: TextStyle(color: Colors.blue))
                ],
              ),
            ),
            SizedBox(
              width: size.width * .5,
              child: Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: kWhatsAppColor, width: 2))),
                child: TextField(
                  controller: phoneNumberController,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintText: '-- -- -- -- -- --',
                      fillColor: kWhatsAppColor,
                      focusColor: kWhatsAppColor,
                      hoverColor: kWhatsAppColor,
                      contentPadding: const EdgeInsets.only(top: 10)),
                ),
              ),
            ),
            const Text(
              'Enter 6-digit code',
              style: TextStyle(color: Colors.grey, height: 2),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () async {
                final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId!,
                  smsCode: phoneNumberController.text.toString(),
                );
                try {
                  await _auth.signInWithCredential(credential);
                  // navigate to chat screen
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                } catch (e) {
                  print(e);
                }
              },
              child: const Text('Verify'),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Icon(
                  Icons.message,
                  color: kWhatsAppLightColor,
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                const Text('Resend SMS'),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.call,
                  color: kWhatsAppLightColor,
                ),
                SizedBox(
                  width: size.width * .05,
                ),
                const Text('Call me'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
