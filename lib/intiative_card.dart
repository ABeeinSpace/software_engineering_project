import 'dart:developer'; //This import gives us access to the log() function. It can be safely removed when all buttons are properly implemented.
import 'package:flutter/material.dart';
import 'main.dart';

class InitiativeCard extends StatelessWidget {
  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method

  String hp;
  String name;

  InitiativeCard(this.name, this.hp, {super.key});

  // const InitiativeCard({
  //   Key? key,
  // }) : super(key: key);

  /// build()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method to construct the InitiativeCard Widget. Instances of this widget are responsible for displaying and managing the state of the initiative blocks
  /// Special: Method overrides Widget.build()
  @override
  Widget build(BuildContext context) {
    //This line grabs the current width of the window. I use it to set the width of the initiative cards to 60% of the width of the application's window
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: screenWidth *
              0.6, //Uses the MediaQuery defined above to set the card size to 60% of the window (this is to have room for the Status Conditions panel without having to do something disgusting like dynamic resizing of the cards based on status conditions panel state).
          child: Card(
              elevation: 3,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Text("Initiative"),
                          CircleAvatar(
                            // backgroundColor: Colors.amber,
                            child: Text(hp),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(name),
                          ),
                          //TODO: Do the health bar (Which is probably going to Suck to do).
                          Text("HEALTH BAR GOES HERE")
                          //TODO: Do something for Temporary Health Bar
                        ]),
                      ),
                      // Column(
                      //   children: [
                      //     const Text("Abilities"),
                      //     IconButton(
                      //         onPressed: showAbilitiesPanel,
                      //         icon: const Icon(Icons.workspaces_outline))
                      //   ],
                      // ),
                      const VerticalDivider(),

                      Column(
                        children: [
                          const Text(
                              "Conditions"), //Should consider renaming this to "Status Conditions" for clarity
                          IconButton(
                              onPressed: showConditionsPanel,
                              icon: const Icon(Icons.star_border_rounded))
                        ],
                      )
                    ],
                  ))),
        ));
  }

  /// showConditionsPanel()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for showing and hiding the Status Conditons flyout.
  void showConditionsPanel() {
    //TODO: Consider adding code to this method to highlight the button in some way when the panel is open.

    // InitativeCard will need to be converted to a stateful widget in order to get the icon to change state *fairly* automatically.
    log("Should show status conditions panel");
  }

  /// showAbilitiesPanel()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for showing and hiding the Abilities drop-down/flyout.
  void showAbilitiesPanel() {
    //TODO: Consider adding code to this method to highlight the button in some way when the panel is open.

    // InitativeCard will need to be converted to a stateful widget in order to get the icon to change state *fairly* automatically.
    log("Should show Abilities panel");
  }
}

class InitiativeCardContainer extends StatelessWidget {
  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method
  //  InitiativeCardContainer({
  //   Key? key,
  // }) : super(key: key);

  String name;
  String hp;

  InitiativeCardContainer(this.name, this.hp, {super.key});

  /// build()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method to construct the UI around the InitiativeCard Widget. This widget may remain stateless unless Flutter takes issue with it.
  /// Special: Method overrides Widget.build()
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10),
      // width: 90,
      child: InitiativeCard(name, hp),
    );
  }
}
