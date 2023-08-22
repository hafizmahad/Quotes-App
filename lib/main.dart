import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote of the Day App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: QuoteOfTheDayScreen(),
    );
  }
}

class QuoteService {
  static List<Map<String, dynamic>> quotes = [
    {
      "quote": "Quote 1",
      "image": "assets/navi-F6GPoByBDaU-unsplash.jpg", // Asset path
    },
    {
      "quote": "Quote 3",
      "image": "assets/mark-harpur-K2s_YE031CA-unsplash.jpg", // Asset path
    },
    {
      "quote": "Quote 4",
      "image": "assets/navi-F6GPoByBDaU-unsplash.jpg", // Asset path
    },
    {
      "quote": "Quote 5",
      "image": "assets/mark-harpur-K2s_YE031CA-unsplash.jpg", // Asset path
    },
    {
      "quote": "Quote 6",
      "image": "assets/mark-harpur-K2s_YE031CA-unsplash.jpg", // Asset path
    }, {
      "quote": "Quote 7",
      "image": "assets/mark-harpur-K2s_YE031CA-unsplash.jpg", // Asset path
    }, {
      "quote": "Quote 8",
      "image": "assets/mark-harpur-K2s_YE031CA-unsplash.jpg", // Asset path
    },


  ];

  static Map<String, dynamic> getRandomQuote() {
    Random random = Random();
    int index = random.nextInt(quotes.length);
    return quotes[index];
  }
}

class QuoteOfTheDayScreen extends StatefulWidget {
  @override
  _QuoteOfTheDayScreenState createState() => _QuoteOfTheDayScreenState();
}

class _QuoteOfTheDayScreenState extends State<QuoteOfTheDayScreen> {
  Map<String, dynamic> currentQuote = QuoteService.getRandomQuote();
  double opacity = 1.0;

  void _changeQuoteWithAnimation() {
    setState(() {
      opacity = 0.0;
    });

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        currentQuote = QuoteService.getRandomQuote();
        opacity = 1.0;
      });
    });
  }

  void _shareQuote() async {
    final String text = "Check out this inspiring quote: ${currentQuote['quote']}";
    final String smsUri = 'sms:?body=$text';
    final String whatsappUri = 'whatsapp://send?text=$text';

    if (await canLaunch(smsUri)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Share Quote'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('SMS'),
                  onTap: () async {
                    await launch(smsUri);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('WhatsApp'),
                  onTap: () async {
                    await launch(whatsappUri);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    } else {
      print('Could not launch sharing intent.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quote of the Day')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 300),
              child: Image.asset(
                currentQuote['image'], // Asset path
                width: 200,
                height: 200,
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: opacity,
              duration: Duration(milliseconds: 300),
              child: Text(
                currentQuote['quote'],
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeQuoteWithAnimation,
              child: Text('Next Quote'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareQuote,
              child: Text('Share Quote'),
            ),
          ],
        ),
      ),
    );
  }
}
