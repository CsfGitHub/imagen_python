/*
GAME FUNCTION:
- Player must guess a number between a min and max
- Player gets a certain amount of guesses
- Notify player of guesses remaining
- Notify the player of the correct answer if loose
- Let player choose to play again
*/

// Game values
let min = 1,
    max = 3,
    winninNum = getRandomNumber(min,max),
    guessesLeft = 1;

// UI Elements
const game = document.querySelector('#game'),
      minNum = document.querySelector('.min-num'),
      maxNum = document.querySelector('.max-num'),
      guessBtn = document.querySelector('#guess-btn'),
      guessInput = document.querySelector('#guess-input'),
      message = document.querySelector('.message');

// Assign UI Min and max
minNum.textContent = min;
maxNum.textContent = max;

// PLay Again EL
game.addEventListener('mousedown',function(e){
  if(e.target.className === 'play-again'){
    window.location.reload();
    
    // guessesLeft = 3;
    // guessBtn.value = 'Submit';
    // guessBtn.className = 'submit';
    // // Enable input
    // guessInput.disabled = false;
    
  }
})

// Liste to Guess
guessBtn.addEventListener('click',function (){
  let guess = parseInt(guessInput.value);

// Validate our Input
if(guess === NaN || guess < min || guess > max){
  setMessage(`Por favor introduce un número entre ${min} y ${max}`, 'red');
}
else if (guess === winninNum){
  gameOver(true,`¡Acertaste!, era el ${winninNum}`);
}else{
  guessesLeft -= 1;
  if (guessesLeft === 0){
     gameOver(false,`¡GAME OVER, PERDISTE!, era el ${winninNum}`);
  }else{
    //Change border color
    guessInput.style.borderColor = 'red';
    // CLear the input
    guessInput.value = '';
    // GAme continues answer wrong
    setMessage(`¡Fallaste!, te quedan ${guessesLeft} intentos`, 'red');
  }

}

});

// Game Over
function gameOver(won,msg){
  let color;
  won === true? color = 'green' : color = 'red';

  // Disable input
  guessInput.disabled = true;
  // Change border color
  guessInput.style.borderColor = color;
  // set message to won
   setMessage(msg, color);

   // Play again
    guessBtn.value = 'Play Again';
    guessBtn.className += 'play-again';
}

// Get winning Number

function getRandomNumber(min,max){
  return(Math.floor(Math.random()*(max-min+1) + min));
}

function setMessage(msg,color){
  message.textContent = msg;
  message.style.color = color;
}