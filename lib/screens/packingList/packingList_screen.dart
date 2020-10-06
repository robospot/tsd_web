import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd_web/screens/packingList/cubit/packinglist_cubit.dart';

class PackingListScreen extends StatefulWidget {
  PackingListScreen({Key key}) : super(key: key);

  @override
  _PackingListScreenState createState() => _PackingListScreenState();
}

class _PackingListScreenState extends State<PackingListScreen> {
  @override
  void initState() {
    super.initState();
    context.bloc<PackinglistCubit>().getAllPackList();
//Регулярность обновления таблицы
    // var timer = Timer.periodic(
    //     Duration(seconds: 2), (Timer t) => context.bloc<PackinglistCubit>().getAllPackList());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackinglistCubit, PackinglistState>(
        builder: (context, state) {
      if (state is PackinglistInitial) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PackinglistLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }

      if (state is PackinglistLoaded) {
        return Container(
          margin: EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Номер упаковочного листа"),
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: state.packList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              '${state.packList[index]}',
                            ),
                            onTap: () => fetchSsccbyPl(state.packList[index]),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text("Номера SSCC"),
                    Expanded(
                                          child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: state.ssccList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${state.ssccList[index]}'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    });
  }

  fetchSsccbyPl(String packListnum) {
    context.bloc<PackinglistCubit>().fetchSsccbyPl(packListnum);
  }
}
