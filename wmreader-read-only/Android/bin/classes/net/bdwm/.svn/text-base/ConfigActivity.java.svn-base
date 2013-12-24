package net.bdwm;

import android.*;
import android.R;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Config;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import net.bdwm.Utility.ConfigManager;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class ConfigActivity extends ListActivity {

    static ConfigActivity self;

    enum ConfigStatus
    {
        Ready,
        PopularType,
        PopularAmount,
        FontSize,
        ConnectionTimeout,
        ShowTopArticles,
        ShowArticleReply
    };

    ConfigStatus status;
    String[] list;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setTitle("设置");
        self = this;

        list = new String[] {
            "热门话题类型",
            "热门话题数目",
            "文章字体大小",
            "网络连接超时",
            "版面置顶帖",
            "文章回帖"
        };
        ArrayAdapter<String> a = new ArrayAdapter<String>(this, R.layout.simple_list_item_1, list);
        setListAdapter(a);
    }

    public void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        if (position >= list.length) return;
        Intent i = new Intent(this, SelectActivity.class);
        i.putExtra("Title", list[position]);
        switch (position)
        {
            case 0:
                status = ConfigStatus.PopularType;
                i.putExtra("Count", 3);
                i.putExtra("Option-0", "即时");
                i.putExtra("Option-1", "今日");
                i.putExtra("Option-2", "本周");
                break;
            case 1:
                status = ConfigStatus.PopularAmount;
                i.putExtra("Count", 10);
                for (int j = 0; j < 10; ++j)
                    i.putExtra(String.format("Option-%d", j), String.format("%d 项", 10 + 10 * j));
                break;
            case 2:
                status = ConfigStatus.FontSize;
                i.putExtra("Count", 15);
                for (int j = 0; j < 15; ++j)
                    i.putExtra(String.format("Option-%d", j), String.format("%d pt", 6 + j));
                break;
            case 3:
                status = ConfigStatus.ConnectionTimeout;
                i.putExtra("Count", 6);
                for (int j = 0; j < 6; ++j)
                    i.putExtra(String.format("Option-%d", j), String.format("%d 秒", 5 + 5 * j));
                break;
            case 4:
                status = ConfigStatus.ShowTopArticles;
                i.putExtra("Count", 2);
                i.putExtra("Option-0", "显示");
                i.putExtra("Option-1", "隐藏");
                break;
            case 5:
                status = ConfigStatus.ShowArticleReply;
                i.putExtra("Count", 2);
                i.putExtra("Option-0", "显示");
                i.putExtra("Option-1", "隐藏");
                break;
            default:
                break;
        }
        startActivity(i);
    }

    void setConfigValue(int v)
    {
        ConfigManager m = ConfigManager.get();
        switch (status)
        {
            default:
                break;
            case PopularType:
                m.setPopularType(v);
                break;
            case PopularAmount:
                m.setPopularAmount(v * 10 + 10);
                break;
            case FontSize:
                m.setFontSize(6 + v);
                break;
            case ConnectionTimeout:
                m.setConnectionTimeout(v * 5 + 5);
                break;
            case ShowTopArticles:
                m.setShowTopArticles(v == 0);
                break;
            case ShowArticleReply:
                m.setShowArticleReply(v == 0);
                break;
        }
        status = ConfigStatus.Ready;
    }

}
