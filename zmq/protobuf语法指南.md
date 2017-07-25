# 定义一个消息类型


先来看一个非常简单的例子。假设你想定义一个“搜索请求”的消息格式，每一个请求含有一个查询字符串、你感兴趣的查询结果所在的页数，以及每一页多少条查询结果。可以采用如下的方式来定义消息类型的.proto文件了：
```
message SearchRequest {
  required string query = 1;
  optional int32 page_number = 2;
  optional int32 result_per_page = 3;
}
```
SearchRequest消息格式有3个字段，在消息中承载的数据分别对应于每一个字段。其中每个字段都有一个名字和一种类型。

## 1 指定字段类型

在上面的例子中，所有字段都是标量类型：两个整型（page_number和result_per_page），一个string类型（query）。当然，你也可以为字段指定其他的合成类型，包括枚举（enumerations）或其他消息类型。

## 2 分配标识号

正如上述文件格式，在消息定义中，每个字段都有唯一的一个数字标识符。这些标识符是用来在消息的二进制格式中识别各个字段的，一旦开始使用就不能够再改变。注：[1,15]之内的标识号在编码的时候会占用一个字节。[16,2047]之内的标识号则占用2个字节。所以应该为那些频繁出现的消息元素保留 [1,15]之内的标识号。切记：要为将来有可能添加的、频繁出现的标识号预留一些标识号。

最小的标识号可以从1开始，最大到2^29 - 1, or 536,870,911。不可以使用其中的[19000－19999]的标识号， Protobuf协议实现中对这些进行了预留。如果非要在.proto文件中使用这些预留标识号，编译时就会报警。

## 3 指定字段规则

所指定的消息字段修饰符必须是如下之一：

* required：一个格式良好的消息一定要含有1个这种字段。表示该值是必须要设置的；
* optional：消息格式中该字段可以有0个或1个值（不超过1个）。
* repeated：在一个格式良好的消息中，这种字段可以重复任意多次（包括0次）。重复的值的顺序会被保留。表示该值可以重复，相当于java中的List。
由于一些历史原因，基本数值类型的repeated的字段并没有被尽可能地高效编码。在新的代码中，用户应该使用特殊选项[packed=true]来保证更高效的编码。如：
```
repeated int32 samples = 4 [packed=true];
```
> required是永久性的：在将一个字段标识为required的时候，应该特别小心。如果在某些情况下不想写入或者发送一个required的字段，将原始该字段修饰符更改为optional可能会遇到问题——旧版本的使用者会认为不含该字段的消息是不完整的，从而可能会无目的的拒绝解析。在这种情况下，你应该考虑编写特别针对于应用程序的、自定义的消息校验函数。Google的一些工程师得出了一个结论：使用required弊多于利；他们更 愿意使用optional和repeated而不是required。当然，这个观点并不具有普遍性。

## 4 添加更多消息类型

在一个.proto文件中可以定义多个消息类型。在定义多个相关的消息的时候，这一点特别有用——例如，如果想定义与SearchResponse消息类型对应的回复消息格式的话，你可以将它添加到相同的.proto文件中，如：
```
message SearchRequest {
  required string query = 1;
  optional int32 page_number = 2;
  optional int32 result_per_page = 3;
}
message SearchResponse {
 ...
}
```
## 5 添加注释

向.proto文件添加注释，可以使用C/C++/java风格的双斜杠（//） 语法格式，如：
```
message SearchRequest {
  required string query = 1;
  optional int32 page_number = 2;// Which page number do we want?
  optional int32 result_per_page = 3;// Number of results to return per page.
}
```
## 6 从.proto文件生成了什么？

当用protocolbuffer编译器来运行.proto文件时，编译器将生成所选择语言的代码，这些代码可以操作在.proto文件中定义的消息类型，包括获取、设置字段值，将消息序列化到一个输出流中，以及从一个输入流中解析消息。

* 对C++来说，编译器会为每个.proto文件生成一个.h文件和一个.cc文件，.proto文件中的每一个消息有一个对应的类。
* 对Java来说，编译器为每一个消息类型生成了一个.java文件，以及一个特殊的Builder类（该类是用来创建消息类接口的）。
* 对Python来说，有点不太一样——Python编译器为.proto文件中的每个消息类型生成一个含有静态描述符的模块，，该模块与一个元类（metaclass）在运行时（runtime）被用来创建所需的Python数据访问类。
你可以从如下的文档链接中获取每种语言更多API。http://code.google.com/intl/zh-CN/apis/protocolbuffers/docs/reference/overview.html

