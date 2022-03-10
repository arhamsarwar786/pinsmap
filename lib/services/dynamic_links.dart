// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:pinsmap/services/auth.dart';
// import 'package:get/get.dart';
// import 'package:pinsmap/src/pages/signInPage.dart';
// import 'package:pinsmap/src/pages/addItemPage.dart';

// class DynamicLinkService {
//   // final AuthService _auth = AuthService();

//   void handleDynamicLinks() async {
//     ///To bring INTO FOREGROUND FROM DYNAMIC LINK.
//     FirebaseDynamicLinks.instance.onLink(
//       onSuccess: (PendingDynamicLinkData? dynamicLinkData) async {
//         await _handleDeepLink(dynamicLinkData);
//       },
//       onError: (OnLinkErrorException e) async {
//         print('DynamicLink Failed: ${e.message}');
//         return e.message;
//       },
//     );

//     final PendingDynamicLinkData? data =
//         await FirebaseDynamicLinks.instance.getInitialLink();
//     _handleDeepLink(data);
//   }

//   // bool _deeplink = true;
//   _handleDeepLink(PendingDynamicLinkData? data) async {
//     final Uri? deeplink = data!.link;
//     if (deeplink != null) {
//       print('Handling Deep Link | deepLink: $deeplink');
//     }
//   }
// }
