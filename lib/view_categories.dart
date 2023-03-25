import 'package:flutter/material.dart';
import 'package:kwiz/pages/viewquizzes/viewquizzes.dart';

//References: https://api.flutter.dev/flutter/material/AppBar-class.html
//Using this array to test the dynamic aspect of the page. This will be replaced by prompts from our database eventually...
var categories = [
  'All',
  'Art',
  'Biology',
  'Fashion',
  'Food',
  'Gaming',
  'Entertainment',
  'History',
  'Holidays',
  'Languages',
  'Mathematics',
  'Music',
  'Science',
  'Sport',
  'Politics',
  'Technology',
  'Transport'
];

void main() => runApp(const ViewCategories());

class ViewCategories extends StatelessWidget {
  const ViewCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: Color.fromARGB(255, 14, 39, 179),
        //colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const ViewCategoriesScreen(),
    );
  }
}

class ViewCategoriesScreen extends StatefulWidget {
  const ViewCategoriesScreen({super.key});

  @override
  State<ViewCategoriesScreen> createState() => _ViewCategoriesState();
}

class _ViewCategoriesState extends State<ViewCategoriesScreen> {
  bool shadowColor = false;
  double? scrolledUnderElevation;

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color oddItemColor = colorScheme.primary.withOpacity(0.10);
    final Color evenItemColor = colorScheme.primary.withOpacity(0.30);

    //Search bar reference: https://flutterassets.com/search-bar-in-flutter/

    //Scaffold consists of: An app bar that contains the Home button and Seach box , the body that has a gridview
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        //backgroundColor: Color.fromARGB(255, 187, 182, 182).withOpacity(0.1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 130,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  side: BorderSide(width: 1.0, color: Colors.black),
                  //primary: Colors.green,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {},
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 28,
                ),
                label: const Text(
                  'Home',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            //Spacer(),
            Flexible(
              child: SizedBox(
                width: 280,
                height: 50,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search Categories',
                    // Add a clear button to the search bar
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onPressed: () => _searchController.clear(),
                    ),
                    // Add a search icon or button to the search bar
                    prefixIcon: IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 30,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        // Perform the search here
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(width: 12, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Flexible(
            child: GridView.builder(
                itemCount: categories.length,
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final Color color =
                      Colors.primaries[index % Colors.primaries.length];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewQuizzes()),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      // tileColor: _items[index].isOdd ? oddItemColor : evenItemColor,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        border: Border.all(width: 2 /*color: Colors.white*/),
                        color: color,
                      ),
                      child: Text(
                        categories[index],
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white.withOpacity(1.0)),
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