## 7 标量数值类型

一个标量消息字段可以含有一个如下的类型——该表格展示了定义于.proto文件中的类型，以及与之对应的、在自动生成的访问类中定义的类型：
```
.proto类型      Java 类型     C++类型     备注
double          double        double
float           float         float
int32           int           int32       使用可变长编码方式。编码负数时不够高效——如果你的字段可能含有负数，那么请使用sint32。
int64           long          int64       使用可变长编码方式。编码负数时不够高效——如果你的字段可能含有负数，那么请使用sint64。
uint32          int[1]        uint32      Uses variable-length encoding.
uint64          long[1]	      uint64      Uses variable-length encoding.
sint32          int           int32       使用可变长编码方式。有符号的整型值。编码时比通常的int32高效。
sint64          long          int64       使用可变长编码方式。有符号的整型值。编码时比通常的int64高效。
fixed32         int[1]        uint32      总是4个字节。如果数值总是比总是比228大的话，这个类型会比uint32高效。
fixed64         long[1]       uint64      总是8个字节。如果数值总是比总是比256大的话，这个类型会比uint64高效。
sfixed32        int           int32       总是4个字节。
sfixed64        long          int64       总是8个字节。
bool            boolean       bool
string          String        string      一个字符串必须是UTF-8编码或者7-bit ASCII编码的文本。
bytes           ByteString    string      可能包含任意顺序的字节数据。
```
你可以在文章http://code.google.com/apis/protocolbuffers/docs/encoding.html 中，找到更多“序列化消息时各种类型如何编码”的信息。

## 8 Optional的字段和默认值

如上所述，消息描述中的一个元素可以被标记为“可选的”（optional）。一个格式良好的消息可以包含0个或一个optional的元素。当解 析消息时，如果它不包含optional的元素值，那么解析出来的对象中的对应字段就被置为默认值。默认值可以在消息描述文件中指定。例如，要为 SearchRequest消息的result_per_page字段指定默认值10，在定义消息格式时如下所示：
```
optional int32 result_per_page = 3 [default = 10];
```
如果没有为optional的元素指定默认值，就会使用与特定类型相关的默认值：对string来说，默认值是空字符串。对bool来说，默认值是false。对数值类型来说，默认值是0。对枚举来说，默认值是枚举类型定义中的第一个值。

## 9 枚举

当需要定义一个消息类型的时候，可能想为一个字段指定某“预定义值序列”中的一个值。例如，假设要为每一个SearchRequest消息添加一个 corpus字段，而corpus的值可能是UNIVERSAL，WEB，IMAGES，LOCAL，NEWS，PRODUCTS或VIDEO中的一个。 其实可以很容易地实现这一点：通过向消息定义中添加一个枚举（enum）就可以了。一个enum类型的字段只能用指定的常量集中的一个值作为其值（如果尝 试指定不同的值，解析器就会把它当作一个未知的字段来对待）。在下面的例子中，在消息格式中添加了一个叫做Corpus的枚举类型——它含有所有可能的值 ——以及一个类型为Corpus的字段：
```
message SearchRequest {
  required string query = 1;
  optional int32 page_number = 2;
  optional int32 result_per_page = 3 [default = 10];
  enum Corpus {
    UNIVERSAL = 0;
    WEB = 1;
    IMAGES = 2;
    LOCAL = 3;
    NEWS = 4;
    PRODUCTS = 5;
    VIDEO = 6;
  }
  optional Corpus corpus = 4 [default = UNIVERSAL];
}
```
你可以为枚举常量定义别名。 需要设置allow_alias option 为 true, 否则 protocol编译器会产生错误信息。
```
enum EnumAllowingAlias {
  option allow_alias = true;
  UNKNOWN = 0;
  STARTED = 1;
  RUNNING = 1;
}
enum EnumNotAllowingAlias {
  UNKNOWN = 0;
  STARTED = 1;
  // RUNNING = 1;  // Uncommenting this line will cause a compile error inside Google and a warning message outside.
}
```
枚举常量必须在32位整型值的范围内。因为enum值是使用可变编码方式的，对负数不够高效，因此不推荐在enum中使用负数。如上例所示，可以在 一个消息定义的内部或外部定义枚举——这些枚举可以在.proto文件中的任何消息定义里重用。当然也可以在一个消息中声明一个枚举类型，而在另一个不同 的消息中使用它——采用MessageType.EnumType的语法格式。

