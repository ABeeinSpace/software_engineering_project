import 'dart:developer'; //This import gives us access to the log() function. It can be safely removed when all buttons are properly implemented.
import 'package:flutter/material.dart';
import 'initiative_card.dart';
import 'initiative.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        useMaterial3: true,
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Combat Scribe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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

  late TextEditingController controller;

  //String that will hold the name inputted by the user

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

  //String that will hold the Initiative inputted by the user
  String name = '';
  String initiative = '';
  double elevate = 3.0;
  int currentIndex = 0;
  int roundNumber = 1;
  int time = 0;

  //Array of initatives
  List<InitiativeCardContainer> arr = [];

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
                onPressed: nextButtonPressed,
                tooltip: "Next round",
                icon: const Icon(Icons.arrow_forward)),
          ),
          ButtonBar(
            children: [
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
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: arr),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        ///When the add initative button is pressed, open a dialog for the user to input their name
        onPressed: () async {
          log("Button Pressed!");
          showDialogWithFields();
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Initiative"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      // We should consider making the FAB display a pop-up menu to enable prefab monster addition like the button in the top of the window.

      // End of Body
    );
  }

  void showDialogWithFields() {
    showDialog(
      context: context,
      builder: (_) {
        var nameController = TextEditingController();
        var initiativeController = TextEditingController();
        return AlertDialog(
          title: Text('Enter Player Info'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name'),
              ),
              TextFormField(
                controller: initiativeController,
                decoration: InputDecoration(hintText: 'Initiative'),
              ),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var name = nameController.text;
                var initiative = initiativeController.text;
                editInitiativeCard2(name, initiative);
                log(name);
                log(initiative);
                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }

//Dialog box for inputting name
  Future<String?> openDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Block Info'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter Name'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: submit1,
              child: const Text('SUBMIT'),
            ),
          ],
        ),
      );

//Dialog box for inputting Initiative
  Future<String?> openInitiativeDialog() => showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Player Initiative'),
          content: TextField(
            autofocus: true,
            decoration:
                const InputDecoration(hintText: 'Enter Player Initiative'),
            controller: controller,
          ),
          actions: [
            TextButton(
              onPressed: submit,
              child: const Text('SUBMIT'),
            ),
          ],
        ),
      );

//Submit function for name that pops the text into the awaiting string and calls the Initiative dialog
  void submit1() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
    openInitiativeDialog();
  }

//Submit function for Initiative that pops the text into the awaiting string
  void submit() {
    Navigator.of(context).pop(controller.text);
    controller.clear();
    Navigator.of(context).pop();

    // hold = InitiativeCardContainer(name, Initiative);
  }

//Add the corresponding inputted values to the next open space in the array
  void editInitiativeCard() {
    arr.add(InitiativeCardContainer.fromInitiative(
        Initiative(name: name, initiativeCount: int.parse(initiative)),
        elevate));
    numOfThings++;
  }

//TODO: this is dumb. Too Bad!
  void editInitiativeCard2(String name, String init) {
    setState(() {
      arr.add(InitiativeCardContainer.fromInitiative(
          Initiative(name: name, initiativeCount: int.parse(init)), elevate));
      numOfThings++;
    });
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
    //A setState call to edit the cards with the new elevation
    setState(() => this.elevate = elevate);

    //Store the index of the card we are moving away from
    int pastIndex = currentIndex;

    //If we are not already at the first element in the array
    if (currentIndex > 0) {
      //Decrement the index
      currentIndex--;
      //If we arealready looking at the first element of the array
    } else {
      //'Loop' back to the back of the array
      currentIndex = numOfThings - 1;
      roundNumber--;
      time -= 6;
    }

    //Call the addElevation method with the index of the card we are looking at now and the card itself
    addElevation(currentIndex, arr[currentIndex]);

    //Call the removeElevation method with the index of the card we just looked at and the card itself
    removeElevation(pastIndex, arr[pastIndex]);
  }

  /// _prevButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling button press events from the previous round button(s)
  /// Is a candidate to be moved into the initiative_card file
  void nextButtonPressed() {
    //A setState call to edit the cards with the new elevation
    setState(() => this.elevate = elevate);
    //

    //Store the index of the card we are moving away from
    int pastIndex = currentIndex;
    //If we are not already at the last element in the array
    if (currentIndex < numOfThings - 1) {
      //Increment the index
      currentIndex++;
      //If we are already at the last element in the array
    } else {
      //'Loop' back to the front of the array
      currentIndex = 0;
      roundNumber++;
      time += 6;
    }

    //Call the addElevation method with the index of the card we are looking at now and the card itself
    setState(() {
      arr[currentIndex].elevate = 15;
    });
    // addElevation(currentIndex, arr[currentIndex]);

    //Call the removeElevation method with the index of the card we just looked at and the card itself
    arr[pastIndex].elevate = 3;
    // removeElevation(pastIndex, arr[pastIndex]);

    // setState(() => this.elevate = elevate);

    // //Store the index of the card we are moving away from
    // int pastIndex = currentIndex;
    // //If we are not already at the last element in the array
    // if (currentIndex < numOfThings - 1) {
    //   //Increment the index
    //   currentIndex++;
    //   //If we are already at the last element in the array
    // } else {
    //   //'Loop' back to the front of the array
    //   currentIndex = 0;
    // }

    // //Call the addElevation method with the index of the card we are looking at now and the card itself
    // addElevation(currentIndex, arr[currentIndex]);

    // //Call the removeElevation method with the index of the card we just looked at and the card itself
    // removeElevation(pastIndex, arr[pastIndex]);
  }

  /// addElevation()
  /// Parameters: The index of the Initiative card we are currently looking at as an int
  ///             The Initiative card we are looking at as an object
  /// Returns: N/A (void)
  /// Description: Method responsible for adding elevation to current initiative card
  void addElevation(int currentIndex, InitiativeCardContainer currentCard) {
    currentCard.elevate = 15;
    // InitiativeCardContainer(currentCard.name, currentCard.hp, 75.0);
  }

  /// removeElevation
  /// Parameters:The index of the last Initiative card we looked at as an int
  ///             The last Initiative card we looked at as an object
  /// Returns: N/A (void)
  /// Description: Method responsible for removing elevation from card we just looked at, but are no longer looking at
  void removeElevation(int pastIndex, InitiativeCardContainer pastCard) {
    pastCard.elevate = 3;
  }
}
