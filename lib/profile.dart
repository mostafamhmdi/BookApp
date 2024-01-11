import 'package:test1/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class profile_page extends StatefulWidget {
  @override
  State<profile_page> createState() => _profile();
}

class _profile extends State<profile_page> {
  bool isHeartFilled = false;
  final List<String> pngIcons = [
    'images/Python.png',
    'images/powerBI.png',
    'images/TF.png',
    'images/pandas.png',
    'images/mysql.png',
  ];
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var fontSize = themeProvider.fontSize;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
        actions: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              icon: Icon(
                isHeartFilled
                    ? CupertinoIcons.heart_fill
                    : CupertinoIcons.heart,
                color: isHeartFilled ? Colors.red : Colors.redAccent,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  isHeartFilled = !isHeartFilled;
                });
              },
            ),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(360),
                    child: Image.asset(
                      'images/Mostafa.png',
                      width: MediaQuery.of(context).size.width * 0.33,
                      height: MediaQuery.of(context).size.width * 0.33,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Mostafa Mohammadi',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.065,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.003,
              ),
              Text(
                'Data Scientist',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  color: Color.fromARGB(255, 231, 229, 229),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.006,
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.036,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x72736c).withOpacity(0.86),
                        offset: Offset(1, 0),
                        blurRadius: 9,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      String githubUrl =
                          'https://www.linkedin.com/in/mostafamhmdi/';
                      Clipboard.setData(ClipboardData(text: githubUrl));

                      // Show SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Linkedin URL Copied to clipboard'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Color.fromRGBO(153, 153, 153,
                              1), // You can customize the duration
                        ),
                      );
                      // Button action
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(
                          253, 200, 67, 1.0), // Set your desired color here
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blue,
                            size: MediaQuery.of(context).size.width * 0.085,
                          ),
                        ),

                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.025), // Adjust the spacing between the icon and text
                        Text(
                          'linkedin.com/in/mostafamhmdi/',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Add more buttons here if needed
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.042,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x72736c).withOpacity(0.86),
                        offset: Offset(1, 0),
                        blurRadius: 9,
                        spreadRadius: 2,
                      )
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: ElevatedButton(
                    onPressed: () {
                      String githubUrl = 'https://github.com/mostafamhmdi';
                      Clipboard.setData(ClipboardData(text: githubUrl));

                      // Show SnackBar
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Github URL Copied to clipboard'),
                          duration: Duration(seconds: 1),
                          backgroundColor: Color.fromRGBO(153, 153, 153,
                              1), // You can customize the duration
                        ),
                      );

                      // Button action
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(
                            253, 200, 67, 1.0) // Set your desired color here
                        ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Icon(
                            FontAwesomeIcons.github,
                            color: Color.fromARGB(255, 2, 2, 2),
                            size: MediaQuery.of(context).size.width * 0.085,
                          ),
                        ),

                        SizedBox(
                            width: MediaQuery.of(context).size.width *
                                0.025), // Adjust the spacing between the icon and text
                        Text(
                          'github.com/mostafamhmdi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Add more buttons here if needed
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.01,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 40, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xd7b590).withOpacity(1),
                          offset: Offset(0, 1),
                          blurRadius: 16,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.175,
                    height: MediaQuery.of(context).size.width * 0.175,
                    child: ElevatedButton(
                      onPressed: () {
                        String githubUrl = 'mostafamohammadi2100@gmail.com';
                        Clipboard.setData(ClipboardData(text: githubUrl));

                        // Show SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Gmail Copied to clipboard'),
                              duration: Duration(seconds: 1),
                              backgroundColor: Color.fromRGBO(153, 153, 153,
                                  1) // You can customize the duration
                              ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Adjust the border radius as needed
                          ),
                          primary: Color.fromRGBO(253, 200, 67, 1.0)),
                      child: Icon(
                        FontAwesomeIcons.google,
                        size: MediaQuery.of(context).size.width * 0.065,
                        color: Colors.black, // Adjust the icon color as needed
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 40, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xd7b590).withOpacity(1),
                          offset: Offset(0, 1),
                          blurRadius: 16,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.175,
                    height: MediaQuery.of(context).size.width * 0.175,
                    child: ElevatedButton(
                      onPressed: () {
                        String githubUrl = 'https://t.me/Mostafa_mhammadi';
                        Clipboard.setData(ClipboardData(text: githubUrl));

                        // Show SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Telegram URL Copied to clipboard'),
                              duration: Duration(seconds: 1),
                              backgroundColor: Color.fromRGBO(153, 153, 153,
                                  1) // You can customize the duration
                              ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Adjust the border radius as needed
                          ),
                          primary: Color.fromRGBO(253, 200, 67, 1.0)),
                      child: Icon(
                        FontAwesomeIcons.telegram,
                        size: MediaQuery.of(context).size.width * 0.065,
                        color: Colors.black, // Adjust the icon color as needed
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xd7b590).withOpacity(1),
                          offset: Offset(0, 1),
                          blurRadius: 16,
                          spreadRadius: 1,
                        )
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.175,
                    height: MediaQuery.of(context).size.width * 0.175,
                    child: ElevatedButton(
                      onPressed: () {
                        String githubUrl =
                            'https://www.instagram.com/mostafa_mhammadi/';
                        Clipboard.setData(ClipboardData(text: githubUrl));

                        // Show SnackBar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Instagram URL Copied to clipboard'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color.fromRGBO(153, 153, 153,
                                1), // You can customize the duration
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                25.0), // Adjust the border radius as needed
                          ),
                          primary: Color.fromRGBO(253, 200, 67, 1.0)),
                      child: Icon(
                        FontAwesomeIcons.instagram,
                        size: MediaQuery.of(context).size.width * 0.065,
                        color: Colors.black, // Adjust the icon color as needed
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.035,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonBar(
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(double.infinity,
                              MediaQuery.of(context).size.height * 0.045),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromRGBO(3, 69, 151, 1)),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Container(
                              height: 100,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: pngIcons.map((path) {
                                    return Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        // Set your desired width here
                                        child: Image.asset(
                                          path,

                                          height:
                                              60, // Set your desired height here
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Text(
                        'Click to see what I know',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 180, 177, 177),
    );
  }
}
