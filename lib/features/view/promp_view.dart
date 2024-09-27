import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:translate_app/core/utils/translate_from.dart';
import 'package:translate_app/core/utils/translate_to.dart';
import 'package:translate_app/core/utils/utils.dart';
import 'package:translate_app/shared/components/components.dart';

class PrompView extends StatefulWidget {
  const PrompView({super.key});

  @override
  State<PrompView> createState() => _PrompViewState();
}

class _PrompViewState extends State<PrompView> {
  String? selectedCountryFrom;
  String? selectedCountryTo;
  String _translatedText = '';
  bool _isLoading = false;

  final TextEditingController _controllerFrom = TextEditingController();

  // Funcion para actualizar el idioma
  void _handleLanguageChangedFrom(String? newCountry) {
    setState(() {
      selectedCountryFrom = newCountry;
    });
  }

  // Funcion para actualizar el idioma
  void _handleLanguageChangedTo(String? newCountry) {
    setState(() {
      selectedCountryTo = newCountry;
    });
  }

  // Funcion para traducir cada texto
  Future<void> _translateLanguage() async {
    final apiKey = dotenv.env['API_KEY'];

    if (apiKey == null) {
      log('API_KEY no encontrada');
      return;
    }

    final inputText = _controllerFrom.text;
    final fromLang = selectedCountryFrom;
    final toLang = selectedCountryTo;

    if (inputText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const CustomLabel(text: 'Que es lo que quieres traducir?')));
      return;
    }

    if (fromLang == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const CustomLabel(text: 'Selecciona el idioma de origen')));
      return;
    }

    if (toLang == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          content: const CustomLabel(text: 'Selecciona el idioma de destino')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final model = GenerativeModel(
        model: 'gemini-1.5-flash', //gemini-1.5-flash
        apiKey: apiKey,
      );

      final content = [
        Content.text('Translate only $inputText from $fromLang to $toLang')
      ];

      final response = await model.generateContent(content);

      setState(() {
        _translatedText = response.text!;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: CustomLabel(text: 'Falló al traducir Error:$e')));

      log(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomLabel(
                          text: 'TraductorFlu',
                          fontWeight: FontWeight.w400,
                          textSize: 18.0,
                          textColor: Colors.grey,
                        ),
                        CustomIcon(icon: Icons.text_fields, iconSize: 24)
                      ],
                    ),
                  ),

                  gapH(30),

                  // Cambio de idiomas
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomDropdown(
                          onLanguageChanged: _handleLanguageChangedFrom,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CustomIcon(icon: Icons.swap_horiz_rounded),
                        ),
                        CustomDropdown(
                          onLanguageChanged: _handleLanguageChangedTo,
                        ),
                      ],
                    ),
                  ),

                  gapH(20),

                  // Cambio de translacion from
                  Row(
                    children: [
                      const CustomLabel(
                        text: 'Traducir de',
                        fontWeight: FontWeight.w400,
                        textSize: 14,
                      ),
                      gapW(10),
                      if (selectedCountryFrom != null)
                        CustomLabel(
                          text: '$selectedCountryFrom',
                          fontWeight: FontWeight.bold,
                          textSize: 14,
                        ),
                    ],
                  ),

                  gapH(20),

                  Container(
                    width: size.width,
                    height: 175,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: TranslateForm(
                      hintText: 'Algo para traducir?',
                      controller: _controllerFrom,
                    ),
                  ),

                  gapH(20),

                  // Cambio de translacion to
                  Row(
                    children: [
                      const CustomLabel(
                        text: 'Traducir a',
                        fontWeight: FontWeight.w400,
                        textSize: 14,
                      ),
                      gapW(10),
                      if (selectedCountryTo != null)
                        CustomLabel(
                          text: '$selectedCountryTo',
                          fontWeight: FontWeight.bold,
                          textSize: 14,
                        ),
                    ],
                  ),
                  gapH(20),

                  Container(
                    width: size.width,
                    height: 175,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : TranslateTo(
                            translateText: _translatedText,
                          ),
                  ),

                  gapH(20),

                  // Botton para empezar la traduccion

                  CustomElevatedbutton(
                    size: size,
                    text: 'Traducir',
                    textSize: 18.0,
                    onPressed: _translateLanguage,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
