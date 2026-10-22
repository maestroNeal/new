# Add any feeback or comments in this README

## What I did

All 7 tasks are done.

1. Repository - Changed DispatchGroup to async/await. All banks still load at the same time.
2. Merge lists - Wrote combineTwoSortedLists. It walks through both lists at the same time so it runs in O(n). I used a Set to skip duplicates.
3. Cell design - Made a new row view and a view model for it (MVVM). Deposits show in green, the description goes up to 2 lines and then shows "...".
4. Search - Added a search bar at the top of the list. It starts filtering after 3 characters, ignores upper/lower case and updates while typing.
5. KD bank - Added KDService and a new KD source with a green colour.
6. Loading - A full screen spinner shows while the data is loading and hides when it is done.
7. Unit tests - Added 5 tests for combineAndSortTransactions.

## Assumptions

- The comments in TransactionUtilities say "earliest to latest" but the task says latest to oldest. I went with the task and did not change the comments.
- Duplicates are checked using the == that was already in the project. Same transaction from two different banks is not a duplicate.
- Spaces count towards the 3 characters in search.
- Amounts are shown as US$ like in the design. I did not convert currencies.
- If tags don't fit in one line they get cut off with "...".
- For KD, withdrawals use the "to" name and deposits use the "from" name. If tags are null I treat it as no tags.

## Things I noticed but did not change

- BKO ignores isDeposit, so BKO deposits show up like withdrawals (not green).
- If an API call fails the app just shows an empty list. It would be nice to show an error message.
