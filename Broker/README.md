# Broker Solution

I must say that I strugled with this solution a lot but that's just because I was trying to think of attack vectors that would make it profitable for the attacker.

After about hour and a half I realized that this CTF is not about making the profit but it's about Capturing The Flag.

## Solution

To solve this challange we need to get the balance of the Broker contract to < 5 Ether.

From the setup contract we can see that the contract borrowed 250 000 tokens.

The key to this challange lies in the rate() function. Because solidity doesn't support decimal numbers division without first multiplying it is very dangerous. If the denominator is bigger than the numerator the result will be just 0.

So all we need to do is to buy up a lot of tokens from the Uniswap pool. This will achieve two things.

1. We will have enough tokens to liquidate the Setup contract
2. rate() function will return 0 thus making safeDebt() function also 0.

Now we can just call liquidate() function and we solved the challenge.
