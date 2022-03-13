import 'package:api_service/model/json_model.dart';
import 'package:api_service/service/service.dart';
import 'package:flutter/material.dart';
import 'package:grock/grock.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Grock.navigationKey,
      scaffoldMessengerKey: Grock.snackbarMessengerKey,
      title: 'Material App',
      home: home(),
    );
  }
}

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Service service = Service();

  String data = "veri";
  String url = "https://reqres.in/api/unknown/23";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GrockContainer(
              onTap: () {
                service
                    .get(
                  url: url,
                  fromJson: (type) => JsonModel.fromJson(type),
                )
                    .then((value) {
                  setState(() {
                    data = value.data?.email?.toString() ?? "";
                  });
                });
              },
              padding: [20, 10].horizontalAndVerticalP,
              color: Colors.lightBlue,
              child: const Text("Get Data"),
            ),
            Text(data),
          ],
        ),
      ),
    );
  }
}
