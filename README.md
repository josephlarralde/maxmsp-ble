# MaxMSP BLE

A BLE Object for Max

## Install

- Add [the `.mxo`](https://github.com/mhamilt/maxmsp-ble/releases/download/0.1.0-alpha/max-ble.mxo.zip) to `~/Documents/Max 8/Library` or define your own folder and add it to the [Search Path](https://docs.cycling74.com/max8/vignettes/search_path)

**OR**

- Add [the package folder](https://github.com/mhamilt/maxmsp-ble/releases/download/0.1.3-alpha/max-ble.zip) to `~/Documents/Max 8/Packages`
- 
### Usage

- Send a `scan` message to the object to find available devices.
- Found Devices will be printed to the Max Console Window
- Details logged about a device will include an index.
- send a `connect $1` message to the object, where `$1` is the index of a found device.
- Details of what services and charateristics the device has will be printed to the Max Window
- Available data will be sent out the inlet in `list` form `SERVICE_UUID CHARACTERISTIC_UUID RAW_BYTE_LIST`
- Use a pair of `route` objects to filter which Service / Characteristic pair you need.
- `RAW_BYTE_LIST` can then be assmebled into the original data format.

### Example

Copy and paste the below example into Max:

<pre><code>
----------begin_max5_patcher----------
1162.3ocyYtzaaiCD.9r8uBBg8nqgnnd481l1r.KP1S6lSKJJXjYhUgLo.Ic
hcK5+8czP4XGWpTKmDEewNhhly7w4IY993QA2nVKLAjem7ejQi993QivgZFX
T6yiBVxWWTwM3zBrp6tqRDLw8px43fpa95Ghx2NXMWyWJrB8WDR9MvjgoD19
N4pkkxJgEWL5i+.awhR4ceQKJrNkIhNMbBgFE270tOIed25nVYObgbCY2TKb
qRPoDVuO27xeLdbyGSNRLWJLF9cOxoUrFUr.snVosjei5aGHNvGkQ+RJSBa9
JICoLp+TdZHJEO.Z8OSHr7Bh1XJ8gXZeQjkiFOVdJxX9ufwnNYbxoxYWlx4h
6KKDjnNYMo2lyzvoQI.eNlyRFVC5AftOJQ8Ek3XVixGyPOTmC56tq42pHlpF
alunOVuYjkFgtlINWyjg20rPsbo.RQcHnvj9.j3j7PYUEoXkVCSpZCwH35hE
jaUZxEWcIw4.aHb4bhwpzBBmTUZrDHqmPK4UUalR9TYg5dgVL+woiK5MBRst
YdyIVEwtPP9a9ZxGURipRLkbcsRRJTRIrYAaZMyg2t.3j+mK03ee80+0mlP9
3BHieAHSP3kE3fnRo4OPtYicOYZ.PHvFHgaZU1oj+cQowo2EbIpXbsAzqUFT
xfzboj.ibioqcuppDzM0JItgw73xSC5YIG1tX1jTzgONqSmgvWQq8EUqDVkx
tfbk5AxkRg9tMnQFLIdbzoyNIxRvOo4nOeTX2j0N5sJo8VdA5jSe88s8A1ic
PzHaS42PYyZhNOAdwTvTV1.ZHOHN3hFWeebl0WCXT5roIMYiwLUTWt4myF9Z
5cxs.QaHWItWTgw19PJsuHMqss.z9Poz2Ah5hE5IxRL1bS1r2.Td1d0h9ico
D1OCX3o0NZqMIM67oUsYw9rSImFesQQQsQQmG8aSyC+SeLxNQaX76lMrqnth
Jn6EWcd0sj4kls8kTC4KqWHz7JuIKi6cxRVaW3LrTGcV3aP.YWdpHk9vn2cm
Rgvv8vfMvGlnyZbtlBa5HzqMjva5+btXs+yHSC6s4D5XoYav0RVjywdfpTfd
q9cUAHOrsYO316V0hBaqD5xQkvFPe2ag1om6Ahrd65lDilLGDrYmGdtvQjpI
F3LFRPa8fYuaggBmeLC3j5J46Nz+.4YZrbs84no2oMosoKSnuYvzYRy1bJ9R
Xj2+BftLDt7Eoz206f4INednq2svzdinstbryE5.+PeWISeoKOeu6CkEeVze
1ybd0fS5RsYtC6jQwbjm.dMUkdJh3JfWIxA2kOpDMi+TtMpU5hsK21qtlrSQ
lKfCvJ41RkbuIQcyw6V6QKn7iPPa0lWljROFIAskQnuPIwZWjmWRouFLkLPl
I5QHGD6cSRomKzcWY3Xkb9.QX1.ImgxhwFp.3viQPIuBgUziAospyKSRQmQg
UGf8igUzeJeOutFNVho8miBEpV8UEN87I3ikR2iXwj.s39xsyGuy7fl+gBkV
nB0JMpnAqSccNFrTABVtprU1.tfHwpkRNzGPc6UCiEUG+iw+OZQhFE.
-----------end_max5_patcher-----------
</code></pre>

#### Subscribing

To be notified of a service, you can take this approach:

<pre><code>
----------begin_max5_patcher----------
923.3ocuWF0aZCCD.9Y3WgUTk1KzpXmDHr25l19CzmlllpLAWpqRribbZosp
+2m84.DngRJX5CPjubwm+t67c1uNbPvL4RVU.56n+hFL30gCF.hrBFzLdPPA
cYVNsBTKPvdRN6gfQtWoYK0f3WxQU47LFhr5U74vKLJeYzjUBE0EbQNSCyEY
iPYsdWokTc18bwhaUrLsaEhiuJbDhjNw9HIAFPtJD8ulOwMK5mKYN8CBFY9g
9m8suMbn8uQ8DyBVUEcA6cbNm8HPIppdVUlhOigt.itnSpG+InFuepIgIWkX
HEmZAFGi6A2dk4rbFU0Efw9APLwEJmB.Fkbt3aVsVKEcAx5vWIUQKXZl5Vlf
NKGrWXWPhOVHS.HIwq9e+PNiJVbbftm8nkJVISLGQKsO5xODF3GVA5hhBsOl
N9bEOqKXh50XnYEMExBvog+1t0mbMdp84H6eFgINgjezgP2WrR30MZNsKgwA
qIokyypqWRhhNniMEbr3vvC6Y4BMTD7nKDpkKVjy5HYgL47uoIEp0gSh66dF
KtdFyzufZCweUXtuR7lJCRk1zJqKOfuJy6nLEpClL4bUUHSVXpKneGh+QVix
nhVMt0RDEYhpZdVcNUgtgorM2+VE5m2ah0YlPMux7xqP+5Ql5YMuv7M2yPOR
yqYn5x4TMqBw0nm344HyDZHnrVitSIKPl0zky1jQkyErLYsPu0QbTrJyRkp4
RwscpQ6v.9STbN7CBCVG+DrqUKwUn1FE7nq9lFWrwvVm71dyUZemTnuilwZC
QKbwS8HtwScod.tjPOi6Ng51Pj1l1J9K.sQ1NhdiMWufHX+T7jiDs8dzOovj
Up67T8o9prP65Bi+xOcaksnvlBeep8jQ9wEzzlqox3YyCrmiE9Aou973fD2E
1LUdRNDd4lBEaiHnKTDcmKqBlyJeatqj0prUSWCJnMVbNyTIR.w3V5XulJZe
6e5qgVMIerkB8gkF2CKg8fgfSAiODRauZJ3yKkliozDtFCo.wgtqvNk79QDb
j6Qx5Qmp+ItG9Gfs8trwQw1r0nwt6vDsdvItzR6SNBYKkjp4LEzO3zbJj9X5
XejdF9Ib+mV9Yu1x4Cj9h1vk1e6ra1A9z7j8wxDejcPhOJeoqO.srzbf7pFk
AaX5h8fD7.oifgbgaHzWxb+lG4qzGtec.UYZSoM8npUv5JX4X28bBJjFeonl
23NMzYLIzEUXt+WUYyYVglsCea3+AjpWsaH
-----------end_max5_patcher-----------
</code></pre>


#### Combining with umenus

<pre><code>
----------begin_max5_patcher----------
1666.3ocuY0zbahCF9bxuBML8Xni9Fo8FXfY50saOs6NcHXkD5XCd.baZ6r+
2WgD3XmXa.CNWf7JKfmm2u0a98s23bewypJGve.9avM276au4FyRMKbSq7MN
qSdNcURkYaNqUUUIOpbty9a0pmqMqmtRkT1sZw15Up55etQYe0NNf+s8m1jT
m9TV9iesTkVa+Ujz6iv6.HAq4FwbEi+Hb2yjuccVt9EZP.tcwrkluaw8eyEA
cdYm1usYqnlE+uaus4xcSjeUpZvGPWFAIMrQSPtn4FEMZBJlO9kq9g9M9F5s
oTsQkubZ7yZGYjyyOza4G+pyuesBTsJKUAHmlh20GMMziB4FVNd2T1wYI9BX
YZw50p752Py3hs4KAgpuqoZ0+j+ku7ov6.+4m+7m514prbUpdS06iQswuR+1
RpyJx+5w2wQhZIzOxzpCoQQfXPSvKYDVcB93JD3LpP9rprQWn+yEOkTljVqJ
yppyRcNiYFQLDiXcps2vvwPLz7QrsZZs8j9rYMTd.ttsglThwJgfv237lUqV
2VHvAIfwMuRrOR1b+tlK5EY1EwAGYQ6Szsne6NkGaQpyf0jX1KFpxj0Js46q
p7j6WYT.vipkIyWViZPEvTXCfOaZi1heV6w4rCXnzDl.MNUbznyThOQLCYFK
0kVjqSAb4k6ZIIlaxLv8FchRL7pWO3wjZUOF0yGPQM1QOSsNJd7srPmuhA85
7hlGmWTGOoWpy60228glBfWXanV500Fpbz1T50uKzklJ65HSP016qRKyt2H7
gcZ19KkOxXYAuoXH11UNhJFsVgveuZdEjr4x6gsMf1VsWxGsuMYFyYMS07ML
pq+rdJ46wI95.f.2nPehKkgCcEgw9tbuvXXLSFShzDD3JDcEziD577gdbWn.
66RWPibCBoTWY.xiwHXhGmZdBb2SDygvXR.2cAGxcon3Et9bRfaXT.2OlEDE
rnoyBr2tOgO0mFxXtdQDMnB0fJXwBgtq.FhrHxWf7oGBJYDk5i8PtgAROWJM
zyUFpuPEXTDILfIobySv2ApXrOiDSc88w5uATydANRnaNcgbASxhiQDySH6d
BFERhCk9tQXOnKEigMbNvESEggLhTxaI9NdDRjXNIJxU+KZr3Eq+FALptNWb
LmA0JhEwGPbQfj6gHP23Hhvk5ywtAdZiiGTPnRs9kGsn4S3QGdtW46SmT0EO
93J0YcdOmSq.YOMgw2Eu65voo23oI58ml1XyIPSw6CMOUcHcB2hxKuCwV5aq
zxtfFDmwRsm5ji+0SYU.0yIq2rRAVpVWjWUWp6ZrBT+jBrsQs.Jd.XxUWAxx
A51l+117zlJufejU+DP+Yb0VDPcAn5ohezbuq0Z8eZKkWA1TV7n1DtVWxNMY
0pedENodi90CYGtFdzGSGit9GS+KUZHuSgYzdGTD7TrhJsNRu8L5OTjW+PRp
ZeR0GSQxqOSa4XeDydN81IN4MBqEZWlgFMPU1uLZ.RSCMyE0N4HRSSxu3TBs
I9aSIL9QjRt5cY9JK2an2prJSiYl6CnUS6L.zwkrQ1pIp+iNZdWlTHuZ39F3
zr9g7upXaYZGQ5FoN3EHsTUUmkaR6r2lv18bTU7P+PlQD02GRbvdVmsbSgtB
aK0vlw0wvh8FW2gRXtsBKjdDIaFQr8j7GJg3sYKM1HizNPTTtTUd5HnAS+lw
mg5g97yRepMIQKVsyd4PIb6LXZSSdfDRd.GkFNNIJwGfAkbVJ0BFr8eq.t6z
XSGZhA.sgfr4WoMnv.L7JFGzNOGjvn5ajdquNZRbjMDJxNGEob6j4sjRXG91
gRXqyBztyFoIZYZlTWuQnC.0Dqa7dBSEXCINa.dLDrMevKBS0WFO.jgNKvrd
gsHCgs+ukNPBKDufZivTQ8TAMhg1gk4FX84+8pzGuFYdXSzf.9BxLByggFMo
HZLQZPCxa+vVzL4Dh6ydROK13PiWHWtW7QivTg1f5sBOf.jNes8jlAmsoo0P
RxUQqQGdComO9DY66YOo4nBAbRQnspo1NcHyUIBxP7zdUAtiiL99Eu3y.x3S
tFQqxZ1S25Mj5pmCYRSZCjMa6dBSEXzIqxrJIzdkALBSEXCosZLsejg1u.0b
nxHSUiYsd83iYOrcxlMeWUV09xMPxYcx2JLMNKtyHlkaEMGp2oT88rt8SLqj
Tl9TVsJsdaogFNOysS5zYcgtE77sYscgqUF5OoYjE4IqUUaZmzkYxF29e29+
.0eXAXC
-----------end_max5_patcher-----------
</code></pre>



## Building

### Cloning this Repository

First step, open Terminal then make sure you have `git` by typing:

```sh
which git
```

If you get nothing then type:

```sh
xcode-select --install
```

To make this repository a little more portable, the `max-sdk` has been included as a submodule. What this means is that you will need to state `--recurse-submodules` when cloning.

Clone this repo into your Max folder's `developing` directory

```sh
cd "~/Documents/Max 8/"
mkdir developing
cd "developing"
git clone --recurse-submodules https://github.com/mhamilt/maxmsp-ble
```

You should be able to build straight away from the Xcode project contained in the `xcode` directory.

### Change sdk Version

```sh
cd max-sdk
git checkout v7.0.3 # or v7.1.0 v7.3.3 v8.0.3
```
