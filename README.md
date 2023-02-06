# PERX Challenge

Very simple app that loads a list of medication using FDA API and displays in a table view. You can click on a medication to view some more detail about it. There is definitely room for improvement on UI and amound of detail if more time could be put towards this.

## Implementation

MainViewController implements the list of medications. This uses the network client to call the API. This includes search and pagination. Filtering/sorting could be added easily.

DetailViewController displays details about the medication in a stack view. There is more detail in the response so that could be added easily.

## Testing

There are 3 tests which check that the search API call works. The 3 scenarios are no search text, pagination (with no search text) and a call with search text.
