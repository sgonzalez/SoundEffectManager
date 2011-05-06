//
//  SoundEffectManager.m
//
//  Copyright 2011 Hicaduda. All rights reserved.
//
/*
 
 hicaduda.com || http://github.com/sgonzalez/SoundEffectManager
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software in binary form, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "SoundEffectManager.h"

@implementation SoundEffectManager

static SystemSoundID GetSound( NSString *name ) {
    static NSMutableDictionary *sSoundIDs;
    NSNumber *soundIDObj = [sSoundIDs objectForKey: name];
    if( ! soundIDObj ) {
        NSLog(@"Loading sound '%@'",name);
        NSString *type = name.pathExtension;
        if( ! type.length )
            type = @"aiff";
        name = name.stringByDeletingPathExtension;
        
        NSString *path = [[NSBundle mainBundle] pathForResource: name
                                                         ofType: type];
        NSURL *url;
        if( path )
            url = [NSURL fileURLWithPath: path];
        else {
            NSLog(@"Couldn't find sound %@",name);
            return 0;
        }
        SystemSoundID soundID;
        if( AudioServicesCreateSystemSoundID((CFURLRef)url,&soundID) != noErr ) {
            NSLog(@"Couldn't load sound %@",url);
            return 0;
        }
        
        soundIDObj = [NSNumber numberWithUnsignedInt: soundID];
        if( ! sSoundIDs )
            sSoundIDs = [[NSMutableDictionary alloc] init];
        [sSoundIDs setObject: soundIDObj forKey: name];
    }
    return [soundIDObj unsignedIntValue];
}

+ (void)playSoundNamed:(NSString *)soundName {	
	AudioServicesPlaySystemSound( GetSound(soundName) );
}

+ (void)preloadSoundNamed:(NSString *)soundName {
	(void) GetSound(soundName);
}

+ (void)playVibrateSound {
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
