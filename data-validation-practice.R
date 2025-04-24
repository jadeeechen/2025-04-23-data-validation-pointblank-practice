library(pointblank)
data(small_table)
small_table


##### VALIDATION RULES #####

# single validation: checking if all a's are less than 4 -> NO
small_table |>
  col_vals_lt(a, value = 4)

# single validation: checking if all a's are more than 10 -> NO
small_table |>
  col_vals_gt(a, value = 10)

# single validation: checking if all a's are less than 10 -> YES
small_table |>
  col_vals_lt(a, value = 10)

# chaining validations:
small_table |>
  col_vals_lt(a, value = 10) |>
  col_vals_between(d, left=0, right = 10000, inclusive=c(TRUE,TRUE))

##### VALIDATION TABLE #####

# create agent, then interrogate agent
agent <- small_table |>
  create_agent() |>
  col_vals_lt(a, value = 10) |>
  col_vals_between(d, left=0, right = 10000, inclusive=c(TRUE,TRUE))

agent |>
  interrogate()

# create and interrogate agent together
agent <- small_table |>
  create_agent() |>
  col_vals_lt(a, value = 10) |>
  col_vals_between(d, left=0, right = 10000, inclusive=c(TRUE,TRUE)) |>
  interrogate()

