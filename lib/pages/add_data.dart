import 'dart:async';
import 'dart:ui';

import 'package:api_get_and_post/models/send_data_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  int? sendStatusCode;

  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  OutlineInputBorder borderDesign(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color,
      ),
    );
  }

  late Response response;
  var dio = Dio(BaseOptions(connectTimeout: 500));
  bool? isLoading = false;
  bool? isError = false;

  Future sedData(SendDataModel sendDataModel) async {
    try {
      response = await dio.post('https://reqres.in/api/users',
          data: sendDataModel.toJson());
      sendStatusCode = response.statusCode;
      setState(() {});
      print(response.statusCode);
      isLoading = false;
    } on DioError catch (e) {
      isLoading = true;
      if (e.type == DioErrorType.connectTimeout) {
        setState(() {
          isError = true;
        });
      }

      print(isLoading);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Data To The Server"),
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
              child: Column(
            children: [
              const SizedBox(height: 100),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Name Can't Be Empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "User Name",
                    icon: const Icon(Icons.person, color: Colors.cyan),
                    label: const Text("Name"),
                    focusedBorder: borderDesign(Colors.cyan),
                    errorBorder: borderDesign(Colors.red),
                    enabledBorder: borderDesign(Colors.black),
                    disabledBorder: borderDesign(Colors.black),
                    focusedErrorBorder: borderDesign(Colors.red),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
                child: TextFormField(
                  controller: jobController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Job Can't Be Empty";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    icon: const Icon(Icons.work_outlined, color: Colors.cyan),
                    label: const Text("Job"),
                    hintText: "User Job",
                    focusedErrorBorder: borderDesign(Colors.red),
                    focusedBorder: borderDesign(Colors.cyan),
                    errorBorder: borderDesign(Colors.red),
                    enabledBorder: borderDesign(Colors.black),
                    disabledBorder: borderDesign(Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.cyan)),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              print("Data isn,t Empty");

                              await sedData(SendDataModel(
                                  name: nameController.text,
                                  job: jobController.text));
                              setState(() {});
                            } else {
                              print("Data Is Empty");
                            }
                          },
                          child: const Text("Send"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (isLoading!)
                        const Center(
                          child: CircularProgressIndicator(),
                        )
                      else if (isError!)
                        const Center(
                            child: Text(
                          "Error",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ))
                      else if (sendStatusCode == 201)
                        const Center(
                            child: Text(
                          "Send Successfully ",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ))
                      else if (sendStatusCode == null)
                        const Center(child: Text(""))
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
