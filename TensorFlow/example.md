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
def conv2d(X, w):
    # 卷积遍历各方向步数为1，SAME：边缘外自动补0，遍历相乘
    return tf.nn.conv2d(X, w, strides=[1, 1, 1, 1], padding="SAME")

def relu(X, w):
    return tf.nn.relu(conv2d(X, w))

def max_pool_2x2(X):
    # 池化卷积结果（conv2d）池化层采用kernel大小为2*2，步数也为2，周围补0，取最大值。数据量缩小了4倍
    return tf.nn.max_pool(X, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding="SAME")

def init_weights(shape):
    # 正态分布，标准差为0.1，默认最大为1，最小为-1，均值为0
    return tf.Variable(tf.random_normal(shape, stddev=0.01))

def model(X, w, w2, w3, w4, w_o, p_keep_conv, p_keep_hidden):
    l1 = tf.nn.dropout(max_pool_2x2(relu(X, w)), p_keep_conv)
    l2 = tf.nn.dropout(max_pool_2x2(relu(l1, w2)), p_keep_conv)
    l3 = tf.reshape(max_pool_2x2(relu(l2, w3)), [-1, w4.get_shape().as_list()[0]])
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
# word2vec
```
#!/usr/bin/python3
# -*- coding:utf-8 _*-
"""
@author:peiwei
@file: tf.py
@time: 2017/07/26
"""
import collections
import numpy as np
import tensorflow as tf
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

# Configuration
batch_size = 20
# Dimension of the embedding vector. Two too small to get
# any meaningful embeddings, but let's make it 2 for simple visualization
embedding_size = 2
num_sampled = 15    # Number of negative examples to sample.

# Sample sentences
sentences = ["the quick brown fox jumped over the lazy dog",
            "I love cats and dogs",
            "we all love cats and dogs",
            "cats and dogs are great",
            "sung likes cats",
            "she loves dogs",
            "cats can be very independent",
            "cats are great companions when they want to be",
            "cats are playful",
            "cats are natural hunters",
            "It's raining cats and dogs",
            "dogs and cats love sung"]

# sentences to words and count
words = " ".join(sentences).split()
count = collections.Counter(words).most_common()
print ("Word count", count[:5])

# Build dictionaries
rdic = [i[0] for i in count] #reverse dic, idx -> word
dic = {w: i for i, w in enumerate(rdic)} #dic, word -> id
voc_size = len(dic)

# Make indexed word data
data = [dic[word] for word in words]
print('Sample data', data[:10], [rdic[t] for t in data[:10]])

# Let's make a training data for window size 1 for simplicity
# ([the, brown], quick), ([quick, fox], brown), ([brown, jumped], fox), ...
cbow_pairs = [];
for i in range(1, len(data)-1) :
    cbow_pairs.append([[data[i-1], data[i+1]], data[i]]);
print('Context pairs', cbow_pairs[:10])

# Let's make skip-gram pairs
# (quick, the), (quick, brown), (brown, quick), (brown, fox), ...
skip_gram_pairs = [];
for c in cbow_pairs:
    skip_gram_pairs.append([c[1], c[0][0]])
    skip_gram_pairs.append([c[1], c[0][1]])
print('skip-gram pairs', skip_gram_pairs[:5])

def generate_batch(size):
    assert size < len(skip_gram_pairs)
    x_data=[]
    y_data = []
    r = np.random.choice(range(len(skip_gram_pairs)), size, replace=False)
    for i in r:
        x_data.append(skip_gram_pairs[i][0])  # n dim
        y_data.append([skip_gram_pairs[i][1]])  # n, 1 dim
    return x_data, y_data

# generate_batch test
print ('Batches (x, y)', generate_batch(3))

# Input data
train_inputs = tf.placeholder(tf.int32, shape=[batch_size])
# need to shape [batch_size, 1] for nn.nce_loss
train_labels = tf.placeholder(tf.int32, shape=[batch_size, 1])
# Ops and variables pinned to the CPU because of missing GPU implementation
with tf.device('/cpu:0'):
    # Look up embeddings for inputs.
    embeddings = tf.Variable(
        tf.random_uniform([voc_size, embedding_size], -1.0, 1.0))
    embed = tf.nn.embedding_lookup(embeddings, train_inputs) # lookup table

# Construct the variables for the NCE loss
nce_weights = tf.Variable(
    tf.random_uniform([voc_size, embedding_size],-1.0, 1.0))
nce_biases = tf.Variable(tf.zeros([voc_size]))

# Compute the average NCE loss for the batch.
# This does the magic:
#   tf.nn.nce_loss(weights, biases, inputs, labels, num_sampled, num_classes ...)
# It automatically draws negative samples when we evaluate the loss.
loss = tf.reduce_mean(tf.nn.nce_loss(nce_weights, nce_biases, train_labels, embed, num_sampled, voc_size))

# Use the adam optimizer
train_op = tf.train.AdamOptimizer(1e-1).minimize(loss)

# Launch the graph in a session
with tf.Session() as sess:
    # Initializing all variables
    tf.global_variables_initializer().run()

    for step in range(100):
        batch_inputs, batch_labels = generate_batch(batch_size)
        _, loss_val = sess.run([train_op, loss],
                feed_dict={train_inputs: batch_inputs, train_labels: batch_labels})
        if step % 10 == 0:
          print("Loss at ", step, loss_val) # Report the loss

    # Final embeddings are ready for you to use. Need to normalize for practical use
    trained_embeddings = embeddings.eval()

# Show word2vec if dim is 2
if trained_embeddings.shape[1] == 2:
    labels = rdic[:10] # Show top 10 words
    for i, label in enumerate(labels):
        x, y = trained_embeddings[i,:]
        plt.scatter(x, y)
        plt.annotate(label, xy=(x, y), xytext=(5, 2),
            textcoords='offset points', ha='right', va='bottom')
    plt.savefig("word2vec.png")
```
