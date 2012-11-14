//
//  ofxiOSSoundPlayer.cpp
//  emptyExample
//
//  Created by Lukasz Karluk on 14/11/12.
//
//

#include "ofxiOSSoundPlayer.h"
#include "AVSoundPlayer.h"

AVSoundPlayer * soundPlayer;

ofxiOSSoundPlayer::ofxiOSSoundPlayer() {
    soundPlayer = nil;
}

ofxiOSSoundPlayer::~ofxiOSSoundPlayer() {
    unloadSound();
}

bool ofxiOSSoundPlayer::loadSound(string fileName, bool stream) {
    if(soundPlayer != nil) {
        unloadSound();
    }

    soundPlayer = [[AVSoundPlayer alloc] init];
    BOOL bOk = [soundPlayer loadWithFile:[NSString stringWithUTF8String:fileName.c_str()]];
    
    return bOk;
}

void ofxiOSSoundPlayer::unloadSound() {
    if(soundPlayer != nil) {
        [soundPlayer unloadSound];
        [soundPlayer release];
        soundPlayer = nil;
    }
}

void ofxiOSSoundPlayer::play() {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer play];
}

void ofxiOSSoundPlayer::stop() {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer stop:NO];
}

void ofxiOSSoundPlayer::setVolume(float value) {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer volume:value];
}

void ofxiOSSoundPlayer::setPan(float value) {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer pan:value];
}

void ofxiOSSoundPlayer::setSpeed(float value) {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer speed:value];
}

void ofxiOSSoundPlayer::setPaused(bool bPause) {
    if(soundPlayer == nil) {
        return;
    }
    if(bPause) {
        [soundPlayer pause];
    } else {
        [soundPlayer play];
    }
}

void ofxiOSSoundPlayer::setLoop(bool bLoop) {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer loop:bLoop];
}

void ofxiOSSoundPlayer::setMultiPlay(bool bMultiPlay) {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer multiPlay:bMultiPlay];
}

void ofxiOSSoundPlayer::setPosition(float position) {
    if(soundPlayer == nil) {
        return;
    }
    [soundPlayer position:position];
}

void ofxiOSSoundPlayer::setPositionMS(int positionMS) {
    if(soundPlayer == nil) {
        return;
    }
    float position = 100 / (float)positionMS;
    [soundPlayer position:position];
}

float ofxiOSSoundPlayer::getPosition() {
    if(soundPlayer == nil) {
        return 0;
    }
    return [soundPlayer position];
}

int ofxiOSSoundPlayer::getPositionMS() {
    if(soundPlayer == nil) {
        return 0;
    }
    float position = 100 * [soundPlayer position];
    return position;
}

bool ofxiOSSoundPlayer::getIsPlaying() {
    if(soundPlayer == nil) {
        return false;
    }
    return [soundPlayer isPlaying];
}

float ofxiOSSoundPlayer::getSpeed() {
    if(soundPlayer == nil) {
        return 0;
    }
    return [soundPlayer speed];
}

float ofxiOSSoundPlayer::getPan() {
    if(soundPlayer == nil) {
        return 0;
    }
    return [soundPlayer pan];
}

bool ofxiOSSoundPlayer::isLoaded() {
    if(soundPlayer == nil) {
        return false;
    }
    return [soundPlayer isLoaded];
}

float ofxiOSSoundPlayer::getVolume() {
    if(soundPlayer == nil) {
        return false;
    }
    return [soundPlayer volume];
}
