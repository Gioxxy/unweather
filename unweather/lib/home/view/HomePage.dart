import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unweather/home/view/widget/Forecast.dart';
import 'package:unweather/home/viewModel/HomeViewModel.dart';
import 'package:unweather/utils/AppColors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();

    _viewModel = HomeViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.primary,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: -20,
              left: -20,
              child: ClipOval(
                child: Container(
                  height: MediaQuery.of(context).size.width/2,
                  width: MediaQuery.of(context).size.width/2,
                  color: AppColors.accent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ClipOval(
                child: Container(
                  height: MediaQuery.of(context).size.width - 40,
                  width: MediaQuery.of(context).size.width - 40,
                  color: AppColors.accent,
                ),
              ),
            ),

            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 44,
                  sigmaY: 44,
                ),
                child: Container(color: Colors.transparent,),
              ),
            ),

            FutureBuilder(
              future: _viewModel.featchData(),
              builder: (context, snapshot){

                if(!snapshot.hasData) {
                  return CircularProgressIndicator();
                }

                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: Text(_viewModel.city, style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(_viewModel.temperature, style: TextStyle(color: Colors.white54, fontSize: 200, letterSpacing: -10, fontWeight: FontWeight.bold),),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(top: 110),
                      child: Image.asset("assets/images/cloudy.png", height: 500,),
                    ),

                    SingleChildScrollView(
                      padding: EdgeInsets.only(top: 500, bottom: 18, left: 18, right: 18),
                      child: Container(
                        width: double.infinity,
                        child: Material(
                          color: Colors.white,
                          elevation: 6,
                          shadowColor: AppColors.primary.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: _viewModel.day,
                                            style: TextStyle(color: Colors.black, fontSize: 60, fontWeight: FontWeight.bold, fontFamily: "Avenir Next"),
                                            children: <TextSpan>[
                                              TextSpan(text: _viewModel.month, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Avenir Next"),)
                                            ]
                                        ),
                                      ),

                                      Text(_viewModel.minTemperature + "\n" + _viewModel.maxTemperature, style: TextStyle(fontSize: 17, color: AppColors.grey, fontWeight: FontWeight.w600,), ),
                                    ],
                                  ),
                                ),

                                SizedBox(height: 20,),

                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 9,
                                    itemBuilder: (context, index){
                                      return Forecast(viewModel: _viewModel.forecastHours[index],);
                                    },
                                  ),
                                ),

                                SizedBox(height: 20,),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 35),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Dettagli", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                      SizedBox(height: 15,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Precipitazioni", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                              Text(_viewModel.rain, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 15,),
                                              Text("HUM", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                              Text(_viewModel.humidity, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 15,),
                                              Text("Vento NNO", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                              Text(_viewModel.windSpeed, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text("Nuvolositò", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                              Text(_viewModel.cloudiness, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 15,),
                                              Text("Visibilità", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                              Text(_viewModel.visibility, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                              SizedBox(height: 15,),
                                              Text("Pressione", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                              Text(_viewModel.pressure, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                            ],
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                ),

                                SizedBox(height: 40,),

                                SizedBox(
                                  height: 120,
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index){
                                      return Forecast(viewModel: _viewModel.forecastDays[index],);
                                    },
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}
