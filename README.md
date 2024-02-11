# Ibex
![Ibexes are superb climbers.](https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/003_Wild_Alpine_Ibex_Sunset_Creux_du_Van_Mont_Racine_Photo_by_Giles_Laurent.jpg/440px-003_Wild_Alpine_Ibex_Sunset_Creux_du_Van_Mont_Racine_Photo_by_Giles_Laurent.jpg)
An Ibex is an amazing mountain-climbing goat. 
Another kind of Ibex is Spain's `IBEX 35` stock index -- no connection.


##### Aims to be an Elixir wrapper for the Interactive Brokers TWS API with a focus on correct concurrency, stability, and ease of use. 
- Unofficial and inchoate. 
- May contain bugs and other errors.
- No warranty and no guarantee. Test in paper account exhaustively. Use at your own risk.
- Author(s) accept no responsibility of any kind.
- Nothing in this repo constitutes financial advice.
---

## First step: a tiny subset of the api allowing Elixir apps to subscribe to live and historical futures market data. Maybe FX data also.

# TODO TCP Connection: Implement the TCP connection logic using :gen_tcp.
# TODO GenServer for Market Data: Create a GenServer that handles subscriptions to market data.
# TODO Implement Callbacks: Start with a few critical callbacks from the EWrapper interface to handle market data.
# TODO Documentation.




<!-- ## Installation -->
<!--  -->
<!-- If [available in Hex](https://hex.pm/docs/publish), the package can be installed -->
<!-- by adding `ibex` to your list of dependencies in `mix.exs`: -->
<!--  -->
<!-- ```elixir -->
<!-- def deps do -->
  <!-- [ -->
    <!-- {:ibex, "~> 0.1.0"} -->
  <!-- ] -->
<!-- end -->
<!-- ``` -->
<!--  -->
<!-- Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc) -->
<!-- and published on [HexDocs](https://hexdocs.pm). Once published, the docs can -->
<!-- be found at <https://hexdocs.pm/ibex>. -->


----
