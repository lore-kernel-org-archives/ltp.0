Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tosubrata@gmail.com>) id 1MLdEz-00034F-M4
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 13:19:17 +0000
Received: from mail-px0-f181.google.com ([209.85.216.181])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLdEy-0001I4-Cm
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 13:19:17 +0000
Received: by pxi11 with SMTP id 11so106766pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 30 Jun 2009 06:18:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810906300559s5be55da1h477fba50da33e3e4@mail.gmail.com>
References: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
	<1246015980.6196.20.camel@subratamodak.linux.ibm.com>
	<1246347680.4819.31.camel@subratamodak.linux.ibm.com>
	<f5a7b3810906300250o6ee16e3bv672ad77018d34a81@mail.gmail.com>
	<1246356254.4819.39.camel@subratamodak.linux.ibm.com>
	<f5a7b3810906300559s5be55da1h477fba50da33e3e4@mail.gmail.com>
Date: Tue, 30 Jun 2009 18:48:40 +0530
Message-ID: <bb33bcf20906300618i54b43b82n2fd6fde95ec992ab@mail.gmail.com>
From: Subrata Modak <tosubrata@gmail.com>
Subject: Re: [LTP] [PATCH] Re::personality test case build fails
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: Jiri Palecek <jpalecek@web.de>, Pradeep K Surisetty <pradeepkumars@in.ibm.com>, ltp-list@lists.sourceforge.net

T24gVHVlLCBKdW4gMzAsIDIwMDkgYXQgNjoyOSBQTSwgbmFyZXNoIGthbWJvanU8bmFyZXNoLmtl
cm5lbEBnbWFpbC5jb20+IHdyb3RlOgo+Pj4gPgo+Pj4gPiBOYXJlc2ggPz8KPj4+Cj4+PiBIaSBT
dWJyYXRhLAo+Pj4KPj4+IEkgaGF2ZSBub3RpY2VkIHNvbWUgaXNzdWUgd2l0aCBwZXJzb25hbGl0
eTAxLmMgYW5kIHBlcnNvbmFsaXR5MDIuYwo+Pj4gdGVzdCBjYXNlcyBpbiBkZXNpZ24uCj4+Cj4+
IEdyZWF0LiBBbmQgd2hhdCBkZXNpZ24gcmV2aWV3cyBmb3IgdGhlIG5ld2x5IHBvcnRlZCB0ZXN0
cyBpbiBMVFAgPwo+Cj4KPiBUaGUgcGVyc29uYWxpdHkgaXMgZGlmZmVyZW50IGZvciBkaWZmIEFS
Q0ggYW5kIHRoZXJlIGFyZSAyMwo+IHBlcnNvbmFsaXRpZXMgYXJlIGF2YWlsYWJsZS4gcHJlc2Vu
dCB0ZXN0IGNhc2UgaXMgZGVzaWduIHRvIHN1cHBvcnQKPiBYODYgQVJDSCAuQ3VycmVudGx5IGNo
ZWNraW5nIGFwcGxpY2FiaWxpdHkgYW5kIG1ha2luZyB0aGUgdGVzdCBjYXNlcwo+IGFzIGdlbmVy
aWMgdG8gc3VwcG9ydCBtb3N0IG9mIHRoZSBBUkNILgo+Cj4gVGhpcyBpcyBjb21tZW50ZWQgdGVz
dCBjYXNlcyB1bmRlciBzeXNjYWxscyBvbiB2ZXIgMS4xNTQKPgo+IGh0dHA6Ly9sdHAuY3ZzLnNv
dXJjZWZvcmdlLm5ldC92aWV3dmMvbHRwL2x0cC9ydW50ZXN0L3N5c2NhbGxzP3ZpZXc9bG9nCj4K
Pgo+ICMgwqBUaGUgcGVyc29uYWxpdHkoKSBzeXN0ZW0gY2FsbCBpcyBwb29ybHkgZG9jdW1lbnRl
ZAo+ICMgwqBhbmQgZGlmZmljdWx0IHRvIGZpZ3VyZSBvdXQgaG93IHRvIHVzZSBieSBsb29raW5n
Cj4gIyDCoGF0IHRoZSBkaWZmZXJlbnQgYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGtlcm5lbCBmaWxl
cy4KPiAjcGVyc29uYWxpdHkwMSBwZXJzb25hbGl0eTAxCj4gI3BlcnNvbmFsaXR5MDIgcGVyc29u
YWxpdHkwMgo+Cj4gU3VicmF0YSwKPgo+IERvIHlvdSB3YW50IHRvIGluY2x1ZGUgdGhlc2UgdGVz
dCBjYXNlcyBpbiB0aGlzIHJlbGVhc2U/CgpOb3BlLiBVbnRpbCB0aGV5IGFyZSBmaXhlZCBwcm9w
ZXJseS4gU2VlbXMgUm9iYmllIGNvbW1lbnRlZCB0aGVtIGxvbmcKYmFjay4gQnV0LCB0aGVzZSB0
ZXN0cyBoYXZlIGJlZW4gYnVpbGRpbmcgZmluZSBmb3IgcXVpdGUgbG9uZyB0aW1lCndpdGhvdXQg
b3VyIGtub3dsZWRnZSwgdGhvdWdoIHRoZXkgd2VyZSBub3QgcnVubmluZy4KClJlZ2FyZHMtLQpT
dWJyYXRhCgo+Cj4gSWYgeW91IGhhdmUgaXNzdWVzIHBsZWFzZSBsZXQgbWUga25vdy4KPgo+IEJl
c3QgcmVnYXJkcywKPiBOYXJlc2ggS2FtYm9qdQo+Cj4+Cj4+IFJlZ2FyZHMtLQo+PiBTdWJyYXRh
Cj4+Cj4+PiBDdXJyZW50bHkgSSBhbSBpbnZlc3RpZ2F0aW5nIGFuZCBnZXQgYmFjayB0byBpbiBz
aG9ydC4KPj4+Cj4+PiBCZXN0IFJlZ2FyZHMKPj4+IE5hcmVzaCBLYW1ib2p1Cj4+Pgo+Pj4gPgo+
Pj4gPj4gUmVnYXJkcy0tCj4+PiA+PiBTdWJyYXRhCj4+PiA+Pgo+Pj4gPj4gPiBKaXJpLAo+Pj4g
Pj4gPiBJIHRoaW5rIHlvdSBhcmUgZG9pbmcgTXVsdGkgQVJDSCBzdXBwb3J0IHJpZ2h0Pwo+Pj4g
Pj4gPgo+Pj4gPj4gPiBZb3VyIHN1Z2dlc3Rpb25zIGFyZSB3ZWxjb21lIDopCj4+PiA+PiA+Cj4+
PiA+PiA+IEJlc3QgcmVnYXJkcwo+Pj4gPj4gPiBOYXJlc2ggS2FtYm9qdQo+Pj4KPj4+ID4+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gPj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KPj4+ID4+IEx0cC1saXN0IG1haWxpbmcgbGlzdAo+Pj4gPj4gTHRw
LWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4+PiA+PiBodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo+Pj4gPgo+Pj4gPgo+Pgo+Pgo+Cj4gLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KPiBMdHAtbGlzdCBtYWlsaW5nIGxpc3QKPiBMdHAtbGlzdEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKPiBodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by9sdHAtbGlzdAo+CgoKCi0tIApSZWdhcmRzICYgVGhhbmtzLS0KU3VicmF0YQoKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQK
aHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
