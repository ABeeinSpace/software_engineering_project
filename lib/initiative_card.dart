import 'dart:developer'; //This import gives us access to the log() function. It can be safely removed when all buttons are properly implemented.
import 'package:flutter/material.dart';
import 'initiative.dart';

class InitiativeCard extends StatefulWidget {
  
  late String name;
  late String hp;
  InitiativeCard(this.name, this.hp, {super.key});

  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method
  // String hp;
  // String name;


  @override
  State<InitiativeCard> createState() => _InitiativeCardState();
}

class _InitiativeCardState extends State<InitiativeCard> {
  bool _shouldDisplayConditionsCard = false;
  bool _shouldDisplayAbilitiesCard = false;
  
  late Initative currentInitative;
  

  /// build()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method to construct the InitiativeCard Widget. Instances of this widget are responsible for displaying and managing the state of the initiative blocks
  /// Special: Method overrides Widget.build()
  @override
  Widget build(BuildContext context) {
    //This line grabs the current width of the window. I use it to set the width of the initiative cards to 60% of the width of the application's window
    double screenWidth = MediaQuery.of(context).size.width;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: SizedBox(
              width: screenWidth *
                  0.6, //Uses the MediaQuery defined above to set the card size to 60% of the window (this is to have room for the Status Effects panel without having to do something disgusting like dynamic resizing of the cards based on status effects panel state).
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
                                child: Text(widget.hp),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(widget.name),
                              ),
                              //TODO: Do the health bar (Which is probably going to Suck to do).
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid)),
                                child: Align(child: Text("feck")),
                              ),
                            ]),
                          ),

                          // Column(
                          //   children: [
                          //     const Text("Abilities"),
                          //     IconButton(
                          //         onPressed: _showAbilitiesPanel,
                          //         icon: const Icon(Icons.workspaces_outline))
                          //   ],
                          // ),
                          const VerticalDivider(),

                          Column(
                            children: [
                              const Text(
                                  "Effects"), //Should consider renaming this to "Status Effects" for clarity
                              IconButton(
                                  onPressed: _showConditionsPanel,
                                  icon: (_shouldDisplayConditionsCard
                                      ? const Icon(Icons.star_rounded)
                                      : const Icon(Icons.star_border_rounded)))
                            ],
                          )
                        ],
                      ))),
            )),
        Visibility(
          visible: _shouldDisplayConditionsCard,
          child: Container(
            width: 300,
            height: 300,
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: const [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Conditions"),
                          ),
                        ),
                        Divider(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Blinded"),
                            ))
                      ],
                    ),
                  ),
                )),
          ),
        )
      ],
    );
  }

  /// showEffectsPanel()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for showing and hiding the Status Effects flyout.
  void _showConditionsPanel() {

    setState(() {
      if (_shouldDisplayConditionsCard) {
        _shouldDisplayConditionsCard = false;
      } else {
        _shouldDisplayConditionsCard = true;
      }
    });

    // // InitativeCard will need to be converted to a stateful widget in order to get the icon to change state *fairly* automatically.
    // log("Should show status effects panel");
  }

  /// showAbilitiesPanel()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for showing and hiding the Abilities drop-down/flyout.
  void _showAbilitiesPanel() {

    // InitativeCard will need to be converted to a stateful widget in order to get the icon to change state *fairly* automatically.
    setState(() {
      if (_shouldDisplayAbilitiesCard) {
        _shouldDisplayAbilitiesCard = false;
      } else {
        _shouldDisplayAbilitiesCard = true;
      }
    });
  }
}

class InitiativeCardContainer extends StatelessWidget {
  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method
  // const InitiativeCardContainer({
  //   Key? key,
  // }) : super(key: key);

  String name = '';
  String hp = '';
  
  late Initative currentInitative = Initative(name: name, initiativeCount: hp);
  // Initative currentInitative;


  InitiativeCardContainer(this.name, this.hp, {super.key});
  InitiativeCardContainer.fromInitative(this.currentInitative, {super.key});




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
      child: InitiativeCard(name, hp),
    );
  }
}
