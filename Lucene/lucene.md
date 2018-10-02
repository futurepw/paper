# 建立索引

我们都知道，使用数据库的时候，想增快搜索的效率，最常用的方法就是给数据添加索引。在Lucene中之所以可以快速的搜索到想要的信心，
也是因为建立了对应的索引。所以，使用Lucene的第一个步骤，就是建立索引。下面我们看看Lucene是怎么建立索引的。
```
public class Indexer {
 
    public static String[] strs = { "This is Tom!", "Hi, Marry.",
            "Lucene is good" };
    public static String indexDir = "d:/LuceneIndex";
 
    public static void main(String[] args) {
 
        IndexWriter writer = null;
        try {
            // 索引目录
            Directory dir = FSDirectory.open(new File(indexDir));
 
            // 配置并新建索引
            IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_36,
                    new StandardAnalyzer(Version.LUCENE_36));
            writer = new IndexWriter(dir, config);
 
            // 往索引中写入文档
            for (String str : strs) {
                // 新建文档
                Document doc = new Document();
                // 域
                Field field = new Field("contents", str, Field.Store.YES,
                        Field.Index.ANALYZED);
                // 向文档中加入域
                doc.add(field);
                // 添加文档
                writer.addDocument(doc);
            }
            System.out.println("被索引的文档个数：" + writer.numDocs());
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (writer != null)
                try {
                    // 关闭writer
                    writer.close();
                } catch (CorruptIndexException e) {
                    e.printStackTrace();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
 
    }
 
}
```
在代码中可以看得出，索引的建立主要是通过IndexWriter这个类来生成。IndexWriter的构造方法是：
IndexWriter(Directory d, IndexWriterConfig conf)。需要传入一个Directory以及一个IndexWriterConfig对象。
Document就类似我们数据库的里面的一条记录。Field可以理解为这条记录的一个字段。
在添加完Document之后，记得使用writer.close();方法来关闭writer。

# 搜索索引
正如我们所知道的，Lucene主要是围绕索引来实现搜索功能。既然现在已经建立好了索引。那么，我们现在来看看Lucene中怎么搜索索引吧。
```
public class Seacher {
 
    // 索引保存路径
    public static String indexDir = "d:/LuceneIndex";
 
    public static void main(String[] args) {
 
        // IndexSearcher
        IndexSearcher searcher = null;
        try {
 
            // 新建 IndexSearcher
            Directory dir = FSDirectory.open(new File(indexDir));
            IndexReader reader = IndexReader.open(dir);
            searcher = new IndexSearcher(reader);
 
            // 搜索条件
            QueryParser parser = new QueryParser(Version.LUCENE_36, "contents",
                    new StandardAnalyzer(Version.LUCENE_36));
            Query query = parser.parse("Hi,Tom");
 
            // 搜索结果
            TopDocs hits = searcher.search(query, 10);
 
            // 获取搜索结果
            for (ScoreDoc scoreDoc : hits.scoreDocs) {
                Document doc = searcher.doc(scoreDoc.doc);
                System.out.println(doc.get("contents"));
            }
 
        } catch (IOException e) {
            e.printStackTrace();
        } catch (ParseException e) {
            e.printStackTrace();
        } finally {
            if (searcher != null)
                try {
                    // 关闭 IndexSearcher
                    searcher.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
        }
 
    }
 
}
```
Lucene中搜索索引，主要是通过IndexSearcher这个类来实现的。IndexSearcher的构造方法是：IndexSearcher(IndexReader r)。
IndexReader需要通过FSDirectory.open(new File(indexDir));来获取。
搜索的时候，需要通过QueryParser来生成一个查询条件Query，然后使用TopDocs hits = searcher.search(query, 10);
来获取查询的数据。因为通常情况下，不需要所有的查询结果，所以这里只查了10条。

