import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_screen/sign_in/sign_in.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(248, 220, 251, 255),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: demo_data.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingWidget(
                    image: demo_data[index].image,
                    title: demo_data[index].title,
                    description: demo_data[index].description,
                  ),
                ),
              ),
              Row(
                children: [
                  ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: DotIndicator(
                              isActive: index == _pageIndex,
                            ),
                          )),
                  const Spacer(),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_pageIndex != demo_data.length - 1){
                          _pageController.nextPage(
                            duration: const Duration(
                            microseconds: 300,
                          ),
                          curve: Curves.ease,
                        );
                      } else {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen(),
                        ),
                        );
                      }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          backgroundColor: Color.fromARGB(255, 0, 0, 0)),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              //const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: isActive ? 16 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? Colors.red : Colors.red.withOpacity(0.4),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnBoard {
  final String image, title, description;

  OnBoard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<OnBoard> demo_data = [
  OnBoard(
      image: "asset/page1.png",
      title: "Find the information \nbeen looking for",
      description: "You can find the information aroud you."),
  OnBoard(
      image: "asset/page2.png",
      title: "Get the entertain and fun \nFor yourself",
      description: "Let it bring you to open world."),
  OnBoard(
      image: "asset/page3.png",
      title: "Let get shopping \nbeen looking for",
      description: "You can buy anything you want."),
  OnBoard(
      image: "asset/page4.png",
      title: "Let get shopping \nbeen looking for",
      description: "You can buy anything you want."),
  OnBoard(
      image: "asset/page5.png",
      title: "Let get stated ",
      description: "Come to new vision."),
];

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Spacer(),
      Image.asset(
        image,
        height: 400,
      ),
      const Spacer(),
      Text(
        title,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 20,
          fontWeight: FontWeight.w700,
          fontStyle: FontStyle.normal,
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      const Spacer(),
      Text(
        description,
        textAlign: TextAlign.center,
        style: GoogleFonts.lato(
          textStyle: Theme.of(context).textTheme.displayLarge,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
        ),
      )
    ]);
  }
}
