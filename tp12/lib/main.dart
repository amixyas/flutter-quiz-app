import 'package:flutter/material.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyQuizePage(),
    );
  }
}

class MyQuizePage extends StatefulWidget {
  const MyQuizePage({Key? key}) : super(key: key);

  @override
  _MyQuizePageState createState() => _MyQuizePageState();
}

class Quiz {
  String image;
  String question;
  bool answer;


  Quiz(this.image, this.question, this.answer);
}

class _MyQuizePageState extends State<MyQuizePage> {
  int quizID = 1;

  var quizzes = [
    Quiz("U+200B.jpg", "U+200B is used to create empty post or comment in facebook.", true),
    Quiz("BAT.jpg", "Basic-Attention-Token is security blockchain token.", false),
    Quiz("Rust.jpg", "Rust language enforces memory safety.", true)
  ];

  void nextQuiz(){
    if (quizID != quizzes.length - 1) {
      quizID = quizID + 1;
    } else {
      quizID = 0;
    }
  }

  SnackBar correctAnswer(){
    var snackMessage = "Correct answer :)";
    return SnackBar(
        content: Text(snackMessage), backgroundColor: Colors.green
    );
  }
  SnackBar wrongAnswer(){
    var snackMessage = "Wrong answer :(";
    return SnackBar(
        content: Text(snackMessage), backgroundColor: Colors.red
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text(
            "Quiz",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w400
            )
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child : SafeArea(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      color: Colors.white,
                      child: Image.asset('images/' + quizzes[quizID].image),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text(
                            quizzes[quizID].question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        )
                    )
                ),
                Expanded(
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 5,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (quizzes[quizID].answer == true) {
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(correctAnswer());
                                        nextQuiz();
                                      } else {
                                        ScaffoldMessenger
                                            .of(context)
                                            .showSnackBar(wrongAnswer());
                                      }
                                    });
                                  },
                                  child: const Text(
                                    "True",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                              ),
                            )),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    if (quizzes[quizID].answer == false) {
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(correctAnswer());
                                      nextQuiz();
                                    } else {
                                      ScaffoldMessenger
                                          .of(context)
                                          .showSnackBar(wrongAnswer());
                                    }
                                  });
                                },
                                child: const Text(
                                  "False",
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 17,
                                       fontWeight: FontWeight.w400
                                   ),
                                   textAlign: TextAlign.center,
                                )
                            )
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    nextQuiz();
                                  });
                                },
                              child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              ],
            )),
      ),),
    );
  }
}