package net.bdwm;

import android.R;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import net.bdwm.Utility.ConfigManager;

/**
 * Created on 11-9-26
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class MenuActivity extends ListActivity {

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        ConfigManager.appPref = getSharedPreferences("config", 0);
        ConfigManager.favPref = getSharedPreferences("favorite", 0);
        setTitle("未名阅读器");
        String[] list = new String[]{"热门话题", "版面列表", "收藏夹", "设置"};
        ArrayAdapter<String> adapter = new ArrayAdapter<String>(this, R.layout.simple_list_item_1, list);
        setListAdapter(adapter);
    }

    public boolean onCreateOptionsMenu(Menu m)
    {
        super.onCreateOptionsMenu(m);
        m.add("关于");
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem i)
    {
        super.onOptionsItemSelected(i);
        Intent intent = new Intent(this, AboutActivity.class);
        startActivity(intent);
        return true;
    }

    protected void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        Intent i = null;
        switch(position)
        {
            case 0:
                i = new Intent(this, PopularActivity.class);
                break;
            case 1:
                i = new Intent(this, BoardlistActivity.class);
                break;
            case 2:
                i = new Intent(this, FavoriteActivity.class);
                break;
            case 3:
                i = new Intent(this, ConfigActivity.class);
                break;
            default:
                break;
        }
        if (i != null) startActivity(i);
    }

}
