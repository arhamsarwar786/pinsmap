class Splash {
  String? image;
  String? title;

  Splash({
    required this.image,
    required this.title,
  });
}

class Images {
  static final image = [
    Splash(
        image: 'assets/onb1.png',
        title: 'Save Your Favorite Locations as Easy as You save Contacts'),
    Splash(
        image: 'assets/onb2.png',
        title:
            'Search for Your Saved Location then one Swipe Right and you are in Driving Mode'),
    Splash(image: 'assets/onb3.png', title: 'Share With Your Friends'),
  ];
}
