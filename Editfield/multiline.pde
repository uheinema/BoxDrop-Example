import android.os.Bundle;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.*;
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.widget.EditText;
import android.text.Editable;
import android.graphics.Color;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.view.View.OnKeyListener;
import android.view.View;
import android.view.KeyEvent;
import android.view.View.OnClickListener;
import android.view.ViewGroup.LayoutParams;
import android.view.Gravity;
import android.R;
import processing.android.CompatUtils;

import android.util.TypedValue;
import android.text.method.ScrollingMovementMethod;

EditText edit;
// int editId;

String txt;

public void setup() {
  fullScreen();
  textSize(100);
  edit=createEdit(100, 
    width/4, height/6, 
    width/2, height/3);
  addView(edit);
}

void draw() {
  background(frameCount|0xfff0f000);
  txt = edit.getText().toString();
  fill(0);
  text(txt, 50, 100);
  if ("666".equals(txt)) {
    // bleh...must runonui
    show(edit, false);
  };
  if ("777".equals(txt)) {
    edit.getText().clear();
  }
  //edit.scrollTo(0,frameCount);
  // edit.setX(100+frameCount%200);
}


EditText createEdit(int ts, int x, int y, int w, int h) { // x,y,bla,...
  EditText edit = new EditText(getContext());
  edit.setLayoutParams (new RelativeLayout.LayoutParams (RelativeLayout.LayoutParams.WRAP_CONTENT, RelativeLayout.LayoutParams.WRAP_CONTENT));
  edit.setHint("Write Here!");
  edit.setTextColor(Color.rgb(0, 0, 0));
  edit.setTextSize(TypedValue.COMPLEX_UNIT_PX, ts);
  edit.setHintTextColor(Color.rgb(170, 170, 170));  
  edit.setBackgroundColor(//0); // transparent
    Color.WHITE);      // edit.getBackground().setAlpha(255);  
  // no background displays input line???
  edit.getLayoutParams().width=w;
  edit.getLayoutParams().height=h;
  edit.setX(x); 
  edit.setY(y); 
  
  edit.setTextSize(TypedValue.COMPLEX_UNIT_PX, ts);
  edit.setGravity(Gravity.START);
   
  //edit.setMovementMethod(new ScrollingMovementMethod()); // no effect?
  edit.setVerticalScrollBarEnabled(true);
  edit.setHorizontalScrollBarEnabled(true);
  // edit.requestFocus(); // we are not even shown?
  // all these have almost no(?) effect...
  edit.setInputType(
   android.text.InputType.TYPE_CLASS_TEXT
  //  | android.text.InputType. TYPE_TEXT_FLAG_NO_SUGGESTIONS
  // |   android.text.InputType. TYPE_TEXT_VARIATION_LONG_MESSAGE
    | android.text.InputType. TYPE_TEXT_FLAG_MULTI_LINE); // Multiple lines 
  //edit.setInputType(android.text.InputType.TYPE_CLASS_TEXT);  // Single line
  //editId = CompatUtils.getUniqueViewId();
  // edit.setId(editId);
  edit.setOnKeyListener( // useless, only gets ctrl keys
    new View.OnKeyListener() {
    @ Override
      public boolean onKey(View v, int keyCode, KeyEvent event) {
      println("keycode: "+keyCode);
      if (event.getAction() == KeyEvent.ACTION_DOWN && event.getKeyCode()== KeyEvent.KEYCODE_ENTER) { 
        //  return true; // make edit ignore cr or trigget action
      }
      return false;
    }
  }
  );
  return edit;
}


void addView(View v) {
  final View vv=v;
  final FrameLayout fl = (FrameLayout)getActivity().findViewById(R.id.content);
  getActivity().runOnUiThread(
    new Runnable() { 
    @Override
      public void run() {
      fl.addView(vv);
    }
  }
  );
} 


void show(View v, boolean vis) {
  final View vv=v; 
  final boolean gg=vis;
  getActivity().runOnUiThread(
    new Runnable() { 
    @Override
      public void run() {
      if (gg)
      vv.setVisibility(View.VISIBLE);
      else
        vv.setVisibility(View.GONE);
    }
  }
  );
} 



