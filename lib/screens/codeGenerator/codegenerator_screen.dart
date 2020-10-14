import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class CodeGenerator extends StatefulWidget {
  CodeGenerator({Key key}) : super(key: key);

  @override
  _CodeGeneratorState createState() => _CodeGeneratorState();
}

class _CodeGeneratorState extends State<CodeGenerator> {
  TextEditingController codeController =
      TextEditingController(text: '460123456000010');
  int value = 1;
  int maxLength = 15;
  Barcode barcodeType = Barcode.code128();
  Size boxSize = Size(300, 100);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                  child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Тип штрихкода'),
                  SizedBox(
                    height: 16,
                  ),
                  RadioListTile(
                    value: 1,
                    title: Text('SSCC код'),
                    groupValue: value,
                    onChanged: (val) => setCodeType(val),
                    subtitle: Text('длина кода: 15'),
                  ),
                  RadioListTile(
                    value: 2,
                    title: Text('EAN код'),
                    groupValue: value,
                    onChanged: (val) => setCodeType(val),
                    subtitle: Text('длина кода: 13'),
                  ),
                  RadioListTile(
                    value: 3,
                    title: Text('Datamatrix код'),
                    groupValue: value,
                    onChanged: (val) => setCodeType(val),
                  ),
                  RadioListTile(
                    value: 4,
                    title: Text('Упаковочный лист'),
                    groupValue: value,
                    onChanged: (val) => setCodeType(val),
                    subtitle: Text('длина кода: 11'),
                  ),
                ],
              )),
            ),
            Expanded(
              child: Container(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Штрих-код',
                      ),
                      controller: codeController,
                      maxLength: maxLength,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    BarcodeWidget(
                      barcode: barcodeType, // Barcode type and settings
                      data: codeController.text, // Content
                      width: boxSize.width,
                      height: boxSize.height,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    RaisedButton(
                      onPressed: () => setState(() {}),
                       color: Color(0xff5580C1),
                                      shape: Border.all(
                                          width: 0, style: BorderStyle.none),
                      child: Text("Обновить", style: TextStyle(color: Colors.white),),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  setCodeType(int val) {
    switch (val) {
      case 1: //SSCC
        codeController.text = '460123456000010';
        barcodeType = Barcode.code128();
        boxSize = Size(300, 100);
        maxLength = 15;
        break;
      case 2: //EAN
        codeController.text = '4601234560000';
        barcodeType = Barcode.code128();
        boxSize = Size(300, 100);
        maxLength = 13;
        break;
      case 3: //Datamatrix
        codeController.text = '201034531200000111719112510ABCD1234';
        barcodeType = Barcode.dataMatrix();
        boxSize = Size(200, 200);
        maxLength = null;
        break;
      case 4: //Упак. лист
        codeController.text = '46012345600';
        barcodeType = Barcode.code128();
        boxSize = Size(300, 100);
        maxLength = 11;
        break;
      default:
    }
    setState(() {
      value = val;
    });
  }
}
