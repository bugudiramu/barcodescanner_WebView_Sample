import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String res = "";

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Scanner"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: width,
              child: MaterialButton(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Scan QR Code",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                color: Colors.redAccent,
                onPressed: () async {
                  res = await FlutterBarcodeScanner.scanBarcode(
                    "#1A237E",
                    "Cancel",
                    true,
                  );
                  setState(() {});
                },
              ),
            ),
            SizedBox(height: 15.0),
            InkWell(
              onTap: () => launchUrl(res),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "$res",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              width: width,
              child: MaterialButton(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Launch WebView",
                  style: TextStyle(color: Colors.white, fontSize: 22.0),
                ),
                color: Colors.redAccent,
                onPressed: () => launchWebView("https://github.com/bugudiramu"),
                // onPressed: () => launchWebView(res),
              ),
            ),
          ],
        ),
      ),
    );
  }

  launchUrl(String resUrl) async {
    var url = resUrl;
    // **** open the link in the default browser when link is clicked ****
    if (await canLaunch("$url")) {
      await launch("$url");
    } else {
      Exception("URL doesn't exist");
    }
  }

  launchWebView(String resUrl) async {
    var url = resUrl;
    // **** open the link in Webview when Webview button is clicked is clicked ****
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}
