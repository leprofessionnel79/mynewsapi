import 'package:flutter/material.dart';
import 'package:newsapp/screens/entry.dart';
import 'package:newsapp/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../page_view_model.dart';
import 'package:page_view_indicator/page_view_indicator.dart';

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<PageViewModel> pages;

  ValueNotifier<int> _pagenotifier = ValueNotifier(0);

  void addPages() {
    // ignore: deprecated_member_use
    pages = List<PageViewModel>();

    pages.add(PageViewModel(
        decription: "1 - global news app sharing news from my api",
        icons: Icons.ac_unit,
        images: 'assets/images/bg1.jpg',
        title: 'Page 1'));
    pages.add(PageViewModel(
        decription: "2 - global news app sharing news from my api",
        icons: Icons.map,
        images: 'assets/images/bg2.jpg',
        title: 'Page 2'));
    pages.add(PageViewModel(
        decription: "3 - global news app sharing news from my api",
        icons: Icons.airline_seat_flat,
        images: 'assets/images/bg3.jpg',
        title: 'Page 3'));
    pages.add(PageViewModel(
        decription: "4 - global news app sharing news from my api",
        icons: Icons.access_alarm,
        images: 'assets/images/bg4.jpg',
        title: 'Page 4'));
  }

  @override
  Widget build(BuildContext context) {
    addPages();

    return Stack(
      children: [
        Scaffold(
          body: PageView.builder(
            itemCount: pages.length,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: ExactAssetImage(pages[index].images),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                      50,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Transform.translate(
                          offset: Offset(0, -80),
                          child: Icon(
                            pages[index].icons,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          pages[index].title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          pages[index].decription,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        // Transform.translate(
                        //   offset: Offset(0, 80),
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     child: _drawPageIndicators(pages.length),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              );
            },
            onPageChanged: (index) {
              _pagenotifier.value = index;
            },
          ),
        ),
        // ignore: deprecated_member_use
        Transform.translate(
          offset: Offset(0, 170),
          child: Container(
            alignment: Alignment.center,
            child: _drawPageIndicators(pages.length),
          ),
        ),
        Align(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 17),
            // ignore: deprecated_member_use
            child: Container(
              height: 50,
              width: 300,
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    updateSeen();
                    return Entry();
                  }));
                },
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      letterSpacing: 2.3),
                ),
                color: Colors.red[800],
              ),
            ),
          ),
          alignment: Alignment.bottomCenter,
        )
      ],
    );
  }

  Widget _drawPageIndicators(int length) {
    return PageViewIndicator(
      pageIndexNotifier: _pagenotifier,
      length: length,
      normalBuilder: (animationController, index) => Circle(
        size: 10.0,
        color: Colors.grey,
      ),
      highlightedBuilder: (animationController, index) => ScaleTransition(
        scale: CurvedAnimation(
          parent: animationController,
          curve: Curves.ease,
        ),
        child: Circle(
          size: 14.0,
          color: Colors.red[800],
        ),
      ),
    );
  }

  void updateSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
  }
}
