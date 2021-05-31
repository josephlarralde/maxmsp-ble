//------------------------------------------------------------------------------
#import "MacosBleCentral.h"
//------------------------------------------------------------------------------
@implementation MacosBleCentral
//------------------------------------------------------------------------------
@synthesize discoveredPeripherals;
//------------------------------------------------------------------------------
- (instancetype)init
{
    _shouldConnect = NO;
    _scanType = NO;
    dispatch_queue_t newQueue = dispatch_queue_create("max_masp_ble",  DISPATCH_QUEUE_SERIAL);
    return [self initWithQueue:newQueue];
}
//------------------------------------------------------------------------------
- (instancetype)initWithQueue: (dispatch_queue_t) centralDelegateQueue
{
    return [self initWithQueue: centralDelegateQueue
                 serviceToScan: nil
          characteristicToRead: [CBUUID UUIDWithString:@"B81672D5-396B-4803-82C2-029D34319015"]];
}
//------------------------------------------------------------------------------
- (instancetype)initWithQueue: (dispatch_queue_t) centralDelegateQueue
                serviceToScan: (CBUUID *) scanServiceId
         characteristicToRead: (CBUUID *) characteristicId
{
    self = [super init];
    if (self)
    {
        post("Start BLE\n");
        self.discoveredPeripherals = [NSMutableArray array];
        _latestValue = 0;
        _bleQueue = centralDelegateQueue;
        serviceUuid = scanServiceId;
        characteristicUuid = characteristicId;
        _manager = [[CBCentralManager alloc] initWithDelegate: self
                                                        queue: _bleQueue];
    }
    return self;
}

//------------------------------------------------------------------------------
#pragma mark Manager Methods

- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)aPeripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI
{
    NSData* manuData = advertisementData[CBAdvertisementDataManufacturerDataKey];
    
    if(manuData)
    {
        if (![discoveredPeripherals containsObject: advertisementData[CBAdvertisementDataManufacturerDataKey]])
        {
            post("------------------------");
            post("Name: %s ", [[aPeripheral name] UTF8String]);
            post("RSSI: %s", [RSSI.description UTF8String]);
            post("Manu Data: %s", [manuData.description UTF8String]);
            [discoveredPeripherals addObject:manuData];
        }
    }
    
    if (_shouldConnect)
    {
        if (_scanType)
        {
            if (manuData == discoveredPeripherals[_connectDeviceIndex])
            {
                post("Connecting\n");
                _peripheral = aPeripheral;
                [_manager connectPeripheral: aPeripheral options:nil];
                [_manager stopScan];
            }
        }
        else
        {
            if ([[aPeripheral name] isEqualToString: _deviceName])
            {
                post("Connecting\n");
                _peripheral = aPeripheral;
                [_manager connectPeripheral:aPeripheral options:nil];
                [_manager stopScan];
            }
        }
    }
    
}

//------------------------------------------------------------------------------
- (void) centralManager: (CBCentralManager *)central
   didConnectPeripheral: (CBPeripheral *)aPeripheral
{
    post("Connected\n");
    [aPeripheral setDelegate:self];
    [aPeripheral discoverServices:nil];
}
//------------------------------------------------------------------------------
- (void)centralManagerDidUpdateState:(CBCentralManager *)manager
{
    post("State Update");
    
    if ([manager state] == CBCentralManagerStatePoweredOn)
    {
        //        [self startScan];
    }
}
//------------------------------------------------------------------------------
// Invoked whenever an existing connection with the peripheral is torn down.
- (void) centralManager: (CBCentralManager *)central
didDisconnectPeripheral: (CBPeripheral *)aPeripheral
                  error: (NSError *)error
{
    post("didDisconnectPeripheral\n");
    [self startScan];
}
//------------------------------------------------------------------------------
// Invoked whenever the central manager fails to create a connection with the peripheral.
- (void) centralManager: (CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)aPeripheral
                  error:(NSError *)error
{
    post("didFailToConnectPeripheral\n");
    NSLog(@"Fail to connect to peripheral: %@ with error = %@", aPeripheral, [error localizedDescription]);
}

