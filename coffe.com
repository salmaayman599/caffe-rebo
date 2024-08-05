import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' as gf;

void main() {
  runApp(CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CoffeeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CoffeeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: Icon(Icons.location_on, color: Colors.white),
        title: Text(
          'Bilzen, Tanjungbalai',
          style: gf.GoogleFonts.lato(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PromoBanner(),
            CategoryTabs(),
            CoffeeList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class PromoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.brown[400],
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: NetworkImage('https://via.placeholder.com/400x150'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              color: Colors.red,
              child: Text(
                'Promo',
                style: gf.GoogleFonts.lato(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Text(
              'Buy one get one FREE',
              style: gf.GoogleFonts.lato(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          CategoryTab(label: 'All Coffee'),
          CategoryTab(label: 'Macchiato'),
          CategoryTab(label: 'Latte'),
          CategoryTab(label: 'Americano'),
        ],
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String label;

  CategoryTab({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        backgroundColor: Colors.brown[200],
        label: Text(
          label,
          style: gf.GoogleFonts.lato(color: Colors.white),
        ),
      ),
    );
  }
}

class CoffeeList extends StatelessWidget {
  final List<Map<String, String>> coffeeItems = [
    {
      'name': 'Caffe Mocha',
      'price': '\$4.53',
      'image': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Flat White',
      'price': '\$3.53',
      'image': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Cappuccino',
      'price': '\$3.95',
      'image': 'https://via.placeholder.com/100',
    },
    {
      'name': 'Latte',
      'price': '\$4.00',
      'image': 'https://via.placeholder.com/100',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: coffeeItems.length,
      itemBuilder: (context, index) {
        return CoffeeCard(
          name: coffeeItems[index]['name']!,
          price: coffeeItems[index]['price']!,
          image: coffeeItems[index]['image']!,
        );
      },
    );
  }
}

class CoffeeCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;

  CoffeeCard({required this.name, required this.price, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.brown[200],
        child: Column(
          children: [
            Image.network(image, height: 100, width: 100, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    name,
                    style: gf.GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    price,
                    style: gf.GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart, color: Colors.white),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.white),
          label: '',
        ),
      ],
    );
  }
}