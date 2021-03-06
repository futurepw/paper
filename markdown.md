# markdown语法

## 标题
在markdown中，如果一段文字被定义为标题，要在这段文字前加`#`即可，总共有六级标题，建议在`#`后面加一个空格。
* `# 一级标题`
* `## 二级标题`
* `### 三级标题`
* `#### 四级标题`
* `##### 五级标题`
* `###### 六级标题`

## 列表
在markdown中，列表的显示只需要在文字前加`-`，`+`或者`*`即可变为无序列表，有序列表则直接在文字前面加`1.` `2.` `3.`，符号要和文字之间加一个字符的空格</br>
有序列表
1. 有序列表
2. 有序列表
3. 有序列表
4. 有序列表
</br>

</br>
</br>

## 换行和空格
换行用`</br>`，空格用`&#160;`或者`&nbsp;`

## 引用
在文本前面加`>`这种尖括号即可，也可以嵌套
> 这是引用

> 这是引用
> > 这是引用
> > > 这是引用

## 图片和链接
插入链接和插入图片很像，区别在于一个`!`号
</br>
图片为:`![]()`</br>
链接为:`[]()`</br>
其中中括号里面写名称描叙，而小括号里面写url即可，如`![img](http://mouapp.com/Mou_128.png)`表示图片写法，`[百度一下](www.baidu.com)`表示链接写法

## 粗体和斜体
markdown的粗体和斜体非常简单，用三个`*`包含一段文本就是表示粗斜体的写法，用两个`*`包含一段文本就是表示粗体的写法，用一个`*`包含一段文字的写法表示斜体的写法，也可用`_`代替
</br>
**这是粗体** </br>
*这是斜体*</br>
***这是粗斜体***</br>

## 表格
markdown中表格的写法比较麻烦</br>
```
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |
```
生成表格如下，其中`:`在左边表示左对齐，在右边表示右对齐，两边都有表示居中
| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

## 点亮与代码框
markdown中用一个` `` `将字体包裹在内部表示字体点亮，而用` ```代码``` `这种方式则表示代码框，使用 tab 键即可缩进，如：
```
#include <iostream>
using namespace std;
int main(){
    cout<<"hello world"<<endl;
    return 0;
}
```

## 分割线
分割线语法只需要三个*号或者三个-好即可，如
***
---
