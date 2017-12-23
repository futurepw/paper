
    <div class="article_title">   
         <span class="ico ico_type_Original"></span>

    <h1>
        <span class="link_title"><a href="/rockingdingo/article/details/55806734">
        基于Tensorflow的自然语言处理Restful API调用实例 www.deepnlp.org        
           
        </a>
        </span>

         
    </h1>
</div>

   

        <div class="article_manage clearfix">
        <div class="article_l">
            <span class="link_categories">
            标签：
              <a href="http://www.csdn.net/tag/tensorflow" target="_blank" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_tag']);">tensorflow</a><a href="http://www.csdn.net/tag/%e8%87%aa%e7%84%b6%e8%af%ad%e8%a8%80%e5%a4%84%e7%90%86" target="_blank" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_tag']);">自然语言处理</a><a href="http://www.csdn.net/tag/API" target="_blank" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_tag']);">API</a><a href="http://www.csdn.net/tag/%e8%af%8d%e6%80%a7%e6%a0%87%e6%b3%a8" target="_blank" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_tag']);">词性标注</a><a href="http://www.csdn.net/tag/%e5%ae%9e%e4%bd%93%e8%af%86%e5%88%ab" target="_blank" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_tag']);">实体识别</a>
            </span>
        </div>
        <div class="article_r">
            <span class="link_postdate">2017-02-19 19:06</span>
            <span class="link_view" title="阅读次数">1714人阅读</span>
            <span class="link_comments" title="评论次数"> <a href="#comments" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_pinglun'])">评论</a>(0)</span>
            <span class="link_collect tracking-ad" data-mod="popu_171"> <a href="javascript:void(0);" onclick="javascript:collectArticle('%e5%9f%ba%e4%ba%8eTensorflow%e7%9a%84%e8%87%aa%e7%84%b6%e8%af%ad%e8%a8%80%e5%a4%84%e7%90%86Restful+API%e8%b0%83%e7%94%a8%e5%ae%9e%e4%be%8b+www.deepnlp.org','55806734');return false;" title="收藏" target="_blank">收藏</a></span>
             <span class="link_report"> <a href="#report" onclick="javascript:report(55806734,2);return false;" title="举报">举报</a></span>

        </div>
    </div>    <style type="text/css">        
            .embody{
                padding:10px 10px 10px;
                margin:0 -20px;
                border-bottom:solid 1px #ededed;                
            }
            .embody_b{
                margin:0 ;
                padding:10px 0;
            }
            .embody .embody_t,.embody .embody_c{
                display: inline-block;
                margin-right:10px;
            }
            .embody_t{
                font-size: 12px;
                color:#999;
            }
            .embody_c{
                font-size: 12px;
            }
            .embody_c img,.embody_c em{
                display: inline-block;
                vertical-align: middle;               
            }
             .embody_c img{               
                width:30px;
                height:30px;
            }
            .embody_c em{
                margin: 0 20px 0 10px;
                color:#333;
                font-style: normal;
            }
    </style>
    <script type="text/javascript">
        $(function () {
            try
            {
                var lib = eval("("+$("#lib").attr("value")+")");
                var html = "";
                if (lib.err == 0) {
                    $.each(lib.data, function (i) {
                        var obj = lib.data[i];
                        //html += '<img src="' + obj.logo + '"/>' + obj.name + "&nbsp;&nbsp;";
                        html += ' <a href="' + obj.url + '" target="_blank">';
                        html += ' <img src="' + obj.logo + '">';
                        html += ' <em><b>' + obj.name + '</b></em>';
                        html += ' </a>';
                    });
                    if (html != "") {
                        setTimeout(function () {
                            $("#lib").html(html);                      
                            $("#embody").show();
                        }, 100);
                    }
                }      
            } catch (err)
            { }
            
        });
    </script>
      <div class="category clearfix">
        <div class="category_l">
           <img src="http://static.blog.csdn.net/images/category_icon.jpg">
            <span>分类：</span>
        </div>
        <div class="category_r">
                    <label onclick="GetCategoryArticles('6729879','rockingdingo','top','55806734');">
                        <span onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_fenlei']);">tensorflow<em>（3）</em></span>
                      <img class="arrow-down" src="http://static.blog.csdn.net/images/arrow_triangle _down.jpg" style="display:inline;">
                      <img class="arrow-up" src="http://static.blog.csdn.net/images/arrow_triangle_up.jpg" style="display:none;">
                        <div class="subItem">
                            <div class="subItem_t"><a href="http://blog.csdn.net/rockingdingo/article/category/6729879" target="_blank">作者同类文章</a><i class="J_close">X</i></div>
                            <ul class="subItem_l" id="top_6729879">                            
                            </ul>
                        </div>
                    </label>                    
        </div>
    </div>
        <div class="bog_copyright">         
            <p class="copyright_p">版权声明：本文为博主原创文章，未经博主允许不得转载。</p>
        </div>

  

  
  
     


<div style="clear:both"></div><div style="border:solid 1px #ccc; background:#eee; float:left; min-width:200px;padding:4px 10px;"><p style="text-align:right;margin:0;"><span style="float:left;">目录<a href="#" title="系统根据文章中H1到H6标签自动生成文章目录">(?)</a></span><a href="#" onclick="javascript:return openct(this);" title="展开">[+]</a></p><ol style="display:none;margin-left:14px;padding-left:14px;line-height:160%;"><li><a href="#t0">
简介</a></li><li><a href="#t1">
API参数</a></li><li><a href="#t2">
API接口</a></li><li><a href="#t3">
浏览器中测试API</a></li><li><a href="#t4">
Python中调用API</a></li><ol><li><a href="#t5">
词法模块</a></li><li><a href="#t6">
代码1 创建API的Login</a></li><li><a href="#t7">
代码2 新建API的连接</a></li><li><a href="#t8">
代码3-1</a></li><li><a href="#t9">
代码3-2</a></li><li><a href="#t10">
关于编码</a></li></ol><li><a href="#t11">
附录</a></li><ol><li><a href="#t12">
1POS词性标注标记集</a></li><li><a href="#t13">
2NER命名实体识别标记集</a></li></ol><li><a href="#t14">
拓展阅读</a></li></ol></div><div style="clear:both"></div><div id="article_content" class="article_content tracking-ad" data-mod="popu_307" data-dsm="post">

