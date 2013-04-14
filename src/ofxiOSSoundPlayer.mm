//
//  ofxiOSSoundPlayer.cpp
//  emptyExample
//
//  Created by Lukasz Karluk on 14/11/12.
//
//

#include "ofxiOSSoundPlayer.h"
#import "AVSoundPlayer.h"

ofxiOSSoundPlayer::ofxiOSSoundPlayer() {
    soundPlayer = NULL;
}

ofxiOSSoundPlayer::~ofxiOSSoundPlayer() {
    unloadSound();
}

bool ofxiOSSoundPlayer::loadSound(string fileName, bool stream) {
    if(soundPlayer != NULL) {
        unloadSound();
    }

    string filePath = ofToDataPath(fileName);
    soundPlayer = [[AVSoundPlayer alloc] init];
    BOOL bOk = [(AVSoundPlayer *)soundPlayer loadWithPath:[NSString stringWithUTF8String:filePath.c_str()]];
    
    return bOk;
}

void ofxiOSSoundPlayer::unloadSound() {
    if(soundPlayer != NULL) {
        [(AVSoundPlayer *)soundPlayer unloadSound];
        [(AVSoundPlayer *)soundPlayer release];
        soundPlayer = NULL;
    }
}

void ofxiOSSoundPlayer::play() {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer play];
}

void ofxiOSSoundPlayer::stop() {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer stop];
}

void ofxiOSSoundPlayer::setVolume(float value) {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer volume:value];
}

void ofxiOSSoundPlayer::setPan(float value) {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer pan:value];
}

void ofxiOSSoundPlayer::setSpeed(float value) {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer speed:value];
}

void ofxiOSSoundPlayer::setPaused(bool bPause) {
    if(soundPlayer == NULL) {
        return;
    }
    if(bPause) {
        [(AVSoundPlayer *)soundPlayer pause];
    } else {
        [(AVSoundPlayer *)soundPlayer play];
    }
}

void ofxiOSSoundPlayer::setLoop(bool bLoop) {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer loop:bLoop];
}

void ofxiOSSoundPlayer::setMultiPlay(bool bMultiPlay) {
    ofLog(OF_LOG_NOTICE, "ofxiOSSoundPlayer::setMultiPlay() - multi play is not currently supported.");
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer multiPlay:bMultiPlay];
}

void ofxiOSSoundPlayer::setPosition(float position) {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer position:position];
}

void ofxiOSSoundPlayer::setPositionMS(int positionMS) {
    if(soundPlayer == NULL) {
        return;
    }
    [(AVSoundPlayer *)soundPlayer positionMs:positionMS];
}

float ofxiOSSoundPlayer::getPosition() {
    if(soundPlayer == NULL) {
        return 0;
    }
    return [(AVSoundPlayer *)soundPlayer position];
}

int ofxiOSSoundPlayer::getPositionMS() {
    if(soundPlayer == NULL) {
        return 0;
    }
    return [(AVSoundPlayer *)soundPlayer positionMs];
}

bool ofxiOSSoundPlayer::getIsPlaying() {
    if(soundPlayer == NULL) {
        return false;
    }
    return [(AVSoundPlayer *)soundPlayer isPlaying];
}

float ofxiOSSoundPlayer::getSpeed() {
    if(soundPlayer == NULL) {
        return 0;
    }
    return [(AVSoundPlayer *)soundPlayer speed];
}

float ofxiOSSoundPlayer::getPan() {
    if(soundPlayer == NULL) {
        return 0;
    }
    return [(AVSoundPlayer *)soundPlayer pan];
}

bool ofxiOSSoundPlayer::isLoaded() {
    if(soundPlayer == NULL) {
        return false;
    }
    return [(AVSoundPlayer *)soundPlayer isLoaded];
}

float ofxiOSSoundPlayer::getVolume() {
    if(soundPlayer == NULL) {
        return false;
    }
    return [(AVSoundPlayer *)soundPlayer volume];
}
