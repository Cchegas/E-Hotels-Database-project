const express = require('express');
const path = require('path');
const app = express();
const PORT = 8081;

app.get('/', (req, res) => {
    const filePath = path.join('/Users/stoneterrysheldor/Desktop/Uottawa/2023-2024/WInter/CSI2132/Project/front_end', 'webpg.html');
    res.sendFile(filePath);
});

app.listen(PORT, () => console.log(`Server is live on http://localhost:${PORT}`));

app.use(express.static('/Users/stoneterrysheldor/Desktop/Uottawa/2023-2024/WInter/CSI2132/Project/front_end'));
app.use(express.static('/Users/stoneterrysheldor/Desktop/Uottawa/2023-2024/WInter/CSI2132/Project/front_end/img'));