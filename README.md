# 3DS Controller Bridge 🎮
> A lightweight Node.js bridge to use modern controllers (Switch ProCon tested) on a New 3DS/2DS XL via Luma3DS Input Redirection.

## ❓ Why does this exist?
I looked for Input Redirection app to use on Android but have failed to find any that can be installed in modern android device. So I have used Gemini as my coding slave and made this.
Cleanest method to do this only on the phone was to build a web page which only runs on your local network.
**3DS Controller Bridge** runs a lightweight server directly on your phone via **Termux**. It reads your controller input via the Chrome Web Gamepad API and fires it straight to the 3DS via UDP. It includes a specific **135° rotation matrix** and **Hybrid Polarity Logic** to ensure your controller works perfectly with zero configuration.

## ✨ Features
* **Direct UDP Connection:** No PC required. Runs 100% on your phone straight to your custom firmwared 3/2DS.
* **Low Latency:** Uses raw UDP packets over your local WiFi.
That's all I needed anyways. 

---

## 🚀 Quick Install (One Command)
Open **Termux** (F-Droid version) and paste this single command. It will install Node.js, download the app, and launch it automatically.

```bash
pkg install curl -y && bash <(curl -s [https://raw.githubusercontent.com/vonhoon81/3dsControllerBridge/main/install.sh](https://raw.githubusercontent.com/vonhoon81/3dsControllerBridge/main/install.sh))
