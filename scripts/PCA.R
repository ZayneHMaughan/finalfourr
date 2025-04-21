#DO CORRELATION AND PCA to see if we need to reduce dimensionality
library(dplyr)
library(factoextra)
library(corrplot)
library(ggplot2)
library(CCA)
library(CCP)


corrplot(cor(scale(DATASET[,c(3:79)])))

corr_mat <- cor(scale(DATASET[,c(3:79)]))
# Set a threshold
threshold <- 0.7

# Zero out self-correlations (optional)
diag(corr_mat) <- NA

# Get the upper triangle only (to avoid duplicates)
upper_tri <- upper.tri(corr_mat)

# Apply threshold filter
high_cor_indices <- which(abs(corr_mat) > threshold & upper_tri, arr.ind = TRUE)

# Create a named vector
high_cor_values <- corr_mat[high_cor_indices]
names(high_cor_values) <- apply(high_cor_indices, 1, function(idx) {
  paste(rownames(corr_mat)[idx[1]], colnames(corr_mat)[idx[2]], sep = " - ")
})

print(high_cor_values)

pca_bball <- princomp(scale(DATASET[,c(3:79)]))

fviz_eig(pca_bball, addlabels = TRUE)
fviz_cos2(pca_bball, choice = "var", axes = 1:2)