<p align="left"><img src="http://www.deepnlp.org/static/blog/img/GitHub-Mark.png" alt="" style="margin:0px; padding:0px; font-family:Arial,sans-serif; font-size:14px" width="30" height="30"><span style="font-family:Arial,sans-serif; font-size:14px">&nbsp;</span><a target="_blank" href="https://github.com/rockingdingo/deepnlp" style="margin:0px; padding:0px; color:rgb(51,51,51); text-decoration:none; font-family:Arial,sans-serif; font-size:14px">Github下载完整代码</a><a target="_blank" href="https://github.com/rockingdingo/deepnlp"><span style="color:rgb(51,51,51)"></span></a></p>
<p align="left"><a target="_blank" href="https://github.com/rockingdingo/deepnlp">https://github.com/rockingdingo/deepnlp</a><br>
</p>
<p align="left"><br>
</p>
<p align="left"></p>
<h3 style="margin:10px 0px; padding:3px; color:rgb(194,33,13); font-size:18px; font-family:微软雅黑,Arial; clear:both"><a name="t0" target="_blank"></a>
简介</h3>
<p></p>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
www.deepnlp.org提供了免费的基于python和tensorflow深度神经网络模型开发的自然语言处理的服务，提供的REST风格的API不仅包括了NLP任务的基础模块，如分词(segment)，词性标注(pos)，命名实体识别(ner)，句法分析(parsing)等，还提供了更多基于深度语言模型，词向量word embedding，LSTM, Seq2Seq等模型的在线API。此外还提供了多个文章段落应用，如textcnn文本分类，textsum 生成式文本总结和标题生成, textrank 抽取式自动摘要等。我们会在API
 v1.0版本之后继续拓展更多的基于深度语言的模型，也欢迎更多的Contributors来使用。做这个项目的出发点是开源和免费提供一项基于深度学习的NLP服务，我们的API完全开源，但因受限于我们的资源，目前对使用频率有一定限制。</p>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
