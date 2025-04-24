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

##### POST-INTERROGATION #####

# create agent that fails
agent_fail <- small_table |>
  create_agent() |>
  col_vals_lt(a, value = 10) |>
  col_vals_between(d, left = 0, right = 5000) |>
  col_vals_in_set(f, set = c("low", "mid", "high")) |>
  col_vals_regex(b, regex = "^[0-9]-[a-z]{3}-[0-9]{3}$") |>
  interrogate()

# see agent_fail in viewer
agent_fail

# see passes from agent_fail
get_sundered_data(agent_fail, type = "pass")

# see fails from agent_fail
get_sundered_data(agent_fail, type = "fail")

# see both passess/fails from agent_fail
get_sundered_data(agent_fail, type = "combined")

# see step-by-step breakdown of failed rows (per validation rule)
get_data_extracts(agent_fail)
