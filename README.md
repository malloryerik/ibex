# Ibex
![Ibexes are superb climbers.](https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/003_Wild_Alpine_Ibex_Sunset_Creux_du_Van_Mont_Racine_Photo_by_Giles_Laurent.jpg/440px-003_Wild_Alpine_Ibex_Sunset_Creux_du_Van_Mont_Racine_Photo_by_Giles_Laurent.jpg)

An Ibex is a mountain-climbing goat. 
Another kind of Ibex is Spain's `IBEX 35` stock index -- we have no affiliation or connection.


##### Aims to be an Elixir wrapper for the Interactive Brokers TWS API with a focus on correct concurrency, stability, and ease of use.
- Unofficial and inchoate. 
- May contain bugs and other errors.
- No warranty and no guarantee. Test in paper account exhaustively. Use at your own risk.
- Authors accept no responsibility of any kind.
- Nothing in this repo constitutes financial advice.
---

## First step: a tiny subset of the api allowing Elixir apps to 
1. subscribe to historical market data 
2. subscribe to live data
3. subscribe to an economic calendar. 
   At first, data will mean futures and spot FX data, then stocks, bonds, etc. 

 TODO TCP Connection: Implement the TCP connection logic using :gen_tcp.
 TODO GenServer for Market Data: Create a GenServer that handles subscriptions to market data.
 TODO Implement Callbacks: Start with a few critical callbacks from the EWrapper interface to handle market data.
 TODO Documentation.




 ## Installation
 Ibex will be on Hex.pm once we've finished the above goals.

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
