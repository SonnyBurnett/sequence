from sklearn.datasets import load_boston
import numpy as np
import scipy
import redis
from sklearn.datasets import load_wine
from sklearn.linear_model import LinearRegression

boston = load_boston()
boston_RM = boston.data[:,5]
boston.PRICE = boston.target

x_train = boston_RM[:400].reshape(-1, 1)
x_test = boston_RM[400:].reshape(-1, 1)
y_train = boston.target[:400]
y_test = boston.target[400:]

lm = LinearRegression()
lm.fit(x_train, y_train)

coef = lm.coef_[0]
int = lm.intercept_
print('Coef: {coef}, Intercept: {int}'.format(coef=coef, int=int))