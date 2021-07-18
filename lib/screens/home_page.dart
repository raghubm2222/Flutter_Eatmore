import 'package:eatmore/main.dart';
import 'package:flutter/material.dart';

var primaryColor = Color(0xffff0036);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<int>? _selectedCategory;
  ValueNotifier<int>? _selectedBurger;
  @override
  void initState() {
    super.initState();
    _selectedCategory = ValueNotifier<int>(0);
    _selectedBurger = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _selectedCategory!.dispose();
    _selectedBurger!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 30.0,
                      width: 30.0,
                      child: Image.asset('assets/menu.png'),
                    ),
                    CircleAvatar(
                      radius: 22.0,
                      backgroundImage: AssetImage('assets/profile_image.png'),
                    )
                  ],
                ),
                SizedBox(height: 15.0),
                Text(
                  'Choose the',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  'Food you love',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 15.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(width: 0.3, color: Colors.grey.shade400),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Search for a food item',
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                      contentPadding: EdgeInsets.all(8.0),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 100.0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories
                          .map(
                            (c) => _buildCategoryWidget(
                              title: c.title!,
                              image: c.image!,
                              index: categories.indexOf(c),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Burgers',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 250.0,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: products
                          .map(
                            (e) => _buildProduct(
                              title: e.title!,
                              price: e.price!,
                              image: e.image!,
                              index: products.indexOf(e),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: products
                      .map(
                        (e) => ValueListenableBuilder(
                          valueListenable: _selectedBurger!,
                          builder: (context, _index, _) {
                            return AnimatedContainer(
                              margin: EdgeInsets.all(2),
                              height: 8.0,
                              width: 8.0,
                              duration: Duration(
                                milliseconds: 200,
                              ),
                              decoration: BoxDecoration(
                                color: products.indexOf(e) == _index
                                    ? primaryColor
                                    : Colors.black12,
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildProduct({
    required String title,
    required String image,
    required double price,
    required int index,
  }) {
    return ValueListenableBuilder(
      valueListenable: _selectedBurger!,
      builder: (context, _index, _) {
        bool isActive = _index == index;
        return GestureDetector(
          onTap: () {
            _selectedBurger!.value = index;
          },
          child: Container(
            margin: EdgeInsets.only(right: 20.0),
            padding: EdgeInsets.all(10.0),
            width: 150.0,
            height: 211.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: isActive
                  ? LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xffff0036),
                        Color(0xffff6787),
                      ],
                    )
                  : LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.white,
                        Colors.white,
                      ],
                    ),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? primaryColor.withOpacity(0.09)
                      : Colors.grey.shade200,
                  offset: Offset(0, 8.0),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SizedBox(
                    height: 100.0,
                    width: 100.0,
                    child: Image.asset('assets/$image.png'),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: isActive ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    for (int i = 0; i < 4; i++)
                      SizedBox(
                        height: 15.0,
                        width: 15.0,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Image.asset(
                            'assets/star1.png',
                            color: Colors.yellow,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 15.0,
                      width: 15.0,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          'assets/star.png',
                          color: Colors.yellow,
                        ),
                      ),
                    )
                  ],
                ),
                Text(
                  '\$$price',
                  style: TextStyle(
                    color: isActive ? Colors.white : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryWidget({
    required String title,
    required String image,
    required int index,
  }) {
    return ValueListenableBuilder(
        valueListenable: _selectedCategory!,
        builder: (context, _index, _) {
          bool isSelected = index == _index;
          return GestureDetector(
            onTap: () {
              _selectedCategory!.value = index;
            },
            child: Container(
              width: 110.0,
              height: 69.0,
              margin: EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 1.0,
                  color: isSelected ? primaryColor : Colors.white,
                ),
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? primaryColor.withOpacity(0.09)
                        : Colors.grey.shade200,
                    offset: Offset(0, 8.0),
                    blurRadius: 5.0,
                    spreadRadius: 1.0,
                  )
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30.0,
                    width: 30.0,
                    child: Image.asset(
                      'assets/$image.png',
                      color: isSelected ? primaryColor : Colors.grey,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? primaryColor : Colors.grey.shade400,
                      fontSize: 12.0,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _buildFloatingActionButton() {
    return Container(
      alignment: Alignment.center,
      height: 60.0,
      width: 60.0,
      decoration: BoxDecoration(
        border: Border.all(width: 3.0, color: Colors.white),
        shape: BoxShape.circle,
        color: primaryColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(5, 10),
            color: primaryColor.withOpacity(0.3),
            spreadRadius: 3.0,
            blurRadius: 10.0,
          )
        ],
      ),
      child: SizedBox(
        height: 30,
        child: Image.asset(
          'assets/shopping-bag.png',
          color: Colors.white,
        ),
      ),
    );
  }
}

class CategoryIcon {
  final String? title;
  final String? image;

  CategoryIcon({
    @required this.title,
    @required this.image,
  });
}

List<CategoryIcon> categories = [
  CategoryIcon(title: 'Burgers', image: 'burger'),
  CategoryIcon(title: 'Pizza', image: 'pizza'),
  CategoryIcon(title: 'Chicken', image: 'chicken'),
];

class Product {
  final String? title;
  final String? image;
  final double? rating;
  final double? price;

  Product({
    @required this.title,
    @required this.image,
    @required this.rating,
    @required this.price,
  });
}

List<Product> products = [
  Product(
    title: 'Zinger Burger',
    image: 'zingerburger',
    rating: 4.0,
    price: 12.25,
  ),
  Product(
    title: 'Chicken Burger',
    image: 'chickenburger',
    rating: 4.2,
    price: 12.25,
  ),
  Product(
    title: 'Zinger Burger',
    image: 'zingerburger',
    rating: 5.0,
    price: 12.25,
  ),
  Product(
    title: 'Chicken Burger',
    image: 'chickenburger',
    rating: 4.0,
    price: 12.25,
  ),
  Product(
    title: 'Zinger Burger',
    image: 'zingerburger',
    rating: 4.5,
    price: 12.25,
  ),
  Product(
    title: 'Chicken Burger',
    image: 'chickenburger',
    rating: 4.0,
    price: 12.25,
  ),
];
