import 'package:flutter/material.dart';

import 'condition.dart';
import 'initiative.dart';

class StatelessInitiativeCard extends StatelessWidget {
  StatelessInitiativeCard({super.key, required this.currentInitiative});

  StatelessInitiativeCard.fromInitiative(this.currentInitiative, this.elevation, {super.key});
  final Initiative currentInitiative;

  double elevation = 3;
  bool isActive = false;

  bool _shouldDisplayConditionsCard = false;
  bool _shouldDisplayAbilitiesCard = false;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
        //This line grabs the current width of the window. I use it to set the width of the initiative cards to 60% of the width of the application's window
    double screenWidth = MediaQuery.of(context).size.width;
    currentInitiative.conditionsArray = initConditionsArray();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: SizedBox(
              width: screenWidth *
                  0.6, //Uses the MediaQuery defined above to set the card size to 60% of the window (this is to have room for the Status Effects panel without having to do something disgusting like dynamic resizing of the cards based on status effects panel state).
              child: Card(
                  elevation: elevation,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const Text("Initiative"),
                              CircleAvatar(
                                // backgroundColor: Colors.amber,
                                child: Text("${currentInitiative.initiativeCount}"),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(currentInitiative.name),
                              ),
                              //TODO: Do the health bar (Which is probably going to Suck to do).
                              DecoratedBox(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black,
                                        style: BorderStyle.solid)),
                                child: const Align(child: Text("feck")),
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
            width: 250,
            height: 300,
            margin: const EdgeInsets.fromLTRB(0, 8, 0, 10),
            child: Card(
                elevation: elevation,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("Conditions"),
                          ),
                        ),
                        const Divider(),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column (
                                children: currentInitiative.conditionsArray!.map((e) => Text(e.toString())).toList(),
                              ),
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

    /// showConditionsPanel()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for showing and hiding the Status Effects flyout.
  void _showConditionsPanel() {
      if (_shouldDisplayConditionsCard) {
        _shouldDisplayConditionsCard = false;
      } else {
        _shouldDisplayConditionsCard = true;
      }
  }

  /// showAbilitiesPanel()
  /// Parameters:
  /// Returns: N/A (void)
  /// Description: Method responsible for showing and hiding the Abilities drop-down/flyout.
  void _showAbilitiesPanel() {
    // InitativeCard will need to be converted to a stateful widget in order to get the icon to change state *fairly* automatically.
      if (_shouldDisplayAbilitiesCard) {
        _shouldDisplayAbilitiesCard = false;
      } else {
        _shouldDisplayAbilitiesCard = true;
      }
  }

  List<Condition> initConditionsArray() {
    List<Condition> conditionsArray = [];
    conditionsArray.add(Condition(name: "Blinded", duration: 10, elapsedTime: 5));
    conditionsArray.add(Condition(name: "Frightened", duration: 5, elapsedTime: 2));
    conditionsArray.add(Condition(name: "Exhaustion", duration: 7, elapsedTime: 5));
    conditionsArray.add(Condition(name: "Restrained", duration: 12, elapsedTime: 4));
    return conditionsArray;
  }
}

class InitiativeCardContainer extends StatelessWidget implements Comparable<InitiativeCardContainer> {
  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method
  // const InitiativeCardContainer({
  //   Key? key,
  // }) : super(key: key);

  InitiativeCardContainer.fromInitiative(this.currentInitiative, this.elevation, {super.key});
  final Initiative currentInitiative;
  double elevation;

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
      child: 
      StatelessInitiativeCard.fromInitiative(currentInitiative, elevation),
    );
  }

  @override
  int compareTo(InitiativeCardContainer other) {
    if (currentInitiative.initiativeCount > other.currentInitiative.initiativeCount) {
      return -1;
    } else if (currentInitiative.initiativeCount < other.currentInitiative.initiativeCount) {
      return 1;
    } else {
      return 0;
    }
  }

}
