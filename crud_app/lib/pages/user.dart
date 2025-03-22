import 'package:crud_app/services/user.dart';
import 'package:crud_app/models/user.dart' as user;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class User extends StatefulWidget {
  const User({Key? key}) : super(key: key);
  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController zipCodeController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User',
              style: TextStyle(
                  color: Colors.blue[800],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Form',
              style: TextStyle(
                  color: Colors.pink[200],
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 20.0,
              ),
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
                    decoration: InputDecoration(labelText: 'Enter First Name')),
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
                    decoration: InputDecoration(labelText: 'Enter Last Name')),
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
                    decoration: InputDecoration(labelText: 'Enter Email')),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                    controller: phoneNumberController,
                    decoration:
                        InputDecoration(labelText: 'Enter Phone Number')),
              ),
              SizedBox(height: 10.0),
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 10.0),
                child: TextFormField(
                    controller: zipCodeController,
                    decoration: InputDecoration(labelText: 'Enter Zip Code')),
              ),
              SizedBox(height: 50.0),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.

                      user.User u = user.User(
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          phoneNumber: phoneNumberController.text,
                          zipCode: zipCodeController.text,
                          id: null);
                      print(u);
                      await UserService.createUser(u).then((value) {
                        Fluttertoast.showToast(
                          msg: 'User added successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      });
                      Navigator.pop(context, true);
                      setState(() {});
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[200]),
                  child: Text(
                    'Add',
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          )),
    );
  }
}
