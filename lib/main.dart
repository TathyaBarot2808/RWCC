import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/src/material/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:rwccapp/app_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? finalEmail;

void main() => runApp(MaterialApp(
      home: login(),
      debugShowCheckedModeBanner: false,
    ));

//routing
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login(),
      routes: <String, WidgetBuilder>{
        '/home': (context) => home(),
        '/BMI_Calc': (context) => BMI_Calc(),
        //'/DietPlans': (context) => DietPlans(),
      },
    );
  }
}

//login page
class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();

  static to(StatefulWidget statefulWidget) {}
}

class _loginState extends State<login> {
  final formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Diet Bite",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Form(
          key: formkey,
          child: Stack(children: <Widget>[
            Positioned(
              top: 50,
              height: h * 0.15,
              left: 10,
              right: 10,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: const Radius.circular(40),
                    top: const Radius.circular(40)),
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Login to your Account',
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 141, 198, 177),
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
                  child: Image.asset('assets/logo.jpg', width: 250, height: 250),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      contentPadding: EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: ! passwordVisible,
                    controller: passwordController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        contentPadding: EdgeInsets.all(20),
                        filled: true,
                        fillColor: Colors.white,
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(Icons.visibility),
                        )
                        ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Password";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 300,
                  child: Container(
                    child: TextButton(
                      onPressed: () async {
                        if (formkey!.currentState!.validate()) {
                          AppPreferences().setPreferenceValue(
                              AppPreferences.email, emailController.text);
                          AppPreferences().setPreferenceValue(
                              AppPreferences.password, passwordController.text);
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => new home(),
                              ));
                        }
                      },
                      child: const Text('Login',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.bold)),
                      style: TextButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 255, 255),
                        foregroundColor: Color.fromARGB(255, 141, 198, 177),
                      ),
                    ),
                    margin: EdgeInsets.fromLTRB(5, 35, 5, 5),
                  ),
                ),
              ],
            ))
          ]),
        ));
  }
  void _togglePasswordView() {
  setState(() {
       passwordVisible = !passwordVisible;
    });
  }
}

//home page
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();

  static to(StatefulWidget statefulWidget) {}
}

class _homeState extends State<home> {
  final formkey = GlobalKey<FormState>();
  TextEditingController _nameTEC = TextEditingController();
  TextEditingController _ageTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 154, 191, 177),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              label: 'BMI',
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(Icons.breakfast_dining),
              label: 'diet plans',
              backgroundColor: Colors.grey),
        ],
      ),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 2.0,
              width: 325,
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: Text(
          "Diet Bite",
          style: TextStyle(fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        elevation: 0.5,
      ),
      body: Form(
        key: formkey,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 50,
              height: h * 0.15,
              left: 10,
              right: 10,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                    bottom: const Radius.circular(40),
                    top: const Radius.circular(40)),
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Welcome to our app',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color.fromARGB(255, 141, 198, 177),
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 225, 20, 20),
                    child: Text(
                      'Enter your name',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _nameTEC,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Name',
                          contentPadding: EdgeInsets.all(20.0),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        style: TextStyle(fontSize: 20.0),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter Name";
                          }
                          return null;
                        },
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                    child: Text(
                      'Enter your age',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _ageTEC,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Age',
                        contentPadding: EdgeInsets.all(20.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      style: TextStyle(fontSize: 20.0),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Age";
                        }
                        return null;
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => new BMI_Calc(),
            ),
          );

          var name = _nameTEC.text;
          var age = _ageTEC.text;

          print(name);
          print(age);
        },
        child: Text('next'),
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 30, 207, 142),
      ),
    );
    ;
  }
}

//BMI page
class BMI_Calc extends StatefulWidget {
  const BMI_Calc({super.key});

  @override
  State<BMI_Calc> createState() => _BMI_CalcState();
}

class _BMI_CalcState extends State<BMI_Calc> {
  TextEditingController _heightTEC = TextEditingController();
  TextEditingController _weightTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;

    void BMI_Val() {
      var height = _heightTEC.text;
      var weight = _weightTEC.text;

      var int_weight = double.parse(weight);
      var int_height = double.parse(height);
      var BMI = int_weight / pow(int_height, 2);
      var BMIstr = BMI.toString();

      print("You're BMI is " + BMIstr);
    }