当对一个使用了枚举的.proto文件运行protocol buffer编译器的时候，生成的代码中将有一个对应的enum（对Java或C++来说），或者一个特殊的EnumDescriptor类（对 Python来说），它被用来在运行时生成的类中创建一系列的整型值符号常量（symbolic constants）。

关于如何在你的应用程序的消息中使用枚举的更多信息，请查看所选择的语言http://code.google.com/intl/zh-CN/apis/protocolbuffers/docs/reference/overview.html。

# 使用其他消息类型

你可以将其他消息类型用作字段类型。例如，假设在每一个SearchResponse消息中包含Result消息，此时可以在相同的.proto文件中定义一个Result消息类型，然后在SearchResponse消息中指定一个Result类型的字段，如：
```
message SearchResponse {
  repeated Result result = 1;
}
message Result {
  required string url = 1;
  optional string title = 2;
  repeated string snippets = 3;
}
```
## 1 导入定义

在上面的例子中，Result消息类型与SearchResponse是定义在同一文件中的。如果想要使用的消息类型已经在其他.proto文件中已经定义过了呢？
你可以通过导入（importing）其他.proto文件中的定义来使用它们。要导入其他.proto文件的定义，你需要在你的文件中添加一个导入声明，如：
```
import "myproject/other_protos.proto";
```
默认情况下你只能使用直接导入的.proto文件中的定义. 然而， 有时候你需要移动一个.proto文件到一个新的位置， 可以不直接移动.proto文件， 只需放入一个dummy .proto 文件在老的位置， 然后使用import转向新的位置:
```
// new.proto
// All definitions are moved here
```
```
// old.proto
// This is the proto that all clients are importing.
import public "new.proto";
import "other.proto";
```
// client.proto
```
import "old.proto";
// You use definitions from old.proto and new.proto, but not other.proto
```
protocol编译器就会在一系列目录中查找需要被导入的文件，这些目录通过protocol编译器的命令行参数-I/–import_path指定。如果不提供参数，编译器就在其调用目录下查找。

## 2 嵌套类型

你可以在其他消息类型中定义、使用消息类型，在下面的例子中，Result消息就定义在SearchResponse消息内，如：
```
message SearchResponse {
  message Result {
    required string url = 1;
    optional string title = 2;
    repeated string snippets = 3;
  }
  repeated Result result = 1;
}
```
如果你想在它的父消息类型的外部重用这个消息类型，你需要以Parent.Type的形式使用它，如：
```
message SomeOtherMessage {
  optional SearchResponse.Result result = 1;
}
```
当然，你也可以将消息嵌套任意多层，如：
```
message Outer {                  // Level 0
  message MiddleAA {  // Level 1
    message Inner {   // Level 2
      required int64 ival = 1;
      optional bool  booly = 2;
    }
  }
  message MiddleBB {  // Level 1
    message Inner {   // Level 2
      required int32 ival = 1;
      optional bool  booly = 2;
    }
  }
}
```
## 3 组

> 注：该特性已被弃用，在创建新的消息类型的时候，不应该再使用它——可以使用嵌套消息类型来代替它。

“组”是指在消息定义中嵌套信息的另一种方法。比如，在SearchResponse中包含若干Result的另一种方法是 ：

```
message SearchResponse {
  repeated group Result = 1 {
    required string url = 2;
    optional string title = 3;
    repeated string snippets = 4;
  }
}
```
一个“组”只是简单地将一个嵌套消息类型和一个字段捆绑到一个单独的声明中。在代码中，可以把它看成是含有一个Result类型、名叫result的字段的消息（后面的名字被转换成了小写，所以它不会与前面的冲突）。

因此，除了数据传输格式不同之外，这个例子与上面的SearchResponse例子是完全等价的。

## 4 更新一个消息类型

如果一个已有的消息格式已无法满足新的需求——如，要在消息中添加一个额外的字段——但是同时旧版本写的代码仍然可用。不用担心！更新消息而不破坏已有代码是非常简单的。在更新时只要记住以下的规则即可。

