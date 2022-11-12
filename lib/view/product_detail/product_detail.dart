import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/model/product_model.dart';
import 'package:ecommerce_faza/providers/cart_provider.dart';
import 'package:ecommerce_faza/providers/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductModel? product;

  const ProductDetailPage(this.product);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    Future<void> showSuccessDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * 30),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.close,
                        color: MyColors.primaryOrange,
                      ),
                    ),
                  ),
                  // Image.asset(
                  //   'assets/icon_success.png',
                  //   width: 100,
                  // ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Success :)',
                    style: MyStyle.sectionTitle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    'Berhasil menambahkan keranjang',
                    style: MyStyle.productDetailText,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 154,
                    height: 44,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: MyColors.primaryOrange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Lihat Keranjang',
                        style: MyStyle.productDetailTitle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffffffff)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: MyColors.softGray,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE1C4BE),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  height: 250,
                  width: double.infinity,
                  child: ClipRRect(
                    child: Image.network(
                      this.product!.thumbnail == null ||
                              this.product!.thumbnail == ""
                          ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                          : this.product!.thumbnail!,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Image.asset(
                          'assets/images/icons/back-icon.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          favoriteProvider.setProduct(this.product!);
                        },
                        child: favoriteProvider.isWishlist(this.product!)
                            ? Image.asset(
                                'assets/images/icons/favorited-icon.png',
                                width: 40,
                                height: 40,
                              )
                            : Image.asset(
                                'assets/images/icons/favorite-icon.png',
                                width: 40,
                                height: 40,
                              ),
                      ),
                    ],
                  ),
                )
              ]),
              const SizedBox(height: 10),
              Container(
                color: MyColors.softGray,
                margin: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 53),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(this.product!.title!,
                              style: MyStyle.productDetailTitle),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "\$",
                              style: MyStyle.productDetailPrice,
                            ),
                            Text(this.product!.price!.toString(),
                                style: MyStyle.productDetailPrice)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset('assets/images/icons/star.png'),
                        Text(this.product!.rating!.toString())
                      ],
                    ),
                    const SizedBox(height: 18),
                    Text(this.product!.description!,
                        style: MyStyle.productDetailDesc)
                  ],
                ),
              ),
              const SizedBox(height: 62),
              Container(
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          MyColors.primaryOrange,
                        ),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(8)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        cartProvider.addCart(this.product!);
                        showSuccessDialog();
                      },
                      child: Row(
                        children: [
                          Image.asset('assets/images/icons/btn-cart.png'),
                          Text(
                            'Add To Cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          MyColors.black,
                        ),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(18)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/checkout');
                      },
                      child: Text(
                        'Buy Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
