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
