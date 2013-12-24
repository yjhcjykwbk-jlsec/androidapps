package net.bdwm;

import android.R;
import android.app.AlertDialog;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ListView;
import net.bdwm.CoreBDWM.BDWMBoardlist;
import net.bdwm.Utility.AsyncHTTP;
import net.bdwm.Utility.AsyncHTTPDelegate;
import net.bdwm.Utility.ConfigManager;
import net.bdwm.Utility.CustomArrayAdapter;

import java.util.Vector;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class BoardlistActivity extends ListActivity implements AsyncHTTPDelegate {

    BoardlistActivity self;
    BDWMBoardlist model;
    ProgressDialog progressDialog;

    public static SharedPreferences boardlistPref;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setTitle("版面列表");
        self = this;
        model = new BDWMBoardlist();
        progressDialog = null;
        boardlistPref = getSharedPreferences("boardlist", 0);
        getListView().setTextFilterEnabled(true);
        getListView().setFastScrollEnabled(true);
        if (model.load()) loadList();
        else doRefresh();
    }

    public boolean onCreateOptionsMenu(Menu m)
    {
        super.onCreateOptionsMenu(m);
        m.add("刷新");
        m.add("搜索");
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem i)
    {
        super.onOptionsItemSelected(i);
        if ("刷新".equals(i.getTitle()))
            doRefresh();
        else if ("搜索".equals(i.getTitle()))
        {
            InputMethodManager m = (InputMethodManager)getSystemService(Context.INPUT_METHOD_SERVICE);
            if (m != null) m.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);
        }
        return true;
    }

    public void asyncHTTPFailed(AsyncHTTP r)
    {
        if (progressDialog != null)
        {
            progressDialog.dismiss();
            progressDialog = null;
        }
        AlertDialog.Builder b = new AlertDialog.Builder(this);
        b.setMessage("载入失败");
        b.setCancelable(true);
        b.show();
    }

    public void asyncHTTPFinished(AsyncHTTP r)
    {
        model.loadString(r.content);
        loadList();
        if (progressDialog != null)
        {
            progressDialog.dismiss();
            progressDialog = null;
        }
    }

    protected void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        if (position >= getListAdapter().getCount()) return;
        CustomArrayAdapter a = (CustomArrayAdapter)getListAdapter();
        position = a.getItemOriginalPosition(position);
        Intent i = new Intent(this, BoardActivity.class);
        i.putExtra("Board", model.boardAt(position));
        i.putExtra("Name", model.nameAt(position));
        startActivity(i);
    }

    void loadList()
    {
        int count = model.count();
        Vector<String> list = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
            list.add(model.boardAt(i) + " [" + model.nameAt(i) + "]");
        CustomArrayAdapter a = new CustomArrayAdapter(this, list.toArray());
        setListAdapter(a);
    }

    void doRefresh()
    {
        progressDialog = ProgressDialog.show(this, null, "载入中……", true, true);
        AsyncHTTP r = new AsyncHTTP("http://www.bdwm.net/bbs/bbsall.php",
                this, ConfigManager.get().getConnectionTimeout());
        r.startAsync();
    }

}