* 不要更改任何已有的字段的数值标识。
  * 所添加的任何字段都必须是optional或repeated的。这就意味着任何使用“旧”的消息格式的代码序列化的消息可以被新的代码所解析，因为它们 不会丢掉任何required的元素。应该为这些元素设置合理的默认值，这样新的代码就能够正确地与老代码生成的消息交互了。类似地，新的代码创建的消息 也能被老的代码解析：老的二进制程序在解析的时候只是简单地将新字段忽略。然而，未知的字段是没有被抛弃的。此后，如果消息被序列化，未知的字段会随之一 起被序列化——所以，如果消息传到了新代码那里，则新的字段仍然可用。注意：对Python来说，对未知字段的保留策略是无效的。
  * 非required的字段可以移除——只要它们的标识号在新的消息类型中不再使用（更好的做法可能是重命名那个字段，例如在字段前添加“OBSOLETE\_”前缀，那样的话，使用的.proto文件的用户将来就不会无意中重新使用了那些不该使用的标识号）。
* 一个非required的字段可以转换为一个扩展，反之亦然——只要它的类型和标识号保持不变。
* int32, uint32, int64, uint64,和bool是全部兼容的，这意味着可以将这些类型中的一个转换为另外一个，而不会破坏向前、 向后的兼容性。如果解析出来的数字与对应的类型不相符，那么结果就像在C++中对它进行了强制类型转换一样（例如，如果把一个64位数字当作int32来 读取，那么它就会被截断为32位的数字）。
* sint32和sint64是互相兼容的，但是它们与其他整数类型不兼容。
* string和bytes是兼容的——只要bytes是有效的UTF-8编码。
* 嵌套消息与bytes是兼容的——只要bytes包含该消息的一个编码过的版本。
* fixed32与sfixed32是兼容的，fixed64与sfixed64是兼容的。

## 5 扩展

通过扩展，可以将一个范围内的字段标识号声明为可被第三方扩展所用。然后，其他人就可以在他们自己的.proto文件中为该消息类型声明新的字段，而不必去编辑原始文件了。看个具体例子：

```
message Foo {
  // ...
  extensions 100 to 199;
}
```
这个例子表明：在消息Foo中，范围[100,199]之内的字段标识号被保留为扩展用。现在，其他人就可以在他们自己的.proto文件中添加新字段到Foo里了，但是添加的字段标识号要在指定的范围内——例如：

```
extend Foo {
  optional int32 bar = 126;
}
```
这个例子表明：消息Foo现在有一个名为bar的optional int32字段。

当用户的Foo消息被编码的时候，数据的传输格式与用户在Foo里定义新字段的效果是完全一样的。
然而，要在程序代码中访问扩展字段的方法与访问普通的字段稍有不同——生成的数据访问代码为扩展准备了特殊的访问函数来访问它。例如，下面是如何在C++中设置bar的值：
```
Foo foo;
foo.SetExtension(bar, 15);
```
> 类似地，Foo类也定义了模板函数 HasExtension()，ClearExtension()，GetExtension()，MutableExtension()，以及 AddExtension()。这些函数的语义都与对应的普通字段的访问函数相符。要查看更多使用扩展的信息，请参考相应语言的代码生成指南。注：扩展可 以是任何字段类型，包括消息类型。

## 6 嵌套的扩展

可以在另一个类型的范围内声明扩展，如：

```
message Baz {
  extend Foo {
    optional int32 bar = 126;
  }
  ...
}
```
在此例中，访问此扩展的C++代码如下：

```
Foo foo;
foo.SetExtension(Baz::bar, 15);
```
In other words, the only effect is that bar is defined within the scope of Baz.

> This is a common source of confusion: Declaring an extend block nested inside a message type does not imply any relationship between the outer type and the extended type. In particular, the above example does not mean that Baz is any sort of subclass of Foo. All it means is that the symbol bar is declared inside the scope of Baz; it's simply a static member.

一个通常的设计模式就是：在扩展的字段类型的范围内定义该扩展——例如，下面是一个Foo的扩展（该扩展是Baz类型的），其中，扩展被定义为了Baz的一部分：

```
message Baz {
  extend Foo {
    optional Baz foo_ext = 127;
  }
  ...
}
```
然而，并没有强制要求一个消息类型的扩展一定要定义在那个消息中。也可以这样做：

```
message Baz {
  ...
}
// This can even be in a different file.
extend Foo {
  optional Baz foo_baz_ext = 127;
}
```
事实上，这种语法格式更能防止引起混淆。正如上面所提到的，嵌套的语法通常被错误地认为有子类化的关系——尤其是对那些还不熟悉扩展的用户来说。

## 7 选择可扩展的标量符号

在同一个消息类型中一定要确保两个用户不会扩展新增相同的标识号，否则可能会导致数据的不一致。可以通过为新项目定义一个可扩展标识号规则来防止该情况的发生。

