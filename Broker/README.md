# Broker Solution

I must say that I struggled with this solution a lot, but that's just because I was trying to think of attack vectors that would make it profitable for the attacker.

After about an hour and a half, I realized that this CTF is not about making a profit but about Capturing The Flag.

## Solution

To solve this challenge, we need to get the balance of the Broker contract to < 5 Ether.

From the setup contract, we can see that the contract borrowed 250 000 tokens.

The key to this challenge lies in the rate() function. Because solidity doesn't support decimal numbers, division without first multiplying is very dangerous. If the denominator is bigger than the numerator, the result will be just 0.

So all we need to do is buy up many tokens from the Uniswap pool. This will achieve two things.

1. We will have enough tokens to liquidate the Setup contract
2. rate() function will return 0 thus making safeDebt() function also 0.

Now we can just call liquidate() function, and we solved the challenge.
