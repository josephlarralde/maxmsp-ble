/*
  C Bridge for CoreBluetooth Central on macOS
 
 Bridging techinque by Rob Napier. https://github.com/rnapier
 */
#pragma once
#import <CoreFoundation/CoreFoundation.h>
#include <objc/runtime.h>
#include "../MaxObject.h"
#ifdef __OBJC__
#import "MacosBleCentral.h"
#endif

//typedef CFTypeRef MacosBleCentralRef;
//MacosBleCentralRef MacosBleCentralRefCreate(void);
typedef const void MacosBleCentralC; // 'const void *' is more CF-like, but either is fine
MacosBleCentralC* newBleCentralC(void);
void bleCentralCScan            (MacosBleCentralC *t);
void bleCentralCStopScan        (MacosBleCentralC *t);
void bleCentralCScanFor         (MacosBleCentralC *t, const char* name);
void bleCentralCRelease         (MacosBleCentralC *t);
int  bleCentralCGetLatestValue  (MacosBleCentralC *t);
void bleCentralCSetMaxObjRef    (MacosBleCentralC *t, MaxExternalObject* maxObjRef);
void bleCentralCGetDeviceList   (MacosBleCentralC *t);
 
