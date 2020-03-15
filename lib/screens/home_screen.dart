import 'package:cryptocurrency_app/models/coin_model.dart';
import 'package:cryptocurrency_app/repositories/crypto_repository.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _cryptoRepository = CryptoRepository();
  int _pageNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Top Coins",
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Colors.grey[900],
            ],
          ),
        ),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              _pageNumber = 0;
            });
          },
          child: FutureBuilder(
            future: _cryptoRepository.getTopCoins(page: _pageNumber),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).accentColor,
                    ),
                  ),
                );
              }
              List<Coin> coins = snapshot.data;
              return ListView.builder(
                itemCount: coins.length,
                itemBuilder: (BuildContext context, int index) {
                  Coin coin = coins[index];
                  return ListTile(
                    leading: Text(
                      "${++index}",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    title: Text(
                      coin.fullName,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Text(
                      coin.name,
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    trailing: Text(
                      "\$${coin.price.toStringAsFixed(3)}",
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
