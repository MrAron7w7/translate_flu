import 'package:flutter/material.dart';
import 'package:translate_app/core/utils/utils.dart';
import 'package:translate_app/features/model/country_model.dart';
import 'package:translate_app/shared/components/components.dart';

class CustomDropdown extends StatefulWidget {
  final ValueChanged<String?> onLanguageChanged;
  const CustomDropdown({super.key, required this.onLanguageChanged});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedCountry;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 0.1,
        ),
      ),
      child: DropdownButton<String>(
        dropdownColor: Colors.white,
        value: selectedCountry,
        hint: const CustomLabel(
          text: 'Idioma',
          textSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
        icon: const CustomIcon(icon: Icons.keyboard_arrow_down_rounded),
        underline: Container(color: Colors.transparent),
        items: CountryModel.languageData.map((country) {
          return DropdownMenuItem<String>(
            value: country.countryName,
            child: Row(
              children: [
                Image.asset(country.urlCountry, width: 24.0, height: 24.0),
                gapW(10),
                CustomLabel(
                  text: country.countryName,
                  textSize: 14.0,
                  fontWeight: FontWeight.w500,
                )
              ],
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedCountry = newValue!;
          });
          widget.onLanguageChanged(selectedCountry);
        },
      ),
    );
  }
}
