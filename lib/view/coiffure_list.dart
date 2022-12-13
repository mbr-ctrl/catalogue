import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:catalogue/view/coiffure_detail.dart';
import 'package:catalogue/view/add_item.dart';
import 'package:catalogue/model/coiffure_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:catalogue/model/coiffure_data.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/coiffure_model.dart';
import '../data.dart';

class CoiffureList extends StatefulWidget {
  const CoiffureList({Key? key}) : super(key: key);

  @override
  State<CoiffureList> createState() => _CoiffureListState();
}

class _CoiffureListState extends State<CoiffureList> {
  //final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var savedData = CoiffureData.coiffureList;
  final Uri toLaunch =
  Uri(scheme: 'https', host: 'www.facebook.com', path: '');

  getSaveData() async {
    var data = await Data.getData();
    setState(() {
      savedData = data;
    });
  }

  @override
  void initState() {
    getSaveData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Catalogue Coiffure',
          style: TextStyle(fontSize: 20),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const AddItem();
                      }
                  )
              );
            },
            icon: const Icon(Icons.add)),
        actions: [
          IconButton(
              onPressed: () {
                _makePhoneCall("+237-697-34-91-79");
              },
              icon: const Icon(Icons.add_call, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              _launchInWebViewOrVC(toLaunch);
            },
            icon: Icon(Icons.facebook, color: Colors.white),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: savedData.length,
        itemBuilder: (BuildContext context, index) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 0.5),
                      blurRadius: 1.0
                  )
                ]
            ),
            child: InkWell(
              onTap: (() =>
              {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            DetailCoiffureScreen(
                              coiffure: savedData[index],
                            )
                    )
                ).then((value) => {
                  getSaveData()
                })
              }
              ),
              child: Row(
                children: [
                  Hero(
                      tag: CoiffureData.coiffureList[index].coiffureName,
                      child: Material(
                        color: Colors.transparent,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            savedData[index].coiffureImage,
                            height: 100,
                            width: 125,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              savedData[index].coiffureName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  fontSize: 16.0
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.monetization_on,
                                    color: Colors.green,
                                    size: 16.0,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewOrVC(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  Future initialisation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getStringList('catalogue');
    if (result != null) {
    }
  }
}

