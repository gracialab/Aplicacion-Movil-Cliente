import 'package:mr_fix/data/models/list_options/list_options_model.dart';

class ListOptionsFormCard {
  static final ListOptionsFormCard _singleton = ListOptionsFormCard._();
  factory ListOptionsFormCard() => _singleton;
  ListOptionsFormCard._();

  final List<ListOptionsModel> identification = const [
    ListOptionsModel(label: "Cedula de Ciudadania", value: 1),
    ListOptionsModel(label: "Tarjeta de Identidad", value: 2),
    ListOptionsModel(label: "Cedula de extranjeria", value: 3),
  ];
  final List<ListOptionsModel> country = const [
    ListOptionsModel(label: "Argentina", value: 1),
    ListOptionsModel(label: "Brasil", value: 2),
    ListOptionsModel(label: "Bolivia", value: 3),
    ListOptionsModel(label: "Chile", value: 4),
    ListOptionsModel(label: "Colombia", value: 5),
    ListOptionsModel(label: "Ecuador", value: 6),
    ListOptionsModel(label: "Paraguay", value: 7),
  ];
  final List<ListOptionsModel> state = const [
    ListOptionsModel(label: "Antioquia", value: 1),
    ListOptionsModel(label: "Atlantico", value: 2),
    ListOptionsModel(label: "Huila", value: 3),
  ];
  final List<ListOptionsModel> city = const [
    ListOptionsModel(label: "Neiva", value: 1),
    ListOptionsModel(label: "Pitalito", value: 2),
    ListOptionsModel(label: "Rivera", value: 3),
  ];
  final List<ListOptionsModel> numberDues = List.generate(
    12,
    (index) {
      final value = index + 1;
      return ListOptionsModel(label: value.toString(), value: value);
    },
  );

  final List<ListOptionsModel> selectBank = const [
    ListOptionsModel(label: "1", value: 1),
    ListOptionsModel(label: "2", value: 2),
    ListOptionsModel(label: "3", value: 3),
    ListOptionsModel(label: "4", value: 4),
    ListOptionsModel(label: "5", value: 5),
    ListOptionsModel(label: "6", value: 6),
    ListOptionsModel(label: "7", value: 7),
  ];
  final List<ListOptionsModel> naturalPerson = const [
    ListOptionsModel(label: "1", value: 1),
    ListOptionsModel(label: "2", value: 2),
    ListOptionsModel(label: "3", value: 3),
    ListOptionsModel(label: "4", value: 4),
    ListOptionsModel(label: "5", value: 5),
    ListOptionsModel(label: "6", value: 6),
    ListOptionsModel(label: "7", value: 7),
  ];
}
