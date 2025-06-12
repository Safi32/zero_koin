import 'package:flutter/material.dart';
import 'package:zero_koin/widgets/wallet_web3_widget.dart';

class WalletWeb3Popup extends StatefulWidget {
  final VoidCallback? onMetaMaskConnect;
  final VoidCallback? onTrustWalletConnect;
  final bool isConnecting;

  const WalletWeb3Popup({
    super.key,
    this.onMetaMaskConnect,
    this.onTrustWalletConnect,
    this.isConnecting = false,
  });

  @override
  State<WalletWeb3Popup> createState() => _WalletWeb3PopupState();
}

class _WalletWeb3PopupState extends State<WalletWeb3Popup> {
  String selectedWallet = 'trustwallet';

  @override
  Widget build(BuildContext context) {

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
                onTap: widget.isConnecting ? null : () async {
                  setState(() {
                    selectedWallet = 'trustwallet';
                  });

                  // Call the Trust Wallet connection function
                  if (widget.onTrustWalletConnect != null) {
                    widget.onTrustWalletConnect!();
                    // Close the popup after initiating connection
                    Navigator.of(context).pop();
                  }
                },
                child: WalletWeb3Widget(
                  containerColor:
                      selectedWallet == 'trustwallet'
                          ? Color(0xFF0682A2)
                          : Color(0xFF393746),
                  imageUrl: "assets/trust.png",
                  text: widget.isConnecting ? "CONNECTING..." : "CONNECT-TRUSTWALLET",
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 4),
              GestureDetector(
                onTap: widget.isConnecting ? null : () async {
                  setState(() {
                    selectedWallet = 'metamask';
                  });

                  // Call the MetaMask connection function
                  if (widget.onMetaMaskConnect != null) {
                    widget.onMetaMaskConnect!();
                    // Close the popup after initiating connection
                    Navigator.of(context).pop();
                  }
                },
                child: WalletWeb3Widget(
                  containerColor:
                      selectedWallet == 'metamask'
                          ? Color(0xFF0682A2)
                          : Color(0xFF393746),
                  imageUrl: "assets/icon-metamask.png",
                  text: widget.isConnecting ? "CONNECTING..." : "CONNECT-METAMASK",
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