    void BMI_Test() {
      var height = _heightTEC.text;
      var weight = _weightTEC.text;

      var int_weight = double.parse(weight);
      var int_height = double.parse(height);
      var BMI = int_weight / pow(int_height, 2);
      var BMIstr = BMI.toString();

      if (BMI <= 18.5) {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new dietPlan1(),
          ),
        );
      }
      if (BMI >= 24.9) {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new dietPlan3(),
          ),
        );
      }
      if ((BMI >= 18.5) & (BMI <= 24.9)) {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (context) => new dietPlan2(),
          ),
        );
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 154, 191, 177),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'home',
              backgroundColor: Colors.grey),
          BottomNavigationBarItem(
              icon: Icon(Icons.accessibility),
              label: 'BMI',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.breakfast_dining),
              label: 'diet plans',
              backgroundColor: Colors.grey),
        ],
        currentIndex: 1,
      ),
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              color: Colors.white,
              height: 2.0,
              width: 325,
            ),
            preferredSize: Size.fromHeight(4.0)),
        title: Text(
          "Diet Bite",
          style: TextStyle(fontSize: 35),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        elevation: 0.5,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 50,
            height: h * 0.15,
            left: 10,
            right: 10,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: const Radius.circular(40),
                top: const Radius.circular(40),
              ),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Text(
                    'Calculate your BMI',
                    style: TextStyle(
                      fontSize: 35,
                      color: Color.fromARGB(255, 141, 198, 177),
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(20, 225, 20, 20),
                  child: Text(
                    'Input your height (in m)',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _heightTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'height',
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 40, 20, 20),
                  child: Text(
                    'Input your weight (in kg)',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _weightTEC,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'weight',
                      contentPadding: EdgeInsets.all(20.0),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BMI_Test();
          BMI_Val();
        },
        child: Text(
          'next',
          style: TextStyle(
            color: Color.fromARGB(255, 30, 207, 142),
          ),
        ),
        backgroundColor: Colors.white,
      ),
    );
  }
}

//underweight diet plan page

class dietPlan1 extends StatefulWidget {
  const dietPlan1({super.key});

  @override
  State<dietPlan1> createState() => _dietPlan1State();
}

class _dietPlan1State extends State<dietPlan1> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility),
                label: 'BMI',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.breakfast_dining),
                label: 'diet plans',
                backgroundColor: Colors.blue),
          ],
          currentIndex: 2,
        ),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Underweight",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 410.0,
                height: 300.0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new vegPlan1(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '''    Veg 
Diet Plan''',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 179, 219, 204),
                        fixedSize: Size.fromHeight(150)),
                  ),
                  margin: EdgeInsets.all(25),
                )),
            SizedBox(
                width: 410.0,
                height: 300.0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new nonVegPlan1(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '''Non-Veg 
Diet Plan''',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 179, 219, 204),
                        fixedSize: Size.fromHeight(150)),
                  ),
                  margin: EdgeInsets.all(25),
                )),
          ],
        ));
  }
}

class vegPlan1 extends StatefulWidget {
  const vegPlan1({super.key});

  @override
  State<vegPlan1> createState() => vegPlan1State();
}

class vegPlan1State extends State<vegPlan1> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Vegetarian Plan",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SingleChildScrollView(
            child: Text(
              '''
Early Morning :

A fruit of your choice + whey protein
Or
Soaked almonds + 1 glass skimmed milk
 
Breakfast :

A bowl of oats/wheat flakes/ quinoa with skimmed milk and some nuts
Or
Whole wheat toast with peanut butter + milk
 
Mid-Morning :

Buttermilk made from low-fat yogurt
Or
1 big bowl of watermelon/pineapple/grapefruit + 2 cheese slices
 
Lunch :
 
2 wheat/jowar/bajra chapattis or brown rice + veggies + bowl of dal + cottage cheese
 
Evening Snack :
 
Sprouts or boiled legumes (chickpea/ black chana) with onion, tomato, cucumber, and lime juice + whey with water + eggs/cottage cheese/ low fat cheese slice.
Or
Paneer and spinach roll/ 2 slices of brown bread + fresh juice (celery, carrot, beetroot, green apple, mint leaves, orange, and lemon juice)
 
Dinner :
 
2 wheat/jowar/bajra chapattis or brown rice + veggies + bowl of dal + cottage cheese

''',
              style: TextStyle(color: Colors.white, fontSize: 27),
            ),
          )),
        );
  }
}

