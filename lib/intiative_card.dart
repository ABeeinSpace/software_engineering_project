import 'dart:developer';

import 'package:flutter/material.dart';

class InitiativeCard extends StatelessWidget {
  const InitiativeCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: screenWidth * 0.6,
          child: Card(
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        children: const [
                          Text("Initiative"),
                          CircleAvatar(
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
                          Text("HEALTH BAR GOES HERE")
                        ]),
                      ),
                      Column(
                        children: [
                          const Text("Abilities"),
                          IconButton(
                              onPressed: showAbilitiesPanel,
                              icon: const Icon(Icons.workspaces_outline))
                        ],
                      ),
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
    log("Should show status effects panel");
  }

  void showAbilitiesPanel() {
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
