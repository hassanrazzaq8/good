import 'package:flutter/material.dart';

class CardTexts extends StatelessWidget {
  const CardTexts({
    Key? key,
    required this.snap,
    required this.jourrr,
    required this.actiii,
    required this.monttt,
    // required this.alignment,
  }) : super(key: key);
  final snap;
  final List jourrr;
  final List actiii;
  final List monttt;
  // final alignment;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        itemCount: jourrr.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 6,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Text(
                  "   ${jourrr[index]}",
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  actiii[index],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                Text(
                  monttt[index],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const Text(" ,"),
              ],
            ),
          );
        },
      ),
    );
  }
}
