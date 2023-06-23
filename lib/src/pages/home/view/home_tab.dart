import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../config/custom_colors.dart';
import 'package:badges/badges.dart' as packageBadge;
import '../../base/controller/navigation_controller.dart';
import '../../cart/controller/cart_controller.dart';
import '../../commom_widgets/custom_shimmer.dart';
import './components/item_tile.dart';
import '../../commom_widgets/app_name_widget.dart';
import 'components/category_tile.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

import '../controller/home_controller.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  final searchController = TextEditingController();
  final navigationController = Get.find<NavigationController>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const AppNameWidget(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 15,
              ),
              child: GetBuilder<CartController>(
                builder: (controller) {
                  return GestureDetector(
                      onTap: () {
                        navigationController.navigatePageView(
                            NavigationTabs.cart);
                      },
                      child: packageBadge.Badge(
                        badgeContent: Text(
                          controller.cartItems.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        child: IconButton(
                            onPressed: () {},
                            icon: AddToCartIcon(
                              key: globalKeyCartItems,
                              icon: Icon(
                                Icons.shopping_cart,
                                color: CustomColors.customSwatchColor,
                              ),
                            )),
                      ));
                },
              ),
            ),
          ]),

      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCartAnimation) {
          runAddToCartAnimation = addToCartAnimation;
        },
        child: Column(
          children: [
            // Campo de Pesquisa
            GetBuilder<HomeController>(
              builder: (controller) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: TextFormField(
                    controller: searchController,
                    onChanged: (value) {
                      controller.searchTitle.value = value;
                    },
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        isDense: true,
                        hintText: 'Pesquise aqui...',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 14,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: CustomColors.customContrastColor,
                          size: 21,
                        ),
                        suffixIcon: controller.searchTitle.value.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  searchController.clear();
                                  controller.searchTitle.value = '';
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: CustomColors.customContrastColor,
                                  size: 21,
                                ))
                            : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ))),
                  ),
                );
              },
            ),

            // Categoria
            GetBuilder<HomeController>(builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 25),
                height: 40,
                child: !controller.isCategoryLoading
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) {
                          return CategoryTile(
                            onPressed: () {
                              controller.selectCategory(
                                  controller.allCategories[index]);
                            },
                            category: controller.allCategories[index].title,
                            isSelected: controller.allCategories[index] ==
                                controller.currentCategory,
                          );
                        },
                        separatorBuilder: (_, index) =>
                            const SizedBox(width: 10),
                        itemCount: controller.allCategories.length,
                      )
                    : ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                          10,
                          (index) => Container(
                            margin: const EdgeInsets.only(right: 12),
                            alignment: Alignment.center,
                            child: CustomShimmer(
                              height: 20,
                              width: 80,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),
              );
            }),

            // Grid
            GetBuilder<HomeController>(builder: (controller) {
              return Expanded(
                child: !controller.isProductLoading
                    ? Visibility(
                        visible: (controller.currentCategory?.items ?? [])
                            .isNotEmpty,
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 40,
                              color: CustomColors.customSwatchColor,
                            ),
                            const Text('Não há items para apresentar')
                          ],
                        ),
                        child: GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 9 / 11.5,
                          ),
                          itemCount: controller.allProducts.length,
                          itemBuilder: (_, index) {
                            final lastItem =
                                controller.allProducts.length == (index + 1);
                            if (lastItem && !controller.isLastPage) {
                              if (!controller.isLastPage) {
                                controller.loadMoreProducts();
                              }
                            }
                            return ItemTile(
                              item: controller.allProducts[index],
                              cartAnimationMethod: itemSelectedCartAnimations,
                            );
                          },
                        ),
                      )
                    : GridView.count(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 9 / 11.5,
                        children: List.generate(
                            6,
                            (index) => CustomShimmer(
                                  height: double.infinity,
                                  width: double.infinity,
                                  borderRadius: BorderRadius.circular(20),
                                )),
                      ),
              );
            })
          ],
        ),
      ),
    );
  }
}