如果标识号需要很大的数量时，可以将该可扩展标符号的范围扩大至max，其中max是229 - 1, 或536,870,911。如下所示：
```
 message Foo {
  extensions 1000 to max;
}
```
max 是 2^29 - 1, 或者 536,870,911.

通常情况下在选择标符号时，标识号产生的规则中应该避开[19000－19999]之间的数字，因为这些已经被Protocol Buffers实现中预留了。

# Oneof


如果你的消息中有很多可选字段， 并且同时至多一个字段会被设置， 你可以加强这个行为，使用oneof特性节省内存.

Oneof字段就像可选字段， 除了它们会共享内存， 至多一个字段会被设置。 设置其中一个字段会清除其它oneof字段。 你可以使用case()或者WhichOneof() 方法检查哪个oneof字段被设置， 看你使用什么语言了.

## 1 使用Oneof

为了在.proto定义Oneof字段， 你需要在名字前面加上oneof关键字, 比如下面例子的test_oneof:

```
message SampleMessage {
  oneof test_oneof {
     string name = 4;
     SubMessage sub_message = 9;
  }
}
```
然后你可以增加oneof字段到 oneof 定义中. 你可以增加任意类型的字段, 但是不能使用 required, optional, repeated 关键字.

在产生的代码中, oneof字段拥有同样的 getters 和setters， 就像正常的可选字段一样. 也有一个特殊的方法来检查到底那个字段被设置. 你可以在相应的语言API中找到oneof API介绍.

### Oneof 特性:

* 设置oneof会自动清楚其它oneof字段的值. 所以设置多次后，只有最后一次设置的字段有值.
```
SampleMessage message;
message.set_name(“name”);
CHECK(message.has_name());
message.mutable_sub_message();   // Will clear name field.
CHECK(!message.has_name());
```
* If the parser encounters multiple members of the same oneof on the wire, only the last member seen is used in the parsed message.
* oneof不支持扩展.
* oneof不能 repeated.
* 反射API对oneof 字段有效.
* 如果使用C++,需确保代码不会导致内存泄漏. 下面的代码会崩溃， 因为sub_message 已经通过set_name()删除了.
```
SampleMessage message;
SubMessage* sub_message = message.mutable_sub_message();
message.set_name(“name”);      // Will delete sub_message
sub_message.set_…              // Crashes here
```
* Again in C++, if you Swap() two messages with oneofs, each message will end up with the other’s oneof case: in the example below, msg1 will have a sub_message and msg2 will have a name.
```
SampleMessage msg1;
msg1.set_name(“name”);
SampleMessage msg2;
msg2.mutable_sub_message();
msg1.swap(&msg2);
CHECK(msg1.has_sub_message());
CHECK(msg2.has_name());
```
## 2 向后兼容性问题

当增加或者删除oneof字段时一定要小心. 如果检查oneof的值返回None/NOT_SET, 它意味着oneof字段没有被赋值或者在一个不同的版本中赋值了。 你不会知道是哪种情况。

### Tag 重用问题

* Move optional fields into or out of a oneof: You may lose some of your information (some fields will be cleared) after the message is serialized and parsed.
* Delete a oneof field and add it back: This may clear your currently set oneof field after the message is serialized and parsed.
* Split or merge oneof: This has similar issues to moving regular optional fields.
# 包（Package）

当然可以为.proto文件新增一个可选的package声明符，用来防止不同的消息类型有命名冲突。如：

```
package foo.bar;
message Open { ... }
```
在其他的消息格式定义中可以使用包名+消息名的方式来定义域的类型，如：
```
message Foo {
  ...
  required foo.bar.Open open = 1;
  ...
}
```
包的声明符会根据使用语言的不同影响生成的代码。

* 对于C++，产生的类会被包装在C++的命名空间中，如上例中的Open会被封装在 foo::bar空间中；
* 对于Java，包声明符会变为java的一个包，除非在.proto文件中提供了一个明确有java_package；
* 对于 Python，这个包声明符是被忽略的，因为Python模块是按照其在文件系统中的位置进行组织的。
## 1 包及名称的解析

Protocol buffer语言中类型名称的解析与C++是一致的：首先从最内部开始查找，依次向外进行，每个包会被看作是其父类包的内部类。当然对于 （foo.bar.Baz）这样以“.”分隔的意味着是从最外围开始的。ProtocolBuffer编译器会解析.proto文件中定义的所有类型名。 对于不同语言的代码生成器会知道如何来指向每个具体的类型，即使它们使用了不同的规则。

