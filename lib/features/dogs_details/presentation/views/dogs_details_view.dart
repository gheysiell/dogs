import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs/features/dogs_details/presentation/viewmodels/dogs_details_viewmodel.dart';
import 'package:dogs/shared/input_style.dart';
import 'package:dogs/shared/palette.dart';
import 'package:dogs/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DogsDetailsView extends StatefulWidget {
  const DogsDetailsView({super.key});

  @override
  State<DogsDetailsView> createState() {
    return DogsDetailsViewState();
  }
}

class DogsDetailsViewState extends State<DogsDetailsView> {
  late DogsDetailsViewModel dogsDetailsViewModel;
  TextEditingController controllerId = TextEditingController();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerBredFor = TextEditingController();
  TextEditingController controllerlifeSpan = TextEditingController();
  TextEditingController controllerTemperament = TextEditingController();
  TextEditingController controllerOrigin = TextEditingController();
  TextEditingController controllerHeight = TextEditingController();
  TextEditingController controllerWeight = TextEditingController();
  FocusNode focusId = FocusNode();
  FocusNode focusName = FocusNode();
  FocusNode focusBredFor = FocusNode();
  FocusNode focuslifeSpan = FocusNode();
  FocusNode focusTemperament = FocusNode();
  FocusNode focusOrigin = FocusNode();
  FocusNode focusHeight = FocusNode();
  FocusNode focusWeight = FocusNode();
  List<TextEditingController> textControllers = [];
  List<FocusNode> focusNodes = [];
  List<String> textTitles = [
    'Código',
    'Nome',
    'Função',
    'Tempo de vida',
    'Temperamento',
    'Origem',
    'Altura',
    'Peso',
  ];
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      dogsDetailsViewModel = context.watch<DogsDetailsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        controllerId.text = dogsDetailsViewModel.dog!.id.toString();
        controllerName.text = dogsDetailsViewModel.dog!.name;
        controllerBredFor.text = dogsDetailsViewModel.dog!.bredFor;
        controllerlifeSpan.text = dogsDetailsViewModel.dog!.lifeSpan;
        controllerTemperament.text = dogsDetailsViewModel.dog!.temperament;
        controllerOrigin.text = dogsDetailsViewModel.dog!.origin;
        controllerHeight.text = '${dogsDetailsViewModel.dog!.height} CM';
        controllerWeight.text = '${dogsDetailsViewModel.dog!.weight} KG';
      });

      textControllers = [
        controllerId,
        controllerName,
        controllerBredFor,
        controllerlifeSpan,
        controllerTemperament,
        controllerOrigin,
        controllerHeight,
        controllerWeight,
      ];
      focusNodes = [
        focusId,
        focusName,
        focusBredFor,
        focuslifeSpan,
        focusTemperament,
        focusOrigin,
        focusHeight,
        focusWeight,
      ];

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dog',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Palette.white,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Palette.white,
            size: 30,
          ),
          tooltip: 'Voltar',
        ),
        backgroundColor: Palette.primary,
        shadowColor: Palette.grayMedium,
        elevation: 6,
      ),
      backgroundColor: Palette.white,
      body: ListView.builder(
        itemCount: textControllers.length + 1,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        itemBuilder: (BuildContext context, int index) {
          int indexTextControllers = index - 1;

          return index == 0
              ? TextButton(
                  onPressed: () {
                    Functions.showNetworkImageFullScreen(
                      context,
                      dogsDetailsViewModel.dog!.imageUrl,
                    );
                  },
                  style: TextButton.styleFrom(
                    fixedSize: const Size.fromHeight(200),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  child: CachedNetworkImage(
                    imageUrl: dogsDetailsViewModel.dog!.imageUrl,
                    placeholder: (context, url) => const CircularProgressIndicator(
                      color: Palette.primary,
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.image_outlined,
                      color: Palette.grayLight,
                      size: 40,
                    ),
                  ),
                )
              : Container(
                  margin: const EdgeInsets.only(
                    top: 22,
                  ),
                  child: TextFormField(
                    controller: textControllers[indexTextControllers],
                    focusNode: focusNodes[indexTextControllers],
                    readOnly: true,
                    style: const TextStyle(
                      fontSize: 19,
                      color: Palette.grayMedium,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      fillColor: Palette.primaryLight,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      label: Text(
                        textTitles[indexTextControllers],
                        style: const TextStyle(
                          fontSize: 18,
                          color: Palette.grayMedium,
                        ),
                      ),
                      focusedBorder: InputStyle.inputBorder,
                      enabledBorder: InputStyle.inputBorder,
                      border: InputStyle.inputBorder,
                      disabledBorder: InputStyle.inputBorder,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
