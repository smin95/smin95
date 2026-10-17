library(lavaan)
library(semPlot)
library(ggsem) # install.packages('ggsem')
# Empty canvas
ggsem()

# Load metadata and continue in the interactive environment
ggsem(metadata = "C:/.../....rds") # write file directory of your metadata file

# Convert metadata to ggplot
metadata_to_ggplot(metadata = "C:/.../....rds") -> my_work # write file directory of your metadata file
# save it as figure as it exactly appears in the interactive environment
save_figure('my_work.png', my_work)

# Integrated visualization with other packages
# e.g., lavaan
# Specify and fit a CFA model
model <- '
  visual  =~ x1 + x2 + x3
  textual =~ x4 + x5 + x6
  speed   =~ x7 + x8 + x9
'

fit <- sem(model, data = HolzingerSwineford1939)

ggsem(object = fit)

# e.g., lavaan + semPlot
semplot_obj <- semPaths(
  fit,
  layout = "tree2",
  what = "paths",
  whatLabels = "est",
  style = "lisrel",
  residuals = TRUE
)

# object = semPlot, model = lavaan
# object = necessary argument
ggsem(object = fit)
ggsem(object = semplot_obj, model = fit)

## ggsem_builder() workflow to pre-load multiple objects

lavaan_string <- "visual  =~ x1 + x2 + x3
textual =~ x4 + x5 + x6
speed   =~ x7 + x8 + x9"

HolzingerSwineford1939

(fit <- sem(lavaan_string, data = HolzingerSwineford1939, group = 'school'))
# lavaan only
# object = necessary argument, cannot be empty
# model = not necessary argument. can be empty
# when there is graphical object (like semPlot), then it is object. if not, then model object (lavaan) is object.

ggsem_builder() |>
  add_group(name = "Pasteur", object = fit, x = -35, level = "Pasteur") |>
  add_group(name ="Grant-White", object = fit, x = 35, level = "Grant-White") |>
  launch()

# documentation website: https://smin95.github.io/ggsem
