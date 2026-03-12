% raup@itu.dk * 2024-11-14

%% export any necessary functions
-module(bank).
-export([start/0, loop/0]). % functions to be exported. /0 means taking 0 arguments

%% define the bank actor state


%% define a start(...) function that spawns a bank actor
start() ->
    spawn(fun() -> loop() end). % create the actor (process) that runs in parallel

%% define a init(...) function that initalizes the state of the bank actor


%% loop(...) function with the behavior of the bank actor upon receiving messages
loop() ->
    receive
        {transaction, FromAcc, ToAcc, Amount} ->
            io:format("Bank: Processing transfer of ~p from ~p to ~p ~n", [Amount, FromAcc, ToAcc]),
            %% 1. Withdraw from Payer (send negative deposit)
            FromAcc ! {deposit, -Amount},
            %% 2. Deposit to Payee (send positive deposit)
            ToAcc ! {deposit, Amount},
            loop()
    end.