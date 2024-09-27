import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:translate_app/core/utils/utils.dart';
import 'package:translate_app/shared/components/components.dart';

class TranslateForm extends StatefulWidget {
  final TextEditingController controller;

  final String hintText;

  const TranslateForm({
    super.key,
    required this.controller,
    required this.hintText,
  });

  @override
  State<TranslateForm> createState() => _TranslateFormState();
}

class _TranslateFormState extends State<TranslateForm> {
  int _wordCount = 0;
  final int _lineCount = 50;
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateWordCount);
    _setLanguage();
  }

  Future<void> _handleVolume() async {
    final text = widget.controller.text;
    await _flutterTts.speak(text);
  }

  // Poner el idoma en ingles para que se escuche
  Future<void> _setLanguage() async {
    await _flutterTts
        .setLanguage("en-US"); // Configura el idioma a inglés de Estados Unidos
    await _flutterTts.setPitch(1.0); // Configura el tono
    await _flutterTts.setSpeechRate(0.4); // Configura la velocidad de la voz
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_updateWordCount);
    widget.controller.dispose();
    _flutterTts.stop();
  }

  // Actualizar el conteo de palabras
  void _updateWordCount() {
    final text = widget.controller.text;
    setState(() {
      _wordCount = _countWords(text: text);

      if (_wordCount > _lineCount) {
        widget.controller.value = widget.controller.value.copyWith(
            text: _truncateTextToWordLimint(text: text, wordLimit: _lineCount),
            selection: TextSelection.fromPosition(
              TextPosition(offset: widget.controller.text.length),
            ));
        _wordCount = _lineCount;
      }
    });
  }

  String _truncateTextToWordLimint(
      {required String text, required int wordLimit}) {
    final words = text.trim().split(RegExp(r'\s+'));

    if (words.length <= wordLimit) {
      return text;
    }

    return words.take(wordLimit).join(' ');
  }

  // Conteo de palabras
  int _countWords({required String text}) {
    if (text.isEmpty) {
      return 0;
    }

    final words = text.trim().split(RegExp(r'\s+'));

    return words.length;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input textform field
        TextFormField(
          controller: widget.controller,
          maxLines: 4,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: GoogleFonts.poppins(
              fontSize: 25,
              color: Colors.grey,
            ),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
        ),

        // Espacio de separcion
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Colors.grey,
              ),
            ),
          ),
        ),

        gapH(10),

        //
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Texto de conteo
            CustomLabel(
              text: '$_wordCount / $_lineCount palabras',
            ),

            // Icono de volumen
            GestureDetector(
              onTap: _handleVolume,
              child: const CustomIcon(
                icon: Icons.volume_up,
                iconColor: Colors.blueAccent,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
