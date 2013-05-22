Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UeyBy-0001HW-9s
	for ltp-list@lists.sourceforge.net; Wed, 22 May 2013 01:50:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UeyBw-0006cX-HA
	for ltp-list@lists.sourceforge.net; Wed, 22 May 2013 01:50:14 +0000
Message-ID: <519C23B6.1030000@cn.fujitsu.com>
Date: Wed, 22 May 2013 09:47:34 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <519B35A9.8090300@cn.fujitsu.com>
	<464527248.5091039.1369131720554.JavaMail.root@redhat.com>
In-Reply-To: <464527248.5091039.1369131720554.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] semctl01.c: Pass the correct parameter
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

T24gMDUvMjEvMjAxMyAwNjoyMiBQTSwgSmFuIFN0YW5jZWsgd3JvdGU6Cj4gCj4gCj4gCj4gCj4g
LS0tLS0gT3JpZ2luYWwgTWVzc2FnZSAtLS0tLQo+PiBGcm9tOiAiREFOIExJIiA8bGkuZGFuQGNu
LmZ1aml0c3UuY29tPgo+PiBUbzogIkxUUCBsaXN0IiA8bHRwLWxpc3RAbGlzdHMuc291cmNlZm9y
Z2UubmV0Pgo+PiBTZW50OiBUdWVzZGF5LCAyMSBNYXksIDIwMTMgMTA6NTE6NTMgQU0KPj4gU3Vi
amVjdDogW0xUUF0gIFtQQVRDSF0gc2VtY3RsMDEuYzogUGFzcyB0aGUgY29ycmVjdCBwYXJhbWV0
ZXIKPj4KPj4KPj4gRm9yIFNFTV9TVEFULCB0aGUgc2VtaWQgYXJndW1lbnQgaXMgbm90IGEgc2Vt
YXBob3JlIGlkZW50aWZpZXIsICBidXQgaW5zdGVhZAo+PiBhbgo+PiBpbmRleCBpbnRvIHRoZSBr
ZXJuZWzigJlzIGludGVybmFsIGFycmF5IHRoYXQgbWFpbnRhaW5zIGluZm9ybWF0aW9uIGFib3V0
IGFsbAo+PiBzZW1hcGhvcmUgc2V0cyBvbiB0aGUgc3lzdGVtLgo+Pgo+PiBQYXNzIGEgY29ycmVj
dCBpbmRleCBvZiB0aGUga2VybmVsJyBpbnRlcm5hbCBhcnJheSBpbnRlYWQgb2YgYSBzZW1hcGhv
cmVzIGlkCj4+IHdoZW4KPj4gdGVzdGluZyBmZWF0dXJlIFNFTV9TVEFULgo+Pgo+PiBTaWduZWQt
b2ZmLWJ5OiBEQU4gTEkgPGxpLmRhbkBjbi5mdWppdHN1LmNvbT4KPj4gLS0tCj4gCj4gSGksCj4g
Cj4gdGhhdCBiYWNrdXAvcmVzdG9yZSBvZiBnbG9iYWwgdmFyaWFibGUgaW4gc2V0dXAvY2xlYW51
cCBmdW5jcwo+IGJldHdlZW4gdGVzdGNhc2VzIGxvb2tzIGEgYml0IG9kZCB0byBtZS4KPiAKPiBI
b3cgYWJvdXQgYWRkaW5nIG5ldyBmaWVsZCB0byB0ZXN0X2Nhc2VfdD8KPiAKPiArc3RhdGljIGlu
dCBzZW1faW5kZXggPSAwOwo+ICBzdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiArICAgICAg
IGludCAqc2VtaWQ7Cj4gLi4uCj4gLSAgICAgICAgICAgICAgICAgICAgICAgVEVTVChzZW1jdGwo
c2VtX2lkXzEsIFRDW2ldLnNlbW51bSwgVENbaV0uY21kLAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIFRFU1Qoc2VtY3RsKCooVENbaV0uc2VtaWQpLCBUQ1tpXS5zZW1udW0sIFRDW2ldLmNtZCwK
PiAKPiBUaGVzZSB5b3UgY291bGQgaW5pdGlhbGlzZSBpbiBUQ1tdIGRlZmluaXRpb24gdG8gZWl0
aGVyICZzZW1faWRfMSBvciAmc2VtX2luZGV4Cj4gYW5kIGF2b2lkIGFsbCB0aGF0IGJhY2t1cC9y
ZXN0b3JlIG9mIHNlbV9pZF8xLgo+IAo+IFdoYXQgZG8geW91IHRoaW5rPwoKU291bmRzIGJldHRl
ci47KQoKVGhhbmsgeW91IGZvciByZXZpZXdpbmcuCgpSZWdhcmRzLApEQU4gTEkKPiAKPiBSZWdh
cmRzLAo+IEphbgo+IAoKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KVHJ5IE5ldyBSZWxpYyBOb3cg
JiBXZSdsbCBTZW5kIFlvdSB0aGlzIENvb2wgU2hpcnQKTmV3IFJlbGljIGlzIHRoZSBvbmx5IFNh
YVMtYmFzZWQgYXBwbGljYXRpb24gcGVyZm9ybWFuY2UgbW9uaXRvcmluZyBzZXJ2aWNlIAp0aGF0
IGRlbGl2ZXJzIHBvd2VyZnVsIGZ1bGwgc3RhY2sgYW5hbHl0aWNzLiBPcHRpbWl6ZSBhbmQgbW9u
aXRvciB5b3VyCmJyb3dzZXIsIGFwcCwgJiBzZXJ2ZXJzIHdpdGgganVzdCBhIGZldyBsaW5lcyBv
ZiBjb2RlLiBUcnkgTmV3IFJlbGljCmFuZCBnZXQgdGhpcyBhd2Vzb21lIE5lcmQgTGlmZSBzaGly
dCEgaHR0cDovL3Auc2YubmV0L3NmdS9uZXdyZWxpY19kMmRfbWF5Cl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAt
bGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQv
bGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
