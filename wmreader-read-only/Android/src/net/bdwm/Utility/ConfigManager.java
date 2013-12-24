package net.bdwm.Utility;

import android.content.SharedPreferences;

import java.util.Vector;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class ConfigManager {

    public static SharedPreferences appPref;
    public static SharedPreferences favPref;
    static ConfigManager theManager = null;

    public static ConfigManager get()
    {
        if (theManager == null)
            theManager = new ConfigManager();
        return theManager;
    }

    public Vector<String> favBoard;
    public Vector<String> favName;

    ConfigManager()
    {
        int count = favPref.getInt("Count", 0);
        favBoard = new Vector<String>(count);
        favName = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
        {
            favBoard.add(favPref.getString(String.format("Board-%d", i), "ERROR"));
            favName.add(favPref.getString(String.format("Name-%d", i), "出错了"));
        }
    }

    public void updateFavorite()
    {
        SharedPreferences.Editor e = favPref.edit();
        e.clear();
        int count = favBoard.size();
        e.putInt("Count", count);
        for (int i = 0; i < count; ++i)
        {
            e.putString(String.format("Board-%d", i), favBoard.elementAt(i));
            e.putString(String.format("Name-%d", i), favName.elementAt(i));
        }
        e.commit();
        return;
    }

    public int getPopularType()
    {
        int t = appPref.getInt("PopularType", 1);
        if (t == 0) return 7;
        if (t == 2) return 2520;
        return 180;
    }

    public void setPopularType(int t)
    {
        appPref.edit().putInt("PopularType", t).commit();
    }

    public int getPopularAmount()
    {
        int a = appPref.getInt("PopularAmount", 10);
        if (a >= 10 && a <= 100) return a;
        return 10;
    }

    public void setPopularAmount(int a)
    {
        appPref.edit().putInt("PopularAmount", a).commit();
    }

    public boolean getShowArticleReply()
    {
        return appPref.getBoolean("ShowArticleReply", false);
    }

    public void setShowArticleReply(boolean s)
    {
        appPref.edit().putBoolean("ShowArticleReply", s).commit();
    }

    public boolean getShowTopArticles()
    {
        return appPref.getBoolean("ShowTopArticles", true);
    }

    public void setShowTopArticles(boolean s)
    {
        appPref.edit().putBoolean("ShowTopArticles", s).commit();
    }

    public int getConnectionTimeout()
    {
        int t = appPref.getInt("ConnectionTimeout", 10);
        if (t >= 5 && t <= 30) return t;
        return 10;
    }

    public void setConnectionTimeout(int t)
    {
        appPref.edit().putInt("ConnectionTimeout", t).commit();
    }

    public int getFontSize()
    {
        int s = appPref.getInt("FontSize", 12);
        if (s >= 6 && s <= 20) return s;
        return 12;
    }

    public void setFontSize(int s)
    {
        appPref.edit().putInt("FontSize", s).commit();
    }

}
