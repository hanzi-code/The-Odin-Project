function playGame() {
    let winnerTxt = document.querySelector(".winner");
    let roundTxt = document.querySelector(".round-text");
    let buttons = document.querySelectorAll("button");

    let humanScore = 0;
    let computerScore = 0;

    // Gets the computer choice with the Math.random() func
    function getComputerChoice() {
        let choice = Math.floor(Math.random() * 3) + 1;

        if (choice === 1) {
            return "Paper";
        } else if (choice === 2) {
            return "Rock";
        } else {
            return "Scissors";
        }
    }

    // Gets the player choice, the player can choose betweem 3 buttons
    buttons.forEach(button => {
        button.addEventListener('click', (event) => {
            let target = event.target;

            let getHumanChoice;
            switch (target.id) {
                case 'rock':
                    getHumanChoice = 'Rock';
                    break;
                case 'paper':
                    getHumanChoice = 'Paper';
                    break;
                case 'scissors':
                    getHumanChoice = 'scissors';
                    break;
            }
            // Assign user choices and call the round
            let computerChoice = getComputerChoice().toLowerCase();
            let humanChoice = getHumanChoice.toLowerCase();
            let result = playRound(humanChoice, computerChoice);
            humanScore = result.humanScore;
            computerScore = result.computerScore;
            winnerTxt.textContent = `Human ${humanScore} - Computer ${computerScore}`;

            // Check if human or machine already won.
            if (humanScore === 5) {
                console.log("Human Wins!");
                winnerTxt.textContent = "Human Wins!";
                roundTxt.textContent = `Final score is: Human ${humanScore} - Computer ${computerScore}`;
                humanScore = 0;
                computerScore = 0;
            } else if (computerScore === 5) {
                console.log("Computer Wins!");
                winnerTxt.textContent = "Computer Wins!";
                roundTxt.textContent = `Final score is: Computer ${computerScore} - Human ${humanScore}`;
                humanScore = 0;
                computerScore = 0;
            }
        });
    });

    function playRound(humanChoice, computerChoice) {
        // Check if the round was a tie and return no points
        if (computerChoice === humanChoice) {
            roundTxt.textContent = `Tie - Human Played ${capitalize(humanChoice)} and Computer Played ${capitalize(computerChoice)}`;
            return { humanScore, computerScore };
        }

        // Check if the computer wins if so return it as a object with
        // one more point
        if (computerChoice === "paper" && humanChoice === "rock") {
            roundTxt.textContent = "You lose! Paper beats Rock";
            return { humanScore, computerScore: computerScore + 1 };
        } else if (computerChoice === "scissors" && humanChoice === "paper") {
            roundTxt.textContent = "You lose! Scissors beats Paper";
            return { humanScore, computerScore: computerScore + 1 };
        } else if (computerChoice === "rock" && humanChoice === "scissors") {
            roundTxt.textContent = "You lose! Rock beats Scissors";
            return { humanScore, computerScore: computerScore + 1 };
        }

        // Check if the human wins if so return it as a object with
        // one more point
        if (humanChoice === "paper" && computerChoice === "rock") {
            roundTxt.textContent = "You win! Paper beats Rock";
            return { humanScore: humanScore + 1, computerScore };
        } else if (humanChoice === "scissors" && computerChoice === "paper") {
            roundTxt.textContent = "You win! Scissors beats Paper";
            return { humanScore: humanScore + 1, computerScore };
        } else if (humanChoice === "rock" && computerChoice === "scissors") {
            roundTxt.textContent = "You win! Rock beats Scissors";
            return { humanScore: humanScore + 1, computerScore };
        }
    }

    // This function is just to capitalize the letters that appear on the canvas of the browser
    function capitalize(word) {
        let capitalized = word[0].toUpperCase() + word.slice(1);
        return capitalized;
    }
}

playGame();
