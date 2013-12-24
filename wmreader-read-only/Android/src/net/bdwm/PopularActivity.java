package net.bdwm;

import android.R;
import android.app.AlertDialog;
import android.app.ListActivity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import net.bdwm.CoreBDWM.BDWMPopular;
import net.bdwm.Utility.AsyncHTTP;
import net.bdwm.Utility.AsyncHTTPDelegate;
import net.bdwm.Utility.ConfigManager;

import java.util.Vector;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class PopularActivity extends ListActivity implements AsyncHTTPDelegate {

    BDWMPopular model;
    ProgressDialog progressDialog;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setTitle("热门话题");
        model = new BDWMPopular();
        progressDialog = null;
        doRefresh();
    }

    public boolean onCreateOptionsMenu(Menu m)
    {
        super.onCreateOptionsMenu(m);
        m.add("刷新");
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem i)
    {
        super.onOptionsItemSelected(i);
        doRefresh();
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
        int count = Math.min(ConfigManager.get().getPopularAmount(), model.count());
        Vector<String> list = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
            list.add(model.titleAt(i));
        setListAdapter(new ArrayAdapter<Object>(this, R.layout.simple_list_item_1, list.toArray()));
        if (progressDialog != null)
        {
            progressDialog.dismiss();
            progressDialog = null;
        }
    }

    void doRefresh()
    {
        progressDialog = ProgressDialog.show(this, null, "载入中……", true, true);
        String url = String.format("http://www.bdwm.net/bbs/ListPostTops.php?halfLife=%d",
                ConfigManager.get().getPopularType());
        AsyncHTTP r = new AsyncHTTP(url, this, ConfigManager.get().getConnectionTimeout());
        r.startAsync();
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

}
