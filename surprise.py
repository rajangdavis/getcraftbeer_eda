import surprise
from surprise import SVD
# print(surprise)


# from surprise import Dataset
# from surprise.model_selection import cross_validate


# Load the movielens-100k dataset (download it if needed),
# data = Dataset.load_builtin('ml-100k')


# print(data.head())

# We'll use the famous SVD algorithm.
# algo = SVD()

# # Run 5-fold cross-validation and print results
# cross_validate(algo, data, measures=['RMSE', 'MAE'], cv=5, verbose=True)