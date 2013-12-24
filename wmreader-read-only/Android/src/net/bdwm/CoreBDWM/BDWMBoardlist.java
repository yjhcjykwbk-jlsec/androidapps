package net.bdwm.CoreBDWM;

import android.content.SharedPreferences;
import net.bdwm.BoardlistActivity;

import java.util.Vector;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created on 11-10-12
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class BDWMBoardlist {

    Vector<String> v_board;
    Vector<String> v_name;

    public void loadString(String s)
    {
        v_board = new Vector<String>();
        v_name = new Vector<String>();

        Pattern p = Pattern.compile("<a href=\\\"bbstop.php.board=([^\\\"]*)\\\">([^<]*)</a>");
        Matcher m = p.matcher(s);
        while (m.find())
        {
            v_board.add(m.group(1));
            v_name.add(Helper.UnescapeHTML(m.group(2)));
        }

        SharedPreferences.Editor editor = BoardlistActivity.boardlistPref.edit();
        editor.clear();
        editor.putInt("total", v_board.size());
        for (int i = 0; i < v_board.size(); ++i)
        {
            editor.putString(String.format("board-%d", i), v_board.elementAt(i));
            editor.putString(String.format("name-%d", i), v_name.elementAt(i));
        }
        editor.commit();
    }

    public boolean load()
    {
        v_board = new Vector<String>();
        v_name = new Vector<String>();
        if (!BoardlistActivity.boardlistPref.contains("total"))
            return false;
        try
        {
            int count = BoardlistActivity.boardlistPref.getInt("total", 0);
            for (int i = 0; i < count; ++i)
            {
                v_board.add(BoardlistActivity.boardlistPref.getString(String.format("board-%d", i), "ERROR"));
                v_name.add(BoardlistActivity.boardlistPref.getString(String.format("name-%d", i), "出错了"));
            }
        }
        catch (Throwable t)
        {
            return false;
        }
        return true;
    }

    public int count()
    {
        return v_board.size();
    }

    public String boardAt(int i)
    {
        return v_board.elementAt(i);
    }

    public String nameAt(int i)
    {
        return v_name.elementAt(i);
    }

}
