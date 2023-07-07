import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:food_app/food_model.dart';

void main() {
  runApp(const MyFood());
}

class MyFood extends StatelessWidget {
  const MyFood({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late PageController _pageController;
  final List<FoodModel> _foodlist = foodList;

  double get _currenOfsett {
    bool inited = _pageController.hasClients &&
        _pageController.position.hasContentDimensions;
    return inited ? _pageController.page! : _pageController.initialPage * 1.0;
  }

  int get _currentIndex => _currenOfsett.round() % _foodlist.length;

  @override
  void initState() {
    _pageController = PageController(
        initialPage: _foodlist.length * 9999); // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          return _buildScreen();
        },
      ),
    );
  }

  Stack _buildScreen() {
    final Size size = MediaQuery.of(context).size;
    final FoodModel _currentFood = _foodlist[_currentIndex];
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: -size.width * 0.6,
          child: BgImage(
            currentIndex: _currentIndex,
            food: _currentFood,
            PageOffset: _currenOfsett,
          ),
        ),
        SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _currentFood.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "\$${_currentFood.price}",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.normal,
                  color: Colors.pink),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.3,
                    vertical: size.height * 0.003,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )),
              onPressed: () {},
              child: Text(
                "add to cart",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "swipe to see recipes",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ],
        )),
        Center(
          child: SizedBox(
            height: size.width,
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (contex, index) {
                double _value = 0.0;
                double vp = 1;
                double scale = max(vp, (_currenOfsett - index).abs());
                if (_pageController.position.haveDimensions) {
                  _value = index.toDouble() - (_pageController.page ?? 0);
                  _value = (_value - 0.7).clamp(-1, 1);
                }
                return Transform.rotate(
                  angle: pi * _value,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 200 - scale * 5),
                    child: FittedBox(
                        child: Image.asset(
                            _foodlist[index % _foodlist.length].image,
                            fit: BoxFit.cover)),
                  ),
                ); //infinity scroll
              },
            ),
          ),
        ),
      ],
    );
  }
}

class BgImage extends StatefulWidget {
  const BgImage(
      {super.key,
      required this.currentIndex,
      required this.food,
      required this.PageOffset});
  final int currentIndex;
  final FoodModel food;
  final double PageOffset;
  @override
  State<BgImage> createState() => _BgImageState();
}

class _BgImageState extends State<BgImage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    double _value = 0.0;
    _value = (widget.PageOffset - widget.currentIndex).abs();
    return Opacity(
      opacity: 0.8,
      child: Transform.rotate(
        angle: pi * _value +
            pi /
                180, //0 olunca resmin stabıl hali fakat pi* lı yapınca fotografı dondurunce arkada ki foto da donuor
        child: SizedBox(
          width: size.width * 1.4,
          height: size.width * 1.4,
          child: Image.asset(
            widget.food.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
