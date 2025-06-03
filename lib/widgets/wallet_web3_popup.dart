import 'package:flutter/material.dart';
import 'package:zero_koin/widgets/wallet_web3_widget.dart';

class WalletWeb3Popup extends StatefulWidget {
  const WalletWeb3Popup({super.key});

  @override
  State<WalletWeb3Popup> createState() => _WalletWeb3PopupState();
}

class _WalletWeb3PopupState extends State<WalletWeb3Popup> {
  String selectedWallet = 'trustwallet';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: 360,
      height: 316,
      padding: const EdgeInsets.only(right: 20, bottom: 20, left: 20),
      decoration: BoxDecoration(
        color: Color(0xFF0C091E),
        border: Border.all(color: Colors.white, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text(
              "Wallet Web 3",
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWallet = 'trustwallet';
                  });
                },
                child: WalletWeb3Widget(
                  containerColor:
                      selectedWallet == 'trustwallet'
                          ? Color(0xFF0682A2)
                          : Color(0xFF393746),
                  imageUrl: "assets/trust.png",
                  text: "CONNECT-TRUSTWALLET",
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedWallet = 'metamask';
                  });
                },
                child: WalletWeb3Widget(
                  containerColor:
                      selectedWallet == 'metamask'
                          ? Color(0xFF0682A2)
                          : Color(0xFF393746),
                  imageUrl: "assets/icon-metamask.png",
                  text: "CONNECT-METAMASK",
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 4),
              SizedBox(height: 16),
              Text(
                "OR",
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 0),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 20,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: Color(0xFF0682A2),
                  ),
                  child: Center(
                    child: Text(
                      "Launching Soon",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 0),
              WalletWeb3Widget(
                containerColor: Color(0xFF393746),
                imageUrl: "assets/zero_koin_logo.png",
                text: "CONNECT-ZEROKWALLET",
                fontSize: 18,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
