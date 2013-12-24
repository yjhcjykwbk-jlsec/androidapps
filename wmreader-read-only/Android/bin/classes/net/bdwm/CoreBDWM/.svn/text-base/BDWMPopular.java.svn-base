package net.bdwm.CoreBDWM;

import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class BDWMPopular {

    Vector<String> v_url;
    Vector<String> v_title;

    public void loadString(String s)
    {
        v_url = new Vector<String>();
        v_title = new Vector<String>();
        Pattern p = Pattern.compile("<a href='(bbstcon.php[^>]*)'>([^<]*)</a>");
        Matcher m = p.matcher(s);
        while (m.find())
        {
            v_url.add(m.group(1));
            v_title.add(Helper.UnescapeHTML(m.group(2)));
        }
    }

    public int count()
    {
        return v_title.size();
    }

    public String titleAt(int i)
    {
        return v_title.elementAt(i);
    }

    public String urlAt(int i)
    {
        return v_url.elementAt(i);
    }

}
