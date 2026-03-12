-module(mobile_app).
-export([start/0, loop/0, send_N_requests/5]). % functions to be exported. /0 means taking 0 arguments

%% define a start(...) function that spawns a mobile app actor
start() -> 
    spawn(fun() -> loop() end). % create the actor (process) that runs in parallel

%% define a init(...) function that initalizes the state of the mobile app actor
%% (not needed, our functions do not require any state)

% this allow to call mobile_app:send_N_requests(...) from shell
send_N_requests(MobileAppPid, N, BankPid, FromAcc, ToAcc) ->
    MobileAppPid ! {send_N_requests, BankPid, N, FromAcc, ToAcc}.

%% loop(...) function with the behavior of the mobile app actor upon receiving messages
loop() -> % recurion loop, it call itself to keep the actor alive
    receive 
        %% The user sends this command to the App actor
        {payment_request, BankPid, FromAcc, ToAcc, Amount} -> %pattern matching %% payment request is an atom, what is special variable containing id/tag
            io:format("MobileApp: Requesting payment...~n"), % print to console
            %% The App forwards it to the Bank as a transaction
            BankPid ! {transaction, FromAcc, ToAcc, Amount}, % "!" is send operator, message sent to BankPid
            % first element is called atom, the rest are arguments. Atom is like a title of a message
            loop();
        {send_N_requests, BankPid, N, FromAcc, ToAcc} ->
            lists:foreach(fun(I) -> % as I know there are no for loops in Erlang, we use lists:foreach to iterate
                io:format("MobileApp: Sending request ~p of ~p~n", [I, N]),
                BankPid ! {transaction, FromAcc, ToAcc, 1}
            end, lists:seq(1, N)), % generate list from 1 to N, it is neccessary for foreach to be able to itarate
            loop()
    end.