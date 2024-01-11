import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test1/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  double _fontSize = 16.0;

  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
    _savePreferences();
  }

  void setFontSize(double size) {
    _fontSize = size;
    notifyListeners();
    _savePreferences();
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', _themeMode.index);
    await prefs.setDouble('fontSize', _fontSize);
  }

  Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode =
        ThemeMode.values[prefs.getInt('themeMode') ?? ThemeMode.light.index];
    _fontSize = prefs.getDouble('fontSize') ?? 16.0;
    notifyListeners();
  }
}

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('BookList');
  await Hive.openBox('ShoppingList');
  ThemeProvider themeProvider = ThemeProvider();
  await themeProvider._loadPreferences();
  runApp(
    ChangeNotifierProvider.value(
      value: themeProvider,
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // _loadPreferences();
  }

  ThemeMode _themeMode = ThemeMode.light;
  double _fontSize = 16.0;

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    _themeMode = themeProvider.themeMode;
    _fontSize = themeProvider.fontSize;

    return MaterialApp(
      themeMode: _themeMode,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(3, 69, 151, 1),
        ),
      ),
      darkTheme: ThemeData.dark(),
      routes: <String, WidgetBuilder>{
        "/home": (BuildContext context) => FirstPage(),
        "/Add Books": (BuildContext context) => AddBook(),
        "/Shopping": (BuildContext context) => ShoppingListPage(),
        "/About": (BuildContext context) => profile_page(),
      },
      initialRoute: "/home",
    );
  }
}

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var changeTheme = themeProvider.setThemeMode;
    var changeFontSize = themeProvider.setFontSize;
    return Drawer(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, "/home")},
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Add Books",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, "/Add Books")},
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "About",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, "/About")},
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ListTile(
              title: Text(
                "Shopping List",
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, "/Shopping")},
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.065,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Text(
                "Dark Mode",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Switch(
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  changeTheme(value ? ThemeMode.dark : ThemeMode.light);
                },
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: ListTile(
                  title: Text(
                    "Font Size",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              ListTile(
                title: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Slider(
                    value: themeProvider.fontSize,
                    min: 12,
                    max: 24,
                    onChanged: (value) {
                      changeFontSize(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var fontSize = themeProvider.fontSize;
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      drawer: DrawerWidget(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              color: Color.fromRGBO(253, 200, 67, 1.0),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.15,
              child: Center(
                child: Text(
                  "LitHub",
                  style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Every book has a story, every story finds a home in LitHub.",
                style: TextStyle(
                    fontSize: fontSize, fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddBook extends StatefulWidget {
  @override
  State<AddBook> createState() => _AddBook();
}

class _AddBook extends State<AddBook> {
  List<Map<String, dynamic>> _items = [];

  final _shoppingBox = Hive.box('BookList');

// Get all items from the database
  void _refreshItems() {
    final data = _shoppingBox.keys.map((key) {
      final value = _shoppingBox.get(key);
      return {
        "key": key,
        "Name": value["Name"],
        "Author": value['Author'],
        "Price": value['Price'],
        "Summary": value['Summary']
      };
    }).toList();
    setState(() {
      _items = data;
    });
  }

// Create new item
  Future<void> _createItem(Map<String, dynamic> newItem) async {
    await _shoppingBox.add(newItem);
    _refreshItems(); // update the UI
  }

  Map<String, dynamic> _readItem(int key) {
    final item = _shoppingBox.get(key);
    return item;
  }

// Update a single item
  Future<void> _updateItem(int itemKey, Map<String, dynamic> item) async {
    await _shoppingBox.put(itemKey, item);
    _refreshItems(); // Update the UI
  }

// Delete a single item
  Future<void> _deleteItem(int itemKey) async {
    await _shoppingBox.delete(itemKey);
    _refreshItems(); // update the UI
  }

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Load data when app starts
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<ThemeProvider>(context);
    var fontSize = themeProvider.fontSize;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      drawer: DrawerWidget(),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'No Data',
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              itemCount: _items.length,
              itemBuilder: (_, index) {
                final currentItem = _items[index];
                return Card(
                  margin: EdgeInsets.all(6.0),
                  elevation:
                      0, // Set elevation to 0 to use BoxDecoration shadow
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x4e4d49).withOpacity(1),
                          offset: Offset(0, 6),
                          blurRadius: 5,
                          spreadRadius: -3,
                        )
                      ],
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(8.0),
                      title: Text(
                        currentItem['Name'],
                        style: TextStyle(fontSize: fontSize),
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => bookPage(
                              n: currentItem['Name'],
                              a: currentItem['Author'],
                              p: currentItem['Price'],
                              s: currentItem['Summary'],
                              currentItem: currentItem,
                              updateItem: _updateItem,
                              deleteItem: _deleteItem,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(253, 200, 67, 1.0),
        onPressed: () async {
          var n, a, p, s;

          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => detail(-1),
            ),
          ).then((value) {
            n = (value as Map)['NA'];
            a = (value as Map)['AU'];
            p = (value as Map)['PR'];
            s = (value as Map)['SU'];
          });

          _createItem({'Name': n, 'Author': a, 'Price': p, 'Summary': s});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class detail extends StatefulWidget {
  int itemkey;
  String? n, a, p, s;
  detail(this.itemkey, {this.n, this.a, this.p, this.s});
  @override
  State<detail> createState() => _detail(this.itemkey, n: n, a: a, p: p, s: s);
}

class _detail extends State<detail> {
  int itemkey;
  String? n, a, p, s;
  _detail(this.itemkey, {this.n, this.a, this.p, this.s});
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _summatyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameController.text = n ?? "";
    _authorController.text = a ?? "";
    _priceController.text = p ?? "";
    _summatyController.text = s ?? "";
    var themeProvider = Provider.of<ThemeProvider>(context);
    var fontSize = themeProvider.fontSize;
    return Scaffold(
      appBar: AppBar(title: Text('Edit')),
      drawer: DrawerWidget(),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _authorController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Author',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                controller: _summatyController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'summary',
                  contentPadding: EdgeInsets.symmetric(vertical: 40.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0), // Adjust the padding as needed
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromRGBO(253, 200, 67, 1.0)),
                ),
                onPressed: () async {
                  // Save newitem
                  if (itemkey == -1) {
                    var Name = _nameController.text;
                    var Author = _authorController.text;
                    var Price = _priceController.text;
                    var Summary = _summatyController.text;
                    // Clear the text fields
                    _nameController.text = '';
                    _authorController.text = '';
                    _priceController.text = '';
                    _summatyController.text = '';
                    Navigator.pop(context, {
                      'NA': Name,
                      'AU': Author,
                      'PR': Price,
                      'SU': Summary
                    }); // Close the bottom sheet
                  }

                  // update an existing item
                  if (itemkey != -1) {
                    var Name = _nameController.text;
                    var Author = _authorController.text;
                    var Price = _priceController.text;
                    var Summary = _summatyController.text;
                    // Clear the text fields
                    _nameController.text = '';
                    _authorController.text = '';
                    _priceController.text = '';
                    _summatyController.text = '';

                    Navigator.pop(context,
                        {'NA': Name, 'AU': Author, 'PR': Price, 'SU': Summary});
                  }
                },
                child: Text(
                  itemkey == -1 ? 'Create New' : 'Update',
                  style: TextStyle(
                    backgroundColor: Color.fromRGBO(253, 200, 67, 1.0),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}

class bookPage extends StatefulWidget {
  String? n, a, p, s;
  final Map<String, dynamic> currentItem;
  final Function(int itemKey, Map<String, dynamic> item) updateItem;
  final Function(int itemKey) deleteItem;
  bookPage({
    this.n,
    this.a,
    this.p,
    this.s,
    required this.currentItem,
    required this.updateItem,
    required this.deleteItem,
  });

  @override
  _BookPage createState() => _BookPage(n: n, a: a, p: p, s: s);
}

class _BookPage extends State<bookPage> {
  int rating = 0;
  String? n, a, p, s;
  _BookPage({this.n, this.a, this.p, this.s});
  final _shoppingListBox = Hive.box('ShoppingList');
  @override
  Widget build(BuildContext context) {
    final currentItem = widget.currentItem;
    var themeProvider = Provider.of<ThemeProvider>(context);
    var fontSize = themeProvider.fontSize;
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            onPressed: () async {
              var n, a, p, s;

              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => detail(
                    currentItem['key'],
                    n: currentItem['Name'],
                    a: currentItem['Author'],
                    p: currentItem['Price'],
                    s: currentItem['Summary'],
                  ),
                ),
              ).then((value) {
                n = (value as Map)['NA'];
                a = (value as Map)['AU'];
                p = (value as Map)['PR'];
                s = (value as Map)['SU'];
              });

              widget.updateItem(currentItem['key'],
                  {'Name': n, 'Author': a, 'Price': p, 'Summary': s});
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () => widget.deleteItem(currentItem['key']),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 30),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.05,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            // color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                      child: Text(
                        this.n ?? '',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          // color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.12,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'Written by: ${this.a}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.07,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      '${this.s}',
                      style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Center(
                    child: Text(
                      'Price: ${this.p}\$',
                      style: TextStyle(
                        fontSize: 25,
                        // color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                      (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            rating = index + 1;
                          });
                        },
                        child: Icon(
                          index < rating ? Icons.star : Icons.star_border,
                          color: Color.fromRGBO(253, 200, 67, 1.0),
                          size: 40.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.012,
                  ),
                  Row(children: [
                    SizedBox(width: MediaQuery.of(context).size.width * 0.27),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(3, 69, 151, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          rating = 0;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Thanks for rating'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color.fromRGBO(3, 69, 151,
                                1), // You can customize the duration
                          ),
                        );
                      },
                      child: Text('Submit'),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(3, 69, 151, 1),
                      ),
                      onPressed: () {
                        setState(() {
                          rating = 0;
                          _shoppingListBox.add({
                            'Name': widget.n,
                            'Author': widget.a,
                            'Price': widget.p,
                            'Summary': widget.s,
                          });
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Added to shopping list'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Color.fromRGBO(3, 69, 151, 1),
                          ),
                        );
                      },
                      child: Text('Buy'),
                    ),
                  ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  late Box _shoppingListBox;
  late ThemeProvider themeProvider;
  @override
  void initState() {
    super.initState();
    _shoppingListBox = Hive.box('ShoppingList');
  }

  @override
  Widget build(BuildContext context) {
    themeProvider = Provider.of<ThemeProvider>(context);
    double fontSize = themeProvider.fontSize;
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      drawer: DrawerWidget(),
      body: ListView.builder(
        itemCount: _shoppingListBox.length,
        itemBuilder: (context, index) {
          final currentItem = _shoppingListBox.getAt(index);
          return ListTile(
            title: Text(currentItem['Name']),
            subtitle: Text(currentItem['Author']),
            trailing: IconButton(
              onPressed: () {
                _shoppingListBox.deleteAt(index);

                setState(() {});
              },
              icon: Icon(
                Icons.bookmark_remove,
                color: Colors.red,
              ),
            ),
          );
        },
      ),
    );
  }
}