### 定义服务(Service)

如果想要将消息类型用在RPC(远程方法调用)系统中，可以在.proto文件中定义一个RPC服务接口，protocol buffer编译器将会根据所选择的不同语言生成服务接口代码及存根。如，想要定义一个RPC服务并具有一个方法，该方法能够接收 SearchRequest并返回一个SearchResponse，此时可以在.proto文件中进行如下定义：
```
service SearchService {
  rpc Search (SearchRequest) returns (SearchResponse);
}
```
protocol编译器将产生一个抽象接口SearchService以及一个相应的存根实现。存根将所有的调用指向RpcChannel，它是一 个抽象接口，必须在RPC系统中对该接口进行实现。如，可以实现RpcChannel以完成序列化消息并通过HTTP方式来发送到一个服务器。换句话说， 产生的存根提供了一个类型安全的接口用来完成基于protocolbuffer的RPC调用，而不是将你限定在一个特定的RPC的实现中。C++中的代码 如下所示：
```
using google::protobuf;
protobuf::RpcChannel* channel;
protobuf::RpcController* controller;
SearchService* service;
SearchRequest request;
SearchResponse response;
void DoSearch() {
  // You provide classes MyRpcChannel and MyRpcController, which implement
  // the abstract interfaces protobuf::RpcChannel and protobuf::RpcController.
  channel = new MyRpcChannel("somehost.example.com:1234");
  controller = new MyRpcController;
  // The protocol compiler generates the SearchService class based on the
  // definition given above.
  service = new SearchService::Stub(channel);
  // Set up the request.
  request.set_query("protocol buffers");
  // Execute the RPC.
  service->Search(controller, request, response, protobuf::NewCallback(&Done));
}
void Done() {
  delete service;
  delete channel;
  delete controller;
}
```
所有service类都必须实现Service接口，它提供了一种用来调用具体方法的方式，即在编译期不需要知道方法名及它的输入、输出类型。在服务器端，通过服务注册它可以被用来实现一个RPC Server。

```
using google::protobuf;
class ExampleSearchService : public SearchService {
 public:
  void Search(protobuf::RpcController* controller,
              const SearchRequest* request,
              SearchResponse* response,
              protobuf::Closure* done) {
    if (request->query() == "google") {
      response->add_result()->set_url("http://www.google.com");
    } else if (request->query() == "protocol buffers") {
      response->add_result()->set_url("http://protobuf.googlecode.com");
    }
    done->Run();
  }
};
int main() {
  // You provide class MyRpcServer.  It does not have to implement any
  // particular interface; this is just an example.
  MyRpcServer server;
  protobuf::Service* service = new ExampleSearchService;
  server.ExportOnPort(1234, service);
  server.Run();
  delete service;
  return 0;
}
```
There are a number of ongoing third-party projects to develop RPC implementations for Protocol Buffers. For a list of links to projects we know about, see the third-party add-ons wiki page.

# 选项（Options）

在定义.proto文件时能够标注一系列的options。Options并不改变整个文件声明的含义，但却能够影响特定环境下处理方式。完整的可用选项可以在google/protobuf/descriptor.proto找到。

一些选项是文件级别的，意味着它可以作用于最外范围，不包含在任何消息内部、enum或服务定义中。一些选项是消息级别的，意味着它可以用在消息定 义的内部。当然有些选项可以作用在域、enum类型、enum值、服务类型及服务方法中。到目前为止，并没有一种有效的选项能作用于所有的类型。

如下就是一些常用的选择：

