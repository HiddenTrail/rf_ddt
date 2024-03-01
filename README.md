# rf_ddt
`rf_ddt.py`is a script that expands compactly described data driven test to several traditional tests.

Data driven test is described separately as a test template and table containing test input values that are passed to final tests.

Data driven test is marked with the `#@DDT-Test:` label.
Data for data driven test is sandwiched between `#@DDT-Data:` and `#@DDT-Data-end` labels.
`#@DDT-Data:` works also as an end marker for data driven test part.

## example data driven test
<img src="https://github.com/HiddenTrail/rf_ddt/blob/main/docs/ddt_test.png" width="400">

## example data driven test expanded
<img src="https://github.com/HiddenTrail/rf_ddt/blob/main/docs/expanded.png" width="400">

## running rf_ddt
```
python rf_ddt.py [source.robot] > [target.robot]

For example:

  python rf_ddt.py googling.robot > googling_expanded.robot
```
