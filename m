Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OdoVq-0005Om-QF
	for ltp-list@lists.sourceforge.net; Tue, 27 Jul 2010 18:04:22 +0000
Received: from e1.ny.us.ibm.com ([32.97.182.141])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OdoVp-0006Gn-BS
	for ltp-list@lists.sourceforge.net; Tue, 27 Jul 2010 18:04:22 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6RHwa1U018007
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 13:58:36 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6RI4FS5045160
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 14:04:15 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6RI4EQd008220
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 15:04:14 -0300
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1275483478.4899.8.camel@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
	<4BE26A1A.1000102@in.ibm.com>
	<239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
	<4BE285FF.9030104@in.ibm.com>  <4C0529F8.8060906@in.ibm.com>
	<1275483478.4899.8.camel@subratamodak.linux.ibm.com>
Date: Tue, 27 Jul 2010 23:33:49 +0530
Message-Id: <1280253830.7374.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [08/12 FAILURE] LTPE clock gettime03 fails
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
To: Suzuki Poulose <suzuki@in.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

VGhpcyBhbHNvIGlzIHJlc29sdmVkIG5vdy4KClJlZ2FyZHMtLQpTdWJyYXRhCgpPbiBXZWQsIDIw
MTAtMDYtMDIgYXQgMTg6MjcgKzA1MzAsIFN1YnJhdGEgTW9kYWsgd3JvdGU6Cj4gT24gVHVlLCAy
MDEwLTA2LTAxIGF0IDIxOjEwICswNTMwLCBTdXp1a2kgUG91bG9zZSB3cm90ZTogCj4gPiBPbiDg
tLXgtY3gtK/gtL7gtLTgtIIgMDYg4LSu4LWG4LSv4LWNIDIwMTAgMDI6MzMg4LS14LWI4LSV4LWB
LCBTdXp1a2kgUG91bG9zZSB3cm90ZToKPiA+ID4gT24g4LS14LWN4LSv4LS+4LS04LSCIDA2IOC0
ruC1huC0r+C1jSAyMDEwIDAxOjI1IOC0teC1iOC0leC1gSwgR2FycmV0dCBDb29wZXIgd3JvdGU6
Cj4gPiA+PiBPbiBNYXkgNiwgMjAxMCwgYXQgMTI6MDQgQU0sIFN1enVraSBQb3Vsb3NlIHdyb3Rl
Ogo+ID4gPj4KPiA+ID4+PiA8Zml4LXRpbWVyLXRlc3RzLWJhZC1oZWFkZXIuZGlmZj4KPiA+ID4+
Cj4gPiA+PiBNYXliZSBhIGJldHRlciBzb2x1dGlvbiB3b3VsZCBiZSB0byBOVUxMIHRlcm1pbmF0
ZSB0aGUgYXJyYXkgKHdlbGwsIG9yCj4gPiA+PiBkbyBzaW1pbGFyKT8gVXNpbmcgdHdvIHVuaXRz
IG9mIG1lYXN1cmVtZW50IGp1c3Qgc2VlbXMgbGlrZSBpdCdkCj4gPiA+PiBjb21wbGljYXRlIGhv
dyB0aGluZ3MgYXJlIGJlaW5nIHBlcmZvcm1lZC4uLgo+ID4gPgo+ID4gPiBVc2VkIE1BWF9DTE9D
S1MgdG8gbWFyayB0aGUgZW5kIG9mIGNsb2NrIGxpc3QgYXJyYXkuIFBhdGNoIGF0dGFjaGVkLgo+
ID4gCj4gPiBKdXN0IHJlYWxpemVkIHRoYXQsIEkgc2VudCB0aGUgdmVyeSBvbGQgcGF0Y2ggbm90
IHRoZSB1cGRhdGVkIG9uZS4gSGVyZSAKPiA+IGlzIHRoZSB1cGRhdGVkIG9uZToKPiAKPiBTZWVt
cyBsaWtlIGkgd2FzIG5vdCBhYmxlIHRvIGFwcGx5IHRoZSBuZXcgb25lIGV2ZW4gYWZ0ZXIgcmV2
ZXJ0aW5nIHRoZQo+IG9sZCBvbmUgYmFjay4gQ2FuIHlvdSBwbGVhc2UgcmViYXNlIGFuZCByZXNl
bmQgOi0oCj4gCj4gUmVnYXJkcy0tCj4gU3VicmF0YQo+IAo+ID4gCj4gPiAKPiA+ID4KPiA+ID4K
PiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+IFN1enVraQo+ID4gPj4gVGhhbmtzLAo+ID4gPj4gLUdh
cnJldHQKPiA+ID4KPiA+IAo+IAo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IAo+IF9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTHRwLWxpc3QgbWFp
bGluZyBsaXN0Cj4gTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QKCgotLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KVGhlIFBhbG0gUERLIEhvdCBBcHBzIFByb2dyYW0gb2ZmZXJzIGRldmVsb3BlcnMg
d2hvIHVzZSB0aGUKUGx1Zy1JbiBEZXZlbG9wbWVudCBLaXQgdG8gYnJpbmcgdGhlaXIgQy9DKysg
YXBwcyB0byBQYWxtIGZvciBhIHNoYXJlIApvZiAkMSBNaWxsaW9uIGluIGNhc2ggb3IgSFAgUHJv
ZHVjdHMuIFZpc2l0IHVzIGhlcmUgZm9yIG1vcmUgZGV0YWlsczoKaHR0cDovL2FkLmRvdWJsZWNs
aWNrLm5ldC9jbGs7MjI2ODc5MzM5OzEzNTAzMDM4O2w/Cmh0dHA6Ly9jbGsuYXRkbXQuY29tL0NS
Uy9nby8yNDc3NjU1MzIvZGlyZWN0LzAxLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291
cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZv
L2x0cC1saXN0Cg==
