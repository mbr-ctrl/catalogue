import 'package:flutter/material.dart';
import 'package:catalogue/model/coiffure_model.dart';

class DetailCoiffureScreen extends StatefulWidget {
  final CoiffureModel coiffure;
  const DetailCoiffureScreen({super.key, required this.coiffure});

  @override
  State<DetailCoiffureScreen> createState() => _DetailCoiffureScreenState();
}

class _DetailCoiffureScreenState extends State<DetailCoiffureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.coiffure.coiffureName,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
                tag: widget.coiffure.coiffureName,
                child: Material(
                  color: Colors.transparent,
                  child: Image.asset(
                    widget.coiffure.coiffureImage,
                    height: MediaQuery.of(context).size.height*2/3,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                  ),
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
              child: Text(
                widget.coiffure.coiffureName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
              child: Text(
                widget.coiffure.coiffureDescription,
                style: const TextStyle(
                    fontSize: 18
                ),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      );
  }
}
