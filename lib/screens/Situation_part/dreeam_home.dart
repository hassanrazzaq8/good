import 'package:flutter/material.dart';

import 'create_situation.dart';
import 'situaton_card.dart';

class DreeamHome extends StatefulWidget {
  const DreeamHome({Key? key}) : super(key: key);

  @override
  State<DreeamHome> createState() => _DreeamHomeState();
}

class _DreeamHomeState extends State<DreeamHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dreeam"),
          centerTitle: true,
          backgroundColor: Colors.black,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         Navigator.push(context,
          //             MaterialPageRoute(builder: (context) => const Prects3()));
          //       },
          //       icon: const Icon(Icons.arrow_forward_ios))
          // ],
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.amber,
                height: MediaQuery.of(context).size.height * .35,
              ),
              SizedBox(
                child: Column(
                  children: [
                    const Text(
                      "partager vos meilleurs coup avec les autres joueurs",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CreateSituation(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                        ),
                        child: const Text(
                          " cree une situation + ",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // const SituationCard(),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
