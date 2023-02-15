import 'dart:developer';

import 'package:flutter/material.dart';

class InitiativeCard extends StatelessWidget {
  const InitiativeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //This line grabs the current width of the window. I use it to set the width of the initiative cards to 60% of the width of the window
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: screenWidth * 0.6, //uses the MediaQuery defined above to set the card size to 60% of the window (this is to have room for the Status Effects panel without having to do something disgusting like dynamic resizing of the cards based on status effects panel state).
          child: Card(
            elevation: 3,
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Column(
                        children: const [
                          Text("Initiative"),
                          CircleAvatar(
                            // backgroundColor: Colors.amber,
                            child: Text("18"),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(children: const [
                          Align(
                            alignment: Alignment.center,
                            child: Text("John Doe"),
                          ),
                          //TODO: Do the health bar (Which is probably going to Suck to do).
                          Text("HEALTH BAR GOES HERE")
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
                              "Effects"), //Should consider renaming this to "Status Effects" for clarity
                          IconButton(
                              onPressed: showEffectsPanel,
                              icon: const Icon(Icons.star_border_rounded))
                        ],
                      )
                    ],
                  ))),
        ));
  }

  void showEffectsPanel() {
    //TODO: Consider adding code to this method to highlight the button in some way when the panel is open
    log("Should show status effects panel");
  }

  void showAbilitiesPanel() {
    //TODO: Consider adding code to this method to highlight the button in some way when the panel is open
    log("Should show Abilities panel");
  }
}

class InitiativeCardContainer extends StatelessWidget {
  const InitiativeCardContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.all(10),
      // width: 90,
      child: const InitiativeCard(),
    );
  }
}
