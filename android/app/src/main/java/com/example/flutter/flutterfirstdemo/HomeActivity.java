package com.example.flutter.flutterfirstdemo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.LinearLayout;


public class HomeActivity extends Activity implements View.OnClickListener {

    private LinearLayout mContent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);
        findViewById(R.id.btn_switch).setOnClickListener(this);
        findViewById(R.id.add_flutter).setOnClickListener(this);
        findViewById(R.id.btn_login).setOnClickListener(this);
        mContent = findViewById(R.id.ll_content);
    }

    @Override
    public void onClick(View v) {
        int i = v.getId();
        if (i == R.id.btn_switch) {
            Intent intent = new Intent(this, MainActivity.class);
            intent.setAction("android.intent.action.RUN");
            intent.putExtra("route", "main");
            startActivity(intent);

        } else if (i == R.id.add_flutter) {//                View flutterView = Flutter.createView(
//                        HomeActivity.this,
//                        getLifecycle(),
//                        "route1"
//                );
//                mContent.addView(flutterView);

        } else if (i == R.id.btn_login) {
        } else {
        }
    }
}
