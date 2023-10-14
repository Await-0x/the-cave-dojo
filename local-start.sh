# sozo migrate --name test

sozo auth writer Game start_game --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"
sozo auth writer Draft start_game --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"
sozo auth writer DraftOption start_game --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"

sozo auth writer Draft draft_card --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"
sozo auth writer DraftOption draft_card --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"
sozo auth writer DeckCard draft_card --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"
sozo auth writer Game draft_card --world "0x84486b8e9ffe38978b33c9d7685d9d2d487d0e9f096a1d2669edefc8506c35"