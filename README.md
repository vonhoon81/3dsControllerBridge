# 3DS Controller Bridge 🎮
> A lightweight Node.js bridge to use modern controllers (Switch ProCon tested) on a New 3DS/2DS XL via Luma3DS Input Redirection.

## ❓ Why does this exist?
While 3DS consoles are great, the controller components are the worst things in 2026. 
They are not comfortable and simply not built to last.

So, I started looking into ways to use modern controllers with 3DS devices, hopefully using only my phone. 
But I couldn't find a single Input Redirection app that survived the update to modern Android.

Out of options, I forced Gemini to be my coding slave and we hacked this together.

The result is a lightweight server that runs locally on your phone via Termux. 
It translates Chrome Gamepad API inputs into UDP packets for the 3DS, complete with a 135° rotation matrix (yes, that was very puzzling) and Hybrid Polarity Logic.

And now it just works, so I share.

## ✨ Features
* **Direct UDP Connection:** No PC required. Runs 100% on your phone straight to your custom firmwared 3/2DS.
* **Low Latency:** Uses raw UDP packets over your local WiFi.
That's all I needed anyways. 

---

## 🚀 Quick Install (One Command)
Open **Termux** (F-Droid version) and paste this single command. It will install Node.js, download the app, and launch it automatically.

```bash
pkg update -y && bash <(curl -s https://raw.githubusercontent.com/vonhoon81/3dsControllerBridge/main/install.sh)
```

--- 

## Running on Termux
```bash
node ~/3ds-bridge/server.js > /dev/null 2>&1 & sleep 1 && am start -a android.intent.action.VIEW -d http://localhost:3000
```

---

## 🎮 How to Use this

1.  **On your 3DS:**
    * Press `L + Down + Select` to open Rosalina Menu.
    * Go to `Miscellaneous options` > `Start Input Redirection`.
    * Note the **IP Address** shown on the top screen.

2.  **On your Phone:**
    * Connect a controller to your phone.
    * Open Termux and Run this server
    ```bash 
     node ~/3ds-bridge/server.js > /dev/null 2>&1 & sleep 1 && am start -a android.intent.action.VIEW -d http://localhost:3000
     ```
    * Chrome will open automatically.
    * **Press a button** on your controller to wake it up.

3.  **Connect:**
    * Enter the **3DS IP Address** in the box.
    * Start playing!
