import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translate_app/core/utils/utils.dart';
import 'package:translate_app/shared/components/components.dart';

class TranslateTo extends StatefulWidget {
  final String translateText;
  const TranslateTo({super.key, required this.translateText});

  @override
  State<TranslateTo> createState() => _TranslateToState();
}

class _TranslateToState extends State<TranslateTo> {
  final FlutterTts _flutterTts = FlutterTts();

  Future<void> _handleVolume() async {
    final text = widget.translateText;
    await _flutterTts.speak(text);
  }

  // Para copiar el texto al portapapeles
  void _copyToClipboard({required String text}) {
    Clipboard.setData(ClipboardData(text: text)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Texto copiado al portapapeles'),
        ),
      );
    });
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: CustomLabel(
              text: widget.translateText,
              textSize: 16,
              fontWeight: FontWeight.normal,
            ),
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Icono de copiar
            GestureDetector(
              onTap: () => _copyToClipboard(text: widget.translateText),
              child: const CustomIcon(
                icon: Icons.copy_all,
                iconColor: Colors.blueAccent,
              ),
            ),
            gapW(10),
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
