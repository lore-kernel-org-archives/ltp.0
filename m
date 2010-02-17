Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NhnlP-0005sX-H6
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:32:39 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhnlO-0007AD-8Y
	for ltp-list@lists.sourceforge.net; Wed, 17 Feb 2010 17:32:39 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1HHM2Ma019849
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 12:22:02 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1HHWWGK141390
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 12:32:32 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1HHWW2f017028
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Feb 2010 15:32:32 -0200
Date: Wed, 17 Feb 2010 23:02:26 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100217173226.GA11743@rishikesh.in.ibm.com>
References: <1265891406.10768.10.camel@munipradeep-laptop>
	<20100211233919.GB19098@rishikesh.in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20100211233919.GB19098@rishikesh.in.ibm.com>
Subject: Re: [LTP] memory_hotplug tests are not compiling properly
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
To: mpradeep@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

T24gRnJpLCBGZWIgMTIsIDIwMTAgYXQgMDU6MDk6MTlBTSArMDUzMCwgUmlzaGlrZXNoIEsgUmFq
YWsgd3JvdGU6Cj4gT24gVGh1LCBGZWIgMTEsIDIwMTAgYXQgMDY6MDA6MDZQTSArMDUzMCwgTXVu
aXByYWRlZXAgQmVlcmFrYW0gd3JvdGU6Cj4gPiBIaSBSaXNoaSwKPiA+IAo+ID4gSSBhbSB1bmFi
bGUgdG8gY29tcGlsZSB0aGUgbWVtb3J5X2hvdHBsdWcgdGVzdHMgaW4gTFRQIFNlcCAyMDA5IHJl
bGVhc2UuCj4gPiBJIGFtIGdldHRpbmcgdGhlIGJlbG93IGVycm9yLgo+ID4gCj4gPiAjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKPiA+IGNjIC1zdGQ9Z251
OTkgLU8yICAtRF9HTlVfU09VUkNFIC1EX05FRURfTUlHUkFURV9QQUdFUyAgICAgLWMgLW8KPiA+
IG1lbXRveS5vIG1lbXRveS5jCj4gPiBjYyAtc3RkPWdudTk5IC1PMiAgLURfR05VX1NPVVJDRSAt
RF9ORUVEX01JR1JBVEVfUEFHRVMgICAgIC1jIC1vCj4gPiBjb21tYW5kcy5vIGNvbW1hbmRzLmMK
PiA+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBjb21tYW5kcy5jOjQ1Ogo+ID4gbWlncmF0ZV9wYWdl
cy5oOjEwOiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmG1pZ3JhdGVfcGFnZXPigJkK
PiA+IC91c3IvaW5jbHVkZS9udW1haWYuaDoxNzogZXJyb3I6IHByZXZpb3VzIGRlY2xhcmF0aW9u
IG9mIOKAmG1pZ3JhdGVfcGFnZXPigJkKPiA+IHdhcyBoZXJlCj4gPiBtYWtlOiAqKiogW2NvbW1h
bmRzLm9dIEVycm9yIDEKPiA+ICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIwo+ID4gCj4gPiBFdmVuIHRoZSBwYXRjaCBpcyBub3QgYXBwbHlpbmcgcHJvcGVy
bHkuIAo+ID4gCj4gPiBAQWxsLCBBbnkgaGVscCBpcyBhcHByZWNpYXRlZC4KPiBIaSBNdW5pLAo+
IAo+IFBsZWFzZSB1c2UgbGF0ZXN0IGx0cCwgYXMgaSBoYXZlIHNlZW4gc29tZSBjaGFuZ2VzIGhh
cyBnb25lIGZyb20gZ2FycmV0IGZvciBmaXhpbmYgY29tcGlsYXRpb24gaXNzdWVzLgoKSGkgTXVu
aSwKTGV0IHVzIGtub3cgaWYgeW91IGdldCBhIGNoYW5jZSB0byB0ZXN0IHdpdGggbGF0ZXN0IENW
UyBvcgpsdHAtZnVsbC0yMDEwMDEzMS4xLnRneiA/CgpUaGFua3MgZm9yIHlvdXIgc3VwcG9ydC4K
Ck11bmkKPiAKPiBUaGFua3MKPiBSaXNoaQo+ID4gCj4gPiBUaGFua3MKPiA+IE11bmkKPiA+IAoK
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tClNPTEFSSVMgMTAgaXMgdGhlIE9TIGZvciBEYXRhIENlbnRl
cnMgLSBwcm92aWRlcyBmZWF0dXJlcyBzdWNoIGFzIERUcmFjZSwKUHJlZGljdGl2ZSBTZWxmIEhl
YWxpbmcgYW5kIEF3YXJkIFdpbm5pbmcgWkZTLiBHZXQgU29sYXJpcyAxMCBOT1cKaHR0cDovL3Au
c2YubmV0L3NmdS9zb2xhcmlzLWRldjJkZXYKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9sdHAtbGlzdAo=
