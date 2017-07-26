# TensorFlow API
[Tensorflow Python API 翻译（nn）](http://www.jianshu.com/p/e3a79eac554f)<br>
[Tensorflow Python API 翻译（sparse_ops）](http://www.jianshu.com/p/c233e09d2f5f)<br>
[Tensorflow Python API 翻译（math_ops）（第一部分）](http://www.jianshu.com/p/ce4ee40963c1)<br>
[Tensorflow Python API 翻译（math_ops）（第二部分）](http://www.jianshu.com/p/4daafdbcdddf)<br>
[Tensorflow Python API 翻译（array_ops）](http://www.jianshu.com/p/00ab12bc357c)<br>
[Tensorflow Python API 翻译（constant_op）](http://www.jianshu.com/p/d05ded5678b0)<br>
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
# Convolutional Neural Network
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

test_size = 256


def init_weights(shape):
    return tf.Variable(tf.random_normal(shape, stddev=0.01))


def model(X, w, w2, w3, w4, w_o, p_keep_conv, p_keep_hidden):
    l1a = tf.nn.relu(tf.nn.conv2d(X, w, strides=[1, 1, 1, 1], padding='SAME'))  # l1a shape=(?, 28, 28, 32)
    l1 = tf.nn.max_pool(l1a, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding='SAME')  # l1 shape=(?, 14, 14, 32)
    l1 = tf.nn.dropout(l1, p_keep_conv)

    l2a = tf.nn.relu(tf.nn.conv2d(l1, w2, strides=[1, 1, 1, 1], padding='SAME'))  # l2a shape=(?, 14, 14, 64)
    l2 = tf.nn.max_pool(l2a, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding='SAME')  # l2 shape=(?, 7, 7, 64)
    l2 = tf.nn.dropout(l2, p_keep_conv)

    l3a = tf.nn.relu(tf.nn.conv2d(l2, w3, strides=[1, 1, 1, 1], padding="SAME"))  # l3a shape=(?, 7, 7, 128)
    l3 = tf.nn.max_pool(l3a, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding="SAME")  # l3 shape=(?, 4, 4, 128)
    l3 = tf.reshape(l3, [-1, w4.get_shape().as_list()[0]])  # reshape to (?, 2048)
    l3 = tf.nn.dropout(l3, p_keep_conv)

    l4 = tf.nn.relu(tf.matmul(l3, w4))
    l4 = tf.nn.dropout(l4, p_keep_hidden)

    pyx = tf.matmul(l4, w_o)
    return pyx


mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trainX, trainY, testX, testY = mnist.train.images, mnist.train.labels, mnist.test.images, mnist.test.labels
trainX = trainX.reshape(-1, 28, 28, 1)  # 28x28x1 input img
testX = testX.reshape(-1, 28, 28, 1)  # 28x28x1 input img

X = tf.placeholder("float", [None, 28, 28, 1])
Y = tf.placeholder("float", [None, 10])

w = init_weights([3, 3, 1, 32])  # 3x3x1 conv, 32 outputs
w2 = init_weights([3, 3, 32, 64])  # 3x3x32 conv, 64 outputs
w3 = init_weights([3, 3, 64, 128])  # 3x3x32 conv, 128 outputs
w4 = init_weights([128 * 4 * 4, 625])  # FC 128 * 4 * 4 inputs, 625 outputs
w_o = init_weights([625, 10])  # FC 625 inputs, 10 outputs (labels)

p_keep_conv = tf.placeholder("float")
p_keep_hidden = tf.placeholder("float")
py_x = model(X, w, w2, w3, w4, w_o, p_keep_conv, p_keep_hidden)

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=py_x, labels=Y))
train_op = tf.train.RMSPropOptimizer(0.001, 0.9).minimize(cost)
predict_op = tf.argmax(py_x, 1)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for start, end in zip(range(0, len(trainX), 128), range(128, len(trainX) + 1, 128)):
        sess.run(train_op, feed_dict={X: trainX[start:end], Y: trainY[start:end], p_keep_conv: 0.8, p_keep_hidden: 0.5})
    test_indices = np.arange(len(testX))
    np.random.shuffle(test_indices)
    test_indices = test_indices[0:test_size]
    print(i, np.mean(np.argmax(testY[test_indices], axis=1) == sess.run(predict_op,
                                                                        feed_dict={X: testX, p_keep_conv: 1.0,
                                                                                   p_keep_hidden: 1.0})))

```
# Recurrent Neural Network (LSTM)
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
from tensorflow.contrib import rnn
from tensorflow.examples.tutorials.mnist import input_data

# configuration
#                        O * W + b -> 10 labels for each image, O[? 28], W[28 10], B[10]
#                       ^ (O: output 28 vec from 28 vec input)
#                       |
#      +-+  +-+       +--+
#      |1|->|2|-> ... |28| time_step_size = 28
#      +-+  +-+       +--+
#       ^    ^    ...  ^
#       |    |         |
# img1:[28] [28]  ... [28]
# img2:[28] [28]  ... [28]
# img3:[28] [28]  ... [28]
# ...
# img128 or img256 (batch_size or test_size 256)
#      each input size = input_vec_size=lstm_size=28
# configuration variables

input_vec_size = lstm_size = 28
time_step_size = 28
batch_size = 128
test_size = 256


def init_weights(shape):
    return tf.Variable(tf.random_normal(shape, stddev=0.01))


def model(X, W, B, lstm_size):
    # X, input shape: (batch_size, time_step_size, input_vec_size)
    XT = tf.transpose(X, [1, 0, 2])  # permute time_step_size and batch_size
    # XT shape: (time_step_size, batch_size, input_vec_size)
    XR = tf.reshape(XT, [-1, lstm_size])  # each row has input for each lstm cell (lstm_size=input_vec_size)
    # XR shape: (time_step_size * batch_size, input_vec_size)
    X_split = tf.split(XR, time_step_size, 0)  # split them to time_step_size (28 arrays)
    # Each array shape: (batch_size, input_vec_size)
    # Make lstm with lstm_size (each input vector size)
    lstm = rnn.BasicLSTMCell(lstm_size, forget_bias=1.0, state_is_tuple=True)
    # Get lstm cell output, time_step_size (28) arrays with lstm_size output: (batch_size, lstm_size)
    outputs, _states = rnn.static_rnn(lstm, X_split, dtype=tf.float32)
    # Linear activation
    # Get the last output
    return tf.matmul(outputs[-1], W) + B, lstm.state_size


mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trainX, trainY, testX, testY = mnist.train.images, mnist.train.labels, mnist.test.images, mnist.test.labels
trainX = trainX.reshape(-1, 28, 28)
testX = testX.reshape(-1, 28, 28)

X = tf.placeholder("float", [None, 28, 28])
Y = tf.placeholder("float", [None, 10])

W = init_weights([lstm_size, 10])
B = init_weights([10])

py_x, state_size = model(X, W, B, lstm_size)

cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=py_x, labels=Y))
train_op = tf.train.RMSPropOptimizer(0.001, 0.9).minimize(cost)
predict_op = tf.argmax(py_x, 1)

session_conf = tf.ConfigProto()
session_conf.gpu_options.allow_growth = True

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for start, end in zip(range(0, len(trainX), batch_size), range(batch_size, len(trainX) + 1, batch_size)):
        sess.run(train_op, feed_dict={X: trainX[start:end], Y: trainY[start:end]})
    test_indices = np.arange(len(testX))
    np.random.shuffle(test_indices)
    test_indices = test_indices[0:test_size]
    print(i, np.mean(np.argmax(testY[test_indices], axis=1) == sess.run(predict_op, feed_dict={X: testX})))

```
# tensorboard
```
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data

def init_weights(shape, name):
    return tf.Variable(tf.random_normal(shape, stddev=0.01), name=name)

# This network is the same as the previous one except with an extra hidden layer + dropout
def model(X, w_h, w_h2, w_o, p_keep_input, p_keep_hidden):
    # Add layer name scopes for better graph visualization
    with tf.name_scope("layer1"):
        X = tf.nn.dropout(X, p_keep_input)
        h = tf.nn.relu(tf.matmul(X, w_h))
    with tf.name_scope("layer2"):
        h = tf.nn.dropout(h, p_keep_hidden)
        h2 = tf.nn.relu(tf.matmul(h, w_h2))
    with tf.name_scope("layer3"):
        h2 = tf.nn.dropout(h2, p_keep_hidden)
        return tf.matmul(h2, w_o)

mnist = input_data.read_data_sets("MNIST_data/", one_hot=True)
trX, trY, teX, teY = mnist.train.images, mnist.train.labels, mnist.test.images, mnist.test.labels

X = tf.placeholder("float", [None, 784], name="X")
Y = tf.placeholder("float", [None, 10], name="Y")

w_h = init_weights([784, 625], "w_h")
w_h2 = init_weights([625, 625], "w_h2")
w_o = init_weights([625, 10], "w_o")

# Add histogram summaries for weights
tf.summary.histogram("w_h_summ", w_h)
tf.summary.histogram("w_h2_summ", w_h2)
tf.summary.histogram("w_o_summ", w_o)

p_keep_input = tf.placeholder("float", name="p_keep_input")
p_keep_hidden = tf.placeholder("float", name="p_keep_hidden")
py_x = model(X, w_h, w_h2, w_o, p_keep_input, p_keep_hidden)

with tf.name_scope("cost"):
    cost = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(logits=py_x, labels=Y))
    train_op = tf.train.RMSPropOptimizer(0.001, 0.9).minimize(cost)
    # Add scalar summary for cost
    tf.summary.scalar("cost", cost)

with tf.name_scope("accuracy"):
    correct_pred = tf.equal(tf.argmax(Y, 1), tf.argmax(py_x, 1)) # Count correct predictions
    acc_op = tf.reduce_mean(tf.cast(correct_pred, "float")) # Cast boolean to float to average
    # Add scalar summary for accuracy
    tf.summary.scalar("accuracy", acc_op)

with tf.Session() as sess:
    # create a log writer. run 'tensorboard --logdir=./logs/nn_logs'
    writer = tf.summary.FileWriter("./logs/nn_logs", sess.graph) # for 1.0
    merged = tf.summary.merge_all()

    # you need to initialize all variables
    tf.global_variables_initializer().run()

    for i in range(5):
        for start, end in zip(range(0, len(trX), 128), range(128, len(trX)+1, 128)):
            sess.run(train_op, feed_dict={X: trX[start:end], Y: trY[start:end],
                                          p_keep_input: 0.8, p_keep_hidden: 0.5})
        summary, acc = sess.run([merged, acc_op], feed_dict={X: teX, Y: teY,
                                          p_keep_input: 1.0, p_keep_hidden: 1.0})
        writer.add_summary(summary, i)  # Write summary
        print(i, acc)                   # Report the accuracy
    writer.close()
```
