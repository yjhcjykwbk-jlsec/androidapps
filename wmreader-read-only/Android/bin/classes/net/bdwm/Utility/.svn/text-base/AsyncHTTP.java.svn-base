package net.bdwm.Utility;

import android.os.AsyncTask;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.CoreProtocolPNames;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.util.EntityUtils;

/**
 * Created on 11-10-11
 * This file is part of WMReader project.
 * http://wmreader.googlecode.com/
 * Copyright 2011 Yuan Pengfei. All rights reserved.
 */
public class AsyncHTTP {

    AsyncHTTPDelegate delegate;
    String url;
    int timeout;

    enum AsyncHTTPStatus { Ready, Finished, Failed };
    AsyncHTTPStatus status;

    AsyncHTTP self;

    public String content;

    public AsyncHTTP(String url, AsyncHTTPDelegate delegate, int timeout)
    {
        this.delegate = delegate;
        this.url = url;
        this.timeout = timeout;
        status = AsyncHTTPStatus.Ready;
        self = this;
    }

    public void startAsync()
    {
        ATask t = new ATask();
        t.execute(null, null);
    }

    class ATask extends AsyncTask<Void, Void, Void> {

        protected Void doInBackground(Void... voids)
        {
            HttpResponse response = null;
            try
            {
                HttpParams params = new BasicHttpParams();
                HttpConnectionParams.setConnectionTimeout(params, timeout * 1000);
                HttpConnectionParams.setSoTimeout(params, timeout * 1000);
                params.setParameter(CoreProtocolPNames.USER_AGENT, "WMReader-Android/0.3");
                HttpClient client = new DefaultHttpClient(params);
                HttpGet request = new HttpGet(url);
                response = client.execute(request);
                if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK)
                    status = AsyncHTTPStatus.Finished;
                else
                    status = AsyncHTTPStatus.Failed;
            }
            catch (Throwable t)
            {
                status = AsyncHTTPStatus.Failed;
            }
            if (status != AsyncHTTPStatus.Finished) return null;
            try
            {
                content = EntityUtils.toString(response.getEntity(), "GBK");
            }
            catch (Throwable t)
            {
                content = "";
            }
            return null;
        }

        protected void onPostExecute(Void v)
        {
            if (status == AsyncHTTPStatus.Finished)
            {
                delegate.asyncHTTPFinished(self);
                return;
            }
            delegate.asyncHTTPFailed(self);
        }

    }

}
