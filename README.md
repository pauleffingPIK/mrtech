# mrtech - madrat based REMIND Techno-economic Input Data Library

## Purpose and Functionality
Techno-economic data preprocessing for REMIND

## Installation
For the installation the libraries "devtools" and "madrat" are required.

"devtools" can be installed via:

```r
(install.packages("devtools"))
```

To download the package run the following commands in R:

```r
library(devtools)
install_github("pauleffingPIK/mrtech")
```

Then import the "madrat" and "mrtech":

```r
library(mrtech)
library(madrat)
```

After this, the mrtech functions can be used with the corresponding madrat wrapper functions.
