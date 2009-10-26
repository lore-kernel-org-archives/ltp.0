Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1N2Kxe-00043W-Cn
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 08:29:54 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1N2KxU-0007hU-PG
	for ltp-list@lists.sourceforge.net; Mon, 26 Oct 2009 08:29:52 +0000
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e1.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9Q8S5CJ031646
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 04:28:05 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9Q8TcKh847954
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 04:29:38 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n9Q8TcfJ007196
	for <ltp-list@lists.sourceforge.net>; Mon, 26 Oct 2009 04:29:38 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4AE54F96.7060502@cn.fujitsu.com>
References: <4AE54BCA.7060104@cn.fujitsu.com> <4AE54F96.7060502@cn.fujitsu.com>
Date: Mon, 26 Oct 2009 13:59:30 +0530
Message-Id: <1256545770.4929.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Add new testcases for ext4 new features - V3
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
To: Miao Xie <miaox@cn.fujitsu.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

T24gTW9uLCAyMDA5LTEwLTI2IGF0IDE2OjI4ICswOTAwLCBNaWFvIFhpZSB3cm90ZToKPiBIaSwg
TXIuU3VicmF0YQo+IAo+IFRoZSBwYXRjaCB0aGF0IHlvdSBtYWRlIHRvIGZpeCB0aGUgcHJvYmxl
bSBvZiBmZnNiIHdhcyBub3QgbWVyZ2VkIGludG8KPiB0aGlzIHBhdGNoLiBTbyBpZiB5b3Ugd2Fu
dCB0byBydW4gdGhpcyB0ZXN0Y2FzZXMsIHlvdSBtdXN0IGFwcGxpZWQgeW91cgo+IHBhdGNoIGJl
Zm9yZSBjb21waWxpbmcgdGhlIHRlc3RjYXNlcy4KClN1cmUuIEkgd2lsbCBkbyB0aGF0LiBUaGFu
a3MgZm9yIHJlc2VuZGluZyB0aGUgcGF0Y2ggc28gc29vbi4gSSB3aWxsCm1ha2Ugc3VyZSB0aGlz
IGlzIGF2YWlsYWJsZSBpbiB0aGlzIG1vbnRoxZsgcmVsZWFzZS4KClJlZ2FyZHMtLQpTdWJyYXRh
Cgo+IAo+IFJlZ2FyZHMuCj4gTWlhbwo+IAo+IG9uIDIwMDktMTAtMjYgMTY6MTIsIE1pYW8gWGll
IHdyb3RlOgo+ID4gVGhpcyBpcyB0aGUgcGF0Y2ggb2YgdGVzdGNhc2VzIGZvciB0aGUgZXh0NCBu
ZXcgZmVhdHVyZXMgdGVzdC4KPiA+IEl0IGNvbnRhaW5zIG11bHRpLWJsb2NrIGFsbG9jL2RlbGF5
ZWQgYWxsb2MgdGVzdCwgaW5vZGUgdmVyc2lvbiB0ZXN0LAo+ID4gam91cm5hbCBjaGVja3N1bW1p
bmcgdGVzdCwgbmFub3NlYyB0aW1lc3RhbXBzIHRlc3QsIG9ubGluZSBkZWZyYWcgdGVzdCwKPiA+
IHBlcnNpc3QgcHJlYWxsb2MgdGVzdCwgc3ViZGlyZWN0b3J5IGxpbWl0IHRlc3QgYW5kIHVuaW5p
dCBncm91cHMgdGVzdAo+ID4gb2YgZXh0NC4KPiA+IAo+ID4gSW4gdGhpcyB0ZXN0IHN1aXRlLCB0
aGVyZSBpcyB0d28gRkFJTCBpbiB0aGUgc3ViZGlyZWN0b3J5IGxpbWl0IHRlc3QuCj4gPiBJdCBp
cyBiZWNhdXNlIHdlIGNhbm4ndCBjcmVhdGUgbW9yZSB0aGFuIDMyMDAwIHN1YmRpcmVjdG9yeSB3
aGVuIGJsb2NrCj4gPiBzaXplIGlzIHNtYWxsLCBzdWNoIGFzIDEwMjQsIGFuZCB0aGUgbmFtZSBv
ZiBldmVyeSBzdWJkaXJlY3RvcnkgaXMgdmVyeQo+ID4gbG9uZywgc3VjaCBhcyBldmVyeSBuYW1l
IGlzIDI1NSBieXRlcy4gSSB0aGluayBpdCBpcyB0aGUgYnVnIG9mIHRoZSBleHQ0Lgo+ID4gCj4g
PiBOb3RlOiBZb3VyIE1VU1QgcnVuIGNvbmZpZ3VyZSBpbiB0aGUgZGlyZWN0b3J5Cj4gPiAgICAg
dGVzdGNhc2VzL2tlcm5lbC9mcy9leHQ0LW5ldy1mZWF0dXJlcwo+ID4gICAgICAgdG8gY29uZmln
IHRoZSB0b29sIG9mIGZmc2IsIGFuZCBzcGVjaWZ5IGEgcGFydGl0aW9uIHRvIGJlIHVzZWQgZm9y
IAo+ID4gdGVzdAo+ID4gICAgICAgYmVmb3JlIGNvbXBpbGluZyB0aGUgdG9vbC4gVGhlIGRhdGEg
b24gdGhlIHNwZWNpZmllZCBwYXJ0aXRpb24gCj4gPiB3b3VsZCBiZQo+ID4gICAgICAgREVTVFJP
WUVELgo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWFvIFhpZSA8bWlhb3hAY24uZnVqaXRzdS5j
b20+Cj4gCj4gCj4gCj4gCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gQ29tZSBidWlsZCB3aXRo
IHVzISBUaGUgQmxhY2tCZXJyeShSKSBEZXZlbG9wZXIgQ29uZmVyZW5jZSBpbiBTRiwgQ0EKPiBp
cyB0aGUgb25seSBkZXZlbG9wZXIgZXZlbnQgeW91IG5lZWQgdG8gYXR0ZW5kIHRoaXMgeWVhci4g
SnVtcHN0YXJ0IHlvdXIKPiBkZXZlbG9waW5nIHNraWxscywgdGFrZSBCbGFja0JlcnJ5IG1vYmls
ZSBhcHBsaWNhdGlvbnMgdG8gbWFya2V0IGFuZCBzdGF5IAo+IGFoZWFkIG9mIHRoZSBjdXJ2ZS4g
Sm9pbiB1cyBmcm9tIE5vdmVtYmVyIDkgLSAxMiwgMjAwOS4gUmVnaXN0ZXIgbm93IQo+IGh0dHA6
Ly9wLnNmLm5ldC9zZnUvZGV2Y29uZmVyZW5jZQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCj4gTHRwLWxpc3QgbWFpbGluZyBsaXN0Cj4gTHRwLWxpc3RA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlz
dHMvbGlzdGluZm8vbHRwLWxpc3QKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ29tZSBidWlsZCB3
aXRoIHVzISBUaGUgQmxhY2tCZXJyeShSKSBEZXZlbG9wZXIgQ29uZmVyZW5jZSBpbiBTRiwgQ0EK
aXMgdGhlIG9ubHkgZGV2ZWxvcGVyIGV2ZW50IHlvdSBuZWVkIHRvIGF0dGVuZCB0aGlzIHllYXIu
IEp1bXBzdGFydCB5b3VyCmRldmVsb3Bpbmcgc2tpbGxzLCB0YWtlIEJsYWNrQmVycnkgbW9iaWxl
IGFwcGxpY2F0aW9ucyB0byBtYXJrZXQgYW5kIHN0YXkgCmFoZWFkIG9mIHRoZSBjdXJ2ZS4gSm9p
biB1cyBmcm9tIE5vdmVtYmVyIDkgLSAxMiwgMjAwOS4gUmVnaXN0ZXIgbm93IQpodHRwOi8vcC5z
Zi5uZXQvc2Z1L2RldmNvbmZlcmVuY2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9s
dHAtbGlzdAo=
