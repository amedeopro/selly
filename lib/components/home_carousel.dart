import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

final List<String> imageList = [
  "https://cdn.pixabay.com/photo/2017/12/03/18/04/christmas-balls-2995437_960_720.jpg",
  "https://cdn.pixabay.com/photo/2017/12/13/00/23/christmas-3015776_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/19/10/55/christmas-market-4705877_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/20/00/03/road-4707345_960_720.jpg",
  "https://cdn.pixabay.com/photo/2019/12/22/04/18/x-mas-4711785__340.jpg",
  "https://cdn.pixabay.com/photo/2016/11/22/07/09/spruce-1848543__340.jpg"
];

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      viewportFraction: 1.0,
      autoPlay: true,
      hasPagination: true,
      passiveIndicator: Colors.white,
      activeIndicator: Colors.amber,
      autoPlayAnimationDuration: Duration(seconds: 3),
      //aspectRatio: 2,
      //enlargeMainPage: true,
      items: imageList.map(
        (url) {
          return Container(
            //margin: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child:
                  Image.network(url, fit: BoxFit.cover, width: double.infinity),
            ),
          );
        },
      ).toList(),
      onPageChanged: (index) {
        setState(() {
          index;
        });
      },
    );
  }
}
