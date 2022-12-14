import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_font_size.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/model/cart_model.dart';
import 'package:ecommerce_faza/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

enum PaymentMethod { ovo, gopay }

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  PaymentMethod? _payment;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    Widget cartCard(CartModel cart) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        // padding: const EdgeInsets.only(top: 15, bottom: 0, right: 15, left: 15),
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
            'Checkout',
            style: MyStyle.pageTitle.copyWith(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: MyColors.white,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(13),
                        child: Row(children: [
                          Image.asset('assets/images/icons/basket.png'),
                          const SizedBox(width: 7),
                          Flexible(
                            child: Text(
                              'Ini halaman terakhir dari proses belanjaanmu',
                              style: MyStyle.regularText.copyWith(
                                fontSize: MyFontSize.text_12,
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 14),
                      // Product Container
                      Container(
                        child: ListView(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: cartProvider.carts
                              .map((cart) => cartCard(cart))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 2),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Pengiriman dan pembayaran',
                              style: MyStyle.productCartTitle)
                        ],
                      ),
                      const SizedBox(height: 15),
                      // Payment Method Container
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              content: Container(
                                height: 200,
                                width: double.infinity,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Metode Pembayaran",
                                        style: MyStyle.paymentMethodsTitle,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      ListTile(
                                        title: const Text('Ovo'),
                                        leading: Radio<PaymentMethod>(
                                          value: PaymentMethod.ovo,
                                          groupValue: _payment,
                                          onChanged: (PaymentMethod? value) {
                                            setState(() {
                                              _payment = value;
                                            });
                                            Navigator.pop(context, 'OK');
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Gopay'),
                                        leading: Radio<PaymentMethod>(
                                          value: PaymentMethod.gopay,
                                          groupValue: _payment,
                                          onChanged: (PaymentMethod? value) {
                                            setState(() {
                                              _payment = value;
                                            });
                                            Navigator.pop(context, 'OK');
                                          },
                                        ),
                                      ),
                                    ]),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 17,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(64, 0, 0, 0),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                  spreadRadius: 0),
                            ],
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _payment != null
                                  ? Row(
                                      children: [
                                        Text("Bayar Dengan "),
                                        _payment == PaymentMethod.ovo
                                            ? Text("OVO")
                                            : Text("GOPAY")
                                      ],
                                    )
                                  : Text(
                                      'Pilih metode pembayaran ',
                                      style: MyStyle.productPrice,
                                    ),
                              const IconButton(
                                onPressed: null,
                                icon: Icon(Icons.arrow_forward_ios),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Divider(thickness: 1),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Bayar', style: MyStyle.productTitle),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("\$",
                                      style: MyStyle.productTitle.copyWith(
                                          color: const Color(0xFFF85959))),
                                  Text(
                                    cartProvider.totalPrice().toString(),
                                    style: MyStyle.productTitle.copyWith(
                                        color: const Color(0xFFF85959)),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 8,
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all(
                                MyColors.primaryOrange,
                              ),
                            ),
                            onPressed: () {
                              cartProvider.removeAll();
                              Navigator.pushNamed(context, "/success");
                              // showDialogWithFields(context);
                            },
                            child: Row(
                              children: [
                                Image.asset(
                                    'assets/images/icons/checkout_icon.png'),
                                const SizedBox(width: 3),
                                Text(
                                  'Bayar',
                                  style: MyStyle.productDetailTitle.copyWith(
                                    fontSize: MyFontSize.text_12,
                                    color: MyColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

void showDialogWithFields(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) {
      var emailController = TextEditingController();
      var messageController = TextEditingController();
      return AlertDialog(
        title: Text('Contact Us'),
        content: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(hintText: 'Email'),
            ),
            TextFormField(
              controller: messageController,
              decoration: InputDecoration(hintText: 'Message'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Send them to your email maybe?
              var email = emailController.text;
              var message = messageController.text;
              Navigator.pop(context);
            },
            child: Text('Send'),
          ),
        ],
      );
    },
  );
}
