import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../models/get_data_model.dart';

class GetUsersPage extends StatefulWidget {
  const GetUsersPage({Key? key}) : super(key: key);

  @override
  State<GetUsersPage> createState() => _GetUsersPageState();
}

class _GetUsersPageState extends State<GetUsersPage> {
  late Response response;
  var dio = Dio(BaseOptions(connectTimeout: 4000));
  late GetUsers getUsers;

  Future<GetUsers> getData() async {
    try {
      response = await dio.get('https://reqres.in/api/users');
      print(response.data);
      print(response.statusCode);
      getUsers = GetUsers.fromJson(response.data);
    } catch (e) {
      print(e);
    }
    return getUsers;
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get Users From API"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_outlined),
            onPressed: () {
              setState(() {});
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: getUsers.myData!.length,
                  itemBuilder: (context, index) {
                    return SafeArea(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 35.5,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.7),
                                  child: CircleAvatar(
                                      radius: 33.5,
                                      backgroundImage: NetworkImage(
                                          getUsers.myData![index].avatar!)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${getUsers.myData![index].firstName} ${getUsers.myData![index].lastName}  ",
                                  style: const TextStyle(fontSize: 17),
                                ),
                              ),
                              Text(
                                getUsers.myData![index].email!,
                                style: TextStyle(
                                    fontSize: 10.5,
                                    color: Colors.black.withOpacity(0.5)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                        ],
                      ),
                    );
                  })
              : snapshot.hasError
                  ? Center(
                      child: Text("Error...",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.5))),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
        },
      ),
    );
  }
}
