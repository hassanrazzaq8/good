import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

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
                          "Politique de confidentialité ",
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
                  "Cette politique est effective à partir du 23-10-2022 ",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  """
L'application Dreeam est une application gratuite qui peut proposer des versions premium payante.
Cette page est utilisée pour informer les visiteurs des politiques de collecte, d'utilisation et de divulgation des informations personnelles si quelqu'un décide d'utiliser notre service.
Si vous choisissez d'utiliser notre service, vous acceptez la collecte et l'utilisation d'informations en relation avec cette politique. Les informations personnelles que nous collectons sont utilisées pour fournir et améliorer le service. Nous n'utiliserons ni ne partagerons vos informations avec qui que ce soit, sauf de la manière décrite dans la présente politique de confidentialité.
Collecte et utilisation des informations
Pour une meilleure expérience, lors de l'utilisation de notre service nous pouvons vous demander de nous fournir certaines informations personnellement identifiables. Les informations que nous demandons seront conservées sur votre appareil ainsi que sur notre base de données, Elles ne seront en aucun cas vendues ou divulguées  par nous.
Modifications de cette politique de confidentialité
Nous pouvons mettre à jour notre politique de confidentialité de temps à autre. Ainsi, il vous est conseillé de consulter cette page périodiquement pour tout changement. Nous vous informerons de tout changement en publiant la nouvelle politique de confidentialité sur cette page.
Nous contacter
Si vous avez des questions ou des suggestions concernant notre politique de confidentialité, n'hésitez pas à nous contacter à dreeam.app@gmail.com



                          """,
                  textAlign: TextAlign.justify,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
