import 'dart:math';

import 'package:flutter/material.dart';
import 'package:translate_app/core/constants/assets_app.dart';
import 'package:translate_app/core/utils/utils.dart';
import 'package:translate_app/features/model/country_model.dart';
import 'package:translate_app/features/view/promp_view.dart';
import 'package:translate_app/shared/components/components.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CountryModel? selectedCountry;
  Color? backgroundColor;

  Color randomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetsApp.worlMap),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: GridView.builder(
                    itemCount: CountryModel.countryList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.0,
                    ),
                    itemBuilder: (context, index) {
                      final country = CountryModel.countryList[index]; // Indice
                      final isSelected = country == selectedCountry;
                      return CustomCard(
                        text: country.countryName,
                        image: country.urlCountry,
                        boxColor: isSelected ? backgroundColor : null,
                        onTap: () {
                          setState(() {
                            // Este es el indice que seleccionara la bandera
                            selectedCountry = country;
                            backgroundColor = randomColor();
                          });
                        },
                      );
                    },
                  ),
                ),

                // Segundo expanded de la mitad de la pantalla
                Expanded(
                  child: Column(
                    children: [
                      // Comienza aqui
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomLabel(
                            text: 'Translate',
                            textSize: 33,
                            fontWeight: FontWeight.bold,
                          ),
                          gapW(10),
                          const CustomLabel(
                            text: 'Every',
                            textSize: 33,
                            fontWeight: FontWeight.bold,
                            textColor: Colors.blueAccent,
                          ),
                        ],
                      ),
                      const CustomLabel(
                        text: 'Type Word',
                        textSize: 33,
                        fontWeight: FontWeight.bold,
                      ),

                      gapH(10),

                      const CustomLabel(
                        text: 'Help you communicate in \nDifferent Languages',
                        fontWeight: FontWeight.w300,
                        textSize: 14,
                        textAlign: TextAlign.center,
                      ),

                      gapH(size.height * 0.05),

                      GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PrompView()),
                        ),
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blueAccent,
                          ),
                          child: Center(
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const CustomIcon(
                                icon: Icons.arrow_forward,
                                iconColor: Colors.blueAccent,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
