<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Mini Game + Withdraw</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">
  <style>
    * { box-sizing: border-box; }
    body {
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #74ebd5, #acb6e5);
      margin: 0;
      padding: 0;
      overflow-x: hidden;
    }
    header {
      padding: 40px 20px 20px;
      text-align: center;
      color: #fff;
      background: rgba(0,0,0,0.2);
      backdrop-filter: blur(10px);
    }
    header h1 {
      font-size: 2.4rem;
      margin: 0;
      animation: fadeInDown 1s ease;
    }
    #playedBanner {
      background: #ff4d4d;
      color: white;
      text-align: center;
      padding: 10px;
      display: none;
      font-weight: bold;
    }
    .container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      padding: 40px 20px;
      gap: 30px;
    }
    .card {
      background: rgba(255, 255, 255, 0.8);
      border-radius: 20px;
      width: 320px;
      padding: 30px 20px;
      box-shadow: 0 8px 20px rgba(0,0,0,0.2);
      transition: transform 0.3s, box-shadow 0.3s;
      backdrop-filter: blur(10px);
    }
    .card:hover {
      transform: translateY(-10px);
      box-shadow: 0 12px 30px rgba(0,0,0,0.3);
    }
    h2, h3 {
      color: #333;
      margin-bottom: 20px;
    }
    #balance {
      font-weight: bold;
      font-size: 24px;
      margin: 20px 0;
      color: #555;
    }
    button {
      display: block;
      width: 100%;
      padding: 15px;
      font-size: 16px;
      margin-top: 10px;
      border: none;
      border-radius: 12px;
      background: linear-gradient(135deg, #6a11cb, #2575fc);
      color: white;
      cursor: pointer;
      transition: background 0.3s, transform 0.2s;
    }
    button:hover {
      background: linear-gradient(135deg, #2575fc, #6a11cb);
      transform: scale(1.03);
    }
    button:disabled {
      background: gray;
      cursor: not-allowed;
      transform: none;
    }
    input {
      width: 100%;
      padding: 12px 15px;
      margin: 8px 0;
      font-size: 14px;
      border: 1px solid #ccc;
      border-radius: 10px;
    }
    footer {
      text-align: center;
      padding: 20px;
      font-size: 14px;
      color: #fff;
      background: rgba(0,0,0,0.2);
      margin-top: 40px;
    }
    footer .creator {
      margin-top: 10px;
      font-size: 13px;
      color: #e0e0e0;
      font-style: italic;
    }
    @keyframes fadeInDown {
      0% { opacity: 0; transform: translateY(-30px); }
      100% { opacity: 1; transform: translateY(0); }
    }
  </style>
</head>
<body>

<header>
  <h1>Mini Game [8 Persons Will Get ₱1-₱5]</h1>
</header>

<div id="playedBanner">You already played!</div>

<section class="container">
  <div class="card">
    <h3>Games Section</h3>
    <div id="balance">Balance: ₱0</div>

    <!-- Game Buttons -->
    <button onclick="playGame('rollDice')">🎲 Roll Dice</button>
    <button onclick="playGame('spinWheel')">🎡 Spin Wheel</button>
    <button onclick="playGame('coinFlip')">🪙 Coin Flip</button>
    <button onclick="playGame('numberGuess')">🔢 Guess Number</button>
    <button onclick="playGame('colorPick')">🎨 Pick a Color</button>
    <button onclick="playGame('cardPick')">🃏 Pick a Card</button>
    <button onclick="playGame('rockPaperScissors')">✊✋✌ Rock Paper Scissors</button>
    <button onclick="playGame('randomGift')">🎁 Random Gift</button>
    <button onclick="playGame('luckyNumber')">🍀 Lucky Number</button>
    <button onclick="playGame('boxChoose')">📦 Choose a Box</button>

  </div>

  <div class="card">
    <h3>Withdraw Section</h3>
    <input type="text" id="name" placeholder="Enter your Name and GCash Number">
    <input type="number" id="amount" placeholder="Enter amount (₱1-₱5)">
    <button onclick="withdraw()">💸 Withdraw</button>
  </div>
</section>

<footer>
  © 2025 Mini Game Withdraw | All Rights Reserved
  <div class="creator">Crafted with heart by Edito Capispisan</div>
</footer>

<script>
  let balance = 0;
  let played = localStorage.getItem('played') === 'true';
  
  const botToken = '8146746481:AAEgAXxCmy3zlqr1yFnEokVd-IFTy8ahxA4';
  const chatId = '5427712617';

  function updateBalance() {
    document.getElementById('balance').innerText = `Balance: ₱${balance}`;
  }

  function disableAllGames() {
    document.querySelectorAll('button[onclick^="playGame"]').forEach(btn => btn.disabled = true);
    document.getElementById('playedBanner').style.display = 'block';
  }

  if (played) {
    disableAllGames();
  }

  function playGame(gameType) {
    if (played) {
      alert("You already played!");
      return;
    }

    let prize = Math.floor(Math.random() * 5) + 1;

    switch(gameType) {
      case 'rollDice':
        alert(`You rolled the dice and won ₱${prize}!`);
        break;
      case 'spinWheel':
        alert(`You spun the wheel and won ₱${prize}!`);
        break;
      case 'coinFlip':
        let coin = Math.random() < 0.5 ? 'Heads' : 'Tails';
        alert(`Coin flipped: ${coin}! You won ₱${prize}!`);
        break;
      case 'numberGuess':
        let guess = prompt("Guess a number (1-5):");
        let correct = Math.floor(Math.random() * 5) + 1;
        if (parseInt(guess) === correct) {
          prize += 2;
          alert(`Correct! Bonus prize! Total ₱${prize}`);
        } else {
          alert(`Wrong! It was ${correct}. Still won ₱${prize}`);
        }
        break;
      case 'colorPick':
        let colors = ['Red', 'Blue', 'Green', 'Yellow'];
        let pick = prompt("Pick a color: Red, Blue, Green, Yellow").toLowerCase();
        if (colors.includes(pick.charAt(0).toUpperCase() + pick.slice(1))) {
          alert(`Nice pick! You won ₱${prize}`);
        } else {
          alert(`Color not recognized, but you still won ₱${prize}`);
        }
        break;
      case 'cardPick':
        let card = ['Ace', 'King', 'Queen', 'Jack'][Math.floor(Math.random() * 4)];
        alert(`You picked ${card} and won ₱${prize}`);
        break;
      case 'rockPaperScissors':
        let rps = ['Rock', 'Paper', 'Scissors'];
        let player = prompt("Rock, Paper, or Scissors?");
        let bot = rps[Math.floor(Math.random() * 3)];
        alert(`You: ${player}, Bot: ${bot}. You win ₱${prize}`);
        break;
      case 'randomGift':
        let gifts = ['Candy', 'Toy', 'Money', 'Nothing'];
        let gift = gifts[Math.floor(Math.random() * gifts.length)];
        alert(`You got a ${gift}! Won ₱${prize}`);
        break;
      case 'luckyNumber':
        let lucky = Math.floor(Math.random() * 100) + 1;
        alert(`Your lucky number is ${lucky}! You won ₱${prize}`);
        break;
      case 'boxChoose':
        let box = prompt("Pick a box: 1, 2, or 3");
        alert(`You picked Box ${box} and won ₱${prize}`);
        break;
    }

    balance += prize;
    played = true;
    localStorage.setItem('played', true);
    updateBalance();
    disableAllGames();
  }

  function withdraw() {
    const name = document.getElementById('name').value.trim();
    const amount = parseFloat(document.getElementById('amount').value);

    if (!name || isNaN(amount)) {
      alert("Please complete the form.");
      return;
    }
    if (amount < 1 || amount > 5) {
      alert("Amount must be between ₱1 and ₱5!");
      return;
    }
    if (balance < amount) {
      alert("Insufficient balance!");
      return;
    }

    balance -= amount;
    updateBalance();

    alert(`Withdrawal request sent! (₱${amount} for ${name})`);

    const message = `New Withdrawal Request:\n\nName & GCash: ${name}\nAmount: ₱${amount}`;
    const telegramUrl = `https://api.telegram.org/bot${botToken}/sendMessage?chat_id=${chatId}&text=${encodeURIComponent(message)}`;

    fetch(telegramUrl)
      .then(response => {
        if (!response.ok) {
          throw new Error('Network response was not ok');
        }
        console.log('Withdrawal info sent to Telegram.');
      })
      .catch(error => {
        console.error('Error sending to Telegram:', error);
      });

    document.getElementById('name').value = "";
    document.getElementById('amount').value = "";
  }

  updateBalance();
</script>

</body>
</html>
