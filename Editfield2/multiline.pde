
import android.widget.FrameLayout;
import android.widget.RelativeLayout;
import android.widget.EditText;
import android.widget.ScrollView;
import android.graphics.Color;
import android.view.inputmethod.InputMethodManager;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.view.Gravity;
import android.R;
import processing.android.CompatUtils;

import android.util.TypedValue;
//import android.text.method.ScrollingMovementMethod;
import android.widget.Scroller;

EditText edit;
ScrollView scroller;

String txt;

/// Bonus:
///
/// Detect orientation change
///
/// needs 
///    <activity 
///       android:configChanges="keyboardHidden|orientation"
///       ...
/// in AppManifest.xml to work.
/// For APDE, use APKEditor to hack
/// assets/templates/AppManifest.xml.tmpl
/// Requires reinstall.
/// Back up temporary storage before uninstall!
/// Sketchbook contents are safe, settings are lost
///
int lastHeight; 

public void setup() {
  fullScreen();
  lastHeight=height;
  textSize(100);
  
  edit=createEdit(100);
  scroller=createScroll();
  addView(scroller, edit);
  addView(scroller);
  rerect();
}

void rerect() {
  setRect(scroller, width/4, height/6, width/2, height/3);
  // redraw???
  //scroller.invalidate(); // does nothing??
  show(scroller, false);
  show(scroller, true);
}

int turns=0;

void draw() {
  background(frameCount|0xfff0f000);
  
  if (lastHeight!=height) {
    turns++; 
    lastHeight=height;
    rerect();
  }
  
  txt = edit.getText().toString();
  fill(0);
  textAlign(LEFT, TOP);
  text(txt+"\nturns:"+turns, width/4, 100);
  
  if ("666".equals(txt)) {
    // bleh...must runonui
    show(scroller, false);
  };
  
  if ("777".equals(txt)) {
    // another @$$%# uithread shit
    
    txt=
    "Etaoin  Shrdlu!\n"+
    "MmmmmmM\n1234567890"+
    "ασδφγγηξξξ\n\n"+
    "-- 𐂂 --\nOk?\n Try 888...\n";
    setText(edit,txt,0);
    };
  if ("888".equals(txt)) {
    txt="shaders/LightVert.glsl";
    for(String l:loadStrings(txt)){
       txt+="\n"+l;
    };    
    setText(edit,txt,30);
  }
}

void setRect(ScrollView v, int x, int y, int w, int h) {

  v.getLayoutParams().width=w;
  v.getLayoutParams().height=h;
  v.setX(x); 
  v.setY(y);
}

final int Cwrap=RelativeLayout.LayoutParams.WRAP_CONTENT;
final int Cmatch=RelativeLayout.LayoutParams.MATCH_PARENT;

ScrollView createScroll() {
  ScrollView sv = new ScrollView(getContext());
  sv.setLayoutParams ( new RelativeLayout.LayoutParams(Cwrap, Cwrap));
  sv.setBackgroundColor(Color.GRAY); 
  return sv;
}

EditText createEdit(int ts) {
  EditText ed = new EditText(getContext());
  ed.setHint("Type 777!");
  ed.setTextColor(Color.rgb(0, 0, 0));
  ed.setHintTextColor(Color.rgb(170, 170, 170));    
  ed.setBackgroundColor(//0); // transparent
    Color.WHITE&0xeffafafa);
  // no background displays input line???

  ed.setTextSize(TypedValue.COMPLEX_UNIT_PX, ts);
  ed.setGravity(Gravity.START);
  ed.setPadding(0, 0, 0, 0);
  ed.setHorizontallyScrolling(true);
 // edit.setVerticalScrollBarEnabled(false);
  ed.setHorizontalScrollBarEnabled(true); //???
  ed.setInputType(
    android.text.InputType.TYPE_CLASS_TEXT
    | android.text.InputType. TYPE_TEXT_FLAG_MULTI_LINE
    ); // Multiple lines  
  return ed;
}


/* 
   ----- runOnUI  stuff ----+ 
   needed when manupulating ui outside
   of onXyz. 
   setup, draw, mousePressed....

*/

/*

new Handler(Looper.getMainLooper()).post(mYourUiThreadRunnable)
void runu(Method m) {
  getActivity().runOnUiThread(
    new Runnable() { 
    @Override
      public void run() {
    //  myrun();
        
        scroller.setScrollbarFadingEnabled(true);
    }
  }
  );
} 
*/

void addView(ScrollView to, View v) {
  final View vv=v;
  final ScrollView toto=to;

  getActivity().runOnUiThread(
    new Runnable() { 
    @Override
      public void run() {
      toto.addView(vv);
    }
  }
  );
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

void setText(EditText v,String t,int ts) {
  final EditText vv=v;
  final String tt=t;
  final int tsts=ts;
  v.post(
    new Runnable() { 
    @Override
      public void run() {   
      if(tsts!=0) vv.setTextSize(TypedValue.COMPLEX_UNIT_PX, tsts);
      if(tt!=null)vv.setText(tt);
    }
  }
  );
} 


void show(View v, boolean vis) {
  final View vv=v; 
  final boolean gg=vis;
  getActivity().runOnUiThread(
    new Runnable() { 
    @Override public void run() {
      if (gg)
        vv.setVisibility(View.VISIBLE);
      else
        vv.setVisibility(View.GONE);
    }
  }
  );
} 
