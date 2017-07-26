# 矩阵乘法
> tf.Variable 和 tf.placeholder的区别，两者都可以盛放变量，但在启动会话前，tf.Variable必须先被赋值和初始化，而tf.placeholder是需要在启动会话的时候传入值的；从直观上讲，tf.placeholder更加接近函数的形参。
```
import tensorflow as tf

w1 = tf.Variable(tf.truncated_normal(shape=[2,3],seed=1))#生成2*3的矩阵
w2 = tf.Variable(tf.truncated_normal(shape=[3,1],seed=1))
x = tf.placeholder(dtype=tf.float32,shape=[1,2])
a = tf.matmul(x,w1)
y = tf.matmul(a,w2)

sess = tf.Session()
sess.run(tf.global_variables_initializer())
print(sess.run(y,feed_dict={x:[[1,1]]}))
```

# 简单乘法
```
import tensorflow as tf
#创建两个变量
a = tf.placeholder("float")
b = tf.placeholder("float")

y = tf.multiply(a, b) #乘法

sess = tf.Session()
print("%f should equal 2.0" % sess.run(y, feed_dict={a: 1, b: 2}))
```

# 线性回归
```
import tensorflow as tf
import numpy as np

X = np.linspace(-1,1,101) #从-1 到 1 之间采集101个数
Y  = 2 * X + np.random.randn(*X.shape) * 0.33 # 创建 Y = 2X 加入干扰数据 np.random.randn()是从标准正态分布中返回一个或多个样本值 X.shape获取X的长度返回元组，加*号变成值

x = tf.placeholder("float")
y = tf.placeholder("float")

def model(x,w):# 定义 X*w 的模型
    return tf.multiply(x,w)

w = tf.Variable(0.0,name="weights")
y_model = model(x,w)
cost = tf.square(Y - y_model) #计算平方

train_op = tf.train.GradientDescentOptimizer(0.01).minimize(cost)#tf.train.GradientDescentOptimizer 这个类是实现梯度下降算法的优化器

sess = tf.Session()
sess.run(tf.global_variables_initializer())
for i in range(100):
    for(i,j) in zip(X,Y):
        sess.run(train_op,feed_dict={x:i,y:j})

print(sess.run(w))
```
