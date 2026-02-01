const express = require('express');
const path = require('path');
const dgram = require('dgram');
const app = express();
const udpClient = dgram.createSocket('udp4');

app.use(express.json());

// Serve the controller page
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});

// Handle Input
app.post('/input', (req, res) => {
    const { ip, btns, cp_val, cs_val } = req.body;

    if (ip) {
        const packet = Buffer.alloc(20);
        
        // 1. Standard Inputs (Face Buttons, D-Pad, Triggers)
        // We write 'btns' directly because index.html handles all the polarity logic.
        packet.writeUInt32LE(btns >>> 0, 0); 
        packet.writeUInt32LE(0x02000000, 4); // Touchscreen / Special flags
        packet.writeUInt32LE(cp_val, 8);     // Circle Pad
        
        // 2. IR Header (Static Connected State)
        // We do NOT map ZL/ZR here anymore. They are handled in the standard button packet.
        packet.writeUInt8(0x81, 12); 
        packet.writeUInt8(0, 13);        
        
        // 3. C-Stick (Already Rotated by Client)
        // Luma expects Y-Axis at Offset 14, X-Axis at Offset 15
        const cX = cs_val & 0xFF;        
        const cY = (cs_val >> 8) & 0xFF; 
        
        packet.writeUInt8(cY, 14); 
        packet.writeUInt8(cX, 15); 
        
        packet.writeUInt32LE(0, 16); 

        // Send UDP Packet to 3DS Port 4950
        udpClient.send(packet, 4950, ip, (err) => {
            if (err) console.error(err);
        });
    }
    res.sendStatus(200);
});

const PORT = 3000;
app.listen(PORT, () => console.log(`\n2DS Bridge running on port ${PORT}`));
