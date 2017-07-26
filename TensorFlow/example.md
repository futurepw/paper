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