class nonVegPlan1 extends StatefulWidget {
  const nonVegPlan1({super.key});

  @override
  State<nonVegPlan1> createState() => _nonVegPlan1State();
}

class _nonVegPlan1State extends State<nonVegPlan1> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Non Vegetarian Plan",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SingleChildScrollView(
            child: Text(
              '''
Early Morning:

1 cup of skimmed milk with nuts

Breakfast:

3 to 4 slices of whole wheat bread toast with peanut butter + 3 egg whites + 1 full egg omelette or

1 cup of low fat milk + 1 scoop of whey protein+ 150 gms of oatmeal + 1 banana+ a few almonds+ walnuts.

Mid morning snack:

1 orange or apple or 1 cup of green tea + 2 to 3 multigrain biscuits

Lunch:

150 gms of brown rice or whole wheat chapattis + 150 gms of skinless chicken breast / fish + 1 bowl of mixed vegetables+ green chutney+ salad

Mid afternoon snack:

1 fruit or green tea or sprouts salad + few nuts

Evening:

1 fruit + 1 cup of low fat yoghurt or 1 cup of low fat milk with 1 scoop of whey protein or whole wheat bread 3 egg whites/ steamed chicken sandwich.

Dinner:

1 small fish or 100 gms of skinless/ lean chicken + stir fried veggies with baked potato + 1 cup of brown rice/ whole wheat chappati
''',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
              ),
            ),
          ),
        ));
  }
}

//normal diet plan page
class dietPlan2 extends StatefulWidget {
  const dietPlan2({super.key});

  @override
  State<dietPlan2> createState() => _dietPlan2State();
}

class _dietPlan2State extends State<dietPlan2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility),
                label: 'BMI',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.breakfast_dining),
                label: 'diet plans',
                backgroundColor: Colors.blue),
          ],
          currentIndex: 2,
        ),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Normal weight",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 410.0,
                height: 300.0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new vegPlan2(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '''    Veg 
Diet Plan''',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 179, 219, 204),
                        fixedSize: Size.fromHeight(150)),
                  ),
                  margin: EdgeInsets.all(25),
                )),
            SizedBox(
                width: 410.0,
                height: 300.0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new nonVegPlan2(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '''Non-Veg 
Diet Plan''',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 179, 219, 204),
                        fixedSize: Size.fromHeight(150)),
                  ),
                  margin: EdgeInsets.all(25),
                )),
          ],
        ));
  }
}

class vegPlan2 extends StatefulWidget {
  const vegPlan2({super.key});

  @override
  State<vegPlan2> createState() => vegPlan2State();
}

class vegPlan2State extends State<vegPlan2> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Vegetarian Plan",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SingleChildScrollView(
            child: Text(
              '''
After Waking:

Eat some almonds which have been soaked overnight + any fruit of your choice

Breakfast:

1 cup of oatmeal + 1/3 cup of raspberries

or

2 slices of toast + tofu + chopped cherry tomatoes

Mid - Morning:

Any fruit of choice

Lunch:

1 vegetable wrap made with roti + filled with vegetables of choice + cheese

or

Chickpea salad made with chopped potatoes + chickpeas + mint dressing

Evening Snack:

1/2 cup low fat plain greek yogurt served with 1/4 cup of strawberries

or

trail mix made out of nuts + seeds + dry fruits

Dinner:

1 veggie burger made with a mushroom and quinoa patty

or

pasta dish made with tomatoes + peppers + cheese
''',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
              ),
            ),
          ),
        ));
  }
}

class nonVegPlan2 extends StatefulWidget {
  const nonVegPlan2({super.key});

  @override
  State<nonVegPlan2> createState() => nonVegPlan2State();
}

class nonVegPlan2State extends State<nonVegPlan2> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Non Vegetarian Plan",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SingleChildScrollView(
            child: Text(
              '''
After Waking:

Eat some almonds which have been soaked overnight + any fruit of your choice

Breakfast:

Omlette made with spinach + chilli + cheese

or

Chicken sandwich made with marinated chicken + veggies + toasted whole wheat bread

Mid - Morning:

Any fruit of choice

Lunch:

Burrito Bowl made with 1 cup rice + beans (black beans / kidney beans / pinto beans)+ chopped chicken


or

Quesadilla made with a tortilla + cheese + veggies of choice + chicken

Dinner:

Caprese salad made with tomatoes + sliced mozzarella cheese + some basil leaves + chopped chicken breast

or

Tomato stew with eggs, herbs and spices

''',
              style: TextStyle(
                color: Colors.white,
                fontSize: 27,
              ),
            ),
          ),
        ));
  }
}

