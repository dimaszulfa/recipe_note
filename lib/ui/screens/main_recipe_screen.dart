import 'dart:io';

import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/providers/recipe_provider.dart';
import 'package:recipe_book_local_database/ui/screens/search_recipe_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/recipe_widget.dart';

class MainRecipeScreen extends StatelessWidget {
   const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
              appBar: AppBar(
                title: const Text('My Recipes'),
                actions: [
                  InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => SearchRecipeScreen(
                              recipes: myProvider.allRecipes)))),
                      child: const Icon(Icons.search)),
                  PopupMenuButton(
                    color: !myProvider.isDark ? Colors.blue[200] : null,
                    itemBuilder: ((context) => [
                          PopupMenuItem(
                            onTap: (() => Scaffold.of(context).openDrawer()),
                            child: const Text('Open menu'),
                          ),
                          const PopupMenuItem(
                            child: Text('About'),
                          ),
                          PopupMenuItem(
                            onTap: (() => exit(0)),
                            child: Column(
                              children: [
                                const Divider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.exit_to_app_outlined,
                                      color: Colors.red,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Exit'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: (() async {
                  await Navigator.pushNamed(context, '/new_recipe_screen');
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                      context, '/main_recipe_screen');
                }),
                child: const Icon(Icons.add),
              ),
              drawer: Drawer(
                backgroundColor: !myProvider.isDark ? Colors.green[200] : null,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200,
                      color: !myProvider.isDark ? Colors.green: null,
                      child: const Center(
                        child: CircleAvatar(
                          backgroundImage: AssetImage('images/food_logo.png'),
                          radius: 50,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text('Home'),
                      leading: const Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/main_recipe_screen');
                      },
                    ),
                    ListTile(
                      title: const Text('Favorite Recipes'),
                      leading: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/favorite_recipes_screen');
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    ListTile(
                      title: const Text('Shopping List'),
                      leading: const Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/shopping_list_screen');
                      },
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    Provider.of<RecipeClass>(context).isDark
                        ? ListTile(
                            title: const Text('Light Mode'),
                            leading: const Icon(
                              Icons.light_mode_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Provider.of<RecipeClass>(context, listen: false)
                                  .changeIsDark();
                              Navigator.pop(context);
                            },
                          )
                        : ListTile(
                            title: const Text('Dark Mode'),
                            leading: const Icon(
                              Icons.dark_mode_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Provider.of<RecipeClass>(context, listen: false)
                                  .changeIsDark();
                              Navigator.pop(context);
                            },
                          ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                    ChipMenuWidget(title: "Feeds", onTap: (){}),
                    ChipMenuWidget(title: "My Recipes", onTap: (){})
                  ],),
                  Expanded(
                    child: Container(
                      child: MyRecipesScreen(myProvider: myProvider,),
                    ),
                  )
                ],
              )
            ));
  }
}

class ChipMenuWidget extends StatelessWidget {
   ChipMenuWidget({
    super.key, required this.title, required this.onTap,
  });
  
  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Text(title, style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.bold),),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0)
        ),
      ),
    );
  }
}



class FeedRecipesScreen extends StatefulWidget {
  const FeedRecipesScreen({super.key});

  @override
  State<FeedRecipesScreen> createState() => _FeedRecipesScreenState();
}

class _FeedRecipesScreenState extends State<FeedRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class MyRecipesScreen extends StatefulWidget {
   MyRecipesScreen({super.key, required this.myProvider});
  final RecipeClass myProvider;
  @override
  State<MyRecipesScreen> createState() => _MyRecipesScreenState();
}

class _MyRecipesScreenState extends State<MyRecipesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
                  itemCount: widget.myProvider.allRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeWidget(widget.myProvider.allRecipes[index]);
                  }),

    );
  }
}


