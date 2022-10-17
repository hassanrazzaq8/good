import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 78.0),
                    child: Align(
                      child: Column(
                        children: const [
                          Text(
                            "Condition d’utilisation",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ces termes et conditions sont en vigueur à compter du 23-10-2022",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    """
En téléchargeant ou en utilisant l'application ces conditions s'appliqueront automatiquement à vous, Assurez-vous donc de les lire attentivement avant d'utiliser l'application.
 Vous n'êtes pas autorisé à copier ou modifier l'application,Cela inclut toute partie de l'application ou nos marques de commerce de quelque manière que ce soit. Vous n'êtes pas autorisé à tenter d'extraire le code source de l'application, et vous ne devez pas non plus essayer de traduire l'application dans d'autres langues ou de créer des versions dérivées. L'application elle-même ainsi que toutes les marques,droits d'auteur, droits de base de données et autres droits de propriété intellectuelle qui s'y rapportent, appartiennent toujours à Jimmy vert.

L’Equipe Dreeam s'engage à rendre l'application aussi utile et efficace que possible. Nous nous réservons dans le futur le droit d'apporter des modifications à l'application et d’ajouter des versions premium payante, Chaque utilisateurs possède le droit de décider s'ils souhaitent ou non payer la version premium quand elle sera disponible .
Nous ne vous facturerons jamais l'application ou ses services sans vous indiquer très clairement ce que vous payez.

Nous pouvons mettre à jour nos termes et Conditions de temps à autre. Ainsi, il vous est conseillé de consulter cette page régulièrement afin de vous informer de toute modification. Nous vous informerons de tout changement en publiant les nouvelles conditions générales.

Nous contacter

Si vous avez des questions ou des suggestions concernant nos Termes et Conditions, n'hésitez pas à nous contacter à dreeam.app@gmail.com.

              """,
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
