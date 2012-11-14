//
//  AVSoundPlayer.m
//
//  Created by lukasz karluk on 14/06/12.
//

#import "AVSoundPlayer.h"

@implementation AVSoundPlayer

@synthesize delegate;
@synthesize player;
@synthesize timer;

- (id)init {
    self = [super init];
    if(self) {
        //
    }
    return self;
}

- (void)dealloc {
    [self unloadSound];
    [super dealloc];
}

//----------------------------------------------------------- load / unload.
- (BOOL)loadWithFile:(NSString*)file {
    NSArray * fileSplit = [file componentsSeparatedByString:@"."];
    NSURL * fileURL = [[NSBundle mainBundle] URLForResource:[fileSplit objectAtIndex:0] 
                                              withExtension:[fileSplit objectAtIndex:1]];
	return [self loadWithURL:fileURL];
}

- (BOOL)loadWithPath:(NSString*)path {
    NSURL * fileURL = [NSURL fileURLWithPath:path];
	return [self loadWithURL:fileURL];
}

- (BOOL)loadWithURL:(NSURL*)url {
    NSError * error = nil;
    self.player = [[[AVAudioPlayer alloc] initWithContentsOfURL:url 
                                                          error:&error] autorelease];
    [self.player prepareToPlay];
    if(error) {
        if([self.delegate respondsToSelector:@selector(soundPlayerError:)]) {
            [self.delegate soundPlayerError:error];
        }
        return NO;
    }
    
    self.player.delegate = self;
    return YES;
}

- (void)unloadSound {
    [self stop:NO];
    self.player.delegate = nil;
    self.player = nil;
}

//----------------------------------------------------------- play / pause / stop.
- (void)play {
    BOOL bOk = [self.player play];
    if(bOk) {
        [self startTimer];
    }
}

- (void)pause {
    [self.player pause];
}

- (void)stop:(BOOL)fade {
    if (fade) {
        [self doVolumeFade];
    } else {
        [self.player stop];
    }
    [self stopTimer];
}

- (void)doVolumeFade {  
    if (self.player.volume > 0.1) {
        self.player.volume = self.player.volume - 0.1;
        [self performSelector:@selector(doVolumeFade) withObject:nil afterDelay:0.1];           
    } else {
        // Stop and get the sound ready for playing again
        [self.player stop];
        self.player.currentTime = 0;
        [self.player prepareToPlay];
        self.player.volume = 1.0;
    }
}

//----------------------------------------------------------- states.
- (BOOL)isLoaded {
    return NO;
}

- (BOOL)isPlaying {
    return NO;
}

//----------------------------------------------------------- properties.
- (void)volume:(float)value {
    //
}

- (float)volume {
    return 0;
}

- (void)pan:(float)value {
    //
}

- (float)pan {
    return 0;
}

- (void)speed:(float)value {
    //
}

- (float)speed {
    return 0;
}

- (void)loop:(BOOL)value {
    //
}

- (BOOL)loop {
    return NO;
}

- (void)multiPlay:(BOOL)value {
    //
}

- (BOOL)multiPlay {
    return NO;
}

- (void)position:(float)value {
    //
}

- (float)position {
    return 0;
}

//----------------------------------------------------------- timer.
- (void)updateTimer {
    if([self.delegate respondsToSelector:@selector(soundPlayerDidChange)]) {
        [self.delegate soundPlayerDidChange];
    }
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)startTimer {
    [self stopTimer];
	self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0
                                                  target:self 
                                                selector:@selector(updateTimer) 
                                                userInfo:nil 
                                                 repeats:YES];
}

//----------------------------------------------------------- audio player events.
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player 
                                 error:(NSError *)error {
    if([self.delegate respondsToSelector:@selector(soundPlayerError:)]) {
        [self.delegate soundPlayerError:error];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player 
                       successfully:(BOOL)flag {
    [self stopTimer];
    
    if([self.delegate respondsToSelector:@selector(soundPlayerDidFinish)]) {
        [self.delegate soundPlayerDidFinish];
    }
}

@end
