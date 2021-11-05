/*
 * FOURJS_START_COPYRIGHT(P,2013)
 * Property of Four Js*
 * (c) Copyright Four Js 2013, 2021. All Rights Reserved.
 * * Trademark of Four Js Development Tools Europe Ltd
 *   in the United States and elsewhere
 * FOURJS_END_COPYRIGHT
 */

package com.gma.extension.core;

import android.app.AlertDialog;
import android.content.Intent;
import android.os.Bundle;

import com.fourjs.gma.extension.v1.IFunctionCall;
import com.fourjs.gma.extension.v1.IFunctionCallController;

public class MyCustomFunctionCall implements IFunctionCall
{
    private IFunctionCallController mFunctionCallController;

    @Override
    public void setFunctionCallController(IFunctionCallController iFunctionCallController) {
        mFunctionCallController = iFunctionCallController;
    }

    @Override
    public void invoke(Object[] objects) throws IllegalArgumentException {
        AlertDialog.Builder builder = new AlertDialog.Builder(mFunctionCallController.getCurrentActivity());
        builder.setTitle(getClass().getSimpleName());
        builder.setMessage(String.valueOf(objects[0]));

        AlertDialog dialog = builder.create();
        dialog.show();
    }

    @Override
    public void onSaveInstanceState(Bundle bundle) {
    }

    @Override
    public void onRestoreInstanceState(Bundle bundle) {
    }

    @Deprecated
    @Override
    public void onActivityResult(int requestCode, Intent intent) {
    }

    @Override
    public void onActivityResult(int requestCode, int resultCode, Intent intent) {
    }
}