* java_package (file option): 这个选项表明生成java类所在的包。如果在.proto文件中没有明确的声明java_package，就采用默认的包名。当然了，默认方式产生的 java包名并不是最好的方式，按照应用名称倒序方式进行排序的。如果不需要产生java代码，则该选项将不起任何作用。如：
```
option java_package = "com.example.foo";
```
* java_outer_classname (file option): 该选项表明想要生成Java类的名称。如果在.proto文件中没有明确的java_outer_classname定义，生成的class名称将会根据.proto文件的名称采用驼峰式的命名方式进行生成。如（foo_bar.proto生成的java类名为FooBar.java）,如果不生成java代码，则该选项不起任何作用。如：
```
option java_outer_classname = "Ponycopter";
```
* optimize_for (fileoption): 可以被设置为 SPEED, CODE_SIZE,or LITE_RUNTIME。这些值将通过如下的方式影响C++及java代码的生成：
  * SPEED (default): protocol buffer编译器将通过在消息类型上执行序列化、语法分析及其他通用的操作。这种代码是最优的。
  * CODE_SIZE: protocol buffer编译器将会产生最少量的类，通过共享或基于反射的代码来实现序列化、语法分析及各种其它操作。采用该方式产生的代码将比SPEED要少得多， 但是操作要相对慢些。当然实现的类及其对外的API与SPEED模式都是一样的。这种方式经常用在一些包含大量的.proto文件而且并不盲目追求速度的 应用中。
  * LITE_RUNTIME: protocol buffer编译器依赖于运行时核心类库来生成代码（即采用libprotobuf-lite 替代libprotobuf）。这种核心类库由于忽略了一 些描述符及反射，要比全类库小得多。这种模式经常在移动手机平台应用多一些。编译器采用该模式产生的方法实现与SPEED模式不相上下，产生的类通过实现 MessageLite接口，但它仅仅是Messager接口的一个子集。
```
option optimize_for = CODE_SIZE;
```
* cc_generic_services, java_generic_services, py_generic_services (file options): 在C++、java、python中protocol buffer编译器是否应该基于服务定义产生抽象服务代码。由于历史遗留问题，该值默认是true。但是自2.3.0版本以来，它被认为通过提供代码生成 器插件来对RPC实现更可取，而不是依赖于“抽象”服务。
```
// This file relies on plugins to generate service code.
option cc_generic_services = false;
option java_generic_services = false;
option py_generic_services = false;
```
* message_set_wire_format (message option): 如果该值被设置为true，该消息将使用一种不同的二进制格式来与Google内部的MessageSet的老格式相兼容。对于Google外部的用户来说，该选项将不会被用到。如下所示:
```
message Foo {
  option message_set_wire_format = true;
  extensions 4 to max;
}
```
* packed (field option): 如果该选项在一个整型基本类型上被设置为真，则采用更紧凑的编码方式。当然使用该值并不会对数值造成任何损失。在2.3.0版本之前，解析器将会忽略那些 非期望的包装值。因此，它不可能在不破坏现有框架的兼容性上而改变压缩格式。在2.3.0之后，这种改变将是安全的，解析器能够接受上述两种格式，但是在 处理protobuf老版本程序时，还是要多留意一下。
```
repeated int32 samples = 4 [packed=true];
```
* deprecated (field option): 如果该选项被设置为true，表明该字段已经被弃用了，在新代码中不建议使用。在多数语言中，这并没有实际的含义。在java中，它将会变成一个 @Deprecated注释。也许在将来，其它基于语言声明的代码在生成时也会如此使用，当使用该字段时，编译器将自动报警。如：
```
optional int32 old_field = 6 [deprecated=true];
```
## 1 自定义选项

ProtocolBuffers允许自定义并使用选项。该功能应该属于一个高级特性，对于大部分人是用不到的。由于options是定在 google/protobuf/descriptor.proto中的，因此你可以在该文件中进行扩展，定义自己的选项。如：
```
import "google/protobuf/descriptor.proto";
extend google.protobuf.MessageOptions {
  optional string my_option = 51234;
}
message MyMessage {
  option (my_option) = "Hello world!";
}
```
在上述代码中，通过对MessageOptions进行扩展定义了一个新的消息级别的选项。当使用该选项时，选项的名称需要使用（）包裹起来，以表明它是一个扩展。在C++代码中可以看出my_option是以如下方式被读取的。
```
string value = MyMessage::descriptor()->options().GetExtension(my_option);
```
在Java代码中的读取方式如下：
```
String value = MyProtoFile.MyMessage.getDescriptor().getOptions()
  .getExtension(MyProtoFile.myOption);
```
在Python中:
```
value = my_proto_file_pb2.MyMessage.DESCRIPTOR.GetOptions()
  .Extensions[my_proto_file_pb2.my_option]
  ```
