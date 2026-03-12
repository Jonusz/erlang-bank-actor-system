% raup@itu.dk * 2024-11-14

-module(account).
-export([start/1, loop/1]).

%% Start an account with an initial balance (e.g., 100)
start(InitialBalance) -> % initialization of state balance, passed as argument
    spawn(fun() -> loop(InitialBalance) end).

%% The loop holds the state (Balance)
loop(Balance) ->
    receive
        {deposit, Amount} ->
            NewBalance = Balance + Amount,
            io:format("Account: Received deposit of ~p. New Balance: ~p~n", [Amount, NewBalance]),
            loop(NewBalance);
        print_balance ->
            io:format("Account: Balance: ~p~n", [Balance]),
            loop(Balance)
    end.


