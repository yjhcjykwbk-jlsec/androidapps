package net.bdwm;

import android.*;
import android.R;
import android.app.AlertDialog;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Config;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.ProgressBar;
import net.bdwm.CoreBDWM.BDWMBoard;
import net.bdwm.Utility.AsyncHTTP;
import net.bdwm.Utility.AsyncHTTPDelegate;
import net.bdwm.Utility.ConfigManager;

import java.util.Vector;

/**
 * Created on 11-10-13
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class BoardActivity extends ListActivity implements AsyncHTTPDelegate {

    BDWMBoard model;
    ProgressDialog progressDialog;
    String url;

    String board;
    String name;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        board = getIntent().getExtras().getString("Board");
        name = getIntent().getExtras().getString("Name");
        setTitle(board + " [" + name + "]");
        model = new BDWMBoard();
        progressDialog = null;
        url = "http://www.bdwm.net/bbs/bbstop.php?board=" + board;
        doRefresh();
    }

    void setURL(String s)
    {
        if (s.startsWith("http://"))
            url = s;
        else
            url = "http://www.bdwm.net/bbs/" + s;
    }

    public boolean onCreateOptionsMenu(Menu m)
    {
        super.onCreateOptionsMenu(m);
        m.add("刷新");
        m.add("上一页");
        m.add("下一页");
        m.add("最新");
        m.add("收藏版面");
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem i)
    {
        super.onOptionsItemSelected(i);
        if ("刷新".equals(i.getTitle()))
            doRefresh();
        else if ("上一页".equals(i.getTitle()))
        {
            if (model.previousPage != null)
            {
                setURL(model.previousPage);
                doRefresh();
            }
        }
        else if ("下一页".equals(i.getTitle()))
        {
            if (model.nextPage != null)
            {
                setURL(model.nextPage);
                doRefresh();
            }
        }
        else if ("最新".equals(i.getTitle()))
        {
            if (model.latestPage != null)
            {
                setURL(model.latestPage);
                doRefresh();
            }
        }
        else if ("收藏版面".equals(i.getTitle()))
        {
            if (!ConfigManager.get().favBoard.contains(board))
            {
                ConfigManager.get().favBoard.add(board);
                ConfigManager.get().favName.add(name);
                ConfigManager.get().updateFavorite();
            }
        }
        return true;
    }

    protected void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        if (position >= model.count()) return;
        Intent i = new Intent(this, ArticleActivity.class);
        i.putExtra("URL", model.urlAt(position));
        i.putExtra("Title", model.titleAt(position));
        startActivity(i);
    }

    void doRefresh()
    {
        progressDialog = ProgressDialog.show(this, null, "载入中……", true, true);
        AsyncHTTP r = new AsyncHTTP(url, this, ConfigManager.get().getConnectionTimeout());
        r.startAsync();
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
        int count = model.count();
        Vector<String> list = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
            list.add(model.titleAt(i));
        ArrayAdapter<Object> a = new ArrayAdapter<Object>(this, R.layout.simple_list_item_1, list.toArray());
        setListAdapter(a);
        if (progressDialog != null)
        {
            progressDialog.dismiss();
            progressDialog = null;
        }
    }

}
