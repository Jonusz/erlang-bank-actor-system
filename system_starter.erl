-module(system_starter).
-export([system_start2/0, run_test/0, do_N_transfers/0]).

%% Requirement 1: Start 2 apps, 2 banks, 2 accounts
system_start2() ->
    %% Start Accounts with initial balance of 100
    A1 = account:start(100),
    A2 = account:start(100),
    
    %% Start Banks
    B1 = bank:start(),
    B2 = bank:start(),
    
    %% Start Mobile Apps
    MA1 = mobile_app:start(),
    MA2 = mobile_app:start(),
    
    %% Print the Pids so we can see them (optional)
    io:format("System started.~n"),
    io:format("A1: ~p, A2: ~p~n", [A1, A2]),
    io:format("MA1: ~p, MA2: ~p~n", [MA1, MA2]),
    
    %% Return all Pids in a tuple so we can use them later
    {MA1, MA2, B1, B2, A1, A2}.

run_test() ->
    %% 1. Start the system, initialie all actors
    {MA1, MA2, B1, B2, A1, A2} = system_start2(),
    
    Amount = 10,
    
    %% 2. Transaction from A1 to A2 via MA1
    io:format("Test: Requesting transfer of ~p from A1 to A2 via MA1...~n", [Amount]),
    MA1 ! {payment_request, B1, A1, A2, Amount}, %% payment request is an atom, what is special variable containing id/tag
    
    %% 3. Transaction from A2 to A1 via MA2
    io:format("Test: Requesting transfer of ~p from A2 to A1 via MA2...~n", [Amount]),
    MA2 ! {payment_request, B2, A2, A1, Amount},
    
    ok.

do_N_transfers() ->
    %% 1. Start the system
    {MA1, _MA2, B1, _B2, A1, A2} = system_start2(), % we underscore variables we do not use
    
    %% 2. Trigger 100 transactions of 1 DKK from A1 to A2
    %% Note: We use the helper function from mobile_app
    %% we should call it like this mobile_app:send_N_requests(MA1, 5, B1, A1, A2).
    
    ok.