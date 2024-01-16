// import framework
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tennis_court_agend/Models/courts_tennis.dart';
import 'package:tennis_court_agend/Pages/Agend/agend.dart';
import 'package:tennis_court_agend/Pages/Home/Blocs/scheduled/agends_bloc.dart';

// import project
import 'package:tennis_court_agend/Pages/Home/Widgets/item_agend.dart';
import 'package:tennis_court_agend/Styles/colors.dart';

// import library

class HomePage extends StatefulWidget {
  // route name for the route classes
  static const String routeName = 'HomePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    initializedProccess();
    super.initState();
  }

  // initialize pre load proccess 
  void initializedProccess() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted)BlocProvider.of<AgendsBloc>(context).add(const ListItemAgens());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // backgroundColor: Colors.blue,
        title: const Text(
          'Reserved-App',
          style: TextStyle(
            color: StylesColors.accentColor,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              'Welcome',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // builder of items (agends tennis court)
            Flexible(
              child: BlocBuilder<AgendsBloc, AgendsState>(
                builder: (context, state) {
                  if (state is AgendsLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: StylesColors.backgroundColor,
                      ),
                    );
                  }
                  if (state is AgendsError) {
                    return Center(
                      child: Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                    );
                  }
                  final items = (state.props[0] as List<AgendCourtTennis>);
                  if (items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Images/people.png',
                            scale: 3,
                          ),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                Text('You do not have reserved tennis courts.'),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FractionallySizedBox(
                        widthFactor: 0.95,
                        child: Card(
                          color: Colors.white,
                          child: ItemAgendCourtTennis(
                            item: items[index],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: StylesColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            30.0,
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, ReserverCourt.routeName);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBar(
        height: 40,
        color: StylesColors.backgroundColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
      ),
    );
  }
}
