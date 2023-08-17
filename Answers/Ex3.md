# Goal: to implement an algorithm and a data structure to solve an alternative version of the classic producer- consumer problem by providing some appropriate mechanisms to terminate the waits of consumers.##
For every combination of fairness and interruptibility level, show whether a system can exist or not, selecting a formalism to use in the proofs (there are four in total, weak faireness-weak interruptibility, weak faireness-strong interruptibility, etc.). In the cases where a system exists, show rigorously that both properties are met (by resorting to the selected formalism)

To analyze the existence of a system for different combinations of fairness and interruptibility levels, and to prove whether the specified properties are met, we can use formal methods. In this context, I'll provide an outline of how you could approach each case using a formalism called Petri nets. Petri nets are graphical and mathematical models used for modeling concurrent systems. (Sorry I dont' really have the tool to create them)


1. **Weak Fairness - Weak Interruptibility:**
   In this case, each consumer should eventually acquire a resource, and consumers can be interrupted while waiting.

   **Existence Analysis:**
   A system can exist under these conditions, and it is possible to model such a system using Petri nets.

   **Proof:**
   To prove it, we havt to: Construct a Petri net model that represents the behavior of the consumers and resources. Use markings to represent the state of the system (consumers, resources, waiting status, etc.). Show that transitions (acquiring a resource, releasing a resource, interruption signal) can eventually occur in the net, ensuring that every consumer eventually acquires a resource.

2. **Weak Fairness - Strong Interruptibility:**
   Consumers are guaranteed to eventually acquire a resource, but strong interruptibility means they can only wait for a limited number of other consumers.

   **Existence Analysis:**
   A system can exist under these conditions.

   **Proof:**
   Similar to the previous case, construct a Petri net model. Implement the strong interruptibility requirement by ensuring that a consumer can only wait for a limited number of other consumers. This can be achieved by introducing a counter that counts the number of waiting consumers and allowing transitions based on this counter.

3. **Strong Fairness - Weak Interruptibility:**
   Consumers are guaranteed to acquire a resource after waiting for a finite number of releases, and consumers can be interrupted while waiting.

   **Existence Analysis:**
   A system can exist under these conditions.

   **Proof:**
   Build a Petri net model that incorporates the strong fairness and weak interruptibility conditions. Use markings and transitions to ensure that each consumer waiting for a resource will eventually acquire it within a finite number of releases.

4. **Strong Fairness - Strong Interruptibility:**
   Consumers are guaranteed to acquire a resource after waiting for a finite number of releases, and strong interruptibility means they can only wait for a limited number of other consumers.

   **Existence Analysis:**
   A system can exist under these conditions.

   **Proof:**
   Create a Petri net model that encompasses strong fairness and strong interruptibility requirements. Implement these conditions using appropriate markings, transitions, and counters to ensure that consumers will acquire resources within a finite number of releases, and that their waiting will be limited by the specified number of other waiting consumers.

