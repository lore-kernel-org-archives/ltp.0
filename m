Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Nus5H-0004Ii-IC
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 18:47:11 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nus5F-0003WG-5E
	for ltp-list@lists.sourceforge.net; Thu, 25 Mar 2010 18:47:11 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e8.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o2PIcQ3d002204
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Mar 2010 14:38:26 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o2PIl301147608
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Mar 2010 14:47:03 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o2PIl297018235
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Mar 2010 15:47:03 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <364299f41003241048hecba971td1ed20876a398b59@mail.gmail.com>
References: <20100324133645.23583.48891.sendpatchset@subratamodak.linux.ibm.com>
	<364299f41003241048hecba971td1ed20876a398b59@mail.gmail.com>
Date: Fri, 26 Mar 2010 00:26:05 +0530
Message-Id: <1269543366.6832.1.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix fallocate() build issue for EXT4
	Online	Defragmentation Test
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
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

TWlhbywKCk9uIFdlZCwgMjAxMC0wMy0yNCBhdCAxMDo0OCAtMDcwMCwgR2FycmV0dCBDb29wZXIg
d3JvdGU6Cj4gT24gV2VkLCBNYXIgMjQsIDIwMTAgYXQgNjozNiBBTSwgU3VicmF0YSBNb2Rhawo+
IDxzdWJyYXRhQGxpbnV4LnZuZXQuaWJtLmNvbT4gd3JvdGU6Cj4gPiBFYXJsaWVyIFN1YmplY3Q6
IFJlOiBbTFRQXSBleHQ0L2U0ZGVmcmFnLmMgdGVzdGNhc2VzIGNvbXBpbGF0aW9uIGVycm9yLAo+
ID4KPiA+IEhpIEdhcnJldC9NaWFvLAo+ID4KPiA+IE9uIFBQQyBzeXN0ZW1zLCBmYWxsb2NhdGUo
KSBzZWVtcyB0byBiZSBhbHJlYWR5IGRlZmluZWQgYXQgL3Vzci9pbmNsdWRlL2JpdHMvZmNudGwu
aCwKPiA+IHNvIGJ1aWxkaW5nIEVYVDQgdGVzdCBjYXNlcyBvbiBQUEM2NCBtYWNoaW5lcyB3aWxs
IGNyZWF0ZSBidWlsZCBwcm9ibGVtcyBldmVuIGlmIHRoZQo+ID4gcHJlLXJlcXVpc2l0ZSBwYWNr
YWdlczoKPiA+Cj4gPiBlMmZzcHJvZ3MqCj4gPiBlMmZzcHJvZ3MtbGlicyoKPiA+IGUyZnNwcm9n
cy1kZXZlbCoKPiA+Cj4gPiBhcmUgcHJlc2VudC4gU28sIHRoaXMgcGF0Y2ggYWRkcyBhbiBleHRy
YSBjaGVjay4gUGxlYXNlIGxldCBtZSBrbm93IHlvdXIgdGhvdWdodHMuCj4gPgo+ID4gRXJyb3Jz
IGJvdW5kIHRvIG9jY3VyOgo+ID4gWwo+ID4gZ2NjIC1nIC1PMiAtZyAtTzIgLWZuby1zdHJpY3Qt
YWxpYXNpbmcgLXBpcGUgLVdhbGwgIC1JL3Jvb3Qvc3VicmF0YS9sdHAvbHRwLWRldi90ZXN0Y2Fz
ZXMva2VybmVsL2luY2x1ZGUgLUkuLi8uLi8uLi8uLi8uLi9pbmNsdWRlIC1JLi4vLi4vLi4vLi4v
Li4vaW5jbHVkZSAgIC1MLi4vLi4vLi4vLi4vLi4vbGliICBlNGRlZnJhZy5jICAgLWxsdHAgLWxt
IC1vIGU0ZGVmcmFnCj4gPiBlNGRlZnJhZy5jOjM4ODogZXJyb3I6IGNvbmZsaWN0aW5nIHR5cGVz
IGZvciDigJhmYWxsb2NhdGXigJkKPiA+IC91c3IvaW5jbHVkZS9iaXRzL2ZjbnRsLmg6MjQwOiBu
b3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhmYWxsb2NhdGXigJkgd2FzIGhlcmUKPiA+
IG1ha2VbMV06ICoqKiBbZTRkZWZyYWddIEVycm9yIDEKPiA+IF0KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBTdWJyYXRhIE1vZGFrIDxzdWJyYXRhQGxpbnV4LnZuZXQuaWJtLmNvbT4KPiA+IC0tLQo+
ID4KPiA+IC0tLSBsdHAtZGV2L3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0NC1uZXctZmVhdHVyZXMv
ZXh0NC1vbmxpbmUtZGVmcmFnL2U0ZGVmcmFnLmMgMjAxMC0wMy0xNSAxOTozMjoxMi4wMDAwMDAw
MDAgKzA1MzAKPiA+ICsrKyBsdHAtZGV2Lm1vZGlmaWVkL3Rlc3RjYXNlcy9rZXJuZWwvZnMvZXh0
NC1uZXctZmVhdHVyZXMvZXh0NC1vbmxpbmUtZGVmcmFnL2U0ZGVmcmFnLmMgICAgICAgIDIwMTAt
MDMtMjQgMTg6MDk6MTQuMzM2NzkzNTEzICswNTMwCj4gPiBAQCAtMzgzLDEwICszODMsMTMgQEAg
aW50IHN5bmNfZmlsZV9yYW5nZShpbnQgZmQsIGxvZmZfdCBvZmZzZQo+ID4gICogQG9mZnNldDog
ICAgICAgICAgICBmaWxlIG9mZnNldC4KPiA+ICAqIEBsZW46ICAgICAgICAgICAgICAgZmlsZSBz
aXplLgo+ID4gICovCj4gPiArCj4gPiArI2lmbmRlZiBfX05SX2ZhbGxvY2F0ZQo+ID4gIGludCBm
YWxsb2NhdGUoaW50IGZkLCBpbnQgbW9kZSwgbG9mZl90IG9mZnNldCwgbG9mZl90IGxlbikKPiA+
ICB7Cj4gPiAgICAgICAgcmV0dXJuIHN5c2NhbGwoX19OUl9mYWxsb2NhdGUsIGZkLCBtb2RlLCBv
ZmZzZXQsIGxlbik7Cj4gPiAgfQo+ID4gKyNlbmRpZgo+IAo+ICAgICBJZiBpdCdzIG5vdCBkZWZp
bmVkLCB5b3UncmUgZGVmaW5pdGVseSBpbiB0cm91YmxlIGJlY2F1c2UgdGhhdAo+IHdpbGwgcmVz
dWx0IGluIGEgY29tcGlsZSBlcnJvci4gQW4gYXV0b2NvbmYgdGVzdCBzaG91bGQgYmUgYWRkZWQg
Zm9yCj4gdGhpcyBzeXNjYWxsLCBhbmQvb3IgbGludXhfc3lzY2FsbF9udW1iZXJzLmggc2hvdWxk
IGJlIGludGVncmF0ZWQgaW50bwo+IHRoaXMgdGVzdC4gVGhhdCBtYXkgYmUgYSBiaXQgaGVhdnkg
aGFuZGVkIGJlY2F1c2UgdGhhdCB3aWxsIGludGVncmF0ZQo+IHNvbWUgbGlibHRwIHBpZWNlcyBp
bnRvIHRoZSB0ZXN0cywgYnV0IHRoYXQncyB1cCB0byBNaWFvIHRvIGRlY2lkZS4KCkRpZCB5b3Ug
Z2V0IGEgY2hhbmNlIHRvIGNoZWNrIHRoaXMgcGF0Y2ggPwoKUmVnYXJkcy0tClN1YnJhdGEKCj4g
VGhhbmtzLAo+IC1HYXJyZXR0CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkRvd25sb2FkIEludGVs
JiMxNzQ7IFBhcmFsbGVsIFN0dWRpbyBFdmFsClRyeSB0aGUgbmV3IHNvZnR3YXJlIHRvb2xzIGZv
ciB5b3Vyc2VsZi4gU3BlZWQgY29tcGlsaW5nLCBmaW5kIGJ1Z3MKcHJvYWN0aXZlbHksIGFuZCBm
aW5lLXR1bmUgYXBwbGljYXRpb25zIGZvciBwYXJhbGxlbCBwZXJmb3JtYW5jZS4KU2VlIHdoeSBJ
bnRlbCBQYXJhbGxlbCBTdHVkaW8gZ290IGhpZ2ggbWFya3MgZHVyaW5nIGJldGEuCmh0dHA6Ly9w
LnNmLm5ldC9zZnUvaW50ZWwtc3ctZGV2Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bHRwLWxpc3QK
