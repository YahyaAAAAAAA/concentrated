import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tweleve_ace/presentation/pages/question_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(12),
          children: [
            Center(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QuestionListPage()),
                  );
                },
                icon: Text('add exam'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
