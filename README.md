# Roulette Simulator
This project simulates betting systems on roulette, such as Martingale and Inverse Labouchère, to
demonstrate the inevitability of losses to the house over time.
## Features
- Simulates popular betting strategies like Martingale and Inverse Labouchère.
- Provides statistical analysis of outcomes over multiple rounds.
- Customizable parameters, including initial budget, bet size, and maximum table limit.
## How It Works
1. **Martingale System**: Doubles the bet after every loss to recover previous losses and gain a
profit equal to the initial bet size.
2. **Inverse Labouchère System**: Cancels out numbers from a sequence after a win and adds
them after a loss.
3. The simulation demonstrates how house rules (like table limits) and probabilities ultimately lead to
the loss of funds.
## Requirements
- Bash shell environment.
- No additional dependencies required.
Page 1
Roulette Simulator - README
## Installation
1. Clone the repository:
```bash
git clone https://github.com/FJLdx/roulette-simulator.git
```
2. Navigate to the project directory:
```bash
cd roulette-simulator
```
3. Make the script executable:
```bash
chmod +x ruleta.sh
```
## Usage
Run the script with:
```bash
./ruleta.sh
```
Customize parameters directly in the script for different simulations.
Page 2
Roulette Simulator - README
## Example Output
- Starting balance: $1000
- Bet size: $10
- System: Martingale
Result: Loss after 36 rounds due to table limit.
## Contributing
Contributions are welcome! Please fork the repository and create a pull request for any
improvements or new features.
## License
This project is licensed under the MIT License.
