import 'package:flutter/material.dart';
import 'package:kwiz/pages/viewquizzes/view_quizzes.dart';
import 'package:kwiz/services/database.dart';
import 'package:kwiz/pages/home.dart';

class ViewCategories extends StatefulWidget {
  const ViewCategories({super.key});

  @override
  _ViewCategoriesState createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategories> {
  DatabaseService service = DatabaseService();
  List? categories;
  int catLength = 0;
  List? _displayedItems = [];
  int fillLength = 0;

  final TextEditingController _controller = TextEditingController();

  Future<void> loaddata() async {
    categories = await service.getCategories();
    categories!.insert(0, 'All');
    catLength = categories!.length;
    _displayedItems = categories;
    fillLength = _displayedItems!.length;
  }

  @override
  void initState() {
    super.initState();
    _displayedItems = categories;
    loaddata().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSearchTextChanged(String text) {
    setState(() {
      _displayedItems = categories!
          .where((item) => item.toLowerCase().contains(text.toLowerCase()))
          .toList();
      fillLength = _displayedItems!.length;
    });
  }

  bool shadowColor = false;
  double? scrolledUnderElevation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: /*Color.fromARGB(255, 25, 25, 27)*/
          Color.fromRGBO(41, 41, 52, 1),
      body: _displayedItems == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 40.0,
                        ),
                        onPressed: () {
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                          );
                        },
                      ),
                      SizedBox(
                        width: 50.0,
                      ),
                      const Text(
                        'Catalogue',
                        style: TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: TextField(
                        controller: _controller,
                        onChanged: _onSearchTextChanged,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: /*Color.fromARGB(255, 80, 82, 94)*/
                              Color.fromRGBO(97, 100, 115, 1),
                          hintText: 'Search Catalogue',
                          hintStyle: const TextStyle(
                              fontSize: 18.0, color: Colors.white),
                          prefixIcon: IconButton(
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: const BorderSide(
                                width: 50, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: GridView.builder(
                          itemCount: fillLength,
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final Color color = Colors
                                .primaries[index % Colors.primaries.length];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewQuizzes(
                                          chosenCategory:
                                              _displayedItems?[index])),
                                );
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50.0),
                                    color: color,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 50, 0, 0),
                                    child: Column(
                                      children: [
                                        Text(
                                          _displayedItems?[index],
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white
                                                  .withOpacity(1.0)),
                                        ),
                                        const SizedBox(height: 10),
                                        Image.asset(
                                            '${'assets/images/' + _displayedItems?[index]}.png', //This loads the gif repective to the quiz's category
                                            height: 48,
                                            width: 48,
                                            scale: 0.5,
                                            opacity:
                                                const AlwaysStoppedAnimation<
                                                    double>(1)),
                                      ],
                                    ),
                                  )),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