//overweight diet plan page.
class dietPlan3 extends StatefulWidget {
  const dietPlan3({super.key});

  @override
  State<dietPlan3> createState() => _dietPlan3State();
}

class _dietPlan3State extends State<dietPlan3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.accessibility),
                label: 'BMI',
                backgroundColor: Colors.grey),
            BottomNavigationBarItem(
                icon: Icon(Icons.breakfast_dining),
                label: 'diet plans',
                backgroundColor: Colors.blue),
          ],
          currentIndex: 2,
        ),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Overweight",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 410.0,
                height: 300.0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new vegPlan3(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '''    Veg 
Diet Plan''',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 179, 219, 204),
                        fixedSize: Size.fromHeight(150)),
                  ),
                  margin: EdgeInsets.all(25),
                )),
            SizedBox(
                width: 410.0,
                height: 300.0,
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => new nonVegPlan3(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text(
                        '''Non-Veg 
Diet Plan''',
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Color.fromARGB(255, 179, 219, 204),
                        fixedSize: Size.fromHeight(150)),
                  ),
                  margin: EdgeInsets.all(25),
                )),
          ],
        ));
  }
}

class vegPlan3 extends StatefulWidget {
  const vegPlan3({super.key});

  @override
  State<vegPlan3> createState() => vegPlan3State();
}

class vegPlan3State extends State<vegPlan3> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Vegetarian Plan",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SingleChildScrollView(
            child: Text(
              '''
After Waking:

Eat a cup of plain, low fat greek yogurt

Breakfast:

bircher muesli made with 1/4 grated apple + 2 spoons of yogurt + 1 cup of oats + toasted almonds

or

Granola bowl made with oats + nuts + dried berries (raspberries / blueberries) + cinnamon

Mid - Morning:

1/4 cup of mixed nuts(Walnuts / almonds / cashews / pine nuts)

Lunch:

Tomato soup made with 2 cans of whole tomatoes +  4 cups of (reduced) vegetable stock

or

Wrap made with 1 flatbread (roti / tortialla) + 1 avocado + chopped onions

Evening Snack:

Chaat bowl made with corn + sprouts + onion + tomato + coriander chutney

Dinner:

Pasta made with chickpea pasta + chopped mushrooms + cheese

or

Soup made with 1 cup brown lentils + 8 cups water + 2 medium diced onions + 2 medium diced carrots + juice of 1 lemon

''',
              style: TextStyle(fontSize: 27, color: Colors.white),
            ),
          ),
        ));
  }
}

class nonVegPlan3 extends StatefulWidget {
  const nonVegPlan3({super.key});

  @override
  State<nonVegPlan3> createState() => nonVegPlan3State();
}

class nonVegPlan3State extends State<nonVegPlan3> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 179, 219, 204),
        appBar: AppBar(
          bottom: PreferredSize(
              child: Container(
                color: Colors.white,
                height: 2.0,
                width: 325,
              ),
              preferredSize: Size.fromHeight(4.0)),
          title: Text(
            "Non Vegetarian Plan",
            style: TextStyle(fontSize: 35),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 179, 219, 204),
          elevation: 0.5,
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: SingleChildScrollView(
            child: Text(
              '''
After Waking:

Eat a cup of plain, low fat greek yogurt

Breakfast:

Scrambled eggs (2 eggs) + cracked pepper

or

Sandwich made with 1 slice of tomato + 1 large egg

Mid - Morning:

1 cup of greek yogurt with berries (raspberries / blueberries)

Lunch:

Soup made with chicken stock + tomato + peppers + cheese

or

Salad made with Chicken + mayonnaise + celery + grapes

Evening snacks:

Granola made with dried fruits + nuts

Dinner:

Grilled chicken + lemon juice

or

Roasted salmon + green vegetables (Zucchini / Asparagus / Brussel Sprouts)
''',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ));
  }
}
