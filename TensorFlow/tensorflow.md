# TensorFlow
> 目前主流的`TensorFlow`，用tensorflow这样工具的原因是：它允许我们用计算图（Computational Graphs）的方式建立网络。同时又可以非常方便的对网络进行操作。

[资料](http://www.jianshu.com/p/e0238db24973)<br>
[DIY](http://cs.stanford.edu/people/karpathy/convnetjs/demo/cifar10.html)
# 示例

```
#导入依赖库
import numpy as np #这是Python的一种开源的数值计算扩展，非常强大
import tensorflow as tf  #导入tensorflow 

##构造数据##
x_data=np.random.rand(100).astype(np.float32) #随机生成100个类型为float32的值
y_data=x_data*0.1+0.3  #定义方程式y=x_data*A+B
##-------##

##建立TensorFlow神经计算结构##
weight=tf.Variable(tf.random_uniform([1],-1.0,1.0)) 
biases=tf.Variable(tf.zeros([1]))     
y=Weight*x_data+biases
##-------##

loss=tf.reduce_mean(tf.square(y-y_data))  #判断与正确值的差距
optimizer=tf.train.GradientDescentOptimizer(0.5) #根据差距进行反向传播修正参数
train=optimizer.minimize(loss) #建立训练器

init=tf.initialize_all_variables() #初始化TensorFlow训练结构
sess=tf.Session()  #建立TensorFlow训练会话
sess.run(init)     #将训练结构装载到会话中

for  step in range(400): #循环训练400次
     sess.run(train)  #使用训练器根据训练结构进行训练
     if  step%20==0:  #每20次打印一次训练结果
        print(step,sess.run(weight),sess.run(biases)) #训练次数，A值，B值
```


## 比喻说明：

* 结构：计算图所建立的只是一个网络框架。在编程时，并不会有任何实际值出现在框架中。所有权重和偏移都是框架中的一部分，初始时至少给定初始值才能形成框架。因此需要initialization初始化。
* 比喻：计算图就是一个管道。编写网络就是搭建一个管道结构。在投入实际使用前，不会有任何液体进入管道。而神经网络中的权重和偏移就是管道中的阀门，可以控制液体的流动强弱和方向。在神经网络的训练中，阀门会根据数据进行自我调节、更新。但是使用之前至少要给所有阀门一个初始的状态才能形成结构。用计算图的好处是它允许我们可以从任意一个节点处取出液体。

## 用法说明：

请类比管道构建来理解计算图的用法

### 构造阶段（construction phase）：组装计算图（管道）

* 计算图（graph）：要组装的结构。由许多操作组成。
* 操作（ops）：接受（流入）零个或多个输入（液体），返回（流出）零个或多个输出。
* 数据类型：主要分为张量（tensor）、变量（variable）和常量（constant）
  * 张量：多维array或list（管道中的液体）
    * 创建语句：
    ```
    tensor_name=tf.placeholder(type, shape, name)
    ```
  * 变量：在同一时刻对图中所有其他操作都保持静态的数据（管道中的阀门）
    * 创建语句：
    ````
    name_variable = tf.Variable(value, name)
    ````
    * 初始化语句：
    ```
    #个别变量
    init_op=variable.initializer()
    #所有变量
    init_op=tf.initialize_all_variables()
    #注意：init_op的类型是操作（ops），加载之前并不执行
    ```
    * 更新语句：
    ```
    update_op=tf.assign(variable to be updated, new_value)
    ```
  * 常量：无需初始化的变量
    * 创建语句：
    ```
    name_constant=tf.constant(value)
    ```

## 执行阶段（execution phase）：使用计算图（获取液体）

* 会话：执行（launch）构建的计算图。可选择执行设备：单个电脑的CPU、GPU，或电脑分布式甚至手机。
  * 创建语句：
  ```
  #常规
  sess = tf.Session()
  #交互
  sess = tf.InteractiveSession()
  #交互方式可用tensor.eval()获取值，ops.run()执行操作
  #关闭
  sess.close()
  ```
* 执行操作：使用创建的会话执行操作
  * 执行语句：
  ```
  sess.run(op)
  ```
  * 送值（feed）：输入操作的输入值（输入液体）
    * 语句：
    ```
    sess.run([output], feed_dict={input1:value1, input2:value1})
    ```
  * 取值（fetch）：获取操作的输出值（得到液体）
    * 语句：
    ```
    #单值获取 
    sess.run(one op)
    #多值获取
    sess.run([a list of ops])
    ```
    
# 步骤代码
```
import tensorflow as tf

# 建图
matrix1 = tf.constant([[3., 3.]])
matrix2 = tf.constant([[2.],[2.]])

product = tf.matmul(matrix1, matrix2)

# 启动图
sess = tf.Session()

# 取值
result = sess.run(product)
print result

#关闭
sess.close()
```
