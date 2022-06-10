# Bouncer Solution

While I did solve the challenge on my own, I didn't know exactly how to exploit it, so I had to look up the actual exploit.

## Vulnerability

This vulnerability almost cost SushiSwap 350 million dollars.

The problem is that you can't include msg.value in a loop. If you do, the attacker can batch multiple calls to the function and send just one eth but the msg.value will be equal to 1 eth through all the calls.

So you can pay just one eth then have seven calls, and the contract will think you sent one eth with each call.
