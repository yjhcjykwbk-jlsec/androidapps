package net.bdwm;

import android.*;
import android.R;
import android.app.ListActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.Vector;

/**
 * Created on 11-10-13
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class SelectActivity extends ListActivity {

    Vector<String> v_option;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        b = getIntent().getExtras();
        setTitle(b.getString("Title"));
        int count = b.getInt("Count");
        v_option = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
            v_option.add(b.getString(String.format("Option-%d", i)));
        ArrayAdapter<Object> a = new ArrayAdapter<Object>(this, R.layout.simple_list_item_1, v_option.toArray());
        setListAdapter(a);
    }

    public void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        ConfigActivity.self.setConfigValue(position);
        finish();
    }

}
