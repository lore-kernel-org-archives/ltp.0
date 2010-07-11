Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sumitbd@linsyssoft.com>) id 1OXxQW-0002uq-JU
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:22:40 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OXxQV-0006Ml-PE
	for ltp-list@lists.sourceforge.net; Sun, 11 Jul 2010 14:22:40 +0000
Received: by vws3 with SMTP id 3so4658299vws.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 11 Jul 2010 07:22:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1278855498.8660.48.camel@sumit>
References: <1278855498.8660.48.camel@sumit>
From: Sumit Dhoot <sumitbd@linsyssoft.com>
Date: Sun, 11 Jul 2010 19:52:14 +0530
Message-ID: <AANLkTimjpmS4PdPnO6jW7w6qrD7zkKopA4blPZufS_eq@mail.gmail.com>
Subject: Re: [LTP] [PATCH 3/3] runtest/nfs: TCbin path not exported for few
	tests
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
To: ltp-list@lists.sourceforge.net

SGkgQWxsLAoKSSBmYWlsZWQgdG8gYWRkICJTaWduZWQtb2ZmLWJ5Ii4gQXBvbG9naWVzIGZvciB0
aGlzLgoKT24gU3VuLCBKdWwgMTEsIDIwMTAgYXQgNzowOCBQTSwgIDxzdW1pdGJkQGxpbnN5c3Nv
ZnQuY29tPiB3cm90ZToKPiBIaSwKPgo+IFdoaWxlIHJ1bm5pbmcgbmV0d29ya3Rlc3QgZm9yIG5m
czsgbmZzc3RyZXNzICYgwqBuZnNzdGF0MDEgdGVzdCBnZXRzCj4gZmFpbC4gQmVjYXVzZSBUQ2Jp
biBpcyBub3QgZXhwb3J0ZWQgd2l0aCByZXF1aXJlZCBwYXRoLiBGb2xsb3dpbmcKPiBwYXRjaCBm
aXhlZCB0aGUgYWJvdmUgcHJvYmxlbS4KPgpTaWduZWQtb2ZmLWJ5OiAgU3VtaXQgRGhvb3QgPHN1
bWl0YmRAbGluc3lzc29mdC5jb20+Cgo9PT09PT09Cgo+IEluZGV4OiBsdHAtZnVsbC0yMDEwMDYz
MC9ydW50ZXN0L25mcwo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiAtLS0gbHRwLWZ1bGwtMjAxMDA2MzAub3JpZy9y
dW50ZXN0L25mcwo+ICsrKyBsdHAtZnVsbC0yMDEwMDYzMC9ydW50ZXN0L25mcwo+IEBAIC02LDEw
ICs2LDEwIEBAIG5mczAxIGV4cG9ydCBWRVJTSU9OIFNPQ0tFVF9UWVBFOyBUQ2Jpbj0KPiDCoG5m
czAyIGV4cG9ydCBWRVJTSU9OIFNPQ0tFVF9UWVBFOyBUQ2Jpbj0kTFRQUk9PVC90ZXN0Y2FzZXMv
YmluIG5mczAyCj4gwqBuZnMwMyBleHBvcnQgVkVSU0lPTiBTT0NLRVRfVFlQRTsgVENiaW49JExU
UFJPT1QvdGVzdGNhc2VzL2JpbiBuZnMwMwo+IMKgbmZzMDQgZXhwb3J0IFZFUlNJT04gU09DS0VU
X1RZUEU7IFRDYmluPSRMVFBST09UL3Rlc3RjYXNlcy9iaW4gbmZzMDQKPiAtbmZzbG9jazAxIGV4
cG9ydCBWRVJTSU9OOyBuZnNsb2NrMDEKPiArbmZzbG9jazAxIGV4cG9ydCBWRVJTSU9OOyBUQ2Jp
bj0kTFRQUk9PVC90ZXN0Y2FzZXMvYmluIG5mc2xvY2swMQo+Cj4gwqAjIFRoaXMgd2lsbCBydW4g
MSB0aHJlYWQgb24gMjAgZGlyZWN0b3JpZXMgd2l0aCA1MCBmaWxlcyBpbiBlYWNoLgo+IC1uZnNz
dHJlc3MgZXhwb3J0IFZFUlNJT04gU09DS0VUX1RZUEU7IG5mc3N0cmVzcyAyMCA1MCAxCj4gK25m
c3N0cmVzcyBleHBvcnQgVkVSU0lPTiBTT0NLRVRfVFlQRTsgVENiaW49JExUUFJPT1QvdGVzdGNh
c2VzL2Jpbgo+IG5mc3N0cmVzcyAyMCA1MCAxCj4KPiDCoG5mc3N0YXQwMSBleHBvcnQgVkVSU0lP
TjsgVENiaW49JExUUFJPT1QvdGVzdGNhc2VzL2JpbiBuZnNzdGF0MDEKPiDCoG5mc3gtbGludXgg
ZXhwb3J0IFZFUlNJT04gU09DS0VUX1RZUEU7IFRDYmluPSRMVFBST09UL3Rlc3RjYXNlcy9iaW4K
PiBmc3guc2gKPgoKPT09PT09PQo+Cj4gVGhhbmtzICYgUmVnYXJkcwo+IFN1bWl0IERob290Cj4g
U3lzdGVtIEFkbWluaXN0cmF0b3IKPiBMaW5zeXNzb2Z0IFRlY2hub2xvZ2llcyBQdnQuIEx0ZC4K
PiBzdW1pdGJkQGxpbnN5c3NvZnQuY29tCj4KPgoKCgotLSAKVGhhbmtzICYgUmVnYXJkcwpTdW1p
dCBEaG9vdAoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRoaXMgU0YubmV0IGVtYWlsIGlzIHNwb25z
b3JlZCBieSBTcHJpbnQKV2hhdCB3aWxsIHlvdSBkbyBmaXJzdCB3aXRoIEVWTywgdGhlIGZpcnN0
IDRHIHBob25lPwpWaXNpdCBzcHJpbnQuY29tL2ZpcnN0IC0tIGh0dHA6Ly9wLnNmLm5ldC9zZnUv
c3ByaW50LWNvbS1maXJzdApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0
Cg==
