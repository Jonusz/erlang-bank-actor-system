# erlang-bank-actor-system
Erlang-based actor system modeling concurrent bank transactions. Implements Mobile App, Bank, and Account actors communicating via message passing. Developed for the 2025 PCPP course at ITU.

## The Actor Model Approach to Concurrency

The Actor model approaches concurrent programming by utilizing independent, concurrently executing entities (actors) that communicate exclusively through asynchronous message passing, rather than relying on shared memory. By enforcing a strict "no shared state" architecture, this paradigm eliminates the need for complex synchronization mechanisms like locks. Consequently, it inherently prevents common concurrency issues such as data races, enabling the development of highly scalable, fault-tolerant, and distributed systems.

## What it Simulates

It models a banking transaction system using three types of actors:
* **Mobile Apps:** These actors send transactions to the bank corresponding to mobile payments.
* **Banks:** These actors are responsible for executing the transactions received from the mobile app. That is, substracting the money from the payer account and adding it to the payee account.
* **Accounts:** This actor type models a single bank account. It contains the balance of the account. 

Because Erlang actors process messages strictly sequentially from their mailboxes, data races cannot occur when updating the balances.

## How to Run and Test

1. **Start the Erlang shell** in your terminal from the directory containing the `.erl` files.
2. **Compile the system starter module:**
   ```erlang
   1> c(system_starter).
   ```
3. **Initialize the system:** This spawns the actors (2 Mobile Apps, 2 Banks, 2 Accounts) and returns their Process IDs (PIDs):
This spawns the actors (2 Mobile Apps, 2 Banks, 2 Accounts) and returns their Process IDs (PIDs):
  ```erlang
    2> {MA1, MA2, B1, B2, A1, A2} = system_starter:system_start2().
  ```
4. **Execute a batch of transactions:**
Use the Mobile App actor to send a batch of requests (e.g., sending 5 requests of 1 DKK from Account 1 to Account 2 via Bank 1):
  ```erlang
    3> mobile_app:send_N_requests(MA1, 5, B1, A1, A2).
  ```
