import 'package:flutter/material.dart';
import 'package:software_engineering_project/condition.dart';
import 'initiative.dart';

class InitiativeCard extends StatefulWidget {
  // late String name;
  // late String hp;
  InitiativeCard.fromInitiative(this.currentInitiative, this.elevate, {super.key});
  final Initiative currentInitiative;

  // InitiativeCard(this.name, this.hp, this.elevate, {super.key});

  double elevate;

  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method
  // String hp;
  // String name;

  @override
  State<InitiativeCard> createState() => _InitiativeCardState();
}

class _InitiativeCardState extends State<InitiativeCard> {
  bool _shouldDisplayConditionsCard = false;
  bool _shouldDisplayAbilitiesCard = false;

  /// build()
  /// Parameters: BuildContext context
  /// Returns: Widget
  /// Description: Method to construct the InitiativeCard Widget. Instances of this widget are responsible for displaying and managing the state of the initiative blocks
  /// Special: Method overrides Widget.build()
  @override
  Widget build(BuildContext context) {
    //This line grabs the current width of the window. I use it to set the width of the initiative cards to 60% of the width of the application's window
    double screenWidth = MediaQuery.of(context).size.width;
    widget.currentInitiative.conditionsArray = initConditionsArray();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: SizedBox(
              width: screenWidth *
                  0.6, //Uses the MediaQuery defined above to set the card size to 60% of the window (this is to have room for the Status Effects panel without having to do something disgusting like dynamic resizing of the cards based on status effects panel state).
              child: Card(
                  elevation: widget.elevate,
                  child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const Text("Initiative"),
                              CircleAvatar(
                                // backgroundColor: Colors.amber,
                                child: Text("${widget.currentInitiative.initiativeCount}"),
                              )
                            ],
                          ),
                          Expanded(
                            child: Column(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(widget.currentInitiative.name),
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
                elevation: 3,
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
                                children: widget.currentInitiative.conditionsArray!.map((e) => Text(e.toString())).toList(),
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

  List<Condition> initConditionsArray() {
    List<Condition> conditionsArray = [];
    conditionsArray.add(Condition(name: "Blinded", duration: 10, elapsedTime: 5));
    conditionsArray.add(Condition(name: "Frightened", duration: 5, elapsedTime: 2));
    conditionsArray.add(Condition(name: "Exhaustion", duration: 7, elapsedTime: 5));
    conditionsArray.add(Condition(name: "Restrained", duration: 12, elapsedTime: 4));
    return conditionsArray;
  }
}

class InitiativeCardContainer extends StatelessWidget {
  // This declaration makes any parameters needed available to instances of the class. The Java equivalent is a constructor method
  // const InitiativeCardContainer({
  //   Key? key,
  // }) : super(key: key);

  const InitiativeCardContainer.fromInitiative(this.currentInitiative, this.elevate, {super.key});
  final Initiative currentInitiative;
  final double elevate;
  // InitiativeCardContainer(this.name, this.hp, this.elevate, {super.key});

  // InitiativeCardContainer.fromInitative(Initative initative, {super.key})
  //     : name = initative.name,
  //       hp = initative.initiativeCount.toString(),
  //       elevate = initative.elevate;

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
      InitiativeCard.fromInitiative(currentInitiative),
    );
  }
// addDropShadow(InitiativeCardContainer current){
//   DropShadow({
//   Key? key,
//   required this.child,
//   this.blurRadius = 10.0,
//   this.borderRadius = 0.0,
//   this.offset = const Offset(0.0, 8.0),
//   this.opacity = 1.0,
//   this.spread = 1.0,
// })
// }

}
