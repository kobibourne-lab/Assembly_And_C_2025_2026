Test Plan 

All tests were done manually by running ./main and typing different inputs.
Test Cases

Test 1 - Valid Input
Entered 1 and 1 for three loops. Expected final total of 6.
Got "The sum is: 2" three times and "Final sum is: 6". 

Test 2 - Letter Input
Typed the letter a instead of a number. Expected an error and re-prompt.
Got "Invalid input!" and it asked again.

Test 3 - Special Character
Typed ! instead of a number. Same result as the letter test. .

Test 4 - Number Too Low
Entered 0 - below the minimum of 1. Expected it to be rejected.
Got "Invalid input!" and it asked again. 

Test 5 - Number Too High
Entered 10001- above the maximum. Expected it to be rejected.
Got "Invalid input!" and it asked again.

Test 6 - Invalid Then Valid
Typed letter first followed by a valid number. Expected one error then normal.
Got the error once then it continued through the loops correctly.

Test 7 - Current Total
Entered 2+3, 4+5, 6+7 across the three loops. Expected total of 27.
Got correct sum each loop and the correct total.
ALL TESTS PASSED 
