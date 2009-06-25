Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlkX-0003jM-VO
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:00:09 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJlkT-00048V-UG
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 10:00:09 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5P9tRWX028679
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 05:55:27 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5PA05jS245566
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 06:00:05 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5PA05iI023710
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 06:00:05 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <op.uvzv3omsu2flwt@debian>
References: <200906220117.n5M1HTVJ004183@e2.ny.us.ibm.com>
	<1245768543.4860.65.camel@subratamodak.linux.ibm.com>
	<op.uvzhu1pnu2flwt@debian>  <op.uvzv3omsu2flwt@debian>
Date: Thu, 25 Jun 2009 14:40:24 +0530
Message-Id: <1245921024.5542.42.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix cleanup procedure in the setuid04 test
Reply-To: subrata@linux.vnet.ibm.com
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net

T24gVHVlLCAyMDA5LTA2LTIzIGF0IDIyOjQ4ICswMjAwLCBKacWZw60gUGFsZcSNZWsgd3JvdGU6
IAo+IE9uIFR1ZSwgMjMgSnVuIDIwMDkgMTc6NDE6MTUgKzAyMDAsIEppxZnDrSBQYWxlxI1layA8
anBhbGVjZWtAd2ViLmRlPiB3cm90ZToKPiAKPiA+IE9uIFR1ZSwgMjMgSnVuIDIwMDkgMTY6NDk6
MDMgKzAyMDAsIFN1YnJhdGEgTW9kYWsgIAo+ID4gPHN1YnJhdGFAbGludXgudm5ldC5pYm0uY29t
PiB3cm90ZToKPiA+Cj4gPj4gT24gVHVlLCAyMDA5LTA1LTEyIGF0IDE5OjA2ICswMjAwLCBKaXJp
IFBhbGVjZWsgd3JvdGU6Cj4gPj4+IENsZWFudXAgaGFzIHRvIGJlIG1hZGUgb25seSBvbmNlIGlu
IHRoZSBwYXJlbnQgcHJvY2Vzczsgd2hlbiB0aGUKPiA+Pj4gIGNoaWxkIG1ha2VzIHRoZSBjbGVh
bnVwIGl0c2VsZiwgdGhlIHBhcmVudCBoYXMgbm90aGluZyB0byBjbGVhbnVwLAo+ID4+PiAgd2hp
Y2ggbWFrZXMgaGltIHNhZC4KPiA+Pj4KPiA+Pj4gU2lnbmVkLW9mZi1ieTogSmlyaSBQYWxlY2Vr
IDxqcGFsZWNla0B3ZWIuZGU+Cj4gPj4KPiA+PiBUaGFua3MuCj4gPgo+ID4gT2ggbm8sIGF0IHRo
ZSBzZWNvbmQgc2lnaHQgSSBzZWUgSSd2ZSBwb3N0ZWQgYSB3cm9uZyAob2xkKSB2ZXJzaW9uIG9m
ICAKPiA+IHRoZSBwYXRjaC4gSSdsbCBzZW5kIGEgY29ycmVjdGlvbiBzaG9ydGx5Lgo+IAo+IFRo
ZSBjb3JyZWN0aW9uIGlzIGluIHRoZSBhdHRhY2htZW50LiBQbGVhc2UsIGFwcGx5LgoKRXZlcnl0
aGluZ3MgZmluZSBleGNlcHQ6CgooU3RyaXBwaW5nIHRyYWlsaW5nIENScyBmcm9tIHBhdGNoLikK
cGF0Y2hpbmcgZmlsZSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHVpZC9zZXR1aWQwNC5j
CgpSZWdhcmRzLS0KU3VicmF0YQoKPiAKPiBSZWdhcmRzCj4gICAgICBKaXJpIFBhbGVjZWsKPiAK
PiA+Pj4gLS0tCj4gPj4+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHVpZC9zZXR1aWQw
NC5jIHwgICAgNyArKystLS0tCj4gPj4+ICAxIGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgNCBkZWxldGlvbnMoLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc2V0dWlkL3NldHVpZDA0LmMgIAo+ID4+PiBiL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvc2V0dWlkL3NldHVpZDA0LmMKPiA+Pj4gaW5kZXggMThmMWQ5MC4uMjZhMzg2OCAx
MDA2NDQKPiA+Pj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXR1aWQvc2V0dWlk
MDQuYwo+ID4+PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHVpZC9zZXR1aWQw
NC5jCj4gPj4+IEBAIC0xMTQsNyArMTE0LDcgQEAgdm9pZCBkb19tYXN0ZXJfY2hpbGQoKQo+ID4+
PiAgCWludCBzdGF0dXM7Cj4gPj4+Cj4gPj4+ICAJaWYgKHNldHVpZChsdHB1c2VyLT5wd191aWQp
ID09IC0xKSB7Cj4gPj4+IC0JCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLAo+ID4+PiArCQl0c3Rf
YnJrbShUQlJPSywgdHN0X2V4aXQsCj4gPj4+ICAJCQkgInNldHVpZCBmYWlsZWQgdG8gc2V0IHRo
ZSBlZmZlY3RpdmUgdWlkIHRvICVkIiwKPiA+Pj4gIAkJCSBsdHB1c2VyLT5wd191aWQpOwo+ID4+
PiAgCX0KPiA+Pj4gQEAgLTE0Myw3ICsxNDMsNyBAQCB2b2lkIGRvX21hc3Rlcl9jaGlsZCgpCj4g
Pj4+Cj4gPj4+ICAJCXBpZCA9IEZPUktfT1JfVkZPUksoKTsKPiA+Pj4gIAkJaWYgKHBpZCA8IDAp
Cj4gPj4+IC0JCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgIkZvcmsgZmFpbGVkIik7Cj4gPj4+
ICsJCQl0c3RfYnJrbShUQlJPSywgdHN0X2V4aXQsICJGb3JrIGZhaWxlZCIpOwo+ID4+Pgo+ID4+
PiAgCQlpZiAocGlkID09IDApIHsKPiA+Pj4gIAkJCWludCB0c3RfZmQyOwo+ID4+PiBAQCAtMTYw
LDEzICsxNjAsMTIgQEAgdm9pZCBkb19tYXN0ZXJfY2hpbGQoKQo+ID4+Pgo+ID4+PiAgCQkJaWYg
KFRFU1RfRVJSTk8gPT0gRUFDQ0VTKSB7Cj4gPj4+ICAJCQkJdHN0X3Jlc20oVFBBU1MsICJvcGVu
IHJldHVybmVkIGVycm5vIEVBQ0NFUyIpOwo+ID4+PiAtCQkJCWV4aXQoMCk7Cj4gPj4+ICAJCQl9
IGVsc2Ugewo+ID4+PiAgCQkJCXRzdF9yZXNtKFRGQUlMLAo+ID4+PiAgCQkJCQkgIm9wZW4gcmV0
dXJuZWQgdW5leHBlY3RlZCBlcnJubyAtICVkIiwKPiA+Pj4gIAkJCQkJIFRFU1RfRVJSTk8pOwo+
ID4+PiAtCQkJCWV4aXQoLTEpOwo+ID4+PiAgCQkJfQo+ID4+PiArCQkJdHN0X2V4aXQoKTsKPiA+
Pj4gIAkJfSBlbHNlIHsKPiA+Pj4gIAkJCS8qIFdhaXQgZm9yIHNvbiBjb21wbGV0aW9uICovCj4g
Pj4+ICAJCQl3YWl0cGlkKHBpZCwgJnN0YXR1cywgMCk7Cj4gPj4KPiA+Cj4gPgo+ID4KPiAKPiAK
PiAKPiAtLSAKPiBVc2luZyBPcGVyYSdzIHJldm9sdXRpb25hcnkgZS1tYWlsIGNsaWVudDogaHR0
cDovL3d3dy5vcGVyYS5jb20vbWFpbC8KCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBs
aXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
