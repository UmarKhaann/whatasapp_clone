import 'package:flutter/material.dart';
import 'package:whatsapp_clone/pages/verify_with_otp.dart';
import 'package:whatsapp_clone/utils/colors.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  String selectedCountry = 'Select Country';
  String? countryCode;
  TextEditingController phoneController = TextEditingController();
  bool loading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  verifyPhoneNumber() {
    setState(() {
      loading = true;
    });

    _auth.verifyPhoneNumber(
      phoneNumber: '+$countryCode${phoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);

        setState(() {
          loading = false;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('the provided phone number is not valid');
        }
        setState(() {
          loading = false;
        });
      },
      codeSent: (String verificationId, int? resendToken) async {
        String smsCode = '2313';

        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        await _auth.signInWithCredential(credential);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyWithOTP(
              verificationId: verificationId,
              phoneNumber: phoneController.text,
            ),
          ),
        );

        setState(() {
          loading = false;
        });
      },
      codeAutoRetrievalTimeout: (String str) {
        setState(() {
          loading = false;
        });
      },
    );
  }

  countryPicker() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          countryCode = country.phoneCode;
          selectedCountry = country.displayNameNoCountryCode;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Enter your phone number',
            style:
                TextStyle(color: kWhatsAppColor, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: const [
            Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 102, 99, 99),
              size: 28,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                              text:
                                  'WhatsApp will need to verify your phone number.'),
                          TextSpan(
                              text: " What's my number?",
                              style: TextStyle(color: Colors.blue))
                        ])),
              ),
              // select country
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: kWhatsAppColor))),
                width: size.width * .6,
                child: Row(
                  children: [
                    Expanded(child: Container()),
                    TextButton(
                      onPressed: countryPicker,
                      style: const ButtonStyle(),
                      child: Text(
                        selectedCountry,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 15, height: 2),
                      ),
                    ),
                    Expanded(child: Container()),
                    IconButton(
                        onPressed: countryPicker,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: kWhatsAppColor,
                        ))
                  ],
                ),
              ),
              //enter your number
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: kWhatsAppColor))),
                    width: size.width * .15,
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: '+  ',
                            style:
                                TextStyle(color: Colors.grey[700], height: 3),
                          ),
                          TextSpan(text: countryCode, style: const TextStyle())
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width * .05,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: kWhatsAppColor))),
                    width: size.width * .40,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        hintText: 'phone number',
                        contentPadding: EdgeInsets.only(top: 15),
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(child: Container()),

              //next button
              ElevatedButton(
                onPressed: verifyPhoneNumber,
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kWhatsAppColor)),
                child: loading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        'NEXT',
                        style: TextStyle(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