- (void) scan;
{
    [self startScan];
}


- (void) stop;
{
    _shouldConnect = NO;
    [_manager stopScan];
}
//------------------------------------------------------------------------------
- (void) scanForDeviceWithName:(NSString *) name
{
    post("Search for %s", [name UTF8String]);
    _deviceName = name;
    _shouldConnect = YES;
    _scanType = NO;
}

- (void) scanForDeviceWithManuData:(NSData *) data
{
    post("Search for %s", [data.description UTF8String]);
    _connectDeviceIndex = [self.discoveredPeripherals indexOfObject:data];
    if(_connectDeviceIndex != NSNotFound)
    {
        [self startScan];
        _shouldConnect = YES;
        _scanType = YES;
    }
    
}

- (void) startScan
{
    post("Start scanning\n");
    [_manager scanForPeripheralsWithServices: nil
                                     options: nil];
}
//------------------------------------------------------------------------------
#pragma mark Peripheral Methods

- (void) peripheral: (CBPeripheral *)peripheral
didDiscoverIncludedServicesForService:(CBService *)service
              error:(NSError *)error
{
    post("didDiscoverIncludedServicesForService");
}
//------------------------------------------------------------------------------
// Invoked upon completion of a -[discoverServices:] request.
// Discover available characteristics on interested services
- (void) peripheral: (CBPeripheral *)aPeripheral
didDiscoverServices: (NSError *)error
{
    post("didDiscoverServices\n");
    for (CBService *aService in aPeripheral.services)
    {
        post("Service %s\n", [[[aService UUID] UUIDString] cStringUsingEncoding:NSASCIIStringEncoding]);
        [aPeripheral discoverCharacteristics: nil
                                  forService: aService];
    }
}
//------------------------------------------------------------------------------
// Invoked upon completion of a -[discoverCharacteristics:forService:] request.
// Perform appropriate operations on interested characteristics
- (void) peripheral: (CBPeripheral *)aPeripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    post("didDiscoverCharacteristicsForService\n");
    for (CBCharacteristic *aChar in service.characteristics)
    {
        if ([aChar.UUID isEqual: characteristicUuid])
        {
            post("start notifying\n");
            [aPeripheral setNotifyValue:YES forCharacteristic:aChar];
        }
        if (aChar.properties & CBCharacteristicPropertyRead)
        {
            post("Char UUID: %s\n",[aChar.UUID.UUIDString cStringUsingEncoding:NSASCIIStringEncoding]);
        }
    }
}
//------------------------------------------------------------------------------
- (void) peripheral:(CBPeripheral *)peripheral
didUpdateValueForDescriptor:(CBDescriptor *)descriptor
              error:(NSError *)error
{
    post("didUpdateValueForDescriptor\n");
}
//------------------------------------------------------------------------------
// Invoked upon completion of a -[readValueForCharacteristic:] request or on the reception of a notification/indication.
- (void) peripheral: (CBPeripheral *)aPeripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    _latestValue = *(int*)characteristic.value.bytes;
    onBleNotify(maxObjectRef, _latestValue);
}
//------------------------------------------------------------------------------
- (void) peripheral: (CBPeripheral *)peripheral didDiscoverDescriptorsForCharacteristic:(CBDescriptor *)descriptor error:(NSError *)error
{
    post("didDiscoverDescriptorsForCharacteristic");
}
//------------------------------------------------------------------------------
- (void)peripheral: (CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    post("didUpdateNotificationStateForCharacteristic");
}
//------------------------------------------------------------------------------
- (void)peripheral: (CBPeripheral *)peripheral didModifyServices:(NSArray<CBService *> *)invalidatedServices
{
    post("Service Modified\n");
    [_manager cancelPeripheralConnection:peripheral];
    //    [self startScan];
}
//------------------------------------------------------------------------------
- (void)setMaxObjectRef: (MaxExternalObject *) extMaxObjectRef
{
    maxObjectRef = extMaxObjectRef;
}

- (void)getFoundDeviceList
{    
    for(NSData* manuData in discoveredPeripherals)
    {
        post("%s\n", [[manuData description] UTF8String]);
    }
}
@end