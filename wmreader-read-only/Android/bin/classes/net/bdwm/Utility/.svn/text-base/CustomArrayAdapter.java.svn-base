package net.bdwm.Utility;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Filter;
import android.widget.Filterable;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * Created on 11-10-12
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public
class CustomArrayAdapter extends BaseAdapter implements Filterable {

    List<Object> objects;
    final Object lock_var = new Object();
    ArrayList<Object> org_values;
    ArrayFilter filter;
    LayoutInflater inflator;

    public CustomArrayAdapter(Context context, Object[] objects)
    {
        inflator = (LayoutInflater)context.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
        this.objects = Arrays.asList(objects);
    }

    public int getCount()
    {
        return objects.size();
    }

    public Object getItem(int position)
    {
        return objects.get(position);
    }

    public long getItemId(int position)
    {
        return position;
    }

    public int getItemOriginalPosition(int position)
    {
        if (org_values == null) return position;
        return org_values.indexOf(objects.get(position));
    }

    public View getView(int position, View convertView, ViewGroup parent)
    {
        View view;
        TextView text;
        if (convertView == null)
            view = inflator.inflate(android.R.layout.simple_list_item_1, parent, false);
        else
            view = convertView;
        text = (TextView) view;
        text.setText(getItem(position).toString());
        return view;
    }

    public Filter getFilter()
    {
        if (filter == null) filter = new ArrayFilter();
        return filter;
    }

    class ArrayFilter extends Filter
    {

        protected FilterResults performFiltering(CharSequence target) {
            FilterResults results = new FilterResults();
            if (org_values == null) {
                synchronized (lock_var)
                {
                    org_values = new ArrayList<Object>(objects);
                }
            }
            if (target == null || target.length() == 0)
            {
                synchronized (lock_var)
                {
                    ArrayList<Object> list = new ArrayList<Object>(org_values);
                    results.values = list;
                    results.count = list.size();
                }
            }
            else
            {
                String targetString = target.toString().toLowerCase();
                final ArrayList<Object> values = org_values;
                final int count = values.size();
                final ArrayList<String> newValues = new ArrayList<String>(count);
                for (int i = 0; i < count; ++i)
                {
                    final String value = values.get(i).toString();
                    final String valueText = value.toLowerCase();
                    if (valueText.contains(targetString)) newValues.add(value);
                }
                results.values = newValues;
                results.count = newValues.size();
            }

            return results;
        }

        @SuppressWarnings("unchecked")
        protected void publishResults(CharSequence constraint, FilterResults results)
        {
            objects = (List<Object>)results.values;
            if (results.count > 0)  notifyDataSetChanged();
            else notifyDataSetInvalidated();
        }

    }
}
