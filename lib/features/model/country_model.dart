import 'package:translate_app/core/constants/assets_app.dart';

class CountryModel {
  final String countryName;
  final String urlCountry;

  CountryModel({
    required this.countryName,
    required this.urlCountry,
  });

  static List<CountryModel> countryList = [
    CountryModel(
      countryName: 'USA',
      urlCountry: AssetsApp.usa,
    ),
    CountryModel(
      countryName: 'Russia',
      urlCountry: AssetsApp.russia,
    ),
    CountryModel(
      countryName: 'Italy',
      urlCountry: AssetsApp.italy,
    ),
    CountryModel(
      countryName: 'Germany',
      urlCountry: AssetsApp.germany,
    ),
    CountryModel(
      countryName: 'France',
      urlCountry: AssetsApp.france,
    ),
    CountryModel(
      countryName: 'China',
      urlCountry: AssetsApp.china,
    ),
    CountryModel(
      countryName: 'England',
      urlCountry: AssetsApp.britain,
    ),
    CountryModel(
      countryName: 'Saudi',
      urlCountry: AssetsApp.arabic,
    ),
  ];

  static List<CountryModel> languageData = [
    CountryModel(
      countryName: 'English - US',
      urlCountry: AssetsApp.usa,
    ),
    CountryModel(
      countryName: 'English - UK',
      urlCountry: AssetsApp.britain,
    ),
    CountryModel(
      countryName: 'Russian',
      urlCountry: AssetsApp.russia,
    ),
    CountryModel(
      countryName: 'Italian',
      urlCountry: AssetsApp.italy,
    ),
    CountryModel(
      countryName: 'German',
      urlCountry: AssetsApp.germany,
    ),
    CountryModel(
      countryName: 'French',
      urlCountry: AssetsApp.france,
    ),
    CountryModel(
      countryName: 'Spanish',
      urlCountry: AssetsApp.spain,
    ),
  ];
}
