import 'package:ecommerce_faza/common/my_colors.dart';
import 'package:ecommerce_faza/common/my_styles.dart';
import 'package:ecommerce_faza/model/product_model.dart';
import 'package:ecommerce_faza/model/user_model.dart';
import 'package:ecommerce_faza/providers/auth_provider.dart';
import 'package:ecommerce_faza/providers/product_provider.dart';
import 'package:ecommerce_faza/view/dashboard/product_item.dart';
import 'package:ecommerce_faza/view/product_detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timestamp) =>
        {Provider.of<ProductProvider>(context, listen: false).getProducts()});
    // fetchProduct();
  }

  fetchProduct() async {
    print("Called API ");
    await Provider.of<ProductProvider>(context).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> products = productProvider.products;

    Widget headerWidget() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: const Icon(
              Icons.menu,
            ),
          ),
          IconButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(0),
              ),
              backgroundColor: MaterialStateProperty.all(
                Colors.transparent,
              ),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/cart");
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      );
    }

    Widget bannerWidget() {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 28),
        child: Image.asset('assets/images/banner/banner_1.png'),
      );
    }

    Widget ourProductTitle() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [Text('Our Product', style: MyStyle.sectionTitle)],
      );
    }

    Widget listProduct() {
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // crossAxisSpacing: 12.0,
          // mainAxisSpacing: 12.0,
          mainAxisExtent: 220,
        ),
        itemBuilder: (_, index) => GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ProductDetailPage(products[index])),
            );
            // Navigator.popAndPushNamed(context, '/product_detail');
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            height: 10,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(4, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // IMage
                Container(
                  width: 140,
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      products[index].thumbnail ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Flexible(
                  child: Text(
                    products[index].title ?? '',
                    style: MyStyle.productTitle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("\$"),
                        Text(products[index].price.toString())
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.star,
                          color: MyColors.primaryOrange,
                          size: 15,
                        ),
                        Text(products[index].rating.toString())
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        itemCount: products.length,
      );
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.black,
          actions: [
            IconButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.all(0),
                ),
                backgroundColor: MaterialStateProperty.all(
                  Colors.transparent,
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/cart");
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
          // leading: GestureDetector(
          //   onTap: () {
          //     Scaffold.of(context).openDrawer();
          //   },
          //   child: const Icon(
          //     Icons.menu,
          //     color: Colors.black,
          //   ),
          // ),
        ),
        drawer: SafeArea(
          child: drawerWidget(user: user),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [bannerWidget(), ourProductTitle(), listProduct()],
              ),
            ),
          ),
        ));
  }
}

class drawerWidget extends StatelessWidget {
  const drawerWidget({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyColors.drawerColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.blue,
                        )),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        'https://ui-avatars.com/api/?background=0D8ABC&color=fff&name=' +
                            user.name!,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16, left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(user.name ?? ''),
                        ],
                      ),
                      Text(user.email ?? '')
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: const Text('Favorite'),
            onTap: () {
              Navigator.pushNamed(context, "/favorite");
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .isAuthenticated = false;

              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/sign-in', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
