import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';

class adMob {
  
static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: <String>[],
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );
// adUnitId: 'ca-app-pub-5741002225942405/5761666449',

  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-5741002225942405/5761666449",
    size:AdSize.fullBanner,
    
    
 
    targetingInfo:targetingInfo,
    listener: (MobileAdEvent event) {
      print('BannerAd event $event');
      
    },
    
    
  );
  
// final AdListener listener = AdListener(
//  // Called when an ad is successfully received.
//  onAdLoaded: (Ad ad) => print('Ad loaded.'),
//  // Called when an ad request failed.
//  onAdFailedToLoad: (Ad ad, LoadAdError error) {
//    print('Ad failed to load: $error');
//  },
//  // Called when an ad opens an overlay that covers the screen.
//  onAdOpened: (Ad ad) => print('Ad opened.'),
//  // Called when an ad removes an overlay that covers the screen.
//  onAdClosed: (Ad ad) => print('Ad closed.'),
//  // Called when an ad is in the process of leaving the application.
//  onApplicationExit: (Ad ad) => print('Left application.'),
// )

}
