Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OJnWO-0007P8-PE
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 12:58:12 +0000
Received: from e4.ny.us.ibm.com ([32.97.182.144])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OJnWK-0003rO-LC
	for ltp-list@lists.sourceforge.net; Wed, 02 Jun 2010 12:58:09 +0000
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o52Cj3nG006039
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 08:45:03 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o52Cw2n3131554
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 08:58:02 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o52Cw23N011368
	for <ltp-list@lists.sourceforge.net>; Wed, 2 Jun 2010 08:58:02 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4C0529F8.8060906@in.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
	<4BE26A1A.1000102@in.ibm.com>
	<239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
	<4BE285FF.9030104@in.ibm.com>  <4C0529F8.8060906@in.ibm.com>
Date: Wed, 02 Jun 2010 18:27:57 +0530
Message-Id: <1275483478.4899.8.camel@subratamodak.linux.ibm.com>
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

T24gVHVlLCAyMDEwLTA2LTAxIGF0IDIxOjEwICswNTMwLCBTdXp1a2kgUG91bG9zZSB3cm90ZTog
Cj4gT24g4LS14LWN4LSv4LS+4LS04LSCIDA2IOC0ruC1huC0r+C1jSAyMDEwIDAyOjMzIOC0teC1
iOC0leC1gSwgU3V6dWtpIFBvdWxvc2Ugd3JvdGU6Cj4gPiBPbiDgtLXgtY3gtK/gtL7gtLTgtIIg
MDYg4LSu4LWG4LSv4LWNIDIwMTAgMDE6MjUg4LS14LWI4LSV4LWBLCBHYXJyZXR0IENvb3BlciB3
cm90ZToKPiA+PiBPbiBNYXkgNiwgMjAxMCwgYXQgMTI6MDQgQU0sIFN1enVraSBQb3Vsb3NlIHdy
b3RlOgo+ID4+Cj4gPj4+IDxmaXgtdGltZXItdGVzdHMtYmFkLWhlYWRlci5kaWZmPgo+ID4+Cj4g
Pj4gTWF5YmUgYSBiZXR0ZXIgc29sdXRpb24gd291bGQgYmUgdG8gTlVMTCB0ZXJtaW5hdGUgdGhl
IGFycmF5ICh3ZWxsLCBvcgo+ID4+IGRvIHNpbWlsYXIpPyBVc2luZyB0d28gdW5pdHMgb2YgbWVh
c3VyZW1lbnQganVzdCBzZWVtcyBsaWtlIGl0J2QKPiA+PiBjb21wbGljYXRlIGhvdyB0aGluZ3Mg
YXJlIGJlaW5nIHBlcmZvcm1lZC4uLgo+ID4KPiA+IFVzZWQgTUFYX0NMT0NLUyB0byBtYXJrIHRo
ZSBlbmQgb2YgY2xvY2sgbGlzdCBhcnJheS4gUGF0Y2ggYXR0YWNoZWQuCj4gCj4gSnVzdCByZWFs
aXplZCB0aGF0LCBJIHNlbnQgdGhlIHZlcnkgb2xkIHBhdGNoIG5vdCB0aGUgdXBkYXRlZCBvbmUu
IEhlcmUgCj4gaXMgdGhlIHVwZGF0ZWQgb25lOgoKU2VlbXMgbGlrZSBpIHdhcyBub3QgYWJsZSB0
byBhcHBseSB0aGUgbmV3IG9uZSBldmVuIGFmdGVyIHJldmVydGluZyB0aGUKb2xkIG9uZSBiYWNr
LiBDYW4geW91IHBsZWFzZSByZWJhc2UgYW5kIHJlc2VuZCA6LSgKClJlZ2FyZHMtLQpTdWJyYXRh
Cgo+IAo+IAo+ID4KPiA+Cj4gPiBUaGFua3MKPiA+Cj4gPiBTdXp1a2kKPiA+PiBUaGFua3MsCj4g
Pj4gLUdhcnJldHQKPiA+Cj4gCgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QK
THRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
