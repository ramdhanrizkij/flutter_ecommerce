import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/main.dart';
import 'package:ecommerce_faza/model/cart_model.dart';
import 'package:ecommerce_faza/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget cartCard(CartModel cart) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
        decoration: BoxDecoration(
            color: MyColors.white, borderRadius: BorderRadius.circular(20)),
        height: 116,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  cart.product!.thumbnail == null ||
                          cart.product!.thumbnail == ""
                      ? "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png"
                      : cart.product!.thumbnail!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              width: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      cart.product!.title ?? '',
                      style: MyStyle.productCartTitle,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(children: [
                    Text("\$", style: MyStyle.productPrice),
                    Text(cart.product!.price.toString(),
                        style: MyStyle.productPrice),
                    const SizedBox(width: 5),
                    // Text('Rp.65.000', style: MyStyle.productPriceDiscount)
                  ])
                ],
              ),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    cartProvider.removeCart(cart.id!);
                  },
                  icon: Image.asset('assets/images/icons/trash.png'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        cartProvider.reduceQuantity(cart.id!);
                      },
                      icon: Icon(Icons.remove, color: MyColors.primaryOrange),
                    ),
                    Text(cart.quantity.toString()),
                    IconButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(MyColors.primaryOrange),
                        padding: MaterialStateProperty.all(
                          const EdgeInsets.all(5),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                          MyColors.primaryOrange,
                        ),
                      ),
                      onPressed: () {
                        cartProvider.addQuantity(cart.id!);
                      },
                      icon: Icon(
                        Icons.add,
                        color: MyColors.primaryOrange,
                      ),
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      );
    }

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
          'My Cart',
          style: MyStyle.pageTitle.copyWith(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    children: cartProvider.carts
                        .map((cart) => cartCard(cart))
                        .toList(),
                  ),
                ),
                cartProvider.carts.length > 0
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(vertical: 12)),
                            backgroundColor: MaterialStateProperty.all(
                                MyColors.primaryOrange),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, "/checkout");
                          },
                          child: Text(
                            'Checkout',
                            style:
                                MyStyle.pageTitle.copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.only(
                            top: 100, left: 30, right: 30),
                        child: Text(
                          "Keranjang anda kosong\, ayo mulai belanja Sekarang",
                          style: MyStyle.productCartTitle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.normal),
                        ),
                      )
              ]),
        ),
      ),
    );
  }
}
