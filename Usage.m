#import "SoundEffectManager.h" //Also link against AudioToolbox.framework in project

//Playing a sound (chaches if not already chached)
[SoundEffectManager playSoundNamed:@"SoundEffect.aiff"];

//Preloading a sound (does NOT play it)
[SoundEffectManager preloadSoundNamed:@"MyOtherSoundEffect.aiff"];
