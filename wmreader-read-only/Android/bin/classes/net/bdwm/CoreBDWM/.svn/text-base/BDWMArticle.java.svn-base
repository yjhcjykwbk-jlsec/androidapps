package net.bdwm.CoreBDWM;

import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created on 11-10-12
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class BDWMArticle {

    public String content;
    Vector<String> v_atturl;
    Vector<String> v_attname;
    public String previousPage;
    public String nextPage;
    public String firstPage;
    public String lastPage;

    void loadAttachment(String s)
    {
        v_attname = new Vector<String>();
        v_atturl = new Vector<String>();
        Pattern p = Pattern.compile("<a href=\\\"(http://attach..bdwm.net/[^\\\"]*)\\\"[^>]*>([^<]*)</a>");
        Matcher m = p.matcher(s);
        while (m.find())
        {
            v_atturl.add(m.group(1));
            v_attname.add(Helper.UnescapeHTML(m.group(2)));
        }
    }

    public int attachmentCount()
    {
        return v_attname.size();
    }

    public String attachmentNameAt(int i)
    {
        return v_attname.elementAt(i);
    }

    public String attachmentURLAt(int i)
    {
        return v_atturl.elementAt(i);
    }

    public void loadString(String s)
    {
        int beg = s.indexOf("<pre>"), end = s.indexOf("</pre>", Math.max(0, beg));
        if (beg < 0 || end < 0) content = "";
        else
        {
            content = Helper.UnescapeHTML(s.substring(beg, end).replaceAll("<[^>]+>", ""));
        }
        loadAttachment(s);
        previousPage = null;
        nextPage = null;
        firstPage = null;
        lastPage = null;
    }

    public void loadFullString(String s)
    {
        int beg = 0, end;
        StringBuffer b = new StringBuffer();
        while (beg < s.length())
        {
            beg = s.indexOf("<pre>", beg);
            if (beg < 0) break;
            end = s.indexOf("</pre>", beg);
            if (end < 0) break;
            b.append(s.substring(beg, end));
            beg = end;
        }
        content = Helper.UnescapeHTML(b.toString().replaceAll("<[^>]+>", ""));
        loadAttachment(s);
        Pattern p = Pattern.compile("<a href=.{0,5}(bbstcon.php[^>]*)>上一页</a>");
        Matcher m = p.matcher(s);
        if (m.find()) previousPage = m.group(1);
        else previousPage = null;
        p = Pattern.compile("<a href=.{0,5}(bbstcon.php[^>]*)>下一页</a>");
        m = p.matcher(s);
        if (m.find()) nextPage = m.group(1);
        else nextPage = null;
        p = Pattern.compile("<a href=.{0,5}(bbstcon.php[^>]*)>第一页</a>");
        m = p.matcher(s);
        if (m.find()) firstPage = m.group(1);
        else firstPage = null;
        p = Pattern.compile("<a href=.{0,5}(bbstcon.php[^>]*)>末页</a>");
        m = p.matcher(s);
        if (m.find()) lastPage = m.group(1);
        else lastPage = null;
    }

}
