import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:hello_world/src/config/custom_colors.dart';
import 'package:badges/badges.dart' as packageBadge;
import 'package:hello_world/src/config/app_data.dart' as app_data;
import 'package:hello_world/src/pages/commom_widgets/custom_shimmer.dart';
import 'package:hello_world/src/pages/home/components/item_tile.dart';
import '../commom_widgets/app_name_widget.dart';
import 'components/category_tile.dart';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCartAnimation(gkImage);
  }

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: AppNameWidget(),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 15,
                right: 15,
              ),
              child: GestureDetector(
                  onTap: () {},
                  child: packageBadge.Badge(
                    badgeContent: const Text(
                      '2',
                      style: TextStyle(
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
                  )),
            ),
          ]),

      // Campo de Pesquisa
      body: AddToCartAnimation(
        gkCart: globalKeyCartItems,
        previewDuration: const Duration(milliseconds: 100),
        previewCurve: Curves.ease,
        receiveCreateAddToCardAnimationMethod: (addToCartAnimation) {
          runAddToCartAnimation = addToCartAnimation;
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: TextFormField(
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
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(60),
                        borderSide: const BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ))),
              ),
            ),

            // Categoria
            Container(
              padding: const EdgeInsets.only(left: 25),
              height: 40,
              child: !isLoading
              ? ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    onPressed: () {
                      setState(() {
                        selectedCategory = app_data.categories[index];
                      });
                    },
                    category: app_data.categories[index],
                    isSelected: app_data.categories[index] == selectedCategory,
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: app_data.categories.length,
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
            ),

            // Grid
            Expanded(
              child: !isLoading
                ? GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 9 / 11.5,
                  ),
                  itemCount: app_data.items.length,
                  itemBuilder: (_, index) {
                    return ItemTile(
                      item: app_data.items[index],
                      cartAnimationMethod: itemSelectedCartAnimations,
                    );
                  },
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
            )
          ],
        ),
      ),
    );
  }
}
