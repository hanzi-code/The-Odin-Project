let container = document.querySelector("#container");
let sizeBtn = document.querySelector("#prompt-grid");
let resetBtn = document.querySelector("#reset")
let rgbBtn = document.querySelector("#rgb")
let blackBtn = document.querySelector("#black")

// The default grid size
let gridSize = 16;
let currentGridSize = gridSize;

resetBtn.addEventListener("click", () => resetGrid(currentGridSize));
rgbBtn.addEventListener("click", () => rgbBrush(currentGridSize));
blackBtn.addEventListener("click", () => blackBrush(currentGridSize));

// Gets the size of the grid from a prompt input
sizeBtn.addEventListener("click", () => {
    let newSize = +prompt("Type the size you want (1-100):", "16");
    if (gridSize !== null && newSize >= 1 && newSize <= 100) {
        currentGridSize = newSize;
        createGrids(newSize);
    } else {
        alert("Invalid Input. Please Enter a number between 1 and 100");
    }
});

// Reset so you have a blank grid, maintaining the size
function resetGrid(gridSize) {
    let cellGrid = container.children;
    for (let i = 0; i < gridSize * gridSize; i++) {
        cellGrid[i].style.backgroundColor = "white"
    }
}

// Gets a random color
function randomColor() {
    let values = "ABCDEF0123456789";
    let color = "#";
    for (let i = 0; i < 6; i++) {
        color += values[Math.floor(Math.random() * 16)];
    }
    return color;
}

// This makes the colors of the user brush random or like a rainbow
function rgbBrush(gridSize) {
    let cellGrid = container.children;
    for (let i = 0; i < gridSize * gridSize; i++) {
        cellGrid[i].addEventListener("mouseover", (event) => {
            event.target.style.backgroundColor = randomColor();
        });
    }
}

// Changes the color of the brush to black
function blackBrush(gridSize) {
    let cellGrid = container.children;
    for (let i = 0; i < gridSize * gridSize; i++) {
        cellGrid[i].addEventListener("mouseover", (event) => {
            event.target.style.backgroundColor = "black";
        });
    }
}

// Creates the grid based on the user input
function createGrids(gridSize) {
    container.innerHTML = "";

    container.style.gridTemplateColumns = `repeat(${gridSize}, 1fr)`;
    container.style.gridTemplateRows = `repeat(${gridSize}, 1fr)`;

    for (let i = 0; i < gridSize * gridSize; i++) {
        const grid = document.createElement("div");
        grid.classList.add("grid-cell");

        grid.addEventListener("mouseover", function(event) {
            event.target.style.backgroundColor = "black";
        });

        container.appendChild(grid);
    }
}

createGrids(currentGridSize);