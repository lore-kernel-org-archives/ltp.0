Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJlis-0006sl-6S
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:58:26 +0000
Received: from e2.ny.us.ibm.com ([32.97.182.142])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJliq-00056v-Ga
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:58:26 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5P9rZX1002493
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 05:53:35 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5P9wN0v246258
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 05:58:23 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5P9u1qT031592
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 05:56:01 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906231806.08741.jpalecek@web.de>
References: <1244618075.10778.4.camel@munipradeep-laptop>
	<1245401736.13600.5.camel@munipradeep-laptop>
	<1245768642.4860.92.camel@subratamodak.linux.ibm.com>
	<200906231806.08741.jpalecek@web.de>
Date: Thu, 25 Jun 2009 14:40:13 +0530
Message-Id: <1245921013.5542.40.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH]get_mempolicy01: fix for changing failure
	due	to	configuration error
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

T24gVHVlLCAyMDA5LTA2LTIzIGF0IDE4OjA2ICswMjAwLCBKaXJpIFBhbGVjZWsgd3JvdGU6IAo+
IE9uIFR1ZXNkYXkgMjMgSnVuZSAyMDA5IDE2OjUwOjQyIFN1YnJhdGEgTW9kYWsgd3JvdGU6Cj4g
PiA+ID4gCj4gPiA+ID4gCj4gPiA+IEFzIEkgZG9uJ3Qga25vdyB3aGF0IGFyZSBhbGwgdGhlIGVy
cm9yIHJlcG9ydGluZyBvcHRpb25zIExUUCBoYXZlLCBJCj4gPiA+IGNoYW5nZWQgaXQgdG8gQ09O
Ri4gV2UgY2FuIGNoYW5nZSBpdCBhY2NvcmRpbmdseSB0byBuZWVkLiBDYW4gd2UgcmVwb3J0Cj4g
PiA+IGl0IGFzIEJST0tFTiwgYXMgc2V0X21lbXBvbGljeSBpcyBwcmV2ZW50aW5nIHRoZSBnZXRf
bWVtcG9saWN5IHRlc3QgdG8KPiA+ID4gcnVuPwo+ID4gCj4gPiBNdW5pLAo+ID4gCj4gPiBKaXJp
xZsgcGF0Y2ggY2hlY2tlZCBpbiB0b2RheSBzaG91bGQgZml4IHRoaXM6Cj4gPiAKPiA+IFN1Ympl
Y3Q6IFtMVFBdIFtQQVRDSF0gRGVmaW5lIHNvbWUgc3lzY2FsbCBudW1iZXJzIGluIHRoZQo+ID4g
bGludXhfc3lzY2FsbF9udW1iZXJzLmggZmlsZSwgbm90IHRvIGdldCBidWlsZCBmYWlsdXJlcyBv
ciBjcmFwcHkKPiA+IHJlc3VsdHMgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyB3aGljaCBsYWNrIHRo
ZW0KPiAKClVwZGF0aW5nL2NsZWFuaW5nIGxpbnV4X3N5c2NhbGxfbnVtYmVycy5oIGlzIGEgZ29v
ZCBpZGVhIGFsd2F5cy4KClJlZ2FyZHMtLQpTdWJyYXRhCgo+IFdlbGwsIHllcyBhbmQgbm8uIFRo
ZSBwYXRjaCBkb2VzIGhhbmRsZSB0aGUgc2l0dWF0aW9uIChzb3J0IG9mKSwgYnV0IGl0IHN0aWxs
IHJlc3VsdHMgaW4gYSBUQlJPSyAod2hpY2ggaXMgd3JvbmcsIEkgYWRtaXQpLiBJIHRoaW5rIHRo
aXMgYXJlYSAoaWUuIHN5c2NhbGxzIHdoaWNoIGFyZSBvciBhcmVuJ3QgcHJlc2VudCBpbiBzb21l
IGtlcm5lbHMpIHNob3VsZCBiZSBoYW5kbGVkIG1vcmUgc3lzdGVtYXRpY2FsbHksIGVzcGVjaWFs
bHkgYWZ0ZXIgd2hhdCBJIHdlbnQgdGhyb3VnaCB1cGxvYWRpbmcgdGhlIGxhc3QgdmVyc2lvbiBv
ZiBsdHAgdG8gRGViaWFuLiBJIHdpbGwgdGhpbmsgb2YgaXQgYW5kIHByb2R1Y2Ugc29tZSBleGFt
cGxlIHBhdGNoZXMgYWZ0ZXIgSSBzZW5kIG90aGVyIHBhdGNoZXMgSSBoYXZlIGluIHRoZSBxdWV1
ZS4KPiAKPiBSZWdhcmRzCj4gICAgIEppcmkgUGFsZWNlawoKCi0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlz
dCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlz
dHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
