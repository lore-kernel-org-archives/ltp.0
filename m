Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaNY-0006Lo-8m
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:24 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaNR-00055f-E1
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:24 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UIOthe031458
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:24:55 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UITB2v220238
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UITBCN005705
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:11 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A65CA56.20801@petalogix.com>
References: <364299f40907181419y73621db2w1242b7a1fa7650c@mail.gmail.com>
	<4A63FFC3.80304@petalogix.com>
	<364299f40907200032x28cc62cdn73ebb42f31d80361@mail.gmail.com>
	<4A65BC10.8000908@petalogix.com>
	<364299f40907210657t2f03bec4qd5deaf697b12f1e9@mail.gmail.com>
	<4A65CA56.20801@petalogix.com>
Date: Thu, 30 Jul 2009 23:58:59 +0530
Message-Id: <1248978539.5788.58.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 3/4] Make system enhancements, Draft 3
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
To: michal.simek@petalogix.com
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

T24gVHVlLCAyMDA5LTA3LTIxIGF0IDE2OjAxICswMjAwLCBNaWNoYWwgU2ltZWsgd3JvdGU6IAo+
IEdhcnJldHQgQ29vcGVyIHdyb3RlOgo+ID4gT24gVHVlLCBKdWwgMjEsIDIwMDkgYXQgNjowMSBB
TSwgTWljaGFsIFNpbWVrPG1pY2hhbC5zaW1la0BwZXRhbG9naXguY29tPiB3cm90ZToKPiA+ICAg
Cj4gPj4gR2FycmV0dCBDb29wZXIgd3JvdGU6Cj4gPj4gICAgIAo+ID4+PiBPbiBTdW4sIEp1bCAx
OSwgMjAwOSBhdCAxMDoyNSBQTSwgTWljaGFsCj4gPj4+IFNpbWVrPG1pY2hhbC5zaW1la0BwZXRh
bG9naXguY29tPiB3cm90ZToKPiA+Pj4gICAgICAgCj4gPj4+Pj4gK0xJQk9CSlMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICA6PSAkJChhZGRwcmVmaXggJCQoYnVpbGRkaXIpLywkJChwYXRz
dWJzdCAlLmMsJS5vLCQkKExJQlNSQ1MpKSkKPiA+Pj4+Pgo+ID4+Pj4+Cj4gPj4+Pj4gICAgICAg
ICAgIAo+ID4+Pj4gbG9uZyBsaW5lLgo+ID4+Pj4KPiA+Pj4+ICAgICAgICAgCj4gPj4+IEkgdHJ5
IG15IGJlc3QgdG8gZG8gdHdvIHRoaW5ncyB3aXRoIG1ha2VmaWxlIGNvZGU6Cj4gPj4+IDEuIGFs
aWduIE1ha2VmaWxlIGNvZGUgd2l0aCBzaW5nbGUgdGFiLCB0aGVuIHNwYWNlcy4KPiA+Pj4gMi4g
Y29tcHJlc3MgYXMgbWFueSBzdGF0ZW1lbnRzIGFzIHBvc3NpYmxlIHRvIHJlZHVjZSB0aGUgbnVt
YmVyIG9mCj4gPj4+IHJlcXVpcmVkIGV2YWx1YXRpb24gc3RlcHMsIGJlY2F1c2UgdGhhdCBjYW4g
cmVzdWx0IGluIGludGVyZXN0aW5nCj4gPj4+IGJlaGF2aW9yIGZyb20gbWFrZSB3aXRoIGRlZmlu
ZSBibG9ja3MuLi4KPiA+Pj4KPiA+Pj4gSSB3aWxsIHRyeSBhbmQgY29tcHJlc3MgdGhlIHNwYWNl
IGZ1cnRoZXIgKHRoYXQgbGluZSB3YXMgdGFiCj4gPj4+IHNlcGFyYXRlZCkgaW4gYSBzdHlsZSBj
bGVhbnVwIGNvbW1pdCBhZnRlciB0aGlzIGlzIGFsbCBzYWlkIGFuZAo+ID4+PiBjb21taXR0ZWQs
IGlmIEkgZG9uJ3QgZ2V0IHRvIGl0IHNvb25lci4gSXQncyBqdXN0IGVhc2llciB0byBhZGQgYW5k
Cj4gPj4+IGRlbGV0ZSB0YWJzIGZvciBub3cgOikuCj4gPj4+Cj4gPj4+ICAgICAgIAo+ID4+IG1h
a2Ugbm8gc2Vuc2UgdG8gc2VuZCBhIHBhdGNoIHdpdGggY29kaW5nIHN0eWxlIHZpb2xhdGlvbiBh
bmQgdGhlbiBzZW5kCj4gPj4gbmV4dCBwYXRjaAo+ID4+IHdoaWNoIGZpeGVkIHRoYXQgYmFkIGNv
ZGluZyBzdHlsZS4gSXQgaXMgYmV0dGVyIHRvIGRvIGl0IHByb3Blcmx5IGluCj4gPj4gZmlyc3Qg
dGltZS4KPiA+PiBXZSBoYXZlIHRvIGNsZWFuIHdob2xlIExUUCBzb3VyY2UgY29kZSBub3QgcG9s
bHV0ZSBpdC4KPiA+PiAgICAgCj4gPgo+ID4gSSBhbSBjbGVhbmluZyB1cCBhIGxvdCBtb3JlIGBz
dHlsZS1ndWlkZSB2aW9sYXRpb25zJyB0aGFuIEkgYW0gY2F1c2luZyBpbiBMVFAuCj4gPgo+ID4g
QWxsIENpc2NvIGxldmVsIHByb2plY3Qgc3VwcG9ydCBmb3IgTFRQIGhhcyBiZWVuIHlhbmtlZCBy
ZWNlbnRseSBkdWUKPiA+IHRvIGxpbWl0ZWQgcmVzdHJ1Y3R1cmluZyAodGhlIG90aGVyIGdlbnRs
ZW1hbiB0aGF0IHdhcyBnb2luZyB0byBoZWxwCj4gPiBtZSBpcyBubyBsb25nZXIgcGFydCBvZiBt
eSBwcm9qZWN0IGFzIHdlbGwpLCBzbyBJJ20gZG9pbmcgdGhpcyBzb2xlbHkKPiA+IG9uIG15IHNw
YXJlIHRpbWUuCj4gPgo+ID4gSWYgeW91IF93YW50XyB0byBmaXggdGhlIGl0ZW1zLCB5b3UgY2Fu
IHRvbyAtLSB0aGlzIGlzIGFuIG9wZW5zb3VyY2UKPiA+IHByb2plY3QgeW91IGtub3cgOykuLi4g
SSBhbSBhd2FyZSBvZiB0aGUgZXllc29yZXMgYW5kIEknbGwgZ2V0IHRvIHRoZW0KPiA+IGFzIHNv
b24gYXMgSSBjYW4uCj4gPgo+ID4gMS4gSWYgaXQgYnJlYWtzIGZ1bmN0aW9uYWxpdHksIGl0IG5l
ZWRzIHRvIGJlIGZpeGVkIGJlZm9yZSBjb21taXQuCj4gPiAyLiBJZiBpdCdzIGFuIGV5ZXNvcmUs
IEknbGwgcHJpb3JpdGl6ZSBpdCBhbmQgZml4IGl0IEFTQVAuCj4gPgo+ID4gQlRXLCBBRkFJSyB0
aGVyZSBpc24ndCBhIHN0eWxlIGd1aWRlIGZvciBMVFAgLS0gc28gYmVmb3JlIGNvcnJlY3RpbmcK
PiA+IG1lIG9uIHN0eWxlIEknZCBwcm9kdWNlIGEgd3JpdGV1cCBzdGF0aW5nIHRoYXQgX3RoaXNf
IGlzIGhvdyBJIG5lZWQgdG8KPiA+IGNvZGUgbXkgY29kZSBpbiBvcmRlciB0byBtZWV0IExUUCdz
IHN0YW5kYXJkcywgcGxlYXNlLgo+ID4gICAKPiBXZSB0YWxrZWQgYWJvdXQgY29kaW5nIHN0eWxl
IGZvciBMVFAgc29tZSBtb250aCBhZ28uIExUUCBzaG91bGQgZm9sbG93Cj4gbGludXgga2VybmVs
IGNvZGluZyBzdHlsZS4gSSB0aG91Z2ggdGhhdCBTdWJyYXRhIHdyb3RlIGl0IHNvbWV3aGVyZSwK
PiBkaWRuJ3QgeW91PwoKWWVzLCB3ZSBkZWNpZGVkIG9uIHRoYXQgYW5kIGV2ZW4gdGFsa2VkIGFi
b3V0IGNoZWNrcGF0Y2gucGwgZnJvbSBrZXJuZWwKc291cmNlcyB0byB2ZXJpZnkgb3VyIHBhdGNo
ZXMgYXMgd2VsbC4gSSBkbyBub3Qga25vdyBpZiBpIGhhdmUgcmVjb3JkZWQKaXQgc29tZXdoZXJl
LiBZZXMsIGxldCBtZSBmaXggdXAgdGhlIGRvY3VtZW50YXRpb24gYXMgd2VsbCwgd2hpY2ggaSB3
aWxsCnByb2JhYmx5IGRvIHdpdGggdG9tb3Jyb3fFmyByZWxlYXNlLgoKUmVnYXJkcy0tClN1YnJh
dGEKCj4gT24gdGhlIGJhc2Ugb24gaXQgSSBmaXhlZCBhIGxvdCBvZiBzeXNjYWxscyB0ZXN0cyBp
biBteSBzcGFyZSB0aW1lIHRvby4KPiAKPiBNaWNoYWwKPiAKPiA+IFRoYW5rcywKPiA+IC1HYXJy
ZXR0Cj4gPiAgIAo+IAo+IAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBv
cnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5nIC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1E
YXkgCnRyaWFsLiBTaW1wbGlmeSB5b3VyIHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBk
ZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9uIAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0
aW9uIGNvZGluZy4gRGlzY292ZXIgd2hhdCdzIG5ldyB3aXRoIApDcnlzdGFsIFJlcG9ydHMgbm93
LiAgaHR0cDovL3Auc2YubmV0L3NmdS9ib2JqLWp1bHkKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxp
c3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9s
aXN0aW5mby9sdHAtbGlzdAo=
