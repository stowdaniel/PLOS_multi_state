
# TRANSITION MATRIX -------------------------------------------------------
# creates the transition matrix used in the main analysis

tmat <- mstate::transMat(
  x = list(c(2, 3,  6, 7),
           c(4, 6, 7),
           c(5, 6, 7),
           c(6, 7),
           c(6, 7),
           c(),
           c()),
  names = c("Healthy",
            "INT",
            "CMD",
            "INT->CMD",
            "CMD->INT",
            "CVE",
            "Death")
)

# END ---------------------------------------------------------------------


