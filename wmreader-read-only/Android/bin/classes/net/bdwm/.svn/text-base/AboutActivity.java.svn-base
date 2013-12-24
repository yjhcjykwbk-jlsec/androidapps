package net.bdwm;

import android.R;
import android.app.ListActivity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class AboutActivity extends ListActivity {

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setTitle("关于");
        String[] list = new String[] {
            "名称\n  未名阅读器",
            "版本\n  0.3",
            "网站\n  http://wmreader.googlecode.com",
            "作者\n  coolypf",
            "博客\n  http://hi.baidu.com/coolypf"
        };
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.simple_list_item_1, list);
        setListAdapter(adapter);
    }

    public void onListItemClick(ListView l, View v, int position, long id)
    {
        Intent i;
        Uri u = null;
        if (position == 2) u = Uri.parse("http://wmreader.googlecode.com");
        if (position == 4) u = Uri.parse("http://hi.baidu.com/coolypf");
        if (u == null) return;
        i = new Intent(Intent.ACTION_VIEW, u);
        startActivity(i);
    }

}
