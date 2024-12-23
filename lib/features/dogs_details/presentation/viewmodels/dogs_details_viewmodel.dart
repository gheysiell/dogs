import 'package:dogs/features/dogs/domain/entities/dogs_entity.dart';
import 'package:flutter/material.dart';

class DogsDetailsViewModel extends ChangeNotifier {
  Dog? dog;

  void setDog(Dog value) {
    dog = value;
    notifyListeners();
  }
}
