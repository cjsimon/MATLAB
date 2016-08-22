function guess(debug)
    % The number to guess. Generate a rand integer from 1 to 20
    min = 1;
    max = 20;
    answer = randi([min, max]);
    % Number of guesses
    guessCount = 1;
    
    % If debug mode is on, display the number to guess
    if debug == true
        fprintf('Answer: %d\n\n', answer);
    end
    
    fprintf('Guessing Game!\n');
    fprintf('--------------\n');
    while true
        % Get the user input guess
        guessMessage = sprintf('\nGuess what number Im thinking of from %d to %d: ', min, max);
        guess = input(guessMessage);
        
        % Stop guessing if the guess is the answer
        if guess == answer
            % Correct Guess
            break;
        end
        
        % Incorrect Guess
        if guess > answer
            hlMessage = 'lower';
        else
            if guess < answer
            hlMessage = 'higher';
            end
        end
        fprintf('Incorrect! Guess %s!\n', hlMessage)
        
        % Incrament the guessCount
        guessCount = guessCount + 1;
    end
    % Check if the user guessed it right on the first try
    if guessCount == 1
        % First try!
        message = 'Wow! You got it on your first try!';
        fprintf(message)
    else
        % Not the first try. Indicate how many tries it took the user
        message = 'Correct! It took you %d tries to guess %d!\n';
        fprintf(message, guessCount, answer);
    end
end