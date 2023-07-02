<!DOCTYPE html>
<html>
<head>
</head>
<body>
  <h1>Arithmetic Board Traversal Project</h1>
  <h2>Usage Instructions</h2>
  <ol>
    <li>Clone the repository or download the project files.</li>
    <li>Run the main program.</li>
    <li>Select an arbitrary starting cell on the board.</li>
    <li>The program will perform the traversal following the established rules.</li>
    <li>Once completed, the final value obtained will be displayed.</li>
  </ol>
  <h2>Requirements</h2>
  <p>The project has been implemented using ISO-Prolog arithmetic, utilizing predefined predicates such as `is/2`, `>/2`, and others. It is recommended to have a Prolog interpreter compatible with the ISO-Prolog standard to run the program.</p>
  <h2>Board Representation</h2>
  <p>The board is represented as a list of cells, where each cell is defined using the `cell/2` structure. Each cell contains the position on the board and the associated arithmetic operation. The position is represented using the `pos(Row,Col)` structure, where `Row` and `Col` are variables that take values from 1 to N. The operation is expressed using the `op/2` structure, where the first argument is an arithmetic operator (`+`, `-`, `*`, `//`), and the second argument is an integer.</p>
  <p>Here is an example of a board representation:</p>
  <pre>
board1([cell(pos(1,1),op(*,-3)),
        cell(pos(1,2),op(-,1)),
        cell(pos(1,3),op(-,4)),
        cell(pos(1,4),op(-,555)),
        cell(pos(2,1),op(-,3)),
        cell(pos(2,2),op(+,2000)),
        cell(pos(2,3),op(*,133)),
        cell(pos(2,4),op(-,444)),
        cell(pos(3,1),op(*,0)),
        cell(pos(3,2),op(*,155)),
        cell(pos(3,3),op(//,2)),
        cell(pos(3,4),op(+,20)),
        cell(pos(4,1),op(-,2)),
        cell(pos(4,2),op(-,1000)),
        cell(pos(4,3),op(-,9)),
        cell(pos(4,4),op(*,4))]).
  </pre>
  <p>It is important to note that the list of cells representing the board can be ordered in any way, as any permutation of the list remains a valid and equivalent board.</p>
  <h2>Directions and Allowed Directions</h2>
  <p>Transitions between cells are identified by directions such as north (`n`), south (`s`), east (`e`), west (`o`), northwest (`no`), northeast (`ne`), southwest (`so`), and southeast (`se`).</p>
  <p>To perform the traversal, it is necessary to select a direction from the available options in a list called `AllowedDirections`. This list contains `dir/2` structures that specify a direction (`Dir`) and the maximum number of times (`Num`) that direction can be used during the traversal.</p>
  <p>For example, the list of allowed directions:</p>
  <pre>
AllowedDirections = [dir(n,3), dir(s,4), dir(o,2), dir(se,10)]
  </pre>
  <p>Means that you can only move to the north, south, west, or southeast from the current cell, as long as the cell exists and is within the board's limits. Throughout the traversal, a maximum of 3 transitions to the north, 4 to the south, 2 to the west, and 10 to the southeast are allowed.</p>
  <p>It is important to note that certain combinations of allowed directions may make it impossible to complete a traversal, regardless of the selected starting cell.</p>
  <p>Enjoy the arithmetic board traversal!</p>
</body>
</html>
