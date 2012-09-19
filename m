Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TEElo-0000Jb-50
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 07:32:28 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TEEli-0003CC-Ab
	for ltp-list@lists.sourceforge.net; Wed, 19 Sep 2012 07:32:28 +0000
Date: Wed, 19 Sep 2012 03:32:14 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <57494751.2168861.1348039934791.JavaMail.root@redhat.com>
In-Reply-To: <50591BB1.8030406@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] pthread_detach: avoid threads sharing stack
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net, Kang Kai <Kai.Kang@windriver.com>

CgotLS0tLSBPcmlnaW5hbCBNZXNzYWdlIC0tLS0tCj4gRnJvbTogIldhbmxvbmcgR2FvIiA8Z2Fv
d2FubG9uZ0Bjbi5mdWppdHN1LmNvbT4KPiBUbzogIkphbiBTdGFuY2VrIiA8anN0YW5jZWtAcmVk
aGF0LmNvbT4KPiBDYzogIkthbmcgS2FpIiA8S2FpLkthbmdAd2luZHJpdmVyLmNvbT4sIGx0cC1s
aXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IFNlbnQ6IFdlZG5lc2RheSwgMTkgU2VwdGVtYmVy
LCAyMDEyIDM6MTE6MTMgQU0KPiBTdWJqZWN0OiBSZTogW0xUUF0gW1BBVENIXSBwdGhyZWFkX2Rl
dGFjaDogYXZvaWQgdGhyZWFkcyBzaGFyaW5nIHN0YWNrCj4gCj4gT24gMDkvMTgvMjAxMiAwNTow
OCBQTSwgS2FuZyBLYWkgd3JvdGU6Cj4gPiBPbiAyMDEy5bm0MDnmnIgxOOaXpSAxNToxMCwgV2Fu
bG9uZyBHYW8gd3JvdGU6Cj4gPj4gSGkgS2FuZywKPiA+Pgo+ID4+PiBUaGlzIHRlc3RjYXNlIHdh
cyBvYnNlcnZlZCB0byBjcmFzaCB3aXRoIHNlZ21lbnRhdGlvbiBmYXVsdDoKPiA+Pj4gaHR0cDov
L3d3dy5tYWlsLWFyY2hpdmUuY29tL2x0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldC9tc2cx
NDY5Mi5odG1sCj4gPiAKPiA+IEhpIFdhbmxvbmcsCj4gPiAKPiA+PiBIYXZlIHlvdSB0ZXN0ZWQg
dGhpcyBwYXRjaCBmcm9tIEphbiBvbiB5b3VyIHN5c3RlbT8KPiA+IAo+ID4gSXQgb3JpZ2luYWxs
eSBmYWlscyBvbiByb3V0ZXJzdGF0aW9uKG1pcHMpIGFuZCB0ZXN0IEphbidzIHBhdGNoIDEwMAo+
ID4gdGltZXMgYW5kIHBhc3MuCj4gPiBUaGUgcGF0Y2ggYWxzbyBwYXNzZXMgb24geDg2IHdpdGgg
WW9jdG8gbGludXggYW5kIHg4Nl82NCB3aXRoCj4gPiBVYnVudHUgMTEuMTAuCj4gCj4gT0ssIHNv
LCBKYW4sIGNhbiB5b3Ugd29yayBvdXQgYSBjbGVhbiBwYXRjaCB3aXRob3V0IGNvZGluZyBzdHls
ZQo+IGNoYW5nZT8gSSBtZWFuIGp1c3QKPiBjaGFuZ2UgdGhlIGNvZGUgcmVsYXRlZCB5b3VyIHRo
ZW9yeSwgaXQnbGwgbWFrZSB0aGUgcGF0Y2ggbG9va3MgbW9yZQo+IGNsZWFybHkuCgpQb3N0ZWQg
djIgd2l0aCBhbGwgY29kaW5nIHN0eWxlIGNoYW5nZXMgcmVtb3ZlZC4KClJlZ2FyZHMsCkphbgoK
PiAKPiBPUiwgc3R5bGUgY2xlYW51cCBjYW4gZ28gZmlyc3RseSBiZWZvcmUgdGhlIHRoZW9yeSBj
aGFuZ2Ugd2l0aGluCj4gc2VwYXJhdGUgcGF0Y2hlcy4KPiAKPiBUaGFua3MsCj4gV2FubG9uZyBH
YW8KPiAKPiAKPiAKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMaXZlIFNlY3VyaXR5IFZpcnR1YWwg
Q29uZmVyZW5jZQpFeGNsdXNpdmUgbGl2ZSBldmVudCB3aWxsIGNvdmVyIGFsbCB0aGUgd2F5cyB0
b2RheSdzIHNlY3VyaXR5IGFuZCAKdGhyZWF0IGxhbmRzY2FwZSBoYXMgY2hhbmdlZCBhbmQgaG93
IElUIG1hbmFnZXJzIGNhbiByZXNwb25kLiBEaXNjdXNzaW9ucyAKd2lsbCBpbmNsdWRlIGVuZHBv
aW50IHNlY3VyaXR5LCBtb2JpbGUgc2VjdXJpdHkgYW5kIHRoZSBsYXRlc3QgaW4gbWFsd2FyZSAK
dGhyZWF0cy4gaHR0cDovL3d3dy5hY2NlbGFjb21tLmNvbS9qYXcvc2ZybmwwNDI0MjAxMi8xMTQv
NTAxMjIyNjMvCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ckx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
