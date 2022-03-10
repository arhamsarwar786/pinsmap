import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:pinsmap/src/models/splash.dart';
import 'package:pinsmap/src/components/HomeLayout.dart';
import 'package:pinsmap/src/pages/signInPage.dart';
import 'package:pinsmap/services/admob.dart';
import 'package:firebase_admob/firebase_admob.dart';

// class OnboardPage extends StatefulWidget {
//   final Splash? item;

//   const OnboardPage({Key? key, this.item}) : super(key: key);
//   @override
//   _OnboardPageState createState() => _OnboardPageState();
// }

// class _OnboardPageState extends State<OnboardPage> {

//   adMob _ad = adMob();
//   final _pageController = PageController(
//     initialPage: 0,
//     keepPage: true,
//   );
//   int? _currentPage;

//   _onchanged(int index) => setState(() {
//         _currentPage = index;
//       });

//   @override
//   Widget build(BuildContext context) {

//     FirebaseAdMob.instance
//         .initialize(appId: "ca-app-pub-5741002225942405~5953238132")
//         .then((response) {
//       _ad.myBanner
//         ..load()
//         ..show();
//     });
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
//     );
//     return Scaffold(
//       bottomSheet: Container(
//         // color: Colors.red,
//         padding: EdgeInsets.only(
//           left: 16,
//           right: 16,

//           // bottom: 70,

//           bottom: 100,
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               flex: 3,
//               child: GestureDetector(
//                 onTap: () {
//                   _pageController.jumpToPage(Images.image.length);
//                 },
//                 child: Text(
//                   'Skip',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 16,
//                   ),
//                 ),
//               ),
//             ),
//             // Expanded(
//             //   flex: 3,
//             //   child: Row(
//             //     crossAxisAlignment: CrossAxisAlignment.center,
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       for (var i = 0; i < image.length; i++)
//             //         Padding(
//             //           padding: EdgeInsets.all(4.0),
//             //           child: CircleAvatar(
//             //             radius: 4,
//             //             backgroundColor:
//             //                 _currentPage == i ? Colors.blue : Colors.grey,
//             //           ),
//             //         ),
//             //     ],
//             //   ),
//             // ),
//             Expanded(
//               flex: 3,
//               child: GestureDetector(
//                 onTap: () {
//                   _pageController.nextPage(
//                     duration: Duration(
//                       milliseconds: 200,
//                     ),
//                     curve: Curves.fastOutSlowIn,
//                   );
//                 },
//                 child: (Images.image.length - 1) == _currentPage
//                     ? GestureDetector(
//                         onTap: () {
//                           Get.offAll(() => SignInPage());
//                         },
//                         child: Container(
//                           height: 40,
//                           decoration: BoxDecoration(
//                             color: Color(0xff5857C2),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(60.0)),
//                           ),
//                           child: Center(
//                             child: Text(
//                               'Continue',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         ),
//                       )
//                     : Container(
//                         height: 40,
//                         // width: 100,
//                         decoration: BoxDecoration(
//                           color: Color(0xff5857C2),
//                           borderRadius: BorderRadius.all(Radius.circular(60.0)),
//                         ),
//                         child: Center(
//                           child: Text(
//                             'Next',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 16,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Container(
//         // height: 550,
//         height: 600,
//         // color: Colors.amber,
//         child: Column(

//           children: [
//             Text(Images.image.length.toString()),
//             Expanded(
//               child: PageView.builder(
//                 itemCount: Images.image.length,
//                 physics: BouncingScrollPhysics(),
//                 controller: _pageController,
//                 onPageChanged: _onchanged,
//                 itemBuilder: (BuildContext context, int index) {
//                   final item = Images.image.elementAt(index);
//                   return Stack(

//                     clipBehavior: Clip.none,
//                     children: [
//                       // Positioned(
//                       //   bottom: 100,
//                       //   // bottom:75,
//                       //   left: 0,
//                       //   right: 0,
//                       //   child: Image.asset(
//                       //     '${item.image}',
//                       //     fit: BoxFit.fill,
//                       //   ),
//                       // ),
//                       Container(
//                         alignment: Alignment.bottomCenter,
//                         margin: EdgeInsets.only(bottom: 120),

//                         decoration: BoxDecoration(
//                         // color: Colors.amber,
//                           image: DecorationImage(
//                             image: AssetImage("${item.image}"),
//                             fit: BoxFit.fill,
//                           )
//                         ),

//                       ),

//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(

//                           padding: EdgeInsets.symmetric(
//                             horizontal: 35,
//                           ),
//                           child: Column(
//                             children: [
//                               Text(
//                                 '${item.title}',
//                                 textAlign: TextAlign.center,
//                                 style: TextStyle(
//                                   fontSize: 19.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//             ),

//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for (var i = 0; i < Images.image.length; i++)
//                   Padding(
//                     padding: EdgeInsets.all(4.0),
//                     child: CircleAvatar(
//                       radius: 4,
//                       backgroundColor: _currentPage == i
//                           ? Color(0xff5857C2)
//                           : Color(0xFFBDBDBD),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
////////////////////////////////////////////////
class OnboardPage extends StatefulWidget {
  final Splash? item;

  const OnboardPage({Key? key, this.item}) : super(key: key);
  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  adMob _ad = adMob();
  final _pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );
  int? _currentPage;

  _onchanged(int index) => setState(() {
        _currentPage = index;
      });
  @override
   _deviceOrientation(){
      SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
   }
   @override
void initState(){
  super.initState();
 _deviceOrientation();
}
@override
dispose(){
 _deviceOrientation();
  super.dispose();
}

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
 FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5741002225942405~5953238132")
        .then((response) {
      _ad.myBanner
        ..load()
        ..show();
    });
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );
    return Scaffold(
      
      body: PageView.builder(
        itemCount: Images.image.length,
        physics: BouncingScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onchanged,
        itemBuilder: (BuildContext context, int index) {
          final item = Images.image.elementAt(index);
          return SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: size.height*0.62,
                  

                     

                      decoration: BoxDecoration(
                          // color: Colors.amber,
                          image: DecorationImage(
                            image: AssetImage("${item.image}"),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 35,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '${item.title}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 19.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < Images.image.length; i++)
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: _currentPage == i
                                  ? Color(0xff5857C2)
                                  : Color(0xFFBDBDBD),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              
                bottomButton(size),
               
              ],
            ),
          );
        },
      ),
    );
  }

  Widget bottomButton(size) {
    return Container(

      margin: EdgeInsets.only(top:size.height*0.82 ,  bottom: 10,),
      
      padding: EdgeInsets.only(
        left: size.width*0.044,
        right:size.width*0.044,
      
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                _pageController.jumpToPage(Images.image.length);
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GestureDetector(
              onTap: () {
                _pageController.nextPage(
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  curve: Curves.fastOutSlowIn,
                );
              },
              child: (Images.image.length - 1) == _currentPage
                  ? GestureDetector(
                      onTap: () {
                        Get.offAll(() => SignInPage());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xff5857C2),
                          borderRadius: BorderRadius.all(Radius.circular(60.0)),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      height: 40,
                      // width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xff5857C2),
                        borderRadius: BorderRadius.all(Radius.circular(60.0)),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
