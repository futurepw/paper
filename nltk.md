# NLTK
```
# -*-coding:utf-8-*-

from __future__ import division
from nltk.book import *

"""
    搜索文本
"""
# print text1
# print text1.concordance('monstrous')  # 查找有这个单词的句子，并显示出来
# print '------------------------------'
# print text1.similar('monstrous')  # 还有那些词出现在相似的上下文中
# print text2.similar('monstrous')
# print '------------------------------'
# print text2.common_contexts(['monstrous', 'very'])  # 共同的上下文
# print '------------------------------'
# print text4.dispersion_plot(['citizens', 'freedom', 'duties', 'America'])  # 用图像将文本中单词出现的位置标记出来
# print '------------------------------'


"""
    计数词汇
"""
# print len(text3)  # 输出text3中的文本中字符个数
# print sorted(set(text2))  # 输出文本中排序后的结果，并进行去重处理
# print len(set(text2))
# print '-------------------------'

# from __future__ import division  # 每个词被使用的次数
# print len(text2)/len(set(text2))
# print text2.count('the')  # 统计一个词在文本中出现的次数
# print 100*text2.count('the')/len(text2)  # 计算一个词在文本中占据的百分比

# 使用函数
# def lexical_diversity(text):
#     return len(text)/len(set(text))
# def percentage(count, total):
#     return 100*count/total
#
# print lexical_diversity(text6)
# print lexical_diversity(text9)

"""
    链表（list）
    连接 +
    追加 appand()
    索引 text[10]
    切片 text[10:100]
    排序 sorted()
    去重 set()
"""
"""
    频率分布：FreqDist()来寻找频率
        找到一本书使用最频繁的50个词
"""
# fdist = FreqDist(text9)
# print fdist  # 总的词数有69213个
# voc = fdist.keys()
# print voc[:50]
# # print fdist.plot(50, cumulative=True)  # 将文本中出现词数最多的前50个根据频率用图表示出来
# print fdist.hapaxes()  # 只出现了一次的词

"""
    细粒度选择词：
        选择长度大于15的词
"""
# v = set(text2)
# long_words = [w for w in v if len(w) > 15]
# print sorted(long_words)

"""
    词语搭配和双连词
"""
print text4.collocations()
print text8.collocations()

"""
    计数的其他东西：
        fdist = FreqDist(samples)   创建包含给定样本的频率分布
        fdist.inc(sample)           增加样本
        fdist['monstrous']          计数给定样本出现的次数
        fdist.freq('monstrous')     给定样本的频率
        fdist.N()                   样本总数
        fdist.keys()                以频率递减顺序排序的样本链表
        for sample in fdist:        以频率递减的顺序遍历样本
        fdist.max()                 数值最大的样本
        fdist.tabulate()            绘制频率分布表
        fdist.plot()                绘制频率分布图
        fdist.plot(cumulative=True) 绘制累积频率分布图
        fdist1<fdist2               测试样本在fdist1中出现的频率是否小于fdist2
"""
"""
    s.startswith(t)  测试 s是否以t开头
    s.endswith(t)    测试 s是否以t结尾
    t in s           测试 s是否包含t
    s.islower()      测试 s中所有字符是否都是小写字母
    s.isupper()      测试 s中所有字符是否都是大写字母
    s.isalpha()      测试 s中所有字符是否都是字母
    s.isalnum()      测试 s中所有字符是否都是字母或数字
    s.isdigit()      测试 s中所有字符是否都是数字
    s.istitle()      测试 s是否首字母大写（ s中所有的词都首字母大写
"""

"""
    思考：既然NLTK这么有用，那么对于中文的处理又该如何处理呢？？

    方法：
        1、使用中文分词器（jieba）
        2、对中文字符做编码处理，使用unicode编码方式
        3、python的源码统一声明为gbk
        4、使用支持中文的语料库
"""

"""
     原始数据，用于建立模型
"""
# 缩水版的courses，实际数据的格式应该为 课程名\t课程简介\t课程详情，并已去除html等干扰因素
courses = [
    u'Writing II: Rhetorical Composing',
    u'Genetics and Society: A Course for Educators',
    u'General Game Playing',
    u'Genes and the Human Condition (From Behavior to Biotechnology)',
    u'A Brief History of Humankind',
    u'New Models of Business in Society',
    u'Analyse Numrique pour Ingnieurs',
    u'Evolution: A Course for Educators',
    u'Coding the Matrix: Linear Algebra through Computer Science Applications',
    u'The Dynamic Earth: A Course for Educators',
    u'Tiny Wings\tYou have always dreamed of flying - but your wings are tiny. Luckily the world is full of beautiful hills. Use the hills as jumps - slide down, flap your wings and fly! At least for a moment - until this annoying gravity brings you back down to earth. But the next hill is waiting for you already. Watch out for the night and fly as fast as you can. ',
    u'Angry Birds Free',
    u'没有\它很相似',
    u'没有\t它很相似',
    u'没有\t他很相似',
    u'没有\t他不很相似',
    u'没有',
    u'可以没有',
    u'也没有',
    u'有没有也不管',
    u'Angry Birds Stella',
    u'Flappy Wings - FREE\tFly into freedom!A parody of the #1 smash hit game!',
    u'没有一个',
    u'没有一个2',
]

# 只是为了最后的查看方便
# 实际的 courses_name = [course.split('\t')[0] for course in courses]
courses_name = courses

"""
    预处理(easy_install nltk)
"""


def pre_process_cn(courses, low_freq_filter=True):
    """
     简化的 中文+英文 预处理
        1.去掉停用词
        2.去掉标点符号
        3.处理为词干
        4.去掉低频词

    """
    import nltk
    import jieba.analyse  # jieba分词
    from nltk.tokenize import word_tokenize  # 分词器

    texts_tokenized = []
    for document in courses:
        texts_tokenized_tmp = []
        for word in word_tokenize(document):
            texts_tokenized_tmp += jieba.analyse.extract_tags(word, 10)
        texts_tokenized.append(texts_tokenized_tmp)

    texts_filtered_stopwords = texts_tokenized

    # 去除标点符号，这里可以使用去除停等词的方式来处理
    english_punctuations = [',', '.', ':', ';', '?', '(', ')', '[', ']', '&', '!', '*', '@', '#', '$', '%']
    texts_filtered = [[word for word in document if not word in english_punctuations] for document in
                      texts_filtered_stopwords]

    # 词干化
    from nltk.stem.lancaster import LancasterStemmer
    st = LancasterStemmer()
    texts_stemmed = [[st.stem(word) for word in docment] for docment in texts_filtered]

    # 去除过低频词
    if low_freq_filter:
        all_stems = sum(texts_stemmed, [])
        stems_once = set(stem for stem in set(all_stems) if all_stems.count(stem) == 1)
        texts = [[stem for stem in text if stem not in stems_once] for text in texts_stemmed]
    else:
        texts = texts_stemmed
    return texts


lib_texts = pre_process_cn(courses)

"""
    引入gensim，正式开始处理(easy_install gensim)
"""


def train_by_lsi(lib_texts):
    """
        通过LSI模型的训练
    """
    from gensim import corpora, models, similarities

    # 为了能看到过程日志
    # import logging
    # logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)

    dictionary = corpora.Dictionary(lib_texts)
    corpus = [dictionary.doc2bow(text) for text in
              lib_texts]  # doc2bow(): 将collection words 转为词袋，用两元组(word_id, word_frequency)表示
    tfidf = models.TfidfModel(corpus)
    corpus_tfidf = tfidf[corpus]

    # 拍脑袋的：训练topic数量为10的LSI模型
    lsi = models.LsiModel(corpus_tfidf, id2word=dictionary, num_topics=10)
    index = similarities.MatrixSimilarity(lsi[corpus])  # index 是 gensim.similarities.docsim.MatrixSimilarity 实例

    return (index, dictionary, lsi)


# 库建立完成 -- 这部分可能数据很大，可以预先处理好，存储起来
(index, dictionary, lsi) = train_by_lsi(lib_texts)

# 要处理的对象登场
target_courses = [u'没有']
target_text = pre_process_cn(target_courses, low_freq_filter=False)

"""
对具体对象相似度匹配
"""

# 选择一个基准数据
ml_course = target_text[0]

# 词袋处理
ml_bow = dictionary.doc2bow(ml_course)

# 在上面选择的模型数据 lsi 中，计算其他数据与其的相似度
ml_lsi = lsi[ml_bow]  # ml_lsi 形式如 (topic_id, topic_value)
sims = index[ml_lsi]  # sims 是最终结果了， index[xxx] 调用内置方法 __getitem__() 来计算ml_lsi

# 排序，为输出方便
sort_sims = sorted(enumerate(sims), key=lambda item: -item[1])

# 查看结果
print sort_sims[0:10]  # 看下前10个最相似的，第一个是基准数据自身
print courses_name[sort_sims[1][0]]  # 看下实际最相似的数据叫什么
print courses_name[sort_sims[2][0]]  # 看下实际最相似的数据叫什么
print courses_name[sort_sims[3][0]]  # 看下实际最相似的数据叫什么
```
