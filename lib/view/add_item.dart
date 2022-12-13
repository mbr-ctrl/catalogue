import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:catalogue/model/coiffure_model.dart';
import '../data.dart';

class AddItem extends StatefulWidget {
  final index;
  final value;
  const AddItem({Key? key, this.index, this.value}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  _AddItemState({Key? key, this.index, this.value}) : super();
  final index;
  final value;
  final TextEditingController _coiffureName = TextEditingController();
  TextEditingController _coiffureDescription = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var _coiffureImage;
  var _image;


  isDataValid() {
    if (_coiffureName.text.isEmpty) {
      return false;
    }

    if (_coiffureDescription.text.isEmpty) {
      return false;
    }
    if (_image == null) {
      return false;
    }
    return true;
  }

  getData() {
    if(index != null && value != null) {
      setState(() {
        _coiffureName.text = value['_coiffureName'];
        _coiffureDescription.text = value['_coiffureDescription'];
        _coiffureImage.path = value['_coiffureImage'];

      });
    }
  }

  saveData() async {
    if (isDataValid()) {
      var catlog = {
        'coiffureName': _coiffureName.text,
        'coiffureDescription': _coiffureDescription.text,
        'coiffureImage': _coiffureImage.path
      };

      var savedData = await Data.getData();

      if(index == null) {
        savedData.insert(0, catlog);
      } else {
        savedData[index] = catlog;
      }
      await Data.saveData(savedData);
      Navigator.pop(context);

    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Aucun champs ne doit etre vide'),
              content: const Text('Revoyez les champs de saisie'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK')
                )
              ],
            );
          }
      );
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout d'un Model de Coiffure"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(
              height: 200 ,
              child: _image == null ?
              const Center(child: Text("Aucune image sélectionnée")) :
              Center(child: Image.file(_image.path)),
            ),
            TextFormField(
              controller: _coiffureName,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal,
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2
                  )
                ),
                labelText: "Nom de la coiffure",
                helperText: "Le champs ne doit pas etre vide"
              ),
            ),
            const SizedBox(height: 20,),
            TextFormField(
              controller: _coiffureDescription,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.teal
                  )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.orange,
                    width: 2
                  )
                ),
                labelText: "Description",
                helperText: "Description"
              ),
            ),
            const SizedBox(height: 30,),
            ElevatedButton(
              onPressed: getImage,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  primary: Colors.purple),
              child: const Text(
                "Ajouter une image",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            // Spacing
            Container(height: 20.0),
            ElevatedButton(
              onPressed: saveData,
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  primary: Colors.purple),
              child: const Text(
                "Valider",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
    
  }

  Future getImage() async {
    _coiffureImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
        _image = _coiffureImage!.path;
    });
  }

  void onAdd() {
    CoiffureModel modelCoiffure = CoiffureModel(
        coiffureName: _coiffureName.text,
        coiffureDescription: _coiffureDescription.text,
        coiffureImage: _coiffureImage.path.toString()
    );

  }

}
