import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_walet/Widgets/back_button.dart';
import 'package:card_walet/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:dotted_border/dotted_border.dart';

class AddCard extends StatefulWidget {

  const AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {

  final name = TextEditingController();
  final collection = TextEditingController();
  final mobile = TextEditingController();
  final singUpDate = TextEditingController();
  final city = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final ImagePicker _picker = ImagePicker();

  PickedFile? _imageFile;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  void _pickImage() async {
    try {
      final pickedFile = await _picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      setState(() {
        _imageFile = pickedFile!;
      });
    } catch (e) {
      print("Image picker error " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF6F6F6),
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: CustomBackButton(),
        title: Text("Add New Card",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20),
              physics: ScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Card Image",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    SizedBox(height: 5,),
                    Stack(
                      fit: StackFit.loose,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            _pickImage();
                          },
                          child: Container(
                            width: double.infinity,
                            height: 100,
                            child: DottedBorder(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image),
                                    RichText(
                                        text: TextSpan(
                                            text: 'Drop Your Card Image Here or',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize:13.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: ' Click to Browse',
                                                  style: TextStyle(
                                                    color: Colors.blue,
                                                    fontSize:13.0,
                                                    fontWeight: FontWeight.bold,
                                                  )),

                                            ])),
                                    Text("1600 x 1200 (4:3) recommended. Up to 2MB",style: TextStyle(fontSize: 12),)
                                  ],
                                ),
                              ),
                              borderType: BorderType.RRect,
                              radius: Radius.circular(10),
                              dashPattern: [10,5,10,5,10,5],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),

                    Text("Card Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    SizedBox(
                      height: 5,
                    ),
                    RichText(
                        text: TextSpan(
                            text: 'Player Name',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize:15.0,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                  text: ' *',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize:15.0,
                                    fontWeight: FontWeight.bold,
                                  )),

                            ])),

                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: const Offset(5, 10),
                          ),
                        ],
                        // boxShadow: kElevationToShadow[1],
                      ),
                      child: AppTextField(
                        controller: name, // Optional
                        textFieldType: TextFieldType.NAME,
                        textInputAction: TextInputAction.next,
                        isValidationRequired: true,
                        textStyle: TextStyle(
                            fontSize: 15,
                            // fontFamily: Ams.questrial,
                            color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: 'Player Name',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: Ams.questrial,
                              color: Colors.grey),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: Colors.white ),
                          ),
                          filled: true,
                          fillColor: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Spot",style: TextStyle(
                                color: Colors.black,
                                fontSize:15.0,
                                fontWeight: FontWeight.bold,
                              ),),
                              Container(
                                width: MediaQuery.of(context).size.width*.43,
                                child: DecoratedBox(
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shadows: [BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 20.0,
                                    )],
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.white),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    elevation: 16,
                                    borderRadius: BorderRadius.circular(5),
                                    underline: SizedBox(),
                                    items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              )                              ],
                          ),
                          SizedBox(width: 5,),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Spot",style: TextStyle(
                                color: Colors.black,
                                fontSize:15.0,
                                fontWeight: FontWeight.bold,
                              ),),
                              Container(
                                width: MediaQuery.of(context).size.width*.43,
                                child: DecoratedBox(
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shadows: [BoxShadow(
                                      color: Colors.black54,
                                      offset: Offset(5.0, 10.0),
                                      blurRadius: 20.0,
                                    )],
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.0, style: BorderStyle.solid, color: Colors.white),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                  ),
                                  child: DropdownButton<String>(
                                    elevation: 16,
                                    borderRadius: BorderRadius.circular(5),
                                    underline: SizedBox(),
                                    items: <String>['A', 'B', 'C', 'D'].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (_) {},
                                  ),
                                ),
                              )                              ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Text("Collection",style: TextStyle(
                      color: Colors.black,
                      fontSize:15.0,
                      fontWeight: FontWeight.bold,
                    ),),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: const Offset(5, 10),
                          ),
                        ],
                        // boxShadow: kElevationToShadow[1],
                      ),
                      child: AppTextField(
                        controller: collection, // Optional
                        textFieldType: TextFieldType.OTHER,
                        textInputAction: TextInputAction.done,
                        isValidationRequired: true,
                        textStyle: TextStyle(
                            fontSize: 15,
                            // fontFamily: Ams.questrial,
                            color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: 'Collection Name',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: Ams.questrial,
                              color: Colors.grey),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: Colors.white ),
                          ),                          filled: true,
                          fillColor: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Base/Insert",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize:15.0,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: const Offset(5, 10),
                          ),
                        ],
                        // boxShadow: kElevationToShadow[1],
                      ),
                      child: AppTextField(
                        controller: mobile, // Optional
                        textFieldType: TextFieldType.PHONE,
                        readOnly: true,
                        textStyle: TextStyle(
                            fontSize: 15,
                            // fontFamily: Ams.questrial,
                            color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: 'Base/Insert',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: Ams.questrial,
                              color: Colors.grey),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: Colors.white ),
                          ),
                          filled: true,
                          fillColor: Color(0xffFFFFFF),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Buying Price",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 10,
                            offset: const Offset(5, 10),
                          ),
                        ],
                        // boxShadow: kElevationToShadow[1],
                      ),
                      child: AppTextField(
                        controller: singUpDate, // Optional
                        textFieldType: TextFieldType.OTHER,
                        readOnly: true,
                        textStyle: TextStyle(
                            fontSize: 15,
                            // fontFamily: Ams.questrial,
                            color: Colors.grey),
                        decoration: InputDecoration(
                          hintText: 'Buying Price',
                          hintStyle: TextStyle(
                              fontSize: 15,
                              // fontFamily: Ams.questrial,
                              color: Colors.grey),
                          enabledBorder: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(5.0),
                            borderSide:  BorderSide(color: Colors.white ),
                          ),                          filled: true,
                          fillColor: Color(0xffFFFFFF),
                        ),
                      ),
                    ),


                    Padding(
                      padding:
                      EdgeInsets.only(left: 25.0, right: 25.0, top: 35.0),
                      child: Container(
                          width: double.infinity,
                          child: RaisedButton(
                            child: Text("Add Card To Collection"),
                            textColor: Colors.white,
                            color: mainColor,
                            onPressed: () async {
                              setState(() {
                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              });

                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
