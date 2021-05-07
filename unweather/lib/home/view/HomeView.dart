import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:unweather/home/HomeManager.dart';
import 'package:unweather/home/model/DealySearch.dart';
import 'package:unweather/home/view/widget/Forecast.dart';
import 'package:unweather/home/viewModel/HomeViewModel.dart';
import 'package:unweather/utils/AppColors.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  HomeViewModel _viewModel;
  Future<HomeViewModel> _req;
  TextEditingController _cityTextEditingController;
  DealySearch _dealySearch = DealySearch(milliseconds: 500);
  ScrollController _scrollController;
  bool shouldFadeTemp = false;

  @override
  void initState() {
    super.initState();
    _cityTextEditingController = TextEditingController(text: "Torino");
    _viewModel = HomeViewModel(manager: HomeManager());
    _req = _viewModel.featchData(city: _cityTextEditingController.text);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels >= 200){
        setState(() {
          shouldFadeTemp = true;
        });
      } else {
        setState(() {
          shouldFadeTemp = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _cityTextEditingController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  _searchForCity({String city}){
    _req = _viewModel.featchData(city: _cityTextEditingController.text);
    _req.then((value){
      setState(() {});
    });
    _req.catchError((error){
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
        FutureBuilder<HomeViewModel>(
        future: _req,
        builder: (context, snapshot){
          if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString(), style: TextStyle(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.bold),));
          }
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)));
          }

          HomeViewModel viewModel = snapshot.data;

          return Container(
            height: double.infinity,
            width: double.infinity,
            color: viewModel.isNight ? AppColors.night : AppColors.day,
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
                      color: viewModel.isNight ? AppColors.nightAccent : AppColors.dayAccent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ClipOval(
                    child: Container(
                      height: MediaQuery.of(context).size.width - 40,
                      width: MediaQuery.of(context).size.width - 40,
                      color: viewModel.isNight ? AppColors.nightAccent : AppColors.dayAccent,
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

                AnimatedCrossFade(
                  crossFadeState: shouldFadeTemp ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 500),
                  firstChild: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Text(viewModel.temperature, key: Key("temp"), style: TextStyle(color: Colors.white54, fontSize: 200, letterSpacing: -10, fontWeight: FontWeight.bold),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 260),
                        child: Image.asset(viewModel.iconName, height: 230, width: 300),
                      ),
                    ],
                  ),
                  secondChild: Container(),
                ),



                SingleChildScrollView(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: 500,
                      bottom: MediaQuery.of(context).padding.bottom == 0 ? 18 : MediaQuery.of(context).padding.bottom,
                      left: 18,
                      right: 18
                  ),
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
                                        text: viewModel.day,
                                        style: TextStyle(color: Colors.black, fontSize: 60, fontWeight: FontWeight.bold, fontFamily: "Avenir Next"),
                                        children: <TextSpan>[
                                          TextSpan(text: viewModel.month, style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold, fontFamily: "Avenir Next"),)
                                        ]
                                    ),
                                  ),

                                  Text(viewModel.minTemperature + "\n" + viewModel.maxTemperature, style: TextStyle(fontSize: 17, color: AppColors.grey, fontWeight: FontWeight.w600,), ),
                                ],
                              ),
                            ),

                            SizedBox(height: 20,),

                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.horizontal,
                                itemCount: 9,
                                itemBuilder: (context, index){
                                  return Forecast(viewModel: viewModel.forecastHours[index],);
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
                                          Text(viewModel.rain, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 15,),
                                          Text("HUM", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                          Text(viewModel.humidity, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 15,),
                                          Text("Vento NNO", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                          Text(viewModel.windSpeed, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Nuvolosità", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                          Text(viewModel.cloudiness, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 15,),
                                          Text("Visibilità", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                          Text(viewModel.visibility, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 15,),
                                          Text("Pressione", style: TextStyle(color: AppColors.grey, fontSize: 17, fontWeight: FontWeight.w600),),
                                          Text(viewModel.pressure, style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),

                            SizedBox(height: 40,),

                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 35),
                              child: Text("Prossimi giorni", style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 15,),

                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                scrollDirection: Axis.horizontal,
                                itemCount: 5,
                                itemBuilder: (context, index){
                                  return Forecast(viewModel: viewModel.forecastDays[index],);
                                },
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
          


          AnimatedCrossFade(
            crossFadeState: shouldFadeTemp ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 500),
            firstChild: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: TextField(
                controller: _cityTextEditingController,
                enabled: !shouldFadeTemp,
                autofocus: false,
                cursorColor: Colors.white,
                decoration: InputDecoration.collapsed(hintText: "Città", border: InputBorder.none, hintStyle: TextStyle(color: Colors.white54)),
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value){
                  _dealySearch.run(() {
                    if(value != "" && value != null) {
                      _searchForCity(city: value);
                    }
                  });
                },
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            secondChild: Container(),
          ),
        ],
      ),
    );
  }
}
