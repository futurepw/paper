# 矩阵乘法
> tf.Variable 和 tf.placeholder的区别，两者都可以盛放变量，但在启动会话前，tf.Variable必须先被赋值和初始化，而tf.placeholder是需要在启动会话的时候传入值的；从直观上讲，tf.placeholder更加接近函数的形参。
```
import tensorflow as tf

w1 = tf.Variable(tf.truncated_normal(shape=[2, 3], seed=1))  # 生成2*3的矩阵
w2 = tf.Variable(tf.truncated_normal(shape=[3, 1], seed=1))
x = tf.placeholder(dtype=tf.float32, shape=[1, 2])
a = tf.matmul(x, w1)
y = tf.matmul(a, w2)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
print(sess.run(y, feed_dict={x: [[1, 1]]}))

```

# 简单乘法
```
import tensorflow as tf

# 创建两个变量
a = tf.placeholder("float")
b = tf.placeholder("float")

y = tf.multiply(a, b)  # 乘法

sess = tf.Session()
print("%f should equal 2.0" % sess.run(y, feed_dict={a: 1, b: 2}))

```

# 线性回归
```
import tensorflow as tf
import numpy as np

X = np.linspace(-1, 1, 101)  # 从-1 到 1 之间采集101个数
Y = 2 * X + np.random.randn(*X.shape) * 0.33 
# 创建 Y = 2X 加入干扰数据 np.random.randn()是从标准正态分布中返回一个或多个样本值 X.shape获取X的长度返回元组，加*号变成值

x = tf.placeholder("float")
y = tf.placeholder("float")


def model(x, w):  # 定义 X*w 的模型
    return tf.multiply(x, w)


w = tf.Variable(0.0, name="weights")
y_model = model(x, w)
cost = tf.square(Y - y_model)  # 计算平方

train_op = tf.train.GradientDescentOptimizer(0.01).minimize(cost) 
# tf.train.GradientDescentOptimizer 这个类是实现梯度下降算法的优化器

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for (i, j) in zip(X, Y):
        sess.run(train_op, feed_dict={x: i, y: j})

print(sess.run(w))

```
# 逻辑回归
```
import tensorflow as tf
import numpy as np
from tensorflow.examples.tutorials.mnist import input_data


def init_weights(shape):
    return tf.Variable(tf.random_normal(shape, stddev=0.01))


# tf.random_normal(shape,mean=0.0,stddev=1.0,dtype=tf.float32,seed=None,name=None)返回一个tensor其中的元素的值服从正态分布。

def model(X, w):
    return tf.matmul(X, w)


mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trainX, trainY, testX, testY = mnist.train.images, mnist.train.labels, mnist.test.images, mnist.test.labels

X = tf.placeholder("float", [None, 784])
Y = tf.placeholder("float", [None, 10])

w = init_weights([784, 10])
py_x = model(X, w)

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=py_x, labels=Y))
train_op = tf.train.GradientDescentOptimizer(0.05).minimize(cost)
predict_op = tf.argmax(py_x, 1)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for start, end in zip(range(0, len(trainX), 128), range(128, len(trainX) + 1, 128)):
        sess.run(train_op, feed_dict={X: trainX[start:end], Y: trainY[start:end]})
    print(i, np.mean(np.argmax(testY, axis=1) == sess.run(predict_op, feed_dict={X: testX})))

```
# Feedforward Neural Network 
```
#!/usr/bin/pytFeedforward Neural Network  
# -*- coding:utf-8 _*-  
""" 
@author:peiwei
@file: tf.py 
@time: 2017/07/26 
"""

import tensorflow as tf
import numpy as np
from tensorflow.examples.tutorials.mnist import input_data


def init_weights(shape):
    return tf.Variable(tf.random_normal(shape, stddev=0.01))


# tf.random_normal(shape,mean=0.0,stddev=1.0,dtype=tf.float32,seed=None,name=None)返回一个tensor其中的元素的值服从正态分布。

def model(X, w_h, w_o):
    h = tf.nn.sigmoid(tf.matmul(X, w_h))
    return tf.matmul(h, w_o)


mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trainX, trainY, testX, testY = mnist.train.images, mnist.train.labels, mnist.test.images, mnist.test.labels

X = tf.placeholder("float", [None, 784])
Y = tf.placeholder("float", [None, 10])

w_h = init_weights([784, 625])
w_o = init_weights([625, 10])
py_x = model(X, w_h, w_o)

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=py_x, labels=Y))
train_op = tf.train.GradientDescentOptimizer(0.05).minimize(cost)
predict_op = tf.argmax(py_x, 1)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for start, end in zip(range(0, len(trainX), 128), range(128, len(trainX) + 1, 128)):
        sess.run(train_op, feed_dict={X: trainX[start:end], Y: trainY[start:end]})
    print(i, np.mean(np.argmax(testY, axis=1) == sess.run(predict_op, feed_dict={X: testX})))

```
# Deep Feedforward Neural Network 
```
#!/usr/bin/python3
# -*- coding:utf-8 _*-
"""
@author:peiwei
@file: tf.py
@time: 2017/07/26
"""

import tensorflow as tf
import numpy as np
from tensorflow.examples.tutorials.mnist import input_data


def init_weights(shape):
    return tf.Variable(tf.random_normal(shape, stddev=0.01))


def model(X, w_h, w_h2, w_o, p_keep_input, p_keep_hidden):
    X = tf.nn.dropout(X, p_keep_input)
    h = tf.nn.relu(tf.matmul(X, w_h))

    h = tf.nn.dropout(h, p_keep_hidden)
    h2 = tf.nn.relu(tf.matmul(h, w_h2))

    h2 = tf.nn.dropout(h2, p_keep_hidden)

    return tf.matmul(h2, w_o)


mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trainX, trainY, testX, testY = mnist.train.images, mnist.train.labels, mnist.test.images, mnist.test.labels

X = tf.placeholder("float", [None, 784])
Y = tf.placeholder("float", [None, 10])

w_h = init_weights([784, 625])
w_h2 = init_weights([625, 625])
w_o = init_weights([625, 10])

p_keep_input = tf.placeholder("float")
p_keep_hidden = tf.placeholder("float")
py_x = model(X, w_h, w_h2, w_o, p_keep_input, p_keep_hidden)

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=py_x, labels=Y))
train_op = tf.train.RMSPropOptimizer(0.001, 0.9).minimize(cost)
predict_op = tf.argmax(py_x, 1)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for start, end in zip(range(0, len(trainX), 128), range(128, len(trainX) + 1, 128)):
        sess.run(train_op,
                 feed_dict={X: trainX[start:end], Y: trainY[start:end], p_keep_input: 0.8, p_keep_hidden: 0.5})
    print(i, np.mean(
        np.argmax(testY, axis=1) == sess.run(predict_op, feed_dict={X: testX, p_keep_input: 1.0, p_keep_hidden: 1.0})))

```
