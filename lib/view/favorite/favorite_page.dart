import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/model/cart_model.dart';
import 'package:ecommerce_faza/model/product_model.dart';
import 'package:ecommerce_faza/providers/cart_provider.dart';
import 'package:ecommerce_faza/providers/favorite_provider.dart';
import 'package:ecommerce_faza/view/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);
    List<ProductModel> favorites = favoriteProvider.favorite;

    return Scaffold(
        backgroundColor: Color(0xffF4F2F2),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: MyColors.white,
          shadowColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Favorite',
            style: MyStyle.pageTitle.copyWith(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductDetailPage(favorites[index])),
                ),
                child: Container(
                  height: 116,
                  margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 0, right: 15, left: 15),
                  decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            favorites[index]!.thumbnail == null ||
                                    favorites[index]!.thumbnail == ""
                                ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                                : favorites[index]!.thumbnail!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              favorites[index].title!,
                              style: MyStyle.productCartTitle,
                            ),
                          ),
                          Row(
                            children: [
                              Text("\$", style: MyStyle.productPrice),
                              SizedBox(
                                height: 10,
                              ),
                              Text(favorites[index].price.toString(),
                                  style: MyStyle.productPrice),
                            ],
                          )
                        ],
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.favorite_outline,
                                color: MyColors.alertColor,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: favoriteProvider.favorite.length,
          ),
        )
        // ListView(
        //   padding: EdgeInsets.symmetric(horizontal: 20),
        //   children: favoriteProvider.favorite
        //       .map((item) => favoriteCard(item))
        //       .toList(),
        // ),
        );
  }
}
