import 'package:dogs/core/enums.dart';
import 'package:dogs/features/dogs/domain/entities/dogs_entity.dart';
import 'package:dogs/features/dogs/domain/entities/dogs_response_entity.dart';
import 'package:dogs/features/dogs/domain/usecases/dogs_usecase.dart';
import 'package:dogs/utils/functions.dart';
import 'package:flutter/material.dart';

class DogsViewModel extends ChangeNotifier {
  DogsUseCase dogsUseCase;
  List<Dog> dogs = [];
  bool searchVisible = false;
  bool makingSearch = false;
  bool loaderVisible = false;

  DogsViewModel({
    required this.dogsUseCase,
  });

  void setDogs(List<Dog> value) {
    dogs = value;
    notifyListeners();
  }

  void setSearchVisible(bool value) {
    searchVisible = value;
    notifyListeners();
  }

  void setMakingSearch(bool value) {
    makingSearch = value;
    notifyListeners();
  }

  void setLoaderVisible(bool value) {
    loaderVisible = value;
    notifyListeners();
  }

  Future<void> getDogs(String search) async {
    setLoaderVisible(true);
    setSearchVisible(search.isNotEmpty);
    setMakingSearch(search.isNotEmpty);

    DogResponse dogResponse = await dogsUseCase.getDogs(search);

    setLoaderVisible(false);

    if (dogResponse.responseStatus != ResponseStatus.success) {
      await Functions.showMessageResponseStatus(
        dogResponse.responseStatus,
        'buscar',
        'os',
        'cachorros',
      );
    }

    setDogs(dogResponse.dogs);
  }
}
