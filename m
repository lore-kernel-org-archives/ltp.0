Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O6HgH-0007tS-0h
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 06:20:33 +0000
Received: from e39.co.us.ibm.com ([32.97.110.160])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O6HgE-0005yk-Mp
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 06:20:32 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e39.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3Q6BvOL023203
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 00:11:57 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o3Q6KIYD122850
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 00:20:18 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3Q6KHAq030206
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 00:20:17 -0600
Received: from [9.124.210.160] ([9.124.210.160])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVin) with ESMTP id
	o3Q6KF34030091
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Apr 2010 00:20:16 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1271914527.5122.1.camel@subratamodak.linux.ibm.com>
References: <20100421120550.13534.21836.sendpatchset@subratamodak.linux.ibm.com>
	<1271914527.5122.1.camel@subratamodak.linux.ibm.com>
Date: Mon, 26 Apr 2010 11:50:13 +0530
Message-Id: <1272262814.5003.0.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix Location Of GENHTML Inside RUNLTP
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
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

T24gVGh1LCAyMDEwLTA0LTIyIGF0IDExOjA1ICswNTMwLCBTdWJyYXRhIE1vZGFrIHdyb3RlOgo+
IE9uIFdlZCwgMjAxMC0wNC0yMSBhdCAxNzozNSArMDUzMCwgU3VicmF0YSBNb2RhayB3cm90ZToK
PiA+IFRoZXJlIGFyZSBzb21lIGJpdHMgYW5kIHBpZWNlcyBvZiByZXN0cnVjdHVyaW5nIHN0aWxs
IGxlZnQgdG8gYmUgZG9uZS4KPiA+IHJ1bmx0cCBpcyBub3QgYWJsZSB0byBjYWxsIGdlbmh0bWwg
cHJvcGVybHkgZHVlIHRvIGNoYW5nZSBpbiBsb2NhdGlvbgo+ID4gb2YgdGhlIHNhbWUgc2NyaXB0
LiBUaGUgZm9sbG93aW5nIGVycm9yIHdpbGwgb2NjdXI6Cj4gPiAKPiA+IC4uLgo+ID4gR2VuZXJh
dGluZyBIVE1MIE91dHB1dC4uLi4uISEKPiA+IENhbid0IG9wZW4gcGVybCBzY3JpcHQgIi9vcHQv
bHRwL3Rvb2xzL2dlbmh0bWwucGwiOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5Cj4gPiAuLi4K
PiA+IAo+ID4gRm9sbG93aW5nIHBhdGNoIGZpeGVzIHRoZSBzYW1lLgo+ID4gCj4gPiBTaWduZWQt
b2ZmLWJ5OiBTdWJyYXRhIE1vZGFrIDxzdWJyYXRhQGxpbnV4LnZuZXQuaWJtLmNvbT4KPiA+IC0t
LQo+IAo+IEZpcnN0IG9mIGFsbCwgZG9lcyB0aGlzIHBhdGNoIHNvbHZlIHRoZSBpc3N1ZSBhdCBh
bnlib2R5xZsgc2lkZSA/IElmIHllcywKPiBjYW4gdGhpcyBiZSBpbmNsdWRlZCBpbiBBcHJpbCAy
MDEwIHJlbGVhc2UgPwoKSXMgc29tZWJvZHkgbG9va2luZyBpbnRvIHRoaXMgcGF0Y2ggPwoKUmVn
YXJkcy0tClN1YnJhdGEKCj4gCj4gUmVnYXJkcy0tCj4gU3VicmF0YQo+IAo+ID4gCj4gPiAtLS0g
bHRwLWRldi9ydW5sdHAub3JpZwkyMDEwLTA0LTIxIDIyOjQ4OjU4LjIyMzY1MTQ0MCArMDUzMAo+
ID4gKysrIGx0cC1kZXYvcnVubHRwCTIwMTAtMDQtMjEgMjI6NDk6MTAuOTAxNzgzNDQ1ICswNTMw
Cj4gPiBAQCAtODQ2LDcgKzg0Niw3IEBAIG1haW4oKQo+ID4gICAgICAgICBleHBvcnQgVEVTVF9P
VVRQVVRfRElSRUNUT1JZPSIkTFRQUk9PVC9vdXRwdXQiCj4gPiAgICAgICAgIGV4cG9ydCBURVNU
X0xPR1NfRElSRUNUT1JZPSRMT0dTX0RJUkVDVE9SWQo+ID4gICAgICAgICBlY2hvICJHZW5lcmF0
aW5nIEhUTUwgT3V0cHV0Li4uLi4hISIKPiA+IC0gICAgICAgKCBwZXJsICRMVFBST09UL3Rvb2xz
L2dlbmh0bWwucGwgJExUUFJPT1QvdG9vbHMvaHRtbF9yZXBvcnRfaGVhZGVyLnR4dCB0ZXN0X3N0
YXJ0IHRlc3RfZW5kIHRlc3Rfb3V0cHV0IGV4ZWN1dGlvbl9zdGF0dXMgJE9VVFBVVF9ESVJFQ1RP
UlkgID4gJEhUTUxGSUxFOyApICAgCj4gPiArICAgICAgICggcGVybCAkTFRQUk9PVC9iaW4vZ2Vu
aHRtbC5wbCAkTFRQUk9PVC90b29scy9odG1sX3JlcG9ydF9oZWFkZXIudHh0IHRlc3Rfc3RhcnQg
dGVzdF9lbmQgdGVzdF9vdXRwdXQgZXhlY3V0aW9uX3N0YXR1cyAkT1VUUFVUX0RJUkVDVE9SWSAg
PiAkSFRNTEZJTEU7ICkgICAKPiA+ICAgICAgICAgZWNobyAiR2VuZXJhdGVkIEhUTUwgT3V0cHV0
Li4uLi4hISIKPiA+ICAgICAgICAgZWNobyAiTG9jYXRpb246ICRIVE1MRklMRSI7Cj4gPiAKPiA+
IC0tLQo+ID4gUmVnYXJkcy0tCj4gPiBTdWJyYXRhCj4gPiAKPiAKPiAKPiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+IEx0cC1saXN0IG1haWxpbmcgbGlzdAo+IEx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5l
dAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0
CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bHRwLWxpc3QK
