package net.bdwm.CoreBDWM;

import net.bdwm.Utility.ConfigManager;

import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created on 11-10-13
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class BDWMBoard {

    public String previousPage;
    public String nextPage;
    public String latestPage;
    Vector<String> v_title;
    Vector<String> v_url;

    public void loadString(String s)
    {
        v_title = new Vector<String>();
        v_url = new Vector<String>();
        Pattern p;
        if (ConfigManager.get().getShowTopArticles())
            p = Pattern.compile("<a href=\\\"?(bbst?con.php[^\\\"]*)\\\">([^<]*)(</span>)?</a>");
        else
            p = Pattern.compile("<a href=\\\"(bbst?con.php[^\\\"]*)\\\">([^<]*)</a>");
        Matcher m = p.matcher(s);
        while (m.find())
        {
            v_url.add(m.group(1));
            v_title.add(Helper.UnescapeHTML(m.group(2).substring(3)));
        }
        p = Pattern.compile("<a href=\\\"(bbstop.php[^\\\"]*)\\\">上页</a>");
        m = p.matcher(s);
        if (m.find()) previousPage = m.group(1);
        else previousPage = null;
        p = Pattern.compile("<a href=\\\"(bbstop.php[^\\\"]*)\\\">下页</a>");
        m = p.matcher(s);
        if (m.find()) nextPage = m.group(1);
        else nextPage = null;
        p = Pattern.compile("<a href=\\\"(bbstop.php[^\\\"]*)\\\">最新</a>");
        m = p.matcher(s);
        if (m.find()) latestPage = m.group(1);
        else latestPage = null;
    }

    public String titleAt(int i)
    {
        return v_title.elementAt(i);
    }

    public String urlAt(int i)
    {
        return v_url.elementAt(i);
    }

    public int count()
    {
        return v_title.size();
    }

}