查询得打的TopDocs对象，其实并没有包含我们需要的查询结果，它只包含了我们所查询到的结果的id。
需要使用searcher.doc(scoreDoc.doc);方法来获取我们的插叙结果，也就是我们需要的Document。


# lucene api 介绍

Lucene 是一个高性能的全文搜索框架，下面是使用 Lucene 的简单例子：
```
Analyzer analyzer = new StandardAnalyzer(Version.LUCENE_CURRENT);
 
// Store the index in memory:
Directory directory = new RAMDirectory();
// To store an index on disk, use this instead:
//Directory directory = FSDirectory.open("/tmp/testindex");
IndexWriterConfig config = new IndexWriterConfig(Version.LUCENE_CURRENT, analyzer);
IndexWriter iwriter = new IndexWriter(directory, config);
Document doc = new Document();
String text = "This is the text to be indexed.";
doc.add(new Field("fieldname", text, TextField.TYPE_STORED));
iwriter.addDocument(doc);
iwriter.close();
 
// Now search the index:
DirectoryReader ireader = DirectoryReader.open(directory);
IndexSearcher isearcher = new IndexSearcher(ireader);
// Parse a simple query that searches for "text":
QueryParser parser = new QueryParser(Version.LUCENE_CURRENT, "fieldname", analyzer);
Query query = parser.parse("text");
ScoreDoc[] hits = isearcher.search(query, null, 1000).scoreDocs;
    assertEquals(1, hits.length);
// Iterate through the results:
for (int i = 0; i < hits.length; i++) {
    Document hitDoc = isearcher.doc(hits[i].doc);
    assertEquals("This is the text to be indexed.", hitDoc.get("fieldname"));
}
ireader.close();
directory.close();
```
## 下面来给大家简单介绍一下 Lucene 的 API。

Lucene API 可以分为几个部分：

org.apache.lucene.analysis 定义了抽象的 Analyzer API 来实现文本从一个 text 文本流到 Token 流的转换。 
Token 流是有由 Tokenizer（语汇分解器）的输出结果和 TokenFilters（语汇过滤器）组合而成。
Tokenizer 和 TokenFilters 组合起来在一个 Analyzer 里面使用。
analyzers-common 组件提供了一系列的 Analyzer 实现。
包括 StopAnalyzer（停词分析器） 和 grammar-based StandardAnalyzer（基础语法分析器）。

* org.apache.lucene.codecs 提供了倒排索引的编码和解码的抽象方法。在程序中可以根据自己的需要来选择不同的倒排索引实现。

* org.apache.lucene.document 提供了一个简单的文档类。一个文档里面包括一系列的元数据，这些数据的值，可以是字符串或者 Reader 实例。

* org.apache.lucene.index 提供了两个高级的类：IndexWriter 和 IndexReader。IndexWriter 用来在索引里面添加或者创建 document。
  IndexReader 用来在索引里面读取数据。

* org.apache.lucene.search 提供把查询用数据结构的形式表示（例如：TermQuery 表示分解后的单词，BooleanQuery 表示 boolean。）。
  IndexSearcher 把查询转成 TopDocs。该组件中提供了一些 QueryParsers 来吧字符串或者 xml 生成查询结构。

* org.apache.lucene.store 定义了持久化数据的抽象类。Directory 是包含一些索引文件。已经有了几个不同的实现了，包括 FSDirectory、
  RAMDirectory等。FSDirectory用来把文件保存在文件系统。RAMDirectory 用来包数据保存在内存里面。

* org.apache.lucene.util 包含了一些数据处理工具等。

## 用户使用 Lucene 几个步骤：

* 1、通过添加 Fields 来创建 document。

* 2、创建 IndexWriter，并且把 documents 通过 addDocument() 添加到 IndexWriter 中。

* 3、调用 QueryParser.parse() 命令来查询字符串转化成查询。

* 4、创建 IndexSearcher 并且把 query 传到它的 search() 方法。


[教程](http://www.yiibai.com/lucene/)