本着极简的设计原则原则，我们提供了最简单的接口接受固定参数，并以文本格式返回结果。</p>
<h3 style="margin:10px 0px; padding:3px; color:rgb(194,33,13); font-size:18px; font-family:微软雅黑,Arial; clear:both"><a name="t1" target="_blank"></a>
API参数</h3>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
通过网络浏览器可以直接访问www.deepnlp.org的web API (需要验证登录)，同时也可以通过编程环境程序化调用。</p>
<table class="table  " style="margin:10px auto; padding:0px; table-layout:fixed; empty-cells:show; border-collapse:collapse; border:1px solid rgb(202,217,234); color:rgb(102,102,102); font-family:Arial,sans-serif">
<tbody style="margin:0px; padding:0px">
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
参数</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
含义</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
说明</th>
</tr>
<tr style="margin:0px; padding:0px">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
lang</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
语言代码，包括：zh(中文)和en(英文)</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
lang=zh</th>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
text</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
分析文本</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
text=今天天气不错</th>
</tr>
<tr style="margin:0px; padding:0px">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
annotators</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
定义pipeline API中需要调用的模块，用逗号分隔，包括：segment(分词), pos(词性标注)和ner(命名实体识别)</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
annotators=segment,pos,ner</th>
</tr>
</tbody>
</table>
<h3 style="margin:10px 0px; padding:3px; color:rgb(194,33,13); font-size:18px; font-family:微软雅黑,Arial; clear:both"><a name="t2" target="_blank"></a>
API接口</h3>
<table class="table  " style="margin:10px auto; padding:0px; table-layout:fixed; empty-cells:show; border-collapse:collapse; border:1px solid rgb(202,217,234); color:rgb(102,102,102); font-family:Arial,sans-serif">
<tbody style="margin:0px; padding:0px">
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
模块</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
URL</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
返回结果</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
说明</th>
</tr>
<tr style="margin:0px; padding:0px">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
分词segment</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
www.deepnlp.org/api/v1.0/segment/?lang=zh&amp;text=我爱吃北京烤鸭</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"words": ["我","爱","吃","北京","烤鸭"]}</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"words": list}</th>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
词性标注pos</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
www.deepnlp.org/api/v1.0/pos/?lang=zh&amp;text=我爱吃北京烤鸭</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"pos_str": "我/r 爱/v 吃/v 北京/ns 烤鸭/n"}</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"pos_str": string}</th>
</tr>
<tr style="margin:0px; padding:0px">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
命名实体ner</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
www.deepnlp.org/api/v1.0/ner/?lang=zh&amp;text=我爱吃北京烤鸭</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"ner_json": {"nbz": "","p": "北京","o": "","n": ""}, "ner_str": "我/nt 爱/nt 吃/nt 北京/p 烤鸭/nt"}</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"ner_json": json, ner_str": string} json 包含了nbz品牌,n 人名,o 组织,p 地点;</th>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
模块整合pipeline</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
www.deepnlp.org/api/v1.0/pipeline/?lang=zh&amp;annotators=segment,pos,ner&amp;text=我爱吃北京烤鸭</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"ner_json": {"nbz": "","p": "北京","o": "","n": ""}, "ner_str": "我/nt 爱/nt 吃/nt 北京/p 烤鸭/nt", "segment_str": "我 爱 吃 北京 烤鸭", "pos_str": "我/r 爱/v 吃/v 北京/ns 烤鸭/n"}</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"segment_str": string, "pos_str":string, "ner_str":string, "ner_json":json}</th>
</tr>
<tr style="margin:0px; padding:0px">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
文本摘要textrank</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
www.deepnlp.org/api/v1.0/textrank/?percent=0.2&amp;text=待分析的文章段落</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
{"top": [ [id1, "句子1", [0.0833] ], [id2, "句子2", [0.0812]]]}</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
percent为压缩比, 如抽取原文数量的0.25的句子作为文章摘要。{"top": [[id, "句子1", [score] ], …} id为该句子在原段落中的序号，从0开始。</th>
</tr>
</tbody>
</table>
<br>
<p align="left"></p>
<h3 style="margin:10px 0px; padding:3px; color:rgb(194,33,13); font-size:18px; font-family:微软雅黑,Arial; clear:both"><a name="t3" target="_blank"></a>
浏览器中测试API</h3>
<ul style="margin:0px; padding:0px; font-family:Arial,sans-serif; font-size:14px">
<li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org/api/v1.0/segment/?lang=zh&amp;text=%E6%88%91%E7%88%B1%E5%90%83%E5%8C%97%E4%BA%AC%E7%83%A4%E9%B8%AD" style="margin:0px; padding:0px; color:rgb(51,51,51); text-decoration:none">http://www.deepnlp.org/api/v1.0/segment/?lang=zh&amp;text=我爱吃北京烤鸭</a></li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org/api/v1.0/pos/?lang=zh&amp;text=%E6%88%91%E7%88%B1%E5%90%83%E5%8C%97%E4%BA%AC%E7%83%A4%E9%B8%AD" style="margin:0px; padding:0px; color:rgb(51,51,51); text-decoration:none">http://www.deepnlp.org/api/v1.0/pos/?lang=zh&amp;text=我爱吃北京烤鸭</a></li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org/api/v1.0/ner/?lang=zh&amp;text=%E6%88%91%E7%88%B1%E5%90%83%E5%8C%97%E4%BA%AC%E7%83%A4%E9%B8%AD" style="margin:0px; padding:0px; color:rgb(51,51,51); text-decoration:none">http://www.deepnlp.org/api/v1.0/ner/?lang=zh&amp;text=我爱吃北京烤鸭</a></li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org/api/v1.0/pipeline/?lang=zh&amp;annotators=segment,pos,ner&amp;text=%E6%88%91%E7%88%B1%E5%90%83%E5%8C%97%E4%BA%AC%E7%83%A4%E9%B8%AD" style="margin:0px; padding:0px; color:rgb(51,51,51); text-decoration:none">http://www.deepnlp.org/api/v1.0/pipeline/?lang=zh&amp;annotators=segment,pos,ner&amp;text=我爱吃北京烤鸭</a></li></ul>
<center style="margin:0px; padding:0px; font-family:Arial,sans-serif; font-size:14px">
<img src="http://www.deepnlp.org/static/blog/img/1/api_browser_demo.png" alt="" style="margin:0px; padding:0px" width="900" height="345"></center>
<br>
<p></p>
<p align="left"><span style="font-family:Arial,sans-serif; font-size:14px">图1 浏览器调用API结果</span><br>
</p>
<p align="left"><span style="font-family:Arial,sans-serif; font-size:14px"></span></p>
<h3 style="text-align:left; margin:10px 0px; padding:3px; color:rgb(194,33,13); font-size:18px; font-family:微软雅黑,Arial; clear:both"><a name="t4" target="_blank"></a>
Python中调用API</h3>
<p></p>
<p style="text-align:left" align="left"><span style="font-family:Arial,sans-serif; font-size:14px"></span></p>
<h4 style="text-align:left; margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t5" target="_blank"></a>
词法模块</h4>
<p></p>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
下面我们以一段网剧《老九门》的剧情简介为例，看看如何在python环境中程序化调用deepnlp.org的web API。待分析的文本：</p>
<div class="dp-highlighter bg_python"><div class="bar"><div class="tools"><b>[python]</b> <a href="#" class="ViewSource" title="view plain" onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" target="_blank">view plain</a><span data-mod="popu_168"> <a href="#" class="CopyToClipboard" title="copy" onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" target="_blank">copy</a><div style="position: absolute; left: 598px; top: 2675px; width: 18px; height: 18px; z-index: 99;"><embed id="ZeroClipboardMovie_1" src="http://static.blog.csdn.net/scripts/ZeroClipboard/ZeroClipboard.swf" loop="false" menu="false" quality="best" bgcolor="#ffffff" name="ZeroClipboardMovie_1" allowscriptaccess="always" allowfullscreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=1&amp;width=18&amp;height=18" wmode="transparent" align="middle" width="18" height="18"></div></span><span data-mod="popu_169"> <a href="#" class="PrintSource" title="print" onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" target="_blank">print</a></span><a href="#" class="About" title="?" onclick="dp.sh.Toolbar.Command('About',this);return false;" target="_blank">?</a></div></div><ol start="1" class="dp-py"><li class="alt"><span><span>text&nbsp;=&nbsp;”张启山在轨道边来回踱步，听着站长和守夜人描述昨晚火车进站时的情况。张启山身后站着一位年轻的副官，他正指挥士兵们爬上火车进行切割，很快，一节车厢的铁皮被割出了一个洞。”&nbsp;&nbsp;</span></span></li></ol></div><pre name="code" class="python" style="display: none;">text = ”张启山在轨道边来回踱步，听着站长和守夜人描述昨晚火车进站时的情况。张启山身后站着一位年轻的副官，他正指挥士兵们爬上火车进行切割，很快，一节车厢的铁皮被割出了一个洞。”
</pre><br>
<br>
<p style="text-align:left" align="left"><span style="font-family:Arial,sans-serif; font-size:14px"><span style="color:rgb(51,51,51); font-family:'microsoft yahei',arial; font-size:16px; line-height:27.2px; text-align:justify; text-indent:32px">我们首先引入必要的两个包requests和urllib,
 支持python下的URL访问。其次，使用API需要预先保存网站登录的信息，通过用户验证，浏览器已经保存了你登录的cookie信息了。我们可以通过deepnlp package下的api_service新建一个connection的类。使用到的用户名密码通过api_service.init() 函数免费注册，也可以不注册使用pypi默认的一个账户，但是访问频率会受到最大次数限制100次/天。</span><br>
</span></p>
<p style="text-align:left" align="left"><span style="font-family:Arial,sans-serif; font-size:14px"><span style="color:rgb(51,51,51); font-family:'microsoft yahei',arial; font-size:16px; line-height:27.2px; text-align:justify; text-indent:32px"></span></span></p>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t6" target="_blank"></a>
代码1 创建API的Login</h4>
<div><div class="dp-highlighter bg_python"><div class="bar"><div class="tools"><b>[python]</b> <a href="#" class="ViewSource" title="view plain" onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" target="_blank">view plain</a><span data-mod="popu_168"> <a href="#" class="CopyToClipboard" title="copy" onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" target="_blank">copy</a><div style="position: absolute; left: 598px; top: 3004px; width: 18px; height: 18px; z-index: 99;"><embed id="ZeroClipboardMovie_2" src="http://static.blog.csdn.net/scripts/ZeroClipboard/ZeroClipboard.swf" loop="false" menu="false" quality="best" bgcolor="#ffffff" name="ZeroClipboardMovie_2" allowscriptaccess="always" allowfullscreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=2&amp;width=18&amp;height=18" wmode="transparent" align="middle" width="18" height="18"></div></span><span data-mod="popu_169"> <a href="#" class="PrintSource" title="print" onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" target="_blank">print</a></span><a href="#" class="About" title="?" onclick="dp.sh.Toolbar.Command('About',this);return false;" target="_blank">?</a></div></div><ol start="1" class="dp-py"><li class="alt"><span><span class="keyword">import</span><span>&nbsp;deepnlp&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">from</span><span>&nbsp;deepnlp&nbsp;</span><span class="keyword">import</span><span>&nbsp;api_service&nbsp;&nbsp;</span></span></li><li class="alt"><span>login&nbsp;=&nbsp;api_service.init()&nbsp;&nbsp;<span class="comment">#&nbsp;registration,&nbsp;if&nbsp;failed,&nbsp;load&nbsp;default&nbsp;login&nbsp;with&nbsp;limited&nbsp;access</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>username&nbsp;=&nbsp;login[<span class="string">'username'</span><span>]&nbsp;&nbsp;</span></span></li><li class="alt"><span>password&nbsp;=&nbsp;login[<span class="string">'password'</span><span>]&nbsp;&nbsp;</span></span></li></ol></div><pre name="code" class="python" style="display: none;">import deepnlp
from deepnlp import api_service
login = api_service.init()  # registration, if failed, load default login with limited access
username = login['username']
password = login['password']
</pre><br>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t7" target="_blank"></a>
代码2 新建API的连接</h4>
</div>
<div><div class="dp-highlighter bg_python"><div class="bar"><div class="tools"><b>[python]</b> <a href="#" class="ViewSource" title="view plain" onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" target="_blank">view plain</a><span data-mod="popu_168"> <a href="#" class="CopyToClipboard" title="copy" onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" target="_blank">copy</a><div style="position: absolute; left: 598px; top: 3243px; width: 18px; height: 18px; z-index: 99;"><embed id="ZeroClipboardMovie_3" src="http://static.blog.csdn.net/scripts/ZeroClipboard/ZeroClipboard.swf" loop="false" menu="false" quality="best" bgcolor="#ffffff" name="ZeroClipboardMovie_3" allowscriptaccess="always" allowfullscreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=3&amp;width=18&amp;height=18" wmode="transparent" align="middle" width="18" height="18"></div></span><span data-mod="popu_169"> <a href="#" class="PrintSource" title="print" onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" target="_blank">print</a></span><a href="#" class="About" title="?" onclick="dp.sh.Toolbar.Command('About',this);return false;" target="_blank">?</a></div></div><ol start="1" class="dp-py"><li class="alt"><span><span class="comment">#coding:utf-8</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">from</span><span>&nbsp;__future__&nbsp;</span><span class="keyword">import</span><span>&nbsp;unicode_literals&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">import</span><span>&nbsp;json&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">import</span><span>&nbsp;requests&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">import</span><span>&nbsp;sys,&nbsp;os&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">if</span><span>&nbsp;(sys.version_info&gt;(</span><span class="number">3</span><span>,</span><span class="number">0</span><span>)):&nbsp;</span><span class="keyword">from</span><span>&nbsp;urllib.parse&nbsp;</span><span class="keyword">import</span><span>&nbsp;quote&nbsp;&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">else</span><span>&nbsp;:&nbsp;</span><span class="keyword">from</span><span>&nbsp;urllib&nbsp;</span><span class="keyword">import</span><span>&nbsp;quote&nbsp;&nbsp;</span></span></li><li class=""><span>&nbsp;&nbsp;&nbsp;</span></li><li class="alt"><span><span class="keyword">from</span><span>&nbsp;deepnlp&nbsp;</span><span class="keyword">import</span><span>&nbsp;api_service&nbsp;&nbsp;</span></span></li><li class=""><span><span class="comment">#&nbsp;use&nbsp;your&nbsp;personal&nbsp;login:&nbsp;</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="comment">#&nbsp;login&nbsp;=&nbsp;{'username':&nbsp;'your_user_name'&nbsp;,&nbsp;'password':&nbsp;'your_password'}</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>login&nbsp;=&nbsp;{}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="comment">#&nbsp;load&nbsp;default&nbsp;login&nbsp;for&nbsp;pypi&nbsp;with&nbsp;limited&nbsp;access</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>conn&nbsp;=&nbsp;api_service.connect(login)&nbsp;&nbsp;&nbsp;<span class="comment">#&nbsp;save&nbsp;the&nbsp;connection&nbsp;with&nbsp;login&nbsp;cookies</span><span>&nbsp;&nbsp;</span></span></li></ol></div><pre name="code" class="python" style="display: none;">#coding:utf-8
from __future__ import unicode_literals
import json
import requests
import sys, os
if (sys.version_info&gt;(3,0)): from urllib.parse import quote 
else : from urllib import quote
 
from deepnlp import api_service
# use your personal login: 
# login = {'username': 'your_user_name' , 'password': 'your_password'}
login = {}                          # load default login for pypi with limited access
conn = api_service.connect(login)   # save the connection with login cookies</pre><br>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
我们想要得到这段《老九门》剧情文本的分词Segment和词性标注POS的信息，那么我们可以分别调用两个模块的API，也可以只调用一个pipeline的API，然后通过annotators 来控制需要返回哪几个模块的结果。</p>
<ul style="margin:0px; padding:0px; font-family:Arial,sans-serif; font-size:14px">
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:16px; font-family:'microsoft yahei',arial; text-align:justify">
定义完整URL，传入待分析文本的信息 通过浏览器访问时的API为: http://www.deepnlp.org/api/v1.0/pipeline/?lang=zh&amp;annotators=segment,pos&amp;text=文本 观察后发现完整URL由以下部分构成:</p>
<li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
1.base_url: 即为网站域名www.deepnlp.org；</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
2.模块的API：即"/api/v1.0/segment/?"这一部分，问号后带传递的参数；</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
3.输入的参数：需要通过urllib包的quote()函数，将中英文字符串转码传递给URL，类似于浏览器中的对应部分；</li></ul>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
通过request包的get方法来访问之前定义的URL，同时传递的参数有保留的cookie信息conn。利用json包把返回的结果转化为字典表，例如通过tuples['words']就能访问到对应的分词，结果保存在一个空格分隔的字符串内。</p>
<br>
</div>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t8" target="_blank"></a>
代码3-1</h4>
<p></p>
<p style="text-align:left" align="left"><span style="font-family:Arial,sans-serif; font-size:14px"><span style="color:rgb(51,51,51); font-family:'microsoft yahei',arial; font-size:16px; line-height:27.2px; text-align:justify; text-indent:32px"></span></span></p>
<div class="dp-highlighter bg_python"><div class="bar"><div class="tools"><b>[python]</b> <a href="#" class="ViewSource" title="view plain" onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" target="_blank">view plain</a><span data-mod="popu_168"> <a href="#" class="CopyToClipboard" title="copy" onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" target="_blank">copy</a><div style="position: absolute; left: 598px; top: 3975px; width: 18px; height: 18px; z-index: 99;"><embed id="ZeroClipboardMovie_4" src="http://static.blog.csdn.net/scripts/ZeroClipboard/ZeroClipboard.swf" loop="false" menu="false" quality="best" bgcolor="#ffffff" name="ZeroClipboardMovie_4" allowscriptaccess="always" allowfullscreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=4&amp;width=18&amp;height=18" wmode="transparent" align="middle" width="18" height="18"></div></span><span data-mod="popu_169"> <a href="#" class="PrintSource" title="print" onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" target="_blank">print</a></span><a href="#" class="About" title="?" onclick="dp.sh.Toolbar.Command('About',this);return false;" target="_blank">?</a></div></div><ol start="1" class="dp-py"><li class="alt"><span><span>text&nbsp;=&nbsp;</span><span class="string">"张启山在轨道边来回踱步，听着站长和守夜人描述昨晚火车进站时的情况。张启山身后站着一位年轻的副官，他正指挥士兵们爬上火车进行切割，很快，一节车厢的铁皮被割出了一个洞。"</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>text&nbsp;=&nbsp;text.encode(<span class="string">"utf-8"</span><span>)&nbsp;&nbsp;</span><span class="comment">#&nbsp;convert&nbsp;text&nbsp;from&nbsp;unicode&nbsp;to&nbsp;utf-8&nbsp;bytes</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>&nbsp;&nbsp;&nbsp;</span></li><li class=""><span><span class="comment">#&nbsp;API&nbsp;Setting</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>base_url&nbsp;=&nbsp;<span class="string">'www.deepnlp.org'</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>lang&nbsp;=&nbsp;<span class="string">'zh'</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>&nbsp;&nbsp;&nbsp;</span></li><li class=""><span><span class="comment">#&nbsp;Segmentation</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>url_segment&nbsp;=&nbsp;base_url&nbsp;+&nbsp;<span class="string">"/api/v1.0/segment/?"</span><span>&nbsp;+&nbsp;</span><span class="string">"lang="</span><span>&nbsp;+&nbsp;quote(lang)&nbsp;+&nbsp;</span><span class="string">"&amp;text="</span><span>&nbsp;+&nbsp;quote(text)&nbsp;&nbsp;</span></span></li><li class=""><span>web&nbsp;=&nbsp;requests.get(url_segment,&nbsp;cookies&nbsp;=&nbsp;conn)&nbsp;&nbsp;</span></li><li class="alt"><span>tuples&nbsp;=&nbsp;json.loads(web.text)&nbsp;&nbsp;</span></li><li class=""><span>wordsList&nbsp;=&nbsp;tuples[<span class="string">'words'</span><span>]&nbsp;</span><span class="comment">#&nbsp;segmentation&nbsp;json&nbsp;{'words',&nbsp;[w1,&nbsp;w2,...]}&nbsp;return&nbsp;list</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">print</span><span>&nbsp;(</span><span class="string">"Segmentation&nbsp;API"</span><span>)&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">print</span><span>&nbsp;(</span><span class="string">"&nbsp;"</span><span>.join(wordsList))&nbsp;&nbsp;</span></span></li><li class="alt"><span>&nbsp;&nbsp;&nbsp;</span></li><li class=""><span><span class="comment">#&nbsp;POS&nbsp;tagging</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>url_pos&nbsp;=&nbsp;base_url&nbsp;+&nbsp;<span class="string">"/api/v1.0/pos/?"</span><span>+&nbsp;</span><span class="string">"lang="</span><span>&nbsp;+&nbsp;quote(lang)&nbsp;+&nbsp;</span><span class="string">"&amp;text="</span><span>&nbsp;+&nbsp;quote(text)&nbsp;&nbsp;</span></span></li><li class=""><span>web&nbsp;=&nbsp;requests.get(url_pos,&nbsp;cookies&nbsp;=&nbsp;conn)&nbsp;&nbsp;</span></li><li class="alt"><span>tuples&nbsp;=&nbsp;json.loads(web.text)&nbsp;&nbsp;</span></li><li class=""><span>pos_str&nbsp;=&nbsp;tuples[<span class="string">'pos_str'</span><span>]&nbsp;</span><span class="comment">#&nbsp;POS&nbsp;json&nbsp;{'pos_str',&nbsp;'w1/t1&nbsp;w2/t2'}&nbsp;return&nbsp;string</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">print</span><span>&nbsp;(</span><span class="string">"POS&nbsp;API"</span><span>)&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">print</span><span>&nbsp;(pos_str)&nbsp;&nbsp;</span></span></li></ol></div><pre name="code" class="python" style="display: none;">text = "张启山在轨道边来回踱步，听着站长和守夜人描述昨晚火车进站时的情况。张启山身后站着一位年轻的副官，他正指挥士兵们爬上火车进行切割，很快，一节车厢的铁皮被割出了一个洞。"
text = text.encode("utf-8")  # convert text from unicode to utf-8 bytes
 
# API Setting
base_url = 'www.deepnlp.org'
lang = 'zh'
 
# Segmentation
url_segment = base_url + "/api/v1.0/segment/?" + "lang=" + quote(lang) + "&amp;text=" + quote(text)
web = requests.get(url_segment, cookies = conn)
tuples = json.loads(web.text)
wordsList = tuples['words'] # segmentation json {'words', [w1, w2,...]} return list
print ("Segmentation API")
print (" ".join(wordsList))
 
# POS tagging
url_pos = base_url + "/api/v1.0/pos/?"+ "lang=" + quote(lang) + "&amp;text=" + quote(text)
web = requests.get(url_pos, cookies = conn)
tuples = json.loads(web.text)
pos_str = tuples['pos_str'] # POS json {'pos_str', 'w1/t1 w2/t2'} return string
print ("POS API")
print (pos_str)
</pre><br>
<p></p>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t9" target="_blank"></a>
代码3-2</h4>
<div class="dp-highlighter bg_python"><div class="bar"><div class="tools"><b>[python]</b> <a href="#" class="ViewSource" title="view plain" onclick="dp.sh.Toolbar.Command('ViewSource',this);return false;" target="_blank">view plain</a><span data-mod="popu_168"> <a href="#" class="CopyToClipboard" title="copy" onclick="dp.sh.Toolbar.Command('CopyToClipboard',this);return false;" target="_blank">copy</a><div style="position: absolute; left: 598px; top: 4538px; width: 18px; height: 18px; z-index: 99;"><embed id="ZeroClipboardMovie_5" src="http://static.blog.csdn.net/scripts/ZeroClipboard/ZeroClipboard.swf" loop="false" menu="false" quality="best" bgcolor="#ffffff" name="ZeroClipboardMovie_5" allowscriptaccess="always" allowfullscreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" flashvars="id=5&amp;width=18&amp;height=18" wmode="transparent" align="middle" width="18" height="18"></div></span><span data-mod="popu_169"> <a href="#" class="PrintSource" title="print" onclick="dp.sh.Toolbar.Command('PrintSource',this);return false;" target="_blank">print</a></span><a href="#" class="About" title="?" onclick="dp.sh.Toolbar.Command('About',this);return false;" target="_blank">?</a></div></div><ol start="1" class="dp-py"><li class="alt"><span><span>annotators&nbsp;=&nbsp;</span><span class="string">"segment,pos,ner"</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>url_pipeline&nbsp;=&nbsp;base_url&nbsp;+&nbsp;<span class="string">"/api/v1.0/pipeline/?"</span><span>&nbsp;+&nbsp;</span><span class="string">"lang="</span><span>&nbsp;+&nbsp;quote(lang)&nbsp;+&nbsp;</span><span class="string">"&amp;text="</span><span>&nbsp;+&nbsp;quote(text)&nbsp;+&nbsp;</span><span class="string">"&amp;annotators="</span><span>&nbsp;+&nbsp;quote(annotators)&nbsp;&nbsp;</span></span></li><li class="alt"><span>web&nbsp;=&nbsp;requests.get(url_pipeline,&nbsp;cookies&nbsp;=&nbsp;conn)&nbsp;&nbsp;</span></li><li class=""><span>tuples&nbsp;=&nbsp;json.loads(web.text)&nbsp;&nbsp;</span></li><li class="alt"><span>segment_str&nbsp;=&nbsp;tuples[<span class="string">'segment_str'</span><span>]&nbsp;&nbsp;</span><span class="comment">#&nbsp;segment&nbsp;module</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>pos_str&nbsp;=&nbsp;tuples[<span class="string">'pos_str'</span><span>]&nbsp;&nbsp;&nbsp;</span><span class="comment">#&nbsp;pos&nbsp;module</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span>ner_str&nbsp;=&nbsp;tuples[<span class="string">'ner_str'</span><span>]&nbsp;&nbsp;&nbsp;</span><span class="comment">#&nbsp;ner&nbsp;module</span><span>&nbsp;&nbsp;</span></span></li><li class=""><span>ner_json&nbsp;=&nbsp;tuples[<span class="string">'ner_json'</span><span>]&nbsp;</span><span class="comment">#&nbsp;ner&nbsp;result&nbsp;in&nbsp;json</span><span>&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">print</span><span>&nbsp;(</span><span class="string">"Pipeline&nbsp;API"</span><span>)&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">print</span><span>&nbsp;(segment_str)&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">print</span><span>&nbsp;(pos_str)&nbsp;&nbsp;</span></span></li><li class=""><span><span class="keyword">print</span><span>&nbsp;(ner_str)&nbsp;&nbsp;</span></span></li><li class="alt"><span><span class="keyword">print</span><span>&nbsp;(ner_json)&nbsp;&nbsp;</span></span></li></ol></div><pre name="code" class="python" style="display: none;">annotators = "segment,pos,ner"
url_pipeline = base_url + "/api/v1.0/pipeline/?" + "lang=" + quote(lang) + "&amp;text=" + quote(text) + "&amp;annotators=" + quote(annotators)
web = requests.get(url_pipeline, cookies = conn)
tuples = json.loads(web.text)
segment_str = tuples['segment_str']  # segment module
pos_str = tuples['pos_str']   # pos module
ner_str = tuples['ner_str']   # ner module
ner_json = tuples['ner_json'] # ner result in json
print ("Pipeline API")
print (segment_str)
print (pos_str)
print (ner_str)
print (ner_json)
</pre><br>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t10" target="_blank"></a>
关于编码</h4>
<p></p>
<p style="margin-top:10px; margin-bottom:10px; padding-top:0px; padding-bottom:0px; text-indent:2em; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-size:14px; font-family:'microsoft yahei',arial; text-align:justify">
deepnlp.org的基于Tensorflow的NLP API的默认编码是utf-8； Python2的编码通常是ASCII码，无法有效支持中文，所以通过引入 from __future__ import unicode_literals 函数，来和Python3实现统一。统一之后字符串默认保存的编码是unicode，在传递进入URL时, text文本需要encode转化为utf-8码。</p>
<br>
<p style="text-align:left" align="left"><span style="font-family:Arial,sans-serif; font-size:14px"><span style="color:rgb(51,51,51); font-family:'microsoft yahei',arial; font-size:16px; line-height:27.2px; text-align:justify; text-indent:32px"></span></span></p>
<h3 style="margin:10px 0px; padding:3px; color:rgb(194,33,13); font-size:18px; font-family:微软雅黑,Arial; clear:both"><a name="t11" target="_blank"></a>
附录</h3>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t12" target="_blank"></a>
<a target="_blank" href="http://www.icl.pku.edu.cn/icl_groups/corpus/addition.htm" style="margin:0px; padding:0px; color:rgb(51,51,51); text-decoration:none">1.POS词性标注标记集</a></h4>
<table class="table  " style="margin:10px auto; padding:0px; table-layout:fixed; empty-cells:show; border-collapse:collapse; border:1px solid rgb(202,217,234); color:rgb(102,102,102); font-family:Arial,sans-serif">
<tbody style="margin:0px; padding:0px">
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
代码</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
名称</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
帮助记忆的诠释</th>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Ag</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
形语素</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
形容词性语素。形容词代码为a，语素代码ｇ前面置以A。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
a</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
形容词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语形容词adjective的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
ad</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
副形词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
直接作状语的形容词。形容词代码a和副词代码d并在一起。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
an</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名形词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
具有名词功能的形容词。形容词代码a和名词代码n并在一起。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
b</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
区别词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取汉字“别”的声母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
c</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
连词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语连词conjunction的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Dg</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
副语素</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
副词性语素。副词代码为d，语素代码ｇ前面置以D。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
d</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
副词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取adverb的第2个字母，因其第1个字母已用于形容词。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
e</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
叹词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语叹词exclamation的第1个字母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
f</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
方位词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取汉字“方”的声母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
g</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
语素</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
绝大多数语素都能作为合成词的“词根”，取汉字“根”的声母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
h</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
前接成分</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语head的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
i</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
成语</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语成语idiom的第1个字母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
j</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
简称略语</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取汉字“简”的声母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
k</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
后接成分</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
&nbsp;</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
l</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
习用语</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
习用语尚未成为成语，有点“临时性”，取“临”的声母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
m</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
数词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语numeral的第3个字母，n，u已有他用。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Ng</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名语素</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名词性语素。名词代码为n，语素代码ｇ前面置以N。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
n</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语名词noun的第1个字母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nr</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
人名</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名词代码n和“人(ren)”的声母并在一起。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
ns</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
地名</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名词代码n和处所词代码s并在一起。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nt</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
机构团体</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
“团”的声母为t，名词代码n和t并在一起。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nz</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
其他专名</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
“专”的声母的第1个字母为z，名词代码n和z并在一起。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
o</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
拟声词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语拟声词onomatopoeia的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
p</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
介词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语介词prepositional的第1个字母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
q</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
量词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语quantity的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
r</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
代词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语代词pronoun的第2个字母,因p已用于介词。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
s</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
处所词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语space的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Tg</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
时语素</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
时间词性语素。时间词代码为t,在语素的代码g前面置以T。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
t</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
时间词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语time的第1个字母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
u</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
助词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语助词auxiliary 的第2个字母,因a已用于形容词。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Vg</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
动语素</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
动词性语素。动词代码为v。在语素的代码g前面置以V。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
v</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
动词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取英语动词verb的第一个字母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
vd</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
副动词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
直接作状语的动词。动词和副词的代码并在一起。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
vn</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
名动词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
指具有名词功能的动词。动词和名词的代码并在一起。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
w</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
标点符号</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
&nbsp;</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
x</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
非语素字</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
非语素字只是一个符号，字母x通常用于代表未知数、符号。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
y</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
语气词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取汉字“语”的声母。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
z</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
状态词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
取汉字“状”的声母的前一个字母。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nx</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
英文词简写字母等(全角)</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Ａ,Ｂ,ＮＥＣ,ＰＯＳＴＰＡＩＤ</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Bg</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
&nbsp;</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
翠/Bg 橙/Bg</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Rg</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
古文特定词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
斯/Rg 予/Rg 伊/Rg 胡/Rg</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
Mg</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
中文数字词</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
甲、乙、丙、丁等……</td>
</tr>
</tbody>
</table>
<h4 style="margin:10px 0px; padding:0px; color:rgb(194,33,13); font-size:14px; font-family:'microsoft yahei',Arial; clear:both"><a name="t13" target="_blank"></a>
2.NER命名实体识别标记集</h4>
<table class="table  " style="margin:10px auto; padding:0px; table-layout:fixed; empty-cells:show; border-collapse:collapse; border:1px solid rgb(202,217,234); color:rgb(102,102,102); font-family:Arial,sans-serif">
<tbody style="margin:0px; padding:0px">
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
标签</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
名称</th>
<th style="margin:0px; padding:0px 1em; border:1px solid rgb(202,217,234); font-weight:normal; height:50px">
解释</th>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nt</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
非实体</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
&nbsp;</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
n</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
人名</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
如"刘伯承", "邓小平"等。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
p</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
地名</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
如"北京", "上海", "美国"等。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
o</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
机构名</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
如"工业部", "德国队", "新华社" 等。</td>
</tr>
<tr style="margin:0px; padding:0px">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nz</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
影视作品</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
如"老九门", "我去上学啦"等。</td>
</tr>
<tr class="alter" style="margin:0px; padding:0px; background-color:rgb(245,250,254)">
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
nbz</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
商业品牌</td>
<td style="margin:0px; padding:0px 1em; vertical-align:top; height:50px; border:1px solid rgb(202,217,234)">
如"微博", "爱奇艺", "百度"等。</td>
</tr>
</tbody>
</table>
<br>
<p></p>
<p style="text-align:left" align="left"><span style="font-family:Arial,sans-serif; font-size:14px"><span style="color:rgb(51,51,51); font-family:'microsoft yahei',arial; font-size:16px; line-height:27.2px; text-align:justify; text-indent:32px"></span></span></p>
<h3 style="margin:10px 0px; padding:3px; line-height:35px; font-size:18px; color:rgb(194,33,13); font-family:微软雅黑,Arial; clear:both"><a name="t14" target="_blank"></a>
拓展阅读</h3>
<div style="color:rgb(85,85,85); font-family:'microsoft yahei'; font-size:15px; line-height:35px">
<ul style="font-size:14px; margin:0px; padding:0px; font-family:Arial,sans-serif">
<li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="https://github.com/rockingdingo/deepnlp/tree/master/deepnlp/textsum" style="text-decoration:none; color:rgb(51,51,51); margin:0px; padding:0px">d</a>eepnlp Python包</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="https://pypi.python.org/pypi/deepnlp" style="text-decoration:none; color:rgb(12,137,207)">https://pypi.python.org/pypi/deepnlp</a><br>
</li></ul>
</div>
<ul style="color:rgb(85,85,85); line-height:35px; font-size:14px; margin:0px; padding:0px; font-family:Arial,sans-serif">
<li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="https://github.com/rockingdingo/deepnlp/tree/master/deepnlp/textsum" style="text-decoration:none; color:rgb(51,51,51); margin:0px; padding:0px">Github源码deepnlp</a></li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="https://github.com/rockingdingo/deepnlp" style="text-decoration:none; color:rgb(12,137,207)">https://github.com/rockingdingo/deepnlp</a></li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
www.deepnlp 网站 API demo和接口</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org"></a><a target="_blank" href="http://www.deepnlp.org" style="font-family:'microsoft yahei',arial; font-size:14px; line-height:27.2px; text-align:justify; text-indent:32px">http://www.deepnlp.org</a><br>
</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org/api/v1.0/pipeline">http://www.deepnlp.org/api/v1.0/pipeline</a><br>
</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<a target="_blank" href="http://www.deepnlp.org/blog/tutorial-deepnlp-api/">http://www.deepnlp.org/blog/tutorial-deepnlp-api/</a><br>
</li><li style="margin:10px 0px; padding:0px; color:rgb(51,51,51); line-height:27.2px; word-wrap:break-word; font-family:'microsoft yahei',arial; text-align:justify; list-style:none">
<br>
</li></ul>
<p></p>
   
</div>




<!-- Baidu Button BEGIN -->




<div class="bdsharebuttonbox tracking-ad bdshare-button-style0-16" style="float: right;" data-mod="popu_172" data-bd-bind="1514016180367">
<a href="#" class="bds_more" data-cmd="more" style="background-position:0 0 !important; background-image: url(http://bdimg.share.baidu.com/static/api/img/share/icons_0_16.png?v=d754dcc0.png) !important" target="_blank"></a>
<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间" style="background-position:0 -52px !important" target="_blank"></a>
<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博" style="background-position:0 -104px !important" target="_blank"></a>
<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博" style="background-position:0 -260px !important" target="_blank"></a>
<a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网" style="background-position:0 -208px !important" target="_blank"></a>
<a href="#" class="bds_weixin" data-cmd="weixin" title="分享到微信" style="background-position:0 -1612px !important" target="_blank"></a>
</div>
<script>window._bd_share_config = { "common": { "bdSnsKey": {}, "bdText": "", "bdMini": "1", "bdMiniList": false, "bdPic": "", "bdStyle": "0", "bdSize": "16" }, "share": {} }; with (document) 0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion=' + ~(-new Date() / 36e5)];</script>
<!-- Baidu Button END -->

   

<!--172.16.140.12-->

<!-- Baidu Button BEGIN -->
<script type="text/javascript" id="bdshare_js" data="type=tools&amp;uid=1536434" src="http://bdimg.share.baidu.com/static/js/bds_s_v2.js?cdnversion=420561"></script>

<script type="text/javascript">
    document.getElementById("bdshell_js").src = "http://bdimg.share.baidu.com/static/js/shell_v2.js?cdnversion=" + Math.ceil(new Date()/3600000)
</script>
<!-- Baidu Button END -->



 


        <div id="digg" articleid="55806734">
            <dl id="btnDigg" class="digg digg_disable" onclick="btndigga();">
               
                 <dt>顶</dt>
                <dd>0</dd>
            </dl>
           
              
            <dl id="btnBury" class="digg digg_disable" onclick="btnburya();">
              
                  <dt>踩</dt>
                <dd>0</dd>               
            </dl>
            
        </div>
     <div class="tracking-ad" data-mod="popu_222"><a href="javascript:void(0);" target="_blank">&nbsp;</a>   </div>
    <div class="tracking-ad" data-mod="popu_223"> <a href="javascript:void(0);" target="_blank">&nbsp;</a></div>
    <script type="text/javascript">
        function btndigga() {
            $(".tracking-ad[data-mod='popu_222'] a").click();
        }
        function btnburya() {
            $(".tracking-ad[data-mod='popu_223'] a").click();
        }
            </script>

   <ul class="article_next_prev">
                <li class="prev_article"><span onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_shangyipian']);location.href='http://blog.csdn.net/rockingdingo/article/details/55806291';">上一篇</span><a href="http://blog.csdn.net/rockingdingo/article/details/55806291" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_shangyipian'])">Bayes贝叶斯方法-均值和协方差参数估计及定理证明(一)</a></li>
                <li class="next_article"><span onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_xiayipian']);location.href='http://blog.csdn.net/rockingdingo/article/details/55806451';">下一篇</span><a href="http://blog.csdn.net/rockingdingo/article/details/55806451" onclick="_gaq.push(['_trackEvent','function', 'onclick', 'blog_articles_xiayipian'])">Bayes贝叶斯方法-均值和协方差参数估计及定理证明(二)</a></li>
    </ul>

    <div style="clear:both; height:10px;"></div>


            <div class="similar_article">
                    <h4></h4>
                    <div class="similar_c" style="margin:20px 0px 0px 0px">
                        <div class="similar_c_t">
                          &nbsp;&nbsp;相关文章推荐
                        </div>
                   
                        <div class="similar_wrap tracking-ad" data-mod="popu_36" style="max-height:250px">                       
                            <ul class="similar_list fl">    
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/liangliang103377/article/details/40082255" title="iOS8开发～UI布局（二）storyboard中autolayout和size class的使用详解" strategy="BlogCommendFromCF_0" target="_blank">iOS8开发～UI布局（二）storyboard中autolayout和size class的使用详解</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://edu.csdn.net/huiyiCourse/series_detail/74?utm_source=blog7" title="MySQL在微信支付下的高可用运营--莫晓东" strategy="undefined" target="_blank">MySQL在微信支付下的高可用运营--莫晓东</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/rockingdingo/article/details/52769178" title="R语言中的Softmax Regression建模(MNIST手写体识别和文档多分类应用)" strategy="BlogCommendFromCF_1" target="_blank">R语言中的Softmax Regression建模(MNIST手写体识别和文档多分类应用)</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://edu.csdn.net/huiyiCourse/series_detail/73?utm_source=blog7" title="容器技术在58同城的实践--姚远" strategy="undefined" target="_blank">容器技术在58同城的实践--姚远</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/huludan/article/details/51854929" title="Python调用哈工大语言云（LTP）API进行自然语言处理" strategy="BlogCommendFromCsdn_2" target="_blank">Python调用哈工大语言云（LTP）API进行自然语言处理</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://edu.csdn.net/huiyiCourse/series_detail/73?utm_source=blog7" title="SDCC 2017之容器技术实战线上峰会" strategy="undefined" target="_blank">SDCC 2017之容器技术实战线上峰会</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/churximi/article/details/51173297" title="Python调用哈工大语言云（LTP）API进行自然语言处理" strategy="BlogCommendFromCsdn_3" target="_blank">Python调用哈工大语言云（LTP）API进行自然语言处理</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://edu.csdn.net/huiyiCourse/series_detail/74?utm_source=blog7" title="SDCC 2017之数据库技术实战线上峰会" strategy="undefined" target="_blank">SDCC 2017之数据库技术实战线上峰会</a>
                                   </li>
                            </ul>
                              <ul class="similar_list fr">      
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/noter16/article/details/52688848" title="Python调用哈工大语言云（LTP）API进行自然语言处理" strategy="BlogCommendFromCsdn_4" target="_blank">Python调用哈工大语言云（LTP）API进行自然语言处理</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://edu.csdn.net/huiyiCourse/series_detail/73?utm_source=blog7" title="腾讯云容器服务架构实现介绍--董晓杰" strategy="undefined" target="_blank">腾讯云容器服务架构实现介绍--董晓杰</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/yaoqiang2011/article/details/51871068" title="深度学习与自然语言处理(6)_斯坦福cs224d 一起来学Tensorflow part1" strategy="BlogCommendFromCsdn_5" target="_blank">深度学习与自然语言处理(6)_斯坦福cs224d 一起来学Tensorflow part1</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://edu.csdn.net/huiyiCourse/series_detail/74?utm_source=home7" title="微博热点事件背后的数据库运维心得--张冬洪" strategy="undefined" target="_blank">微博热点事件背后的数据库运维心得--张冬洪</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/monkey131499/article/details/52145254" title="Python与自然语言处理（三）：Tensorflow基础学习" strategy="BlogCommendFromCsdn_6" target="_blank">Python与自然语言处理（三）：Tensorflow基础学习</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/masa_fish/article/details/52700657" title="自然语言处理入门以及TensorFlow官网教程Vector Representations of words简介" strategy="BlogCommendFromCsdn_7" target="_blank">自然语言处理入门以及TensorFlow官网教程Vector Representations of words简介</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/zkl99999/article/details/51424282" title="机器学习/深度学习/自然语言处理学习路线    Stanford机器学习笔记  TensorFlow人工智能引擎入门教程之系列" strategy="BlogCommendFromCsdn_8" target="_blank">机器学习/深度学习/自然语言处理学习路线    Stanford机器学习笔记  TensorFlow人工智能引擎入门教程之系列</a>
                                   </li>
                                   <li>
                                       <em>•</em>
                                       <a href="http://blog.csdn.net/monkey131499/article/details/53609674" title="Python与自然语言处理（四）：TensorFlow基础学习2" strategy="BlogCommendFromCsdn_9" target="_blank">Python与自然语言处理（四）：TensorFlow基础学习2</a>
                                   </li>
                            </ul>
                        </div>
                    </div>
                </div>   
      
