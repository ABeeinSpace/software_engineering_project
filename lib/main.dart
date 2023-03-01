import 'dart:developer'; //This import gives us access to the log() function. It can be safely removed when all buttons are properly implemented.
import 'package:flutter/material.dart';
import 'initiative_card.dart';
import 'initiative.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key}); // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method.

  // This widget is the root of your application.

  /// build()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method responsible for constructing the app's window.
  /// Special: Method overrides Widget.build()
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Combat Scribe',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        useMaterial3: true,
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Combat Scribe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method.
  const MyHomePage(
      {super.key,
      required this.title}); //The required keyword is the same as making a named parameter in Java. It tells the Dart compiler to emit an error if we attempt to instantiate an instance of the class without a parameter.

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  /// createState()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method responsible for constructing the home page of the app.
  /// Special: Method overrides State.createState()
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int numOfThings = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //
  //   });
  // }

  late TextEditingController controller;

  //String that will hold the name inputted by the user
  String name = '';

  @override
  void initState() {
    super.initState();

    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  //String that will hold the hp inputted by the user
  String hp = '';

  //Array of initatives
  List<InitiativeCardContainer> arr = [
    InitiativeCardContainer("Name", " "),
    InitiativeCardContainer("Name", " "),
    InitiativeCardContainer("Name", " "),
    InitiativeCardContainer("Name", " "),
    InitiativeCardContainer("Name", " "),
  ];

  void _incrementNumOfThings() {
    setState(() {
      // _numOfThings++;
    });
  }

  /// build()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method responsible for constructing the State object of the MyHomePage Widget.
  /// Special: Method overrides Widget.build()
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // Start of Header
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          Align(
              alignment: Alignment.center,
              child: IconButton(
                  onPressed: _prevButtonPressed,
                  tooltip: "Previous round",
                  icon: const Icon(Icons.arrow_back))),
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: _nextButtonPressed,
                tooltip: "Next round",
                icon: const Icon(Icons.arrow_forward)),
          ),
          ButtonBar(
            children: [
              IconButton(

                  ///When the add initative button is pressed, open a dialog for the user to input their name
                  onPressed: () async {
                    final name = await openDialog();
                    if (name == null || name.isEmpty) return;
                    setState(() => this.name = name);

                    //When the user has submitted a name, open a dialog for them to input the hp
                    final hp = await openhpDialog();
                    if (hp == null || hp.isEmpty) return;
                    setState(() => this.hp = hp);

                    editInitiativeCard();
                  },
                  tooltip: "Add Initiative",
                  icon: const Icon(Icons.add)),
              // This button will display a drop-down to enable addition of prefab monsters in addition to custom initiatives.
              IconButton(
                  onPressed: _settingsButtonPressed,
                  icon: const Icon(Icons.settings))
            ],
          ),
        ],
      ),

      // End of Header

      // Start of Body
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(children: [
              // const Text(
              //   "You have added this many things:",
              // ),
              // Text(
              //   '$_numOfThings',
              //   style: Theme.of(context).textTheme.headline4,
              // ),
              arr[0],
              arr[1],
              arr[2],
            ])
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        ///When the add initative button is pressed, open a dialog for the user to input their name
        onPressed: () async {
          final name = await openDialog();
          if (name == null || name.isEmpty) return;
          setState(() => this.name = name);

          //When the user has submitted a name, open a dialog for them to input the hp
          final hp = await openhpDialog();
          if (hp == null || hp.isEmpty) return;
          setState(() => this.hp = hp);

          editInitiativeCard();
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Initiative"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      // We should consider making the FAB display a pop-up menu to enable prefab monster addition like the button in the top of the window.

      // End of Body
    );
  }

//Dialog box for inputting name
  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Player Name'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter Player Name'),
            controller: controller,
          ),
          actions: [
            TextButton(
              child: Text('SUBMIT'),
              onPressed: submit1,
            ),
          ],
        ),
      );

//Dialog box for inputting hp
  Future<String?> openhpDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Player Initiative'),
          content: TextField(
            autofocus: true,
            decoration: InputDecoration(hintText: 'Enter Player Initiative'),
            controller: controller,
          ),
          actions: [
            TextButton(
              child: Text('SUBMIT'),
              onPressed: submit,
            ),
          ],
        ),
      );

//Submit function for name that pops the text into the awaiting string and calls the hp dialog
  void submit1() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
    openhpDialog();
  }

//Submit function for hp that pops the text into the awaiting string
  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
    Navigator.of(context).pop();

    // hold = InitiativeCardContainer(name, hp);
  }

//Add the corresponding inputted values to the next open space in the array
  void editInitiativeCard() {
    arr[numOfThings] = InitiativeCardContainer(name, hp);
    numOfThings++;
  }

  /// _settingsButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling the button press event for the Settings button on the app bar.
  void _settingsButtonPressed() {
    log("Settings button pressed!");
  }

  /// _addInitiative()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for adding an initiative to the app. It handles button press events from the plus icon in the app bar and button press events from the FAB.
  void _addInitiative() {
    _incrementNumOfThings();
    //TODO: Implement the Add Initiative dialog, at least partially
    showDialog(
        context: context,
        builder: ((context) {
          return SimpleDialog(
            title: const Text("Creating Initiative"),
            children: [
              Column(
                children: const [
                  Text("Enter the properties of your initiative:"),
                ],
              )
            ],
          );
        }));

    // This block of code is responsible for displaying the Snack Bar down at the bottom of the window when the add initiative button(s) are pressed.
    ScaffoldMessengerState().removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Add initiative button pressed!"),
        duration: Duration(seconds: 2),
      ),
    );
    SnackBarBehavior.floating;
    // log();
  }

  /// _prevButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling button press events from the previous round button(s).
  /// Is a candidate to be moved into the initiative_card file.
  void _prevButtonPressed() {
    log("Previous Round button pressed!");
  }

  /// _prevButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling button press events from the previous round button(s)
  /// Is a candidate to be moved into the initiative_card file
  void _nextButtonPressed() {
    log("Next Round button pressed!");
  }
}
