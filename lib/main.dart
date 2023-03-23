import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  //functionality variables
  int sec = 0, min = 0 ,hr =0;
  String digsec = '00', digmin = '00', dighr ='00';
  Timer? timer;
  bool started =false;
  List laps = [];


  //stoptimer
  void stop(){
    timer!.cancel();
    setState(() {
      started=false;
    });
  }

  // reset
  void reset(){
    timer!.cancel();
    setState(() {
      sec=0;
      min=0;
      hr=0;
      digsec = '00';
      digmin = '00';
      dighr = '00';
      started=false;

    });
  }

  void addlaps(){
    String lap = "$digsec: $digmin : $dighr";
    setState(() {
      laps.add(lap);
    });
  }

  //creating the start timer
  void start()
  {
    started =true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localsec = sec +1;
      int localmin = min;
      int localhr = hr;

      if(localsec>59){
        if(localmin>59){
          localhr++;
          localmin =0 ;
        }
        else{
          localmin++;
          localsec = 0;
        }
      }
      setState(() {
        sec = localsec;
        min=localmin;
        hr = localhr;
        digsec = (sec >= 10) ?"$sec":"0$sec";
        dighr = (hr >= 10) ?"$hr":"0$hr";
        digmin = (min >= 10) ?"$min":"0$min";
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C2757),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                    'Stopwatch App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    "$digsec:$digmin:$dighr",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 82,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Lap n°${index + 1}",
                            style:TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            "$laps{index}",
                            style:TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                            ),
                          ),

                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child:  RawMaterialButton(
                    onPressed: () {
                      (!started) ? start(): stop();
                    },
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      (!started) ? "Start" : "Pause",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 8,
                  ),
                  IconButton(
                    color: Colors.white,
                      onPressed: () {
                      addlaps();
                      },
                      icon: Icon(Icons.flag),
                  ),
                  Expanded(child:  RawMaterialButton(
                    onPressed: () {
                      reset();
                    },
                    fillColor: Colors.blue,
                    shape: StadiumBorder(
                      side: BorderSide(color: Colors.blue),
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),


                  )),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

