// getForCollection() async {
//   int i = 0;

//   while (i < gameNames.length) {
//     var server = await getPath(gameNames[i]);
//     // Gets response json string
//     var temp = WebClient(server).getInfo();

//     //Converts from Future<String> to String
//     var getInfo = await temp;

//     //Calls Gaming constructor
//     game = Gaming(getInfo.gameName, getInfo.creator, getInfo.characters);

//     // Calls [setCharacter] method to allocate instance lists with json data
//     game.setCharacters();

//     //Calls [setState] to notify build that the lists have changed
//     setState(() {
//       gameInfo = gameInfo + game.gameInfos;
//       game.addGame(gameInfo);
//       gameInfo = [];
//       games = games + game.games;
//     });
//     //addToCollection();
//     i++;
//   }
//   //updateCharacter();
// }

// forLater() async {
//   int i = 0;
//   while (i < games.length) {
//     for (int j = 0; j < games[i].characters.length; j++) {
//       var collection = db.collection(games[i].gameName);
//       var snapshot = await collection.get();

//       if (snapshot.docs.isEmpty) {
//         collection
//             .doc((j + 1).toString())
//             .set(games[i].characters[j].ToJson());
//       } else {
//         for (var doc in snapshot.docs) {
//           if (doc['name'] == games[i].characters[j].name) {
//             break;
//           } else {
//             collection
//                 .doc((j + 1).toString())
//                 .set(games[i].characters[j].ToJson());
//           }
//         }
//       }
//     }
//     i++;
//   }
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         Center(
//           child: Container(
//             decoration: BoxDecoration(
//                 gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               colors: [
//                 Colors.pink,
//                 Colors.pink.shade200,
//                 Colors.pink.shade100,
//                 Colors.pink.shade50,
//               ],
//             )),
//             child: Column(
//               children: <Widget>[
//                 DefaultTextStyle(
//                   style: const TextStyle(
//                     fontSize: 50.0,
//                     color: Colors.red,
//                   ),
//                   child: AnimatedTextKit(
//                     animatedTexts: [
//                       WavyAnimatedText('Flavor'),
//                     ],
//                     isRepeatingAnimation: true,
//                     onTap: () {},
//                   ),
//                 ),
//                 const SizedBox(height: 20.0),
//                 TextFormField(
//                   key: _user,
//                   decoration: const InputDecoration(
//                     hintText: 'Email',
//                     icon: Icon(Icons.email, color: Colors.black54),
//                     hintStyle: TextStyle(color: Colors.black54),
//                   ),
//                   style: const TextStyle(color: Colors.black),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Email is required';
//                     }
//                     return null;
//                   },
//                 ),
//                 const SizedBox(height: 10.0),
//                 TextFormField(
//                   key: _pass,
//                   obscureText: true,
//                   decoration: const InputDecoration(
//                     hintText: 'Password',
//                     icon: Icon(Icons.lock, color: Colors.black54),
//                     hintStyle: TextStyle(color: Colors.black54),
//                   ),
//                   style: const TextStyle(color: Colors.black),
//                   validator: (value) {
//                     if (value!.isEmpty) {
//                       return 'Password is required';
//                     }
//                     return null;
//                   },
//                 ),

//                 const SizedBox(height: 20.0),
//                 //this is the login button
//                 ElevatedButton(
//                   style: ButtonStyle(
//                       shape: MaterialStateProperty.all(const StadiumBorder()),
//                       textStyle: MaterialStateProperty.all(
//                           const TextStyle(fontSize: 35)),
//                       fixedSize:
//                           MaterialStateProperty.all(const Size(150, 50))),
//                   onPressed: () async {
//                     if (submit() && await login.call() == true) {
//                       print(values);
//                       if (mounted) {
//                         //this will take the user to the option page
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => const TopTierGames()));
//                       }
//                     }
//                   },
//                   child: const Text('Login'),
//                 ),
//                 const SizedBox(height: 20.0),
//                 //This is the create account button

//                 ElevatedButton(
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(Colors.grey),
//                       shape: MaterialStateProperty.all(const StadiumBorder()),
//                       fixedSize:
//                           MaterialStateProperty.all(const Size(150, 50))),
//                   onPressed: () {
//                     //takes the user to the create account page
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const CreateAccount()));
//                   },
//                   child: const Text(
//                     'Create Account',
//                     style: TextStyle(color: Colors.black, fontSize: 17),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     body: SingleChildScrollView(
//       child: Column(
//         children: <Widget>[
//           const Center(
//             child: Padding(
//               padding: EdgeInsets.only(top: 100.0),
//               child: Text(
//                 'Flavor',
//                 style: TextStyle(
//                   fontSize: 60.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red,
//                 ),
//               ),
//             ),
//           ),
//           const Center(
//             child: Padding(
//               padding: EdgeInsets.only(top: 10),
//               child: Text(
//                 'Create your account',
//                 style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           TextFormField(
//             key: _user,
//             decoration: const InputDecoration(
//               labelText: 'Username',
//               labelStyle: TextStyle(fontSize: 20),
//               hintText: 'ex. JohnDoe123',
//               hintStyle: TextStyle(fontSize: 20),
//               icon: Icon(Icons.person),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Username is required';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             key: _email,
//             decoration: const InputDecoration(
//               labelText: 'Email',
//               labelStyle: TextStyle(fontSize: 20),
//               hintText: 'ex. johndoe123@yahoo.com',
//               hintStyle: TextStyle(fontSize: 20),
//               icon: Icon(Icons.email),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Password is required';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             key: _pass,
//             obscureText: true,
//             decoration: const InputDecoration(
//               labelText: 'Password',
//               labelStyle: TextStyle(fontSize: 20),
//               hintText: 'Enter your password',
//               hintStyle: TextStyle(fontSize: 20),
//               icon: Icon(Icons.lock),
//             ),
//             validator: (value) {
//               if (value!.isEmpty) {
//                 return 'Password is required';
//               }
//               return null;
//             },
//           ),
//           const SizedBox(height: 20.0),
//           ElevatedButton(
//             style: ButtonStyle(
//                 shape: MaterialStateProperty.all(const StadiumBorder()),
//                 textStyle:
//                     MaterialStateProperty.all(const TextStyle(fontSize: 20)),
//                 fixedSize: MaterialStateProperty.all(const Size(200, 0))),
//             onPressed: () {
//               print(values);
//               createUser();
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => const Login()));
//             },
//             child: const Text('Create Account'),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// To remove build
// Remove-Item -Recurse -Force build
