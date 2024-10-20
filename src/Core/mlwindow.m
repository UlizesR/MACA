#import "Core/mlwindow.h"

#import <objc/runtime.h>
#import <Cocoa/Cocoa.h>

@interface ML_APP_DELEGATE : NSObject <NSApplicationDelegate>
@end

@implementation ML_APP_DELEGATE

- (instancetype)initWithApp:(NSApplication *)app
{
    self = [super init];
    if (self)
    {
        [app setDelegate:self];
        [app setActivationPolicy:NSApplicationActivationPolicyRegular];
        [app activateIgnoringOtherApps:YES];
        [app finishLaunching];
    }
    return self;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification
{
    [NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)notification
{
    [NSApp setActivationPolicy:NSApplicationActivationPolicyProhibited];
}

@end 

@inrerface ML_WINDOW_DELEGATE : NSObject <NSWindowDelegate>
@end

@implementation ML_WINDOW_DELEGATE
@end

// set MLWindow struct
struct MLWindow
{
    const char *title;
    uint16_t width;
    uint16_t height;
    id *_nswindow;
};

MLWindow *MLWindowCreate(const char *title, const uint16_t width, const uint16_t height)
{
    // initialize NSApplication
    NSApplication *app = [NSApplication sharedApplication];
    if(!app)
    {
        NSLog(@"Failed to initialize NSApplication");
        return NULL;
    }
    app.delegate = [[ML_APP_DELEGATE alloc] initWithApp:app];

    MLWindow *window = malloc(sizeof(MLWindow));
    if (!window)
    {
        NSLog(@"Failed to allocate memory for MLWindow");
        return NULL;
    }
    window->title = title;
    window->width = width;
    window->height = height;

    NSRect frame = NSMakeRect(0, 0, width, height);
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable;
    NSWindow *nsWindow = [
                          [NSWindow alloc] initWithContentRect:frame 
                                                     styleMask:style 
                                                       backing:NSBackingStoreBuffered 
                                                         defer:NO
    ];
    [nsWindow setTitle:[NSString stringWithUTF8String:title]];
    [nsWindow makeKeyAndOrderFront:nil];
    [nsWindow center];
    [nsWindow setDelegate:[[ML_WINDOW_DELEGATE alloc] init]];
    window->_nswindow = nsWindow;
    return window;
}

void MLWindowClose(MLWindow *window)
{
    if(!window) return;
    [window->nsWindow close];
}

bool MLWindowShouldClose(MLWindow *window)
{
    if(!window) return false;
    return [window->_nswindow isVisible] || [window->_nswindow isMiniaturized];
}

void MLWindowDestroy(MLWindow *window)
{
    if(!window) return;
    NSApplication *app = [NSApplication sharedApplication];
    [app stop:app];
    [app setDelegate:nil];
    [app release];
    if(window->_nswindow) [window->_nswindow release];
    free(window);
}
