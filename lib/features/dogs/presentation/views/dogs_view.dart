import 'package:cached_network_image/cached_network_image.dart';
import 'package:dogs/features/dogs/presentation/viewmodels/dogs_viewmodel.dart';
import 'package:dogs/features/dogs_details/presentation/viewmodels/dogs_details_viewmodel.dart';
import 'package:dogs/features/dogs_details/presentation/views/dogs_details_view.dart';
import 'package:dogs/shared/input_style.dart';
import 'package:dogs/shared/palette.dart';
import 'package:dogs/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DogsView extends StatefulWidget {
  const DogsView({super.key});

  @override
  State<DogsView> createState() {
    return DogsViewState();
  }
}

class DogsViewState extends State<DogsView> {
  late DogsViewModel dogsViewModel;
  late DogsDetailsViewModel dogsDetailsViewModel;
  late double height;
  final TextEditingController controllerSearch = TextEditingController();
  final FocusNode focusSearch = FocusNode();
  final ScrollController scrollController = ScrollController();
  bool initialized = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!initialized) {
      dogsViewModel = context.watch<DogsViewModel>();
      dogsDetailsViewModel = context.watch<DogsDetailsViewModel>();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await dogsViewModel.getDogs(controllerSearch.text);
      });

      height = MediaQuery.of(context).size.height - (kToolbarHeight + MediaQuery.of(context).padding.top);

      scrollController.addListener(() {
        if (focusSearch.hasFocus) focusSearch.unfocus();
        if (!dogsViewModel.makingSearch) dogsViewModel.setSearchVisible(false);
      });

      initialized = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (!dogsViewModel.makingSearch) dogsViewModel.setSearchVisible(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: dogsViewModel.searchVisible
              ? TextFormField(
                  controller: controllerSearch,
                  focusNode: focusSearch,
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    fillColor: Palette.white,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    focusedBorder: InputStyle.inputBorderSearch,
                    enabledBorder: InputStyle.inputBorderSearch,
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      minWidth: 40,
                    ),
                    suffixIcon: dogsViewModel.makingSearch
                        ? IconButton(
                            onPressed: () async {
                              controllerSearch.clear();
                              focusSearch.unfocus();
                              await dogsViewModel.getDogs('');
                            },
                            icon: const Icon(
                              Icons.clear_rounded,
                              size: 26,
                              color: Palette.grayMedium,
                            ),
                            visualDensity: VisualDensity.compact,
                          )
                        : null,
                  ),
                  onFieldSubmitted: (String value) async {
                    await dogsViewModel.getDogs(controllerSearch.text);
                  },
                )
              : const Text(
                  'Dogs',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Palette.white,
                  ),
                ),
          leading: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 40,
                child: Image.asset(
                  'assets/images/icon.png',
                ),
              ),
            ],
          ),
          actions: dogsViewModel.searchVisible
              ? null
              : [
                  IconButton(
                    onPressed: () {
                      focusSearch.requestFocus();
                      dogsViewModel.setSearchVisible(true);
                    },
                    icon: const Icon(
                      Icons.search_rounded,
                      size: 30,
                      color: Palette.white,
                    ),
                    tooltip: 'Pesquisar',
                  ),
                ],
          backgroundColor: Palette.primary,
          shadowColor: Palette.grayMedium,
          elevation: 6,
        ),
        backgroundColor: Palette.white,
        body: dogsViewModel.loaderVisible
            ? const Center(
                child: CircularProgressIndicator(
                  color: Palette.primary,
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  await dogsViewModel.getDogs(controllerSearch.text);
                },
                backgroundColor: Palette.white,
                child: !dogsViewModel.loaderVisible && dogsViewModel.dogs.isEmpty
                    ? SizedBox(
                        height: height,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Image.asset(
                                  'assets/images/icon.png',
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                                const SizedBox(
                                  height: 0,
                                ),
                                const Text(
                                  'Cachorros não encontrados',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Palette.grayMedium,
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: dogsViewModel.dogs.length,
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: TextButton(
                              onPressed: () {
                                Functions.showNetworkImageFullScreen(
                                  context,
                                  dogsViewModel.dogs[index].imageUrl,
                                );
                              },
                              style: TextButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                                fixedSize: const Size.fromWidth(70),
                                padding: EdgeInsets.zero,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: dogsViewModel.dogs[index].imageUrl,
                                placeholder: (context, url) => const CircularProgressIndicator(
                                  color: Palette.primary,
                                ),
                                errorWidget: (context, url, error) => const Icon(
                                  Icons.image_outlined,
                                  color: Palette.grayLight,
                                  size: 40,
                                ),
                              ),
                            ),
                            title: Text(
                              dogsViewModel.dogs[index].name,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Palette.grayMedium,
                              ),
                            ),
                            subtitle: Text(
                              '${dogsViewModel.dogs[index].weight} KG',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Palette.grayMedium,
                              ),
                            ),
                            onTap: () {
                              dogsDetailsViewModel.setDog(dogsViewModel.dogs[index]);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const DogsDetailsView(),
                                ),
                              );
                            },
                          );
                        },
                      ),
              ),
      ),
    );
  }
}
