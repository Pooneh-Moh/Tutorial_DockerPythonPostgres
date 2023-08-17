# Goal: to elaborate on some aspects of Exercise 1 concerning formal languages and computational models.

## a rigorous definition for compositions of functions?
???
## Identify the least expressive computational machine (among automata, pushdown automata, linear bounded automata and Turing machines) that can accept the language described in the previous point and provide a proof. Show why the language cannot be accepted by other less expressive machines (or provide an intuitive explanation).

To answer this question, I will refere to this website: @[https://www.javatpoint.com/application-of-different-automata-theory-of-computation#:~:text=Finite%20automata%20have%20the%20least,have%20the%20most%20expressive%20power.]

The expressive power of different automata refers to the class of languages that can be recognized or generated by each type of automaton. Here is an overview of the expressive power of different automata:

Finite automata: Finite automata can recognize regular languages, which are languages that can be defined by a regular expression or a finite state machine.
Pushdown automata: Pushdown automata can recognize context-free languages, which are languages that can be defined by a context-free grammar.
Linear bounded automata: Linear bounded automata can recognize context-sensitive languages, which are languages that can be defined by a context-sensitive grammar.
Turing machines: Turing machines can recognize recursively enumerable languages, which are languages that can be defined by a recursive function.
It is worth noting that the class of recursively enumerable languages includes all the other language classes mentioned above. This means that any language that can be recognized by a finite automaton, pushdown automaton, or linear bounded automaton can also be recognized by a Turing machine, but not the other way around.

In terms of generating languages, the expressive power of automata is similar. Finite automata can generate regular languages, pushdown automata can generate context-free languages, linear bounded automata can generate context-sensitive languages, and Turing machines can generate recursively enumerable languages.

In summary, the expressive power of different automata increases as the memory or computation power of the automaton increases. **Finite automata have the least expressive power**, followed by pushdown automata, linear bounded automata, and Turing machines, which have the most expressive power. However, it is worth noting that each type of automaton is designed for a specific class of problems, and the choice of which type of automaton to use depends on the specific requirements of the problem at hand.

### 3. 
I'm not sure about the answer on question 1. Therefore, I wil give a general answer in python. Here is the code:

''' def composition_depth(expression):
    if isinstance(expression, int):
        return 1

    max_depth = 0
    for term in expression:
        depth = composition_depth(term)
        max_depth = max(max_depth, depth)

    return max_depth + 1

# Example usage 
expression1 = 42  # A constant
expression2 = [expression1]  # A composition: [f(c1)]
expression3 = [expression2, expression1]  # A composition: [f([f(c1)]), c1]
expression4 = [expression2, expression3]  # A composition: [f([f(c1)]), [f([f(c1)]), c1]]

print(composition_depth(expression2))  # Output: 2
print(composition_depth(expression3))  # Output: 3
print(composition_depth(expression4))  # Output: 4
'''