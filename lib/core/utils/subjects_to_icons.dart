import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SubjectsToIcons {
  static const Map<String, IconData> sharedSubjects = {
    'arabic': Icons.language,
    'english': FontAwesomeIcons.language,
    'computer': FontAwesomeIcons.computer,
    'history': FontAwesomeIcons.flag,
    'religion': FontAwesomeIcons.mosque,
  };

  static const Map<String, IconData> scientificSubjects = {
    'math': Icons.calculate,
    'physics': FontAwesomeIcons.atom,
    'chemistry': FontAwesomeIcons.vial,
    'biology': FontAwesomeIcons.dna,
  };

  static const Map<String, IconData> literarySubjects = {
    'math': Icons.functions,
    'history': FontAwesomeIcons.landmark,
    'geography': FontAwesomeIcons.globe,
    'civics': FontAwesomeIcons.scaleBalanced,
    'arabic literature': Icons.menu_book,
    'sociology': FontAwesomeIcons.peopleGroup,
  };

  static IconData? getIconForSubject(String subjectName) {
    final newName = subjectName.trim().toLowerCase();
    return sharedSubjects[newName] ??
        scientificSubjects[newName] ??
        literarySubjects[newName];
  }
}
