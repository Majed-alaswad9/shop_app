import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/login_signup/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shop_app/NetWork/Local/cach_helper.dart';
import 'package:lottie/lottie.dart';

class OnBoard {
  final String image;

  OnBoard(this.image);
}

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  var boardController = PageController();
  bool isLast = false;

  List<OnBoard> onboard = [
    OnBoard('https://assets4.lottiefiles.com/packages/lf20_wqepljpj.json'),
    OnBoard('https://assets3.lottiefiles.com/packages/lf20_v92o72md.json'),
    OnBoard('https://assets4.lottiefiles.com/packages/lf20_x5jglqn9.json'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CachHelper.saveData(key: 'onBoarding', value: true)
                    .then((value) {
                  if (value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>  LoginScreen()),
                        (route) => false);
                  }
                });
              },
              child: const Text(
                'Skip',
                style: TextStyle(fontSize: 15),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == 2) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) => itemBuilder(onboard[index]),
                itemCount: 3,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: Colors.blue,
                    dotColor: Colors.grey,
                    dotWidth: 7,
                    dotHeight: 10,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  LoginScreen()),
                          (route) => false);
                    }
                    boardController.nextPage(
                      duration: const Duration(
                        milliseconds: 800,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  child: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemBuilder(OnBoard board) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Lottie.network(
                board.image),
          ),
        ],
      );
}
