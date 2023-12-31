import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project_second/Pages/favourite_page.dart';
import 'package:project_second/Pages/home_page.dart';
import 'package:project_second/Pages/show_page.dart';

class ShowCommercial extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ShowCommercial> {
  List CCommercial = [];
  bool isloading = true;

  int currentIndex = 0; // Add a default value

  void getResdintiall() async {
    CollectionReference tblProduct =
        FirebaseFirestore.instance.collection('commercialProperty');
    await Future.delayed(Duration(seconds: 2));
    await tblProduct.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> store = doc.data() as Map<String, dynamic>;
        store['documentId'] = doc.id;
        CCommercial.add(store);
      });

      isloading = false;
      setState(() {});
    });
  }

  @override
  void initState() {
    getResdintiall();
    super.initState();
  }

  // Dummy _changeItem method, replace it with your logic
  // void _changeItem(int index) {
  //   setState(() {
  //     currentIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 20.0, left: 8.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Color.fromRGBO(118, 165, 209, 1),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    },
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontFamily: "Inria Serif" ,),
                      hintText: 'Search',
                      icon: Icon(Icons.search),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Expanded(
                  child: ListView.builder(
                    itemCount: CCommercial.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SingleProperty(
                                    data: CCommercial[index],
                                  ),
                                ));
                        
                        },
                        child: Container(
                          padding: EdgeInsets.all(2),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(2),
                                width: double.infinity,
                                color: Colors.grey[200],
                                child: Image.network(
                                  '${CCommercial[index]['image']}',
                                  height: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                      '${CCommercial[index]['propertyType']}' ,
                                            style: TextStyle(
                                              fontFamily: "Inria Serif" ,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          '${CCommercial[index]['propertyAdress']}',
                                          style: TextStyle(fontSize: 13,fontFamily: "Inria Serif" ,),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            "starting from ",
                                            style: TextStyle(fontSize: 13 ,fontFamily: "Inria Serif" ,),
                                          ),
                                        ),
                                        Text(
                                          '${CCommercial[index]['propertyPrice']} \$',
                                          style: TextStyle(fontFamily: "Inria Serif" ,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 13, 71, 119)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
