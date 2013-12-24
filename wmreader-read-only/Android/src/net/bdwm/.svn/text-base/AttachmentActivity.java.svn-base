package net.bdwm;

import android.R;
import android.app.ListActivity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import java.util.Vector;

/**
 * Created on 11-10-12
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class AttachmentActivity extends ListActivity {

    public void onCreate(Bundle b)
    {
        super.onCreate(b);
        setTitle("附件列表");
        int count = ArticleActivity.articleModel.attachmentCount();
        Vector<String> list = new Vector<String>(count);
        for (int i = 0; i < count; ++i)
            list.add(ArticleActivity.articleModel.attachmentNameAt(i));
        ArrayAdapter<Object> a = new ArrayAdapter<Object>(this, R.layout.simple_list_item_1, list.toArray());
        setListAdapter(a);
    }

    protected void onListItemClick(ListView l, View v, int position, long id)
    {
        super.onListItemClick(l, v, position, id);
        if (position >= ArticleActivity.articleModel.attachmentCount()) return;
        Intent i = new Intent(Intent.ACTION_VIEW,
                Uri.parse(ArticleActivity.articleModel.attachmentURLAt(position)));
        startActivity(i);
    }

}
