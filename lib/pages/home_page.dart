import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medi_mate/profile_page.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../constants.dart';
import '../global_bloc.dart';
import '../models/medicine.dart';
import 'medicine_details/medicine_details.dart';
import 'new_entry/new_entry_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePageContent(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    if (index == 1) {
      return;
    }
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 2) {
      setState(() {
        _selectedIndex = index - 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kPrimaryColor.withOpacity(0.3),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kPrimaryColor,
        onTap: _onItemTapped,
      ),
      floatingActionButton: _selectedIndex == 0 || _selectedIndex == 1
          ? InkResponse(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewEntryPage(),
                  ),
                );
              },
              child: SizedBox(
                width: 18.w,
                height: 9.h,
                child: Card(
                  color: kPrimaryColor,
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(3.h),
                  ),
                  child: Icon(
                    Icons.add_outlined,
                    color: kScaffoldColor,
                    size: 50.sp,
                  ),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopContainer(),
        SizedBox(
          height: 2.h,
        ),
        const Flexible(
          child: BottomContainer(),
        ),
      ],
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius:
            const BorderRadius.only(bottomRight: Radius.circular(180)),
        color: kPrimaryColor.withOpacity(0.5),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 120, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Stay on Track \nStay Healthy',
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(bottom: 1.h),
              child: Text(
                'Welcome to Medi Mate!',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            StreamBuilder<List<Medicine>>(
                stream: globalBloc.medicineList$,
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 1.h),
                    child: Text(
                      !snapshot.hasData
                          ? '0'
                          : snapshot.data!.length.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  const BottomContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);

    return StreamBuilder(
      stream: globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              'No Medicine',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: kPrimaryColor),
            ),
          );
        } else {
          return GridView.builder(
            padding: EdgeInsets.only(top: 1.h),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return MedicineCard(medicine: snapshot.data![index]);
            },
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  const MedicineCard({super.key, required this.medicine});
  final Medicine medicine;
  Hero makeIcon(double size) {
    if (medicine.medicineType == 'Bottle') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/bottle.svg',
          color: kOtherColor,
          height: 7.h,
        ),
      );
    } else if (medicine.medicineType == 'Pill') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/pill.svg',
          color: kOtherColor,
          height: 7.h,
        ),
      );
    } else if (medicine.medicineType == 'Syringe') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/syringe.svg',
          color: kOtherColor,
          height: 7.h,
        ),
      );
    } else if (medicine.medicineType == 'Tablet') {
      return Hero(
        tag: medicine.medicineName! + medicine.medicineType!,
        child: SvgPicture.asset(
          'assets/icons/tablet.svg',
          color: kOtherColor,
          height: 7.h,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName! + medicine.medicineType!,
      child: Icon(
        Icons.error,
        color: kOtherColor,
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.white,
      splashColor: Colors.grey,
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder<void>(
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AnimatedBuilder(
                animation: animation,
                builder: (context, Widget? child) {
                  return Opacity(
                    opacity: animation.value,
                    child: MedicineDetails(medicine),
                  );
                },
              );
            },
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Card(
        elevation: 10,
        color: Colors.white.withOpacity(0.07),
        child: Container(
          padding:
              EdgeInsets.only(left: 2.w, right: 2.w, top: 1.h, bottom: 1.h),
          margin: EdgeInsets.all(1.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2.h),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              makeIcon(7.h),
              const Spacer(),
              Hero(
                tag: medicine.medicineName!,
                child: Text(
                  medicine.medicineName!,
                  overflow: TextOverflow.fade,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              SizedBox(
                height: 0.3.h,
              ),
              Text(
                medicine.interval == 1
                    ? "Every ${medicine.interval} hour"
                    : "Every ${medicine.interval} hour",
                overflow: TextOverflow.fade,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
