import 'package:crud_app/services/user.dart';
import 'package:crud_app/pages/user.dart';
import 'package:crud_app/models/user.dart' as user;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Widget allUsersDetails() {
    return FutureBuilder(
      future: UserService.getUsers(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              var user = snapshot.data[index];
              return Container(
                margin: EdgeInsets.only(bottom: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 21, 101, 192)),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              user.firstName + ' ' + user.lastName,
                              style: TextStyle(
                                  color: Colors.blue[800],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            GestureDetector(
                                onTap: () => {
                                      firstNameController.text = user.firstName,
                                      lastNameController.text = user.lastName,
                                      emailController.text = user.email,
                                      phoneNumberController.text =
                                          user.phoneNumber,
                                      zipCodeController.text = user.zipCode,
                                      EditUserDetail(user.id)
                                    },
                                child: Icon(Icons.edit,
                                    color: Colors.pinkAccent[100])),
                            SizedBox(width: 10.0),
                            GestureDetector(
                                onTap: () => {
                                      UserService.deleteUser(user.id),
                                      setState(() {})
                                    },
                                child: Icon(Icons.delete, color: Colors.grey)),
                          ],
                        ),
                        Text(
                          'Email: ' + user.email,
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => User(),
                )).then((value) {
              setState(() {});
            });
          },
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.pinkAccent[100],
        ),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flutter',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                'Demo',
                style: TextStyle(
                    color: Colors.pinkAccent[100],
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          child: Column(
            children: [
              Expanded(child: allUsersDetails()),
            ],
          ),
        ));
  }

  final _formKey = GlobalKey<FormState>();
  String? firstNameErrMsg;
  String? lastNameErrMsg;
  String? emailNameErrMsg;

  Future EditUserDetail(num id) => showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            content: Form(
                key: _formKey,
                child: Container(
                  width: MediaQuery.of(context).size.width * 2,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel, color: Colors.red),
                        ),
                        SizedBox(width: 60.0),
                      ]),
                      SizedBox(height: 20.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please fill first name';
                              }
                              return null;
                            },
                            controller: firstNameController,
                            decoration:
                                InputDecoration(labelText: 'Enter First Name')),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please fill last name';
                              }
                              return null;
                            },
                            controller: lastNameController,
                            decoration:
                                InputDecoration(labelText: 'Enter Last Name')),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please fill email';
                              }
                              return null;
                            },
                            controller: emailController,
                            decoration:
                                InputDecoration(labelText: 'Enter Email')),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                            controller: phoneNumberController,
                            decoration: InputDecoration(
                                labelText: 'Enter Phone Number')),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        padding: EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                            controller: zipCodeController,
                            decoration:
                                InputDecoration(labelText: 'Enter Zip Code')),
                      ),
                      SizedBox(height: 30.0),
                      Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  user.User u = user.User(
                                      id: id,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text,
                                      email: emailController.text,
                                      phoneNumber: phoneNumberController.text,
                                      zipCode: zipCodeController.text);
                                  await UserService.updateUser(u).then((value) {
                                    setState(() {});
                                    Navigator.pop(context);
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pinkAccent[100]),
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )))
                    ],
                  ),
                )),
          )));
}
