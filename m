Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWi9H-0002Rd-Ul
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 02:47:11 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWi9B-0003WR-Nk
	for ltp-list@lists.sourceforge.net; Fri, 31 Jul 2009 02:47:11 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e9.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6V1sTsk012564
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 21:54:29 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6V1skag176084
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 21:54:46 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6V1q4eW007458
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 21:52:04 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A724B32.7070604@in.ibm.com>
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
	<364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
	<4A658302.60307@in.ibm.com>
	<1248978536.5788.57.camel@subratamodak.linux.ibm.com>
	<4A724B32.7070604@in.ibm.com>
Date: Fri, 31 Jul 2009 07:24:37 +0530
Message-Id: <1249005278.5788.79.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

U2hhcnlhdGhpLAoKT24gRnJpLCAyMDA5LTA3LTMxIGF0IDA3OjA4ICswNTMwLCBTaGFyeWF0aGkg
TmFnZXNoIHdyb3RlOgo+IFN1YnJhdGEKPiA+IAo+ID4gU2hhcnlhdGhpLCBwbGVhc2UgcmVzZW5k
IHRoaXMgY2xlYW4uCj4gPiAKPiBBdHRhY2hpbmcgaXQsIHdpdGggc2lnbmVkIG9mZiBhZGRlZAoK
VGhpcyBpcyBnb29kLiBCdXQsIHdoYXQgaSB3YW50ZWQgaXM6CgoxKSBGaW5hbCBhbmQgY2xlYXIg
ZGVzY3JpcHRpb24gb2YgdGhlIHB1cnBvc2Ugb2YgdGhlIHBhdGNoLAoyKSBTaWduZWQtb2ZmLWJ5
OiBjbGF1c2UsCjMpIFBhdGNoIGl0c2VsZiwKCkl0xZsganVzdCBsaWtlIGhvdyB5b3Ugd291bGQg
cmVzZW5kIGEgcGF0Y2ggdG8gTEtNTCwgc2F5aW5nOgoKW1BBVENIIHYyXVtSRVNFTkRdIC4uLgoK
UmVnYXJkcy0tClN1YnJhdGEKCj4gVGhhbmtzCj4gU2hhcnlhdGhpIE5hZ2VzaAo+IAoKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpMZXQgQ3J5c3RhbCBSZXBvcnRzIGhhbmRsZSB0aGUgcmVwb3J0aW5n
IC0gRnJlZSBDcnlzdGFsIFJlcG9ydHMgMjAwOCAzMC1EYXkgCnRyaWFsLiBTaW1wbGlmeSB5b3Vy
IHJlcG9ydCBkZXNpZ24sIGludGVncmF0aW9uIGFuZCBkZXBsb3ltZW50IC0gYW5kIGZvY3VzIG9u
IAp3aGF0IHlvdSBkbyBiZXN0LCBjb3JlIGFwcGxpY2F0aW9uIGNvZGluZy4gRGlzY292ZXIgd2hh
dCdzIG5ldyB3aXRoIApDcnlzdGFsIFJlcG9ydHMgbm93LiAgaHR0cDovL3Auc2YubmV0L3NmdS9i
b2JqLWp1bHkKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
THRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldApodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAo=
