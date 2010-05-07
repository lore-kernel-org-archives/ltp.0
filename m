Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OAJJy-000740-Gv
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 08:54:10 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OAJJx-00055R-HK
	for ltp-list@lists.sourceforge.net; Fri, 07 May 2010 08:54:10 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o478kh6h027549
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 02:46:43 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o478s26f177768
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 02:54:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o478s2NW014325
	for <ltp-list@lists.sourceforge.net>; Fri, 7 May 2010 02:54:02 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <q2q364299f41005061042p588281bdoefb81e77aedca964@mail.gmail.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065801.23879.92449.sendpatchset@subratamodak.linux.ibm.com>
	<4BE26A1A.1000102@in.ibm.com>
	<239C044B-6014-4FA7-AC8B-6D71AFE8FEDA@gmail.com>
	<4BE285FF.9030104@in.ibm.com>
	<q2q364299f41005061042p588281bdoefb81e77aedca964@mail.gmail.com>
Date: Fri, 07 May 2010 14:23:57 +0530
Message-Id: <1273222437.6042.2.camel@subratamodak.linux.ibm.com>
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, Suzuki Poulose <suzuki@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

T24gVGh1LCAyMDEwLTA1LTA2IGF0IDEwOjQyIC0wNzAwLCBHYXJyZXR0IENvb3BlciB3cm90ZToK
PiBPbiBUaHUsIE1heSA2LCAyMDEwIGF0IDI6MDMgQU0sIFN1enVraSBQb3Vsb3NlIDxzdXp1a2lA
aW4uaWJtLmNvbT4gd3JvdGU6Cj4gPiBPbiDgtLXgtY3gtK/gtL7gtLTgtIIgMDYg4LSu4LWG4LSv
4LWNIDIwMTAgMDE6MjUg4LS14LWI4LSV4LWBLCBHYXJyZXR0IENvb3BlciB3cm90ZToKPiA+Pgo+
ID4+IE9uIE1heSA2LCAyMDEwLCBhdCAxMjowNCBBTSwgU3V6dWtpIFBvdWxvc2Ugd3JvdGU6Cj4g
Pj4KPiA+Pj4gPGZpeC10aW1lci10ZXN0cy1iYWQtaGVhZGVyLmRpZmY+Cj4gPj4KPiA+PiAgICAg
ICAgTWF5YmUgYSBiZXR0ZXIgc29sdXRpb24gd291bGQgYmUgdG8gTlVMTCB0ZXJtaW5hdGUgdGhl
IGFycmF5ICh3ZWxsLAo+ID4+IG9yIGRvIHNpbWlsYXIpPyBVc2luZyB0d28gdW5pdHMgb2YgbWVh
c3VyZW1lbnQganVzdCBzZWVtcyBsaWtlIGl0J2QKPiA+PiBjb21wbGljYXRlIGhvdyB0aGluZ3Mg
YXJlIGJlaW5nIHBlcmZvcm1lZC4uLgo+ID4KPiA+IFVzZWQgTUFYX0NMT0NLUyB0byBtYXJrIHRo
ZSBlbmQgb2YgY2xvY2sgbGlzdCBhcnJheS4gUGF0Y2ggYXR0YWNoZWQuCj4gCj4gTG9va3MgZ29v
ZC4gQWNrZWQtYnk6IEdhcnJldHQgQ29vcGVyIDx5YW5lZ29taUBnbWFpbC5jb20+CgpPay4gRG9u
ZS4KClJlZ2FyZHMtLQpTdWJyYXRhCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBs
aXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZv
cmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
