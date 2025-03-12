import 'package:flutter/material.dart';

class TravelHomePage extends StatefulWidget {
  const TravelHomePage({Key? key}) : super(key: key);

  @override
  _TravelHomePageState createState() => _TravelHomePageState();
}
class _TravelHomePageState extends State<TravelHomePage>
    with TickerProviderStateMixin {
  late AnimationController _vehicleController;
  late AnimationController _profileController;
  late AnimationController _optionController;
  late AnimationController _containerController;
  late Animation<Offset> _profileAnimation;
  late Animation<Offset> _optionAnimation;
  late Animation<Offset> _containerAnimation;
  late Animation<Offset> _vehicleAnimation;

  @override
  void initState() {
    super.initState();
    _profileController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _profileAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _profileController, curve: Curves.easeOut),
    );
// vehicle animation
    _vehicleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _vehicleAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _vehicleController, curve: Curves.easeOut),
    );

// animation animation
    _optionController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _optionAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _optionController, curve: Curves.easeOut));
    // container
    _containerController =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
    _containerAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _containerController, curve: Curves.easeOut));

    Future.delayed(Duration(seconds: 5), () {
      _optionController.forward();
    });

    Future.delayed(Duration(seconds: 10), () {
      _vehicleController.forward();
    });

    _profileController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _optionController.forward();
      }
    });
    _profileController.forward();
    _optionController.forward();
    _containerController.forward();
    _vehicleController.forward();
  }

  @override
  void dispose() {
    _profileController.dispose();
    _optionController.dispose();
    _containerController.dispose();
    _vehicleController.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        elevation: 0,
        centerTitle: true,
        title: Column(
          children: [
            SlideTransition(
              position: _profileAnimation,
              child: Column(children: [
                Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Happy January',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 0, right: 0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SlideTransition(
                position: _profileAnimation,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.lime,
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "From",
                                style: TextStyle(color: Colors.black),
                              ),
                              Spacer(),
                              Icon(Icons.swap_vert, color: Colors.white),
                            ],
                          ),
                          // CabTextFormField(
                          //   prefixIcon: Icons.search,
                          //   hintText: 'Where to go ?',
                          // ),
                          Divider(color: Colors.white24),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SlideTransition(
                position: _optionAnimation,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 0),
                                  Text(
                                    "Book Now",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    size: 55,
                                  ),
                                  Text(
                                    "Preebooking",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.directions_car,
                                    size: 60,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Rental",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Discount Flights",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "\$300",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "9:00 AM - 4:00 PM",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SlideTransition(
                          position: _vehicleAnimation,
                          child: Center(
                            child: Container(
                                width: 200,
                                height: 100,
                                child: Image.asset(
                                  "assets/image/car_logo_three.png",
                                )),
                          ),
                        ),
                      ],
                    ),
                    // Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SlideTransition(
                position: _containerAnimation,
                child: Row(children: [
                  Expanded(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}





