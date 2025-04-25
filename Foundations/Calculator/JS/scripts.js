let expression = '';
let inputField = document.querySelector("#inputField");

document.querySelector("#backspace").addEventListener('click', () => {
    inputField.value = inputField.value.slice(0, -1);
});

document.querySelector("#allClear").addEventListener('click', () => {
    inputField.value = '';
    expression = '';
});

document.querySelectorAll(".number").forEach((button) => {
    button.addEventListener('click', () => {
        appendValue(button.textContent);
    });
});

document.querySelector("#point").addEventListener('click', () => {
    const currentValue = inputField.value;
    if (!currentValue.includes('.') && currentValue.length) {
        appendValue('.');
    }
});

document.querySelectorAll(".operation").forEach((button) => {
    button.addEventListener('click', (event) => {
        let target = event.target;
        const currentValue = inputField.value;
        if (currentValue.length > 0 && !isNaN(currentValue[currentValue.length - 1])) {
            switch (target.id) {
                case 'add':
                    appendValue('+');
                    inputField.value = '';
                    break;
                case 'sub':
                    appendValue('-');
                    inputField.value = '';
                    break;
                case 'div':
                    appendValue('/');
                    inputField.value = '';
                    break;
                case 'multi':
                    appendValue('*');
                    inputField.value = '';
                    break;
                case 'equal':
                    const result = operate(expression);
                    inputField.value = '';
                    inputField.value = result;
                    expression = result.toString();
                    break;
            }
        }
    });
});

function appendValue(value) {
    inputField.value += value;
    expression += value;
}

function operate(expression) {
    try {
        // Check if the expression has at least one operator and two numbers
        if (!/[+\-*/]/.test(expression)) {
            return 'Error: Invalid Expression';
        }

        const expressionArray = expression.split(/([+\-*/])/g).filter(token => token.trim() !== '');

        if (!expressionArray || expressionArray.length < 3) {
            return 'Error: Incomplete Expression';
        }

        // Converting the numbers to Number() type
        for (let i = 0; i < expressionArray.length; i++) {
            if (!isNaN(expressionArray[i])) {
                expressionArray[i] = Number(expressionArray[i]);
            }
        }

        // Handle multiplication and division
        for (let i = 1; i < expressionArray.length; i += 2) {
            const operator = expressionArray[i];
            if (operator === '*' || operator === '/') {
                const left = expressionArray[i - 1];
                const right = expressionArray[i + 1];
                const result = applyOperation(left, right, operator);
                expressionArray.splice(i - 1, 3, result); // Replace the operation with the result
                i -= 2; // Adjust index after splicing
            }
        }

        // Handle addition and subtraction
        let result = expressionArray[0];
        for (let i = 1; i < expressionArray.length; i += 2) {
            const operator = expressionArray[i];
            const right = expressionArray[i + 1];
            result = applyOperation(result, right, operator);
        }

        return result;
    } catch (error) {
        return 'Error: Calculation Failed';
    }
}

function applyOperation(left, right, operator) {
    switch (operator) {
        case '+':
            return left + right;
        case '-':
            return left - right;
        case '*':
            return left * right;
        case '/':
            if (left === 0 || right === 0) {
                return '!Error! !Division by 0!'
            }
            return left / right;
        default:
            return 'Unknown Operator.'
    }
}