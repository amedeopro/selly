import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_maps_marker/interactive_maps_marker.dart';

class StoreLocatorPage extends StatefulWidget {
  const StoreLocatorPage({Key? key}) : super(key: key);

  @override
  State<StoreLocatorPage> createState() => _StoreLocatorPageState();
}

class _StoreLocatorPageState extends State<StoreLocatorPage> {

  List<MarkerItem> markers = [];
  InteractiveMapsController controller = InteractiveMapsController();

  @override
  void initState() {
    super.initState();
//    Fake delay for simulating a network request
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        markers.add(MarkerItem(id: 1, latitude: 41.71322406533266, longitude: 13.604050810623676)); //Mondovision
        markers.add(MarkerItem(id: 2, latitude: 41.710573653362594, longitude: 13.603140438480029)); //Sportfly
        /*markers.add(MarkerItem(id: 3, latitude: 31.5325107, longitude: 74.3610325));
        markers.add(MarkerItem(id: 4, latitude: 31.4668809, longitude: 74.31354));*/
        controller.reset(index: 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.grey.shade100,
        elevation: 0,
        centerTitle: false,
        title: Text(
          "SELLY",
          style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w900,
              color: Colors.black),
        ),
        leading: IconButton( // Aggiungi il leading con l'icona per tornare indietro
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.center_focus_strong_outlined, color: Colors.black,),
            onPressed: () {
              setState(() {
                controller.reset(index: 0);
              });
            },
          )
        ],
      ),
      body: InteractiveMapsMarker(
        items: markers,
        controller: controller,
        center: LatLng(41.71888422280121, 13.63564516110873),
        itemContent: (context, index) {
          MarkerItem item = markers[index];
          return BottomTile(item: item);
        },
        onLastItem: () {
          print('Last Item');
        },
      ),
    );
  }
}

class BottomTile extends StatelessWidget {
  const BottomTile({required this.item});

  final MarkerItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(width: 120.0, color: Colors.red),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${item.id == 1 ? 'Mondovision' : item.id == 2 ? 'Sportfly' : item.id}", style: Theme.of(context).textTheme.headline5),
                  //Text("${item.latitude} , ${item.longitude}", style: Theme.of(context).textTheme.caption),
                  Text("${item.id == 1 ? 'Viale S. Domenico, 3/B, 03039 Sora FR' : item.id == 2 ? 'Via Ponte Marziano, 1, 03039 Sora FR' : item.id}", style: Theme.of(context).textTheme.caption),
                  //stars(),
                  Expanded(
                    child: Text('Cras et ante metus. Vivamus dignissim augue sit amet nisi volutpat, vitae tincidunt lacus accumsan. '),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*Row stars() {
    return Row(
      children: <Widget>[
        Icon(Icons.star, color: Colors.orangeAccent),
        Icon(Icons.star, color: Colors.orangeAccent),
        Icon(Icons.star, color: Colors.orangeAccent),
        Icon(Icons.star, color: Colors.orangeAccent),
        Icon(Icons.star_half, color: Colors.orangeAccent),
        SizedBox(width: 3.0),
        Text('4.5', style: TextStyle(color: Colors.orangeAccent, fontSize: 24.0, fontWeight: FontWeight.w600))
      ],
    );
  }*/
}
