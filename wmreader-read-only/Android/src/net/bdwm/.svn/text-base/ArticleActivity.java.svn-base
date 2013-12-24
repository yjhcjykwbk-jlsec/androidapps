package net.bdwm;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.util.TypedValue;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;
import net.bdwm.CoreBDWM.BDWMArticle;
import net.bdwm.Utility.AsyncHTTP;
import net.bdwm.Utility.AsyncHTTPDelegate;
import net.bdwm.Utility.ConfigManager;

/**
 * Created on 11-10-12
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class ArticleActivity extends Activity implements AsyncHTTPDelegate {

    TextView textView;
    String url;
    BDWMArticle model;
    static BDWMArticle articleModel;
    ProgressDialog progressDialog;

    boolean showReply;

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setURL(getIntent().getExtras().getString("URL"));
        setTitle(getIntent().getExtras().getString("Title"));
        setContentView(R.layout.article);
        textView = (TextView)findViewById(R.id.text);
        model = new BDWMArticle();
        articleModel = model;
        progressDialog = null;
        showReply = ConfigManager.get().getShowArticleReply();
        doRefresh();
    }

    public boolean onCreateOptionsMenu(Menu m)
    {
        super.onCreateOptionsMenu(m);
        return true;
    }

    public boolean onPrepareOptionsMenu(Menu m)
    {
        super.onPrepareOptionsMenu(m);
        m.clear();
        m.add("刷新");
        m.add("查看附件");
        if (showReply)
        {
            m.add("隐藏回帖");
            m.add("上一页");
            m.add("下一页");
            m.add("第一页");
            m.add("末页");
        }
        else
            m.add("显示回帖");
        return true;
    }

    public boolean onOptionsItemSelected(MenuItem i)
    {
        super.onOptionsItemSelected(i);
        if ("刷新".equals(i.getTitle())) doRefresh();
        else if ("查看附件".equals(i.getTitle()))
        {
            Intent it = new Intent(this, AttachmentActivity.class);
            startActivity(it);
        }
        else if ("显示回帖".equals(i.getTitle()))
        {
            showReply = true;
            doRefresh();
        }
        else if ("隐藏回帖".equals(i.getTitle()))
        {
            showReply = false;
            doRefresh();
        }
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
        else if ("第一页".equals(i.getTitle()))
        {
            if (model.firstPage != null)
            {
                setURL(model.firstPage);
                doRefresh();
            }
        }
        else if ("末页".equals(i.getTitle()))
        {
            if (model.lastPage != null)
            {
                setURL(model.lastPage);
                doRefresh();
            }
        }
        return true;
    }

    public void onResume()
    {
        super.onResume();
        if ((int)textView.getTextSize() != ConfigManager.get().getFontSize())
            textView.setTextSize(TypedValue.COMPLEX_UNIT_PT, ConfigManager.get().getFontSize());
    }

    void setURL(String u)
    {
        if (u.startsWith("http://")) url = u;
        else url = "http://www.bdwm.net/bbs/" + u;
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
        if (showReply)
            model.loadFullString(r.content);
        else
            model.loadString(r.content);
        textView.setText(model.content);
        textView.setTextSize(TypedValue.COMPLEX_UNIT_PT, ConfigManager.get().getFontSize());
        textView.scrollTo(0, 0);
        if (progressDialog != null)
        {
            progressDialog.dismiss();
            progressDialog = null;
        }
    }

    void doRefresh()
    {
        progressDialog = ProgressDialog.show(this, null, "载入中……", true, true);
        AsyncHTTP r = new AsyncHTTP(url, this, ConfigManager.get().getConnectionTimeout());
        r.startAsync();
    }

}
