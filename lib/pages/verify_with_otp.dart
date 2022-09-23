import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/home.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:pinput/pinput.dart';

class VerifyWithOTP extends StatefulWidget {
  const VerifyWithOTP({required this.phoneNumber, super.key});
  final String? phoneNumber;

  @override
  State<VerifyWithOTP> createState() => _VerifyWithOTPState();
}

class _VerifyWithOTPState extends State<VerifyWithOTP> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  String? verificationCode;
  TextEditingController pinController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: size.width * .5,
      height: 56,
      textStyle:
          const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1)),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: kWhatsAppColor, width: 2))),
    );

    return Scaffold(
      key: _scaffoldkey,
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * .2),
              child: Pinput(
                length: 6,
                defaultPinTheme: defaultPinTheme,
                controller: pinController,
                pinAnimationType: PinAnimationType.fade,
                onSubmitted: (pin) async {
                  try {
                    await _auth
                        .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: verificationCode!, smsCode: pin))
                        .then((value) async {
                      if (value.user != null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                            (route) => false);
                      }
                    });
                  } catch (e) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Enter 6-digit code',
              style: TextStyle(color: Colors.grey, height: 2),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(kWhatsAppColor)),
              onPressed: () async {
                await _auth
                    .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: verificationCode!,
                        smsCode: pinController.text))
                    .then((value) async {
                  if (value.user != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  }
                });
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

  verifyPhone() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: '+${widget.phoneNumber}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential).then((value) async {
            if (value.user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          verificationCode = verificationId;
        },
        timeout: const Duration(seconds: 120));
  }

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }
}
