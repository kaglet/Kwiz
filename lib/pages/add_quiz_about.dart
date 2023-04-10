// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:kwiz/pages/add_questions.dart';
import 'package:kwiz/classes/qa_container.dart';
import 'package:kwiz/pages/home.dart';
import 'package:kwiz/pages/profile.dart';
import 'package:kwiz/services/database.dart';

class AddQuiz extends StatefulWidget {
  final _aboutQuizController = TextEditingController();
  final _categoryController = TextEditingController();
  final _titleController = TextEditingController();

  AddQuiz({super.key});
  @override
  State<AddQuiz> createState() => AddQuizState();
}

class AddQuizState extends State<AddQuiz> {
  List<QAContainer> qaContainers = [];
  List<String>? categories = [];
  String? _selectedCategory = 'Art';
  DatabaseService service = DatabaseService();
  int currentIndex = 0;

  // screens for stacked widget
  final List screens = [Home(), Profile()];

  late bool _isLoading;

  // before obtaining category data from database, add loading screen
  // after obtaining category data from database, set loading to false
  Future<void> loaddata() async {
    setState(() {
      _isLoading = true;
    });
    List? categoriesDynamic = await service.getCategories();
    categories = categoriesDynamic?.map((e) => e.toString()).toList();
    setState(() {
      _isLoading = false;
    });
  }

  // load category data on screen initialization
  @override
  void initState() {
    loaddata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // if isLoading is true, return nothing else if isLoading is false display appbar
      appBar: _isLoading
          ? null
          : AppBar(
              title: const Text(
                'Quiz Creator',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                  fontFamily: 'TitanOne',
                ),
              ),
              backgroundColor: Color.fromARGB(255, 27, 57, 82),
              actions: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  },
                ),
              ],
            ),
      // prevent renderflex overflow error just in case
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 27, 57, 82),
              Color.fromARGB(255, 5, 12, 31),
            ],
          ),
        ),
        // if isLoading is false, display circular progress widget for loading screen else display child of body
        child: SafeArea(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              //after data is loaded this displays
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Card(
                        margin: EdgeInsets.fromLTRB(10.0, 16.0, 16.0, 0),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(255, 45, 64, 96),
                                Color.fromARGB(255, 45, 64, 96),
                              ],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                TextField(
                                  controller: widget._titleController,
                                  decoration: InputDecoration(
                                    hintText: 'Add Title',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextField(
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Nunito',
                                  ),
                                  controller: widget._aboutQuizController,
                                  minLines: 5,
                                  maxLines: 5,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    labelText: 'About',
                                    labelStyle: TextStyle(
                                      fontFamily: 'Nonita',
                                      color: Colors.grey,
                                    ),
                                    hintText: 'About',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Nonita',
                                      color: Colors.grey,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.0,
                                ),
                                DropdownButtonFormField<String>(
                                  value: _selectedCategory,
                                  decoration: InputDecoration(
                                    hintText: 'Select a Category',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Nunito',
                                  ),
                                  items: categories
                                      ?.map((category) =>
                                          DropdownMenuItem<String>(
                                            value: category,
                                            child: Text(category),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 60.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Colors.orange, Colors.deepOrange],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddQuestions(
                                      aboutQuiz:
                                          widget._aboutQuizController.text,
                                      category: widget._categoryController.text,
                                      title: widget._titleController.text)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            padding: const EdgeInsets.all(16.0),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Begin adding questions',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
      // bottomNavigationBar: _isLoading
      //     ? null
      //     : ClipRRect(
      //         borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20.0),
      //           topRight: Radius.circular(20.0),
      //         ),
      //         child: BottomNavigationBar(
      //             type: BottomNavigationBarType.fixed,
      //             currentIndex: currentIndex,
      //             selectedItemColor: Colors.white,
      //             unselectedItemColor: Colors.white,

      //             // iconSize: 40,
      //             // selectedFontSize: ,
      //             // unselectedFontSize: ,
      //             showUnselectedLabels: false,
      //             showSelectedLabels: false,
      //             backgroundColor: Colors.grey[
      //                 600], // toggle off and bring back individual backgrounds for shifting
      //             onTap: (index) {
      //               setState(() {
      //                 currentIndex = index;
      //                 Navigator.push(
      //                   context,
      //                   MaterialPageRoute(builder: (context) => Home()),
      //                 );
      //               });
      //             },
      //             items: [
      //               BottomNavigationBarItem(
      //                 icon: Icon(
      //                   Icons.home,
      //                 ),
      //                 label: 'Home',
      //                 // backgroundColor: Colors.grey,
      //               ),
      //               BottomNavigationBarItem(
      //                 icon: Icon(Icons.person),
      //                 label: 'Profile',
      //                 // backgroundColor: Colors.grey,
      //               ),
      //             ]),
      //       ),
    );
  }
}

// class MyButton extends StatelessWidget {
//   const MyButton({super.key});

//   MyButton({required this.color, this.text});
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

// create custom button class since all have the same property
// Think in terms of flexbox don't forget everything there. The space works very well with flex properties, to make empty space in a container when padding is too hard.
// spacing is also very customizable.
