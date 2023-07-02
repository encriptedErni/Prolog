<!DOCTYPE html>
<html>
<head>
</head>
<body>
  <h1>Reversible Cellular Automata</h1>
  <p>This project implements a reversible cellular automaton in the context of pure logic programming. The cellular automaton consists of an infinite tape that contains cells, each of which has a given color. The state of the tape evolves by applying a set of rules that determine how the colors of the cells change.</p>
  <p>In this project, we use only the colors white and black, represented by the symbols 'o' and 'x', respectively. The new color of a cell depends only on the original colors of its two neighboring cells, to the left and right. To simplify, the rules are defined based on three cells.</p>
  <p>The rules are represented by a term `r/7`, where each argument contains the resulting color for each of the possible inputs. The null rule is a default rule that applies to all cells and states that a white cell with both white neighbors remains white. The number of black cells in any state of the tape is always finite.</p>
  <p>To query a specific rule, the `rule/2` predicate is provided, which takes the current cell state and the rule to apply as arguments and returns the resulting color of the cell.</p>
  <p>The project is already implemented and the `code.pl` file contains the corresponding source code. Additionally, an example of using the `rule/2` predicate to query a specific rule is provided.</p>
  <p>For more details on the implementation and the constraints of pure logic programming used in this project, please refer to the general and specific instructions mentioned at the beginning of the prompt.</p>
  <h2>Example Usage:</h2>
  <p>Given the set of rules: `r(x,o,x,x,x,x,o)`, if we want to query the rule for a cell with original color 'o' to the left, original color 'x' in the cell itself, and original color 'o' to the right, we can make the following query:</p>
  <pre><code>?- R = r(x,o,x,x,x,x,o), rule(o,x,o,R,Y).
  </code></pre>
  <p>The response `Y=o` indicates that, according to the given rules, the cell in question should have 'o' as the resulting color.</p>
</body>
</html>
