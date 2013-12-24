package net.bdwm;

import android.*;
import android.R;
import android.app.ListActivity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Config;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import net.bdwm.Utility.ConfigManager;

import java.util.Vector;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class FavoriteActivity extends ListActivity {

    boolean statusRemove;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setTitle("收藏夹");
        statusRemove = false;
        doRefresh();
    }

    public boolean onCreateOptionsMenu(Menu m)
    {
        super.onCreateOptionsMenu(m);
        m.add("删除");
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem i)
    {
        super.onOptionsItemSelected(i);
        if (statusRemove)
        {
            statusRemove = false;
            i.setTitle("删除");
        }
        else
        {
            statusRemove = true;
            i.setTitle("完成");
        }
        return true;
    }

    void doRefresh()
    {
        int count = ConfigManager.get().favBoard.size();
        Vector<String> list = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
            list.add(ConfigManager.get().favBoard.elementAt(i) + " ["
                    + ConfigManager.get().favName.elementAt(i) + "]");
        ArrayAdapter<Object> a = new ArrayAdapter<Object>(this, R.layout.simple_list_item_1, list.toArray());
        setListAdapter(a);
    }

    public void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        if (statusRemove)
        {
            ConfigManager.get().favBoard.remove(position);
            ConfigManager.get().favName.remove(position);
            ConfigManager.get().updateFavorite();
            doRefresh();
            return;
        }
        if (position >= ConfigManager.get().favBoard.size()) return;
        Intent i = new Intent(this, BoardActivity.class);
        i.putExtra("Board", ConfigManager.get().favBoard.elementAt(position));
        i.putExtra("Name", ConfigManager.get().favName.elementAt(position));
        startActivity(i);
    }

}
