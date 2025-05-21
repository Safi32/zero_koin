import 'package:flutter/material.dart';
import 'package:zero_koin/widgets/wallet_web3_widget.dart';

class WalletWeb3Popup extends StatelessWidget {
  const WalletWeb3Popup({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth * 0.8,
      height: screenHeight * 0.5,
      padding: EdgeInsets.all(screenWidth * 0.06),
      decoration: BoxDecoration(
        color: Color(0xFF0C091E),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            "Wallet Web 3",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              WalletWeb3Widget(
                containerColor: Colors.blue,
                imageUrl: "assets/wallet_web3_icon_01.png",
                text: "CONNECT -TRUSTWALLET",
              ),
              SizedBox(height: 20),
              WalletWeb3Widget(
                containerColor: Colors.grey,
                imageUrl: "assets/wallet_web3_icon_02.png",
                text: "CONNECT -METAMASK",
              ),
              SizedBox(height: 20),
              Text("OR", style: TextStyle(color: Colors.white, fontSize: 25)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: Center(
                      child: Text(
                        "Launching soon",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              WalletWeb3Widget(
                containerColor: Colors.grey,
                imageUrl: "assets/wallet_web3_icon_03.png",
                text: "CONNECT -ZEROkWALLET",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