正如上面的读取方式，定制选项对于Python并不支持。定制选项在protocol buffer语言中可用于任何结构。下面就是一些具体的例子：
```
import "google/protobuf/descriptor.proto";
extend google.protobuf.FileOptions {
  optional string my_file_option = 50000;
}
extend google.protobuf.MessageOptions {
  optional int32 my_message_option = 50001;
}
extend google.protobuf.FieldOptions {
  optional float my_field_option = 50002;
}
extend google.protobuf.EnumOptions {
  optional bool my_enum_option = 50003;
}
extend google.protobuf.EnumValueOptions {
  optional uint32 my_enum_value_option = 50004;
}
extend google.protobuf.ServiceOptions {
  optional MyEnum my_service_option = 50005;
}
extend google.protobuf.MethodOptions {
  optional MyMessage my_method_option = 50006;
}
option (my_file_option) = "Hello world!";
message MyMessage {
  option (my_message_option) = 1234;
  optional int32 foo = 1 [(my_field_option) = 4.5];
  optional string bar = 2;
}
enum MyEnum {
  option (my_enum_option) = true;
  FOO = 1 [(my_enum_value_option) = 321];
  BAR = 2;
}
message RequestType {}
message ResponseType {}
service MyService {
  option (my_service_option) = FOO;
  rpc MyMethod(RequestType) returns(ResponseType) {
    // Note:  my_method_option has type MyMessage.  We can set each field
    //   within it using a separate "option" line.
    option (my_method_option).foo = 567;
    option (my_method_option).bar = "Some string";
  }
}
```
注：如果要在该选项定义之外使用一个自定义的选项，必须要由包名 + 选项名来定义该选项。如：
```
// foo.proto
import "google/protobuf/descriptor.proto";
package foo;
extend google.protobuf.MessageOptions {
  optional string my_option = 51234;
}
```
```
// bar.proto
import "foo.proto";
package bar;
message MyMessage {
  option (foo.my_option) = "Hello world!";
}
```
最后一件事情需要注意：因为自定义选项是可扩展的，它必须象其它的域或扩展一样来定义标识号。正如上述示例，[50000－99999]已经被占 用，该范围内的值已经被内部所使用，当然了你可以在内部应用中随意使用。如果你想在一些公共应用中进行自定义选项，你必须确保它是全局唯一的。可以通过protobuf-global-extension-registry@google.com来获取全局唯一标识号。 只需提供你的项目名和项目网站. 通常你只需要一个扩展号。 你可以使用一个扩展号声明多个选项:
```
message FooOptions {
  optional int32 opt1 = 1;
  optional string opt2 = 2;
}
extend google.protobuf.FieldOptions {
  optional FooOptions foo_options = 1234;
}
// usage:
message Bar {
  optional int32 a = 1 [(foo_options).opt1 = 123, (foo_options).opt2 = "baz"];
  // alternative aggregate syntax (uses TextFormat):
  optional int32 b = 2 [(foo_options) = { opt1: 123 opt2: "baz" }];
}
```
# 生成访问类

可以通过定义好的.proto文件来生成Java、Python、C++代码，需要基于.proto文件运行protocol buffer编译器protoc。运行的命令如下所示：
```
protoc --proto_path=IMPORT_PATH --cpp_out=DST_DIR --java_out=DST_DIR --python_out=DST_DIR path/to/file.proto
```
* IMPORT_PATH声明了一个.proto文件所在的具体目录。如果忽略该值，则使用当前目录。如果有多个目录则可以 对--proto_path 写多次，它们将会顺序的被访问并执行导入。-I=IMPORT_PATH是它的简化形式。

* 当然也可以提供一个或多个输出路径：
  * --cpp_out 在目标目录DST_DIR中产生C++代码，可以在 http://code.google.com/intl/zh-CN/apis/protocolbuffers/docs/reference /cpp-generated.html中查看更多。
  * --java_out 在目标目录DST_DIR中产生Java代码，可以在 http://code.google.com/intl/zh-CN/apis/protocolbuffers/docs/reference /java-generated.html中查看更多。
  * --python_out 在目标目录 DST_DIR 中产生Python代码，可以在http://code.google.com/intl/zh-CN/apis/protocolbuffers /docs/reference/python-generated.html中查看更多。
  * 作为一种额外的约定，如果DST_DIR 是以.zip或.jar结尾的，编译器将输出结果打包成一个zip格式的归档文件。.jar将会输出一个 Java JAR声明必须的manifest文件。注：如果该输出归档文件已经存在，它将会被重写，编译器并没有做到足够的智能来为已经存在的归档文件添加新的文 件。
你必须提供一个或多个.proto文件作为输入。多个.proto文件能够一次全部声明。虽然这些文件是相对于当前目录来命名的，每个文件必须在一个IMPORT_PATH中，只有如此编译器才可以决定它的标准名称。
