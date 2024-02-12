# Ibex
![Ibexes are superb climbers.](https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/003_Wild_Alpine_Ibex_Sunset_Creux_du_Van_Mont_Racine_Photo_by_Giles_Laurent.jpg/440px-003_Wild_Alpine_Ibex_Sunset_Creux_du_Van_Mont_Racine_Photo_by_Giles_Laurent.jpg)

An ibex is a mountain-climbing goat. 
Another kind of Ibex is Spain's `IBEX 35` stock index -- we have no affiliation or connection.


## Ibex aims to be an unofficial Elixir wrapper for the Interactive Brokers TWS API. 

A focus on excellent concurrency, stability, and ease of use. 
Current thinking is to value software quality over feature completeness, so start with a small subset of functionality that works to a high standard and is maintainable, documented, polished. 
Then grow the API.

---

## First step: a tiny subset of the api allowing Elixir apps to 
1. Connect to the TWS API via a TCP connection using a dedicated GenServer. DONE
2. Subscribe to historical market data. IN PROGRESS
3. Subscribe to live data. TODO
~~4. Subscribe to an economic calendar. TODO~~

   At first, data will mean futures and spot FX data, then stocks, bonds, futures and stock options, etc.


### The subsequent step will focus on getting and sending orders and streaming trading account data.


## Installation
 Ibex will be on Hex.pm once we've finished "first step" goals above.

<!-- ```elixir -->
<!-- def deps do -->
  <!-- [ -->
    <!-- {:ibex, "~> 0.1.0"} -->
  <!-- ] -->
<!-- end -->
<!-- ``` -->
<!--  -->
<!-- Once published, the docs will -->
<!-- be found at <https://hexdocs.pm/ibex>. -->


----

DISCLAIMERS:
- Unofficial and inchoate. 
- May contain bugs and other errors.
- No warranty and no guarantee. Test in paper account exhaustively and review the code closely. Use at your own risk.
- Nothing in this repo constitutes financial advice.
- Authors accept no responsibility of any kind.

