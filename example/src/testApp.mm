#include "testApp.h"

//--------------------------------------------------------------
void testApp::setup(){
    
    ofBackground(255);
	ofxiPhoneSetOrientation(OFXIPHONE_ORIENTATION_LANDSCAPE_RIGHT);
	
	synth.loadSound("sounds/synth.caf");
    synth.setVolume(0.75f);
    synth.setMultiPlay(true);
    
	beats.loadSound("sounds/1085.caf");
    beats.setVolume(0.75f);
    beats.setMultiPlay(false);
    
	vocals.loadSound("sounds/Violet.caf");
	vocals.setVolume(0.5f);
	vocals.setMultiPlay(true);
    
    font.loadFont("fonts/Sudbury_Basin_3D.ttf", 18);
}

//--------------------------------------------------------------
void testApp::update(){
	//
}

//--------------------------------------------------------------
void testApp::draw(){
    
	char tempStr[255];
	
	// draw the background colors:
	float widthDiv = ofGetWidth() / 3.0f;
	ofSetHexColor(0xeeeeee);
	ofRect(0,0,widthDiv,ofGetHeight());
	ofSetHexColor(0xffffff);
	ofRect(widthDiv,0,widthDiv,ofGetHeight());
	ofSetHexColor(0xdddddd);
	ofRect(widthDiv*2,0,widthDiv,ofGetHeight());
    
	//---------------------------------- synth:
	if (synth.getIsPlaying()) ofSetHexColor(0xFF0000);
	else ofSetHexColor(0x000000);
	font.drawString("synth !!", 10,50);
	
	ofSetHexColor(0x000000);
	sprintf(tempStr, "click to play\npct done: %f\nspeed: %f\npan: %f", synth.getPosition(),  synth.getSpeed(), synth.getPan());
	ofDrawBitmapString(tempStr, 10,ofGetHeight()-50);
    
	//---------------------------------- beats:
	if (beats.getIsPlaying()) ofSetHexColor(0xFF0000);
	else ofSetHexColor(0x000000);
	font.drawString("beats !!", widthDiv+10,50);
    
	ofSetHexColor(0x000000);
	sprintf(tempStr, "click and drag\npct done: %f\nspeed: %f", beats.getPosition(),  beats.getSpeed());
	ofDrawBitmapString(tempStr, widthDiv+10,ofGetHeight()-50);
    
	//---------------------------------- vocals:
	if (vocals.getIsPlaying()) ofSetHexColor(0xFF0000);
	else ofSetHexColor(0x000000);
	font.drawString("vocals !!", widthDiv*2+10,50);
    
	ofSetHexColor(0x000000);
	sprintf(tempStr, "click to play (multiplay)\npct done: %f\nspeed: %f", vocals.getPosition(),  vocals.getSpeed());
	ofDrawBitmapString(tempStr, widthDiv*2+10,ofGetHeight()-50);
    
}

//--------------------------------------------------------------
void testApp::exit(){
    
}

//--------------------------------------------------------------
void testApp::touchDown(ofTouchEventArgs & touch){
	if( touch.id == 0 ){
		
        float widthStep = ofGetWidth() / 3.0f;
        float pan = 0;
        float speed = 1;
        
		if (touch.x < widthStep){
            pan = touch.x / widthStep;
            speed = 0.1f + ((float)(ofGetHeight() - touch.y) / (float)ofGetHeight()) * 2;
			synth.play();
			synth.setSpeed(speed);
			synth.setPan(pan);
		} else if (touch.x >= widthStep && touch.x < widthStep*2){
			beats.play();
		} else {
			vocals.play();
			vocals.setSpeed( 0.1f + ((float)(ofGetHeight() - touch.y) / (float)ofGetHeight())*3);
			vocals.setPan((float)touch.x / (float)ofGetWidth());
		}
	}
}

//--------------------------------------------------------------
void testApp::touchMoved(ofTouchEventArgs & touch){
	if( touch.id == 0 ){
		// continuously control the speed of the beat sample via drag,
		// when in the "beat" region:
		float widthStep = ofGetWidth() / 3.0f;
		if (touch.x >= widthStep && touch.x < widthStep*2){
			beats.setSpeed( 0.5f + ((float)(ofGetHeight() - touch.y) / (float)ofGetHeight())*1.0f);
		}
	}
}

//--------------------------------------------------------------
void testApp::touchUp(ofTouchEventArgs & touch){
	
}

//--------------------------------------------------------------
void testApp::touchDoubleTap(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void testApp::lostFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotFocus(){
    
}

//--------------------------------------------------------------
void testApp::gotMemoryWarning(){
    
}

//--------------------------------------------------------------
void testApp::deviceOrientationChanged(int newOrientation){
    
}
