
library(NMF)

normalized_matrix_less_o3 <- readRDS('normalized_matrix_less_o3.rds')
normalized_matrix_less_o3 <- readRDS('weight_matrix.rds')

lsnmf_nndsvd_less_o3_test2a <- nmf(
  normalized_matrix_less_o3,
  rank = 5,
  method = "ls-nmf",
  weight = weight_matrix,
  nrun = 1,
  seed = 'nndsvd'
)
