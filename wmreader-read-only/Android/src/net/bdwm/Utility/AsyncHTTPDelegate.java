package net.bdwm.Utility;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public interface AsyncHTTPDelegate {
    public void asyncHTTPFinished(AsyncHTTP request);
    public void asyncHTTPFailed(AsyncHTTP request);
}
