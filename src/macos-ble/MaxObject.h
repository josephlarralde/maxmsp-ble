#pragma once
#include "ext.h"
#include "ext_obex.h"
#include "z_dsp.h"
#include "buffer.h"
//------------------------------------------------------------------------------
typedef CFTypeRef MacosBleCentralRef;
typedef struct _MaxExternalObject
{
    t_pxobject x_obj;
    t_symbol*  x_arrayname;
    MacosBleCentralRef bleCentral;
    void*   list_outlet1;
    size_t  maxListSize;
    t_atom* outputList;
    long listSize;
    char listAllocSuccess;
} MaxExternalObject;

void onBleNotify(MaxExternalObject* maxObjectPtr, int output);
void onCharacteristicRead(MaxExternalObject* maxObjectPtr, const char* suuid, const char* cuuid, uint8_t* byteArray, size_t numBytes);
void onRSSIRead(MaxExternalObject* maxObjectPtr, const char* uuid, int rssi);
