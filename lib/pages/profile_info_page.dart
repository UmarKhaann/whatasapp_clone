import 'package:flutter/material.dart';
import 'package:whatsapp_clone/utils/colors.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Text(
              'Profile Info',
              style: TextStyle(color: kWhatsAppColor),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Please provide your name and an optional profile photo.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Flexible(
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            hintText: 'Type your name here',
                            focusColor: kWhatsAppColor,
                            fillColor: kWhatsAppColor,
                            hoverColor: kWhatsAppColor,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: kWhatsAppColor, width: 2)),
                            contentPadding: const EdgeInsets.only(bottom: -20)),
                      ),
                    ),
                    const Icon(
                      Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                    )
                  ],
                ),
                Expanded(child: Container()),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(kWhatsAppColor)),
                  child: const Text('NEXT'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
