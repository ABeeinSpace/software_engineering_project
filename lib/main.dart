import 'dart:developer'; //This import gives us access to the log() function. It can be safely removed when all buttons are properly implemented.
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering_project/StarmanProvider.dart';
import 'condition.dart';
import 'package:software_engineering_project/StateManager.dart';
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
    return ChangeNotifierProvider(
        create: (BuildContext context) => StarmanProvider(),
        builder: (context, provider) {
          return Consumer<StarmanProvider>(builder: (context, notifier, child) {
            return MaterialApp(
              title: 'Combat Scribe',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
                primarySwatch: Colors.purple,
              ),
              home: const MyHomePage(title: 'Combat Scribe'),
            );
          });
        });
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

  //Strings to hold user inputs
  String name = '';
  String initiative = '';
  //Double that indicates current elevation
  double elevation = 3.0;
  //Ints to keep track of current spot in the array, current round number, and current time
  int currentIndex = 0;
  int roundNumber = 1;
  int time = 0;

  //Array of initatives
  List<InitiativeCardContainer> arr = [];

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
          //Create a chip to display the round number
          Chip(
            padding: const EdgeInsets.all(3.5),
            //Create the avatar that will hold the round number
            avatar: CircleAvatar(
              //Set the background color of the chip to purple
              backgroundColor: Colors.purple,

              //Display the round number as a string in the Circle Avatar
              child: Text(roundNumber.toString(),
                  style: const TextStyle(color: Colors.white)),
            ),
            //Display this text in the remainder of the chip (to the right of the circle avatar)
            label: const Text('Round Number'),
          ),

          const SizedBox(width: 5.5),

          //Create a chip to display the time
          Chip(
            padding: const EdgeInsets.all(3.5),

            //Create the avatar that will hold the time
            avatar: CircleAvatar(
              //Set the background color of the chip to purple
              backgroundColor: Colors.purple,
              //Display the time as a string in the circle avatar
              child: Center(
                  child: Text(time.toString(),
                      style: const TextStyle(color: Colors.white))),
            ),
            //Display this text in the remainder of the chip (to the right of the circle avatar)
            label: const Text('Time                 '),
          ),

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
          //Button that will apply changes to edited cards on press
          Align(
            alignment: Alignment.center,
            child: IconButton(
                onPressed: updateCards,
                tooltip: "Update Cards",
                icon: const Icon(Icons.check)),
          ),
          PopupMenuButton(onSelected: (value) async {
            switch (value) {
              case 'Dice Roller':
                _diceRollerMenu();
                break;
              case 'Starman':
                toggleStarman();
                break;
              default:
                break;
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem(
                  value: 'Dice Roller', child: Text("Dice Roller")),
              const PopupMenuItem(value: 'Starman', child: Text("Starman")),
            ];
          }),
        ],
      ),

      // End of Header

      // Start of Body

      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Column(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.start,
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
        var currentHealthController = TextEditingController();
        var maxHealthController = TextEditingController();
        return AlertDialog(
          title: const Text('Enter Player Info'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              TextFormField(
                controller: initiativeController,
                decoration: const InputDecoration(hintText: 'Initiative'),
              ),
              TextFormField(
                controller: currentHealthController,
                decoration: const InputDecoration(hintText: 'Current Health'),
              ),
              TextFormField(
                controller: maxHealthController,
                decoration: const InputDecoration(hintText: 'Max Health'),
              ),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                var name = nameController.text;
                var initiative = initiativeController.text;
                var currentHealth = currentHealthController.text;
                var maxHealth = maxHealthController.text;
                // TODO: Actual form field validation
                try {
                  int.parse(initiative);
                } catch (e) {
                  log("Get better ints, fucko");
                  return;
                }
                editInitiativeCard(name, initiative, int.parse(currentHealth),
                    int.parse(maxHealth));
                log(name);
                log(initiative);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

//TODO: this is dumb. Too Bad!
  void editInitiativeCard(
      String name, String init, int currentHealth, int maxHealth) {
    setState(() {
      if (numOfThings == 0) {
        if (Provider.of<StarmanProvider>(context, listen: false).bowie ==
            true) {
          elevation = 75.0;
        } else {
          elevation = 15.0;
        }
      } else {
        elevation = 3.0;
      }
      arr.add(InitiativeCardContainer.fromInitiative(
          Initiative(
              name: name,
              initiativeCount: int.parse(init),
              currentHealth: currentHealth,
              totalHealth: maxHealth),
          elevation));
      arr.sort();
      numOfThings++;
    });
  }

  /// _settingsButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling the button press event for the Settings button on the app bar.
  void _settingsButtonPressed() {
    log("Settings button pressed!");
    //var selections = ['Dice Roller', 'Options'];
    // DropdownButton(
    //   value:
    // );
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text('Other Features'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextButton(
                  onPressed: _diceRollerMenu, child: const Text('Dice Roller')),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  /// _prevButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling button press events from the previous round button(s).
  /// Is a candidate to be moved into the initiative_card file.
  void _prevButtonPressed() {
    //A setState call to edit the cards with the new elevation
    setState(() => elevation = elevation);

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

    //Add the elevation to the card we want to look at now

    //Create a hold variable to hold the current card so the card can be safely deleted
    InitiativeCardContainer hold = arr[currentIndex];
    //Delete the current card
    arr.removeAt(currentIndex);
    //Rebuild a new card with all of the same properties as the old card with the added elevation
    if (Provider.of<StarmanProvider>(context, listen: false).bowie == true) {
      secondaryEditInitiativeCard(
          hold.currentInitiative.name,
          hold.currentInitiative.initiativeCount,
          hold.currentInitiative.totalHealth,
          hold.currentInitiative.currentHealth,
          hold.currentInitiative.conditionsArray,
          hold.currentInitiative.editedName,
          hold.currentInitiative.editedInitiativeCount,
          75.0);
    } else {
      secondaryEditInitiativeCard(
          hold.currentInitiative.name,
          hold.currentInitiative.initiativeCount,
          hold.currentInitiative.totalHealth,
          hold.currentInitiative.currentHealth,
          hold.currentInitiative.conditionsArray,
          hold.currentInitiative.editedName,
          hold.currentInitiative.editedInitiativeCount,
          15.0);
    }

    //Remove the elevation of the card we just looked at

    //Create a hold variable to hold the current card so the card can be safely deleted
    InitiativeCardContainer pastHold = arr[pastIndex];
    //Delete the current card
    arr.removeAt(pastIndex);
    //Rebuild a new card with all of the same properties as the old card with the removed elevation
    secondaryEditInitiativeCard(
        pastHold.currentInitiative.name,
        pastHold.currentInitiative.initiativeCount,
        pastHold.currentInitiative.totalHealth,
        pastHold.currentInitiative.currentHealth,
        pastHold.currentInitiative.conditionsArray,
        pastHold.currentInitiative.editedName,
        pastHold.currentInitiative.editedInitiativeCount,
        3.0);
  }

  /// _prevButtonPressed()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for handling button press events from the previous round button(s)
  /// Is a candidate to be moved into the initiative_card file
  void nextButtonPressed() {
    //A setState call to edit the cards with the new elevation
    setState(() => elevation = elevation);

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

    //Add elevation to the card we are currently looking at

    //Create a hold variable to hold the current card so the card can be safely deleted
    InitiativeCardContainer hold = arr[currentIndex];
    //Delete the current card
    arr.removeAt(currentIndex);

    if (Provider.of<StarmanProvider>(context, listen: false).bowie == true) {
      secondaryEditInitiativeCard(
          hold.currentInitiative.name,
          hold.currentInitiative.initiativeCount,
          hold.currentInitiative.totalHealth,
          hold.currentInitiative.currentHealth,
          hold.currentInitiative.conditionsArray,
          hold.currentInitiative.editedName,
          hold.currentInitiative.editedInitiativeCount,
          75.0);
    } else {
      secondaryEditInitiativeCard(
          hold.currentInitiative.name,
          hold.currentInitiative.initiativeCount,
          hold.currentInitiative.totalHealth,
          hold.currentInitiative.currentHealth,
          hold.currentInitiative.conditionsArray,
          hold.currentInitiative.editedName,
          hold.currentInitiative.editedInitiativeCount,
          15.0);
    }
    // addElevation(currentIndex, arr[currentIndex]);

    //Remove elevation from the card we were just looking at

    //Create a hold variable to hold the current card so the card can be safely deleted
    InitiativeCardContainer pastHold = arr[pastIndex];
    //Delete the current card
    arr.removeAt(pastIndex);

    //Rebuild a new card with all of the same properties as the old card with the removed elevation
    secondaryEditInitiativeCard(
        pastHold.currentInitiative.name,
        pastHold.currentInitiative.initiativeCount,
        pastHold.currentInitiative.totalHealth,
        pastHold.currentInitiative.currentHealth,
        pastHold.currentInitiative.conditionsArray,
        pastHold.currentInitiative.editedName,
        pastHold.currentInitiative.editedInitiativeCount,
        3.0);
  }

  //Edit method that builds a new card after manual edits or changes in elevation
  void secondaryEditInitiativeCard(
      //Read in all necessary parameters
      String name,
      int init,
      int? totalHealth,
      int? currentHealth,
      List<Condition>? conditionsArray,
      String? editedName,
      int? editedInitiativeCount,
      double elevation) {
    //Update the state
    setState(() {
      //Add a new card to the array with the given parameters
      arr.add(InitiativeCardContainer.fromInitiative(
          Initiative(
              name: name,
              initiativeCount: init,
              currentHealth: currentHealth,
              totalHealth: totalHealth,
              conditionsArray: conditionsArray,
              editedName: editedName,
              editedInitiativeCount: (editedInitiativeCount)),
          elevation));
      arr.sort();
    });
  }

  //Method to update the cards when the update cards button is pressed
  void updateCards() {
    //Loop over the entire array
    for (int i = 0; i < arr.length; i++) {
      //If the user edited the name or the initiative on the card
      if (arr[i].currentInitiative.name !=
              arr[i].currentInitiative.editedName.toString() ||
          arr[i].currentInitiative.initiativeCount !=
                  arr[i].currentInitiative.editedInitiativeCount &&
              arr[i].currentInitiative.editedInitiativeCount != null) {
        //Create a hold variable to store the current card and allow it to be safely deleted
        InitiativeCardContainer hold = arr[i];
        //Delete the old card
        //Call the function to create a new card with the following parameters from the old card and the updated user parameters
        if (hold.currentInitiative.editedInitiativeCount != null) {
          arr.removeAt(i);
          secondaryEditInitiativeCard(
              hold.currentInitiative.editedName.toString(),
              hold.currentInitiative.editedInitiativeCount!,
              hold.currentInitiative.totalHealth,
              hold.currentInitiative.currentHealth,
              hold.currentInitiative.conditionsArray,
              hold.currentInitiative.editedName,
              hold.currentInitiative.editedInitiativeCount,
              3.0);
          break;
        }
      }
    }
  }

  void _diceRollerMenu() {
    log("Dice Roller Button Pressed");
    showDialog(
      context: context,
      builder: (_) {
        String diceOutput = "Result of roll goes here";
        var numDiceController = TextEditingController();
        var diceTypeController = TextEditingController();
        var modifierController = TextEditingController();
        return AlertDialog(
          title: const Text('Dice Roller'),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: numDiceController,
                decoration: const InputDecoration(hintText: 'Number of Dice'),
              ),
              TextFormField(
                controller: diceTypeController,
                decoration: const InputDecoration(
                    hintText:
                        'Dice Type (enter number of sides ONLY (ex: type 20 for a d20))'),
              ),
              TextFormField(
                controller: modifierController,
                decoration: const InputDecoration(
                    hintText: 'Modifier (type 0 for no modifier)'),
              ),
              Text(diceOutput),
            ],
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
                onPressed: () async {
                  int numDice = int.parse(numDiceController.text);
                  int diceType = int.parse(diceTypeController.text);
                  int diceModifier = int.parse(modifierController.text);

                  diceOutput = diceRoller(numDice, diceType, diceModifier);
                  await Clipboard.setData(ClipboardData(text: diceOutput))
                      .then((_) => {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Dice roll copied to clipboard!")))
                          });
                },
                child: const Text('Roll the Dice!'))
          ],
        );
      },
    );
  }

  String diceRoller(int numDice, int diceType, int diceModifier) {
    log("Dice Rolled!");
    int totalValue = 0;

    if (numDice <= 0) {
      log("invalid number of dice");
      return "invalid number of dice";
    }

    //Set up the print statement (flutter always formats this to be basically unreadable)
    String result = (numDice.toString() +
        'd' +
        diceType.toString() +
        " + " +
        diceModifier.toString() +
        " = (");

    //set up a for loop to roll the dice
    for (var i = 1; i <= numDice; i++) {
      var rolledDice = math.Random().nextInt(diceType) + 1;
      //increment the total
      totalValue += rolledDice;
      //add dice value to result
      String diceSpacing;
      if (i == numDice) {
        diceSpacing = ") ";
      } else {
        diceSpacing = ", ";
      }
      result = (result + rolledDice.toString() + diceSpacing);
    }

    //add the modifier
    totalValue += diceModifier;
    //get the result
    result =
        result + "+ " + diceModifier.toString() + " = " + totalValue.toString();
    log(result);
    return result;
  }

  void toggleStarman() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bowie, eh? Excellent taste")));

    Provider.of<StarmanProvider>(context, listen: false).toggleStarman();
  }
}
