# SVM_RandomForest_Classification_Project

This project implements Support Vector Machines (SVM) and Random Forest models to perform classification tasks using biomedical datasets.

## Data
- **`data_PQN.rds`**: Metabolic fingerprint data used for SVM classification.
- **`responses.rds`**: Outcome vector for SVM classification (1 = AKI, 0 = non-AKI).
- **`processed_cleveland.rds`**: Cleveland dataset for heart disease prediction using Random Forest.
- **`description.txt`**: Contains variable descriptions for the Cleveland dataset.

## Code Structure
- **`svm_classification.R`**: Implements SVM with various kernels (polynomial, radial, linear, sigmoid) and uses cross-validation to assess performance. Outputs ROC and Precision-Recall curves.
- **`random_forest_classification.R`**: Implements a Random Forest classifier for heart disease prediction, including feature importance visualization and performance metrics using ROC curves.

## Instructions

### 1. Clone the repository:
```bash
git clone https://github.com/YourUsername/SVM_RandomForest_Classification_Project.git
install.packages("e1071")
install.packages("ROCR")
install.packages("randomForest")
Open # SVM_RandomForest_Classification_Project.R in RStudio or another R IDE and execute it.

View the results:
The ROC curves, Precision-Recall curves, and feature importance will be plotted as outputs.
