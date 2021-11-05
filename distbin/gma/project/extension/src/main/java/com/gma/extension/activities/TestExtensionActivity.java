/*
 * FOURJS_START_COPYRIGHT(P,2013)
 * Property of Four Js*
 * (c) Copyright Four Js 2013, 2021. All Rights Reserved.
 * * Trademark of Four Js Development Tools Europe Ltd
 *   in the United States and elsewhere
 * FOURJS_END_COPYRIGHT
 */
package com.gma.extension.activities;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.TextView;

import com.fourjs.gma.extension.v1.ApplicationState;
import com.fourjs.gma.extension.v1.IClientHandler;
import com.fourjs.gma.extension.v1.IFunctionCall;
import com.fourjs.gma.extension.v1.IFunctionCallController;
import com.fourjs.gma.extension.v1.OnApplicationStateChangedListener;
import com.gma.extension.R;
import com.gma.extension.core.MyCustomFunctionCall;

public class TestExtensionActivity extends Activity implements IFunctionCallController
{
    private OnApplicationStateChangedListener mOnApplicationStateChangedListener;
    private IClientHandler mClientHandler = new IClientHandler() {
        @Override
        public void postDialogAction(String action) {
            log("Execute action '" + action + "'");
        }

        @Override
        public boolean isDialogActionPending(String action) {
            log("Check if action '" + action + "' is pending");

            return false;
        }

        @Override
        public boolean cancelDialogAction(String action) {
            log("Cancel action '" + action + "'");

            return false;
        }

        @Override
        public void setOnApplicationStateChangedListener(OnApplicationStateChangedListener onApplicationStateChanged) {
            mOnApplicationStateChangedListener = onApplicationStateChanged;
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.test_activity);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.test, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        int i = item.getItemId();
        if (i == R.id.run_function_call) {
            // Instantiate here your custom function call
            // implementing IFunctionCall interface

            IFunctionCall call = new MyCustomFunctionCall();
            call.setFunctionCallController(this);
            call.invoke(new Object[] { "Hello World!" });

            return true;
        } else if (i == R.id.run_activity) {
            // Create here the intent to start your custom activity

            /*
               Intent intent = new Intent(this, MyCustomActivity.class);
               startActivity(intent);
             */

            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    /**
     * Log message
     * @param msg String
     */
    public void log(String msg) {
        TextView tv = (TextView) findViewById(R.id.test_activity_text_view);
        tv.setText(tv.getText() + "\n" + msg);
    }

    // IFunctionCallController implementation for test

    private IFunctionCall mPendingCall = null;

    @Override
    public void returnValues(IFunctionCall functionCall, Object ... objects) {
        String msg = "";
        for (Object o : objects) {
            if (!msg.isEmpty()) {
                msg += ", ";
            }

            msg += o.toString();
        }

        log(msg);
    }

    @Override
    public void raiseError(IFunctionCall functionCall, String s) {
        log(s);
    }

    @Override
    public void startActivity(IFunctionCall functionCall, Intent intent) {
        startActivity(intent);
    }

    @Deprecated
    @Override
    public void startActivityForResult(IFunctionCall functionCall, Intent intent) {
        startActivityForResult(functionCall, intent, 0);
    }

    @Override
    public void startActivityForResult(IFunctionCall functionCall, Intent intent, int requestCode) {
        mPendingCall = functionCall;
        startActivityForResult(intent, requestCode);
    }

    @Override
    public Activity getCurrentActivity() {
        return this;
    }

    @Override
    public IClientHandler getClientHandler() {
        return mClientHandler;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (mPendingCall != null) {
            mPendingCall.onActivityResult(resultCode, resultCode, data);
        }
    }

    @Override
    public void onResume() {
        super.onResume();

        log("onResume");

        if (mOnApplicationStateChangedListener != null) {
            mOnApplicationStateChangedListener.stateChanged(ApplicationState.RESUME);
        }
    }

    @Override
    public void onStop() {
        super.onStop();

        log("onStop");

        if (mOnApplicationStateChangedListener != null) {
            mOnApplicationStateChangedListener.stateChanged(ApplicationState.STOP);
        }
    }

    @Override
    public void onPause() {
        super.onPause();

        log("onPause");

        if (mOnApplicationStateChangedListener != null) {
            mOnApplicationStateChangedListener.stateChanged(ApplicationState.PAUSE);
        }
    }
}
