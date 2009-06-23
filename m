Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJ7gX-0007Ex-FS
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:13:21 +0000
Received: from e38.co.us.ibm.com ([32.97.110.159])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJ7gR-0004u7-Ie
	for ltp-list@lists.sourceforge.net; Tue, 23 Jun 2009 15:13:16 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e38.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5NFA9CI027473
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:10:09 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5NFD6EW251560
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:13:08 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5NFD5sq003555
	for <ltp-list@lists.sourceforge.net>; Tue, 23 Jun 2009 09:13:05 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245401736.13600.5.camel@munipradeep-laptop>
References: <1244618075.10778.4.camel@munipradeep-laptop>
	<1245346287.5041.32.camel@subratamodak.linux.ibm.com>
	<1245401736.13600.5.camel@munipradeep-laptop>
Date: Tue, 23 Jun 2009 20:20:42 +0530
Message-Id: <1245768642.4860.92.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH]get_mempolicy01: fix for changing failure due
	to	configuration error
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
To: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

PiA+IAo+ID4gCj4gQXMgSSBkb24ndCBrbm93IHdoYXQgYXJlIGFsbCB0aGUgZXJyb3IgcmVwb3J0
aW5nIG9wdGlvbnMgTFRQIGhhdmUsIEkKPiBjaGFuZ2VkIGl0IHRvIENPTkYuIFdlIGNhbiBjaGFu
Z2UgaXQgYWNjb3JkaW5nbHkgdG8gbmVlZC4gQ2FuIHdlIHJlcG9ydAo+IGl0IGFzIEJST0tFTiwg
YXMgc2V0X21lbXBvbGljeSBpcyBwcmV2ZW50aW5nIHRoZSBnZXRfbWVtcG9saWN5IHRlc3QgdG8K
PiBydW4/CgpNdW5pLAoKSmlyacWbIHBhdGNoIGNoZWNrZWQgaW4gdG9kYXkgc2hvdWxkIGZpeCB0
aGlzOgoKU3ViamVjdDogW0xUUF0gW1BBVENIXSBEZWZpbmUgc29tZSBzeXNjYWxsIG51bWJlcnMg
aW4gdGhlCmxpbnV4X3N5c2NhbGxfbnVtYmVycy5oIGZpbGUsIG5vdCB0byBnZXQgYnVpbGQgZmFp
bHVyZXMgb3IgY3JhcHB5CnJlc3VsdHMgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyB3aGljaCBsYWNr
IHRoZW0KClJlZ2FyZHMtLQpTdWJyYXRhCgo+IAo+IFJlZ2FyZHMKPiBNdW5pCj4gCgoKLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCkFyZSB5b3UgYW4gb3BlbiBzb3VyY2UgY2l0aXplbj8gSm9pbiB1cyBm
b3IgdGhlIE9wZW4gU291cmNlIEJyaWRnZSBjb25mZXJlbmNlIQpQb3J0bGFuZCwgT1IsIEp1bmUg
MTctMTkuIFR3byBkYXlzIG9mIHNlc3Npb25zLCBvbmUgZGF5IG9mIHVuY29uZmVyZW5jZTogJDI1
MC4KTmVlZCBhbm90aGVyIHJlYXNvbiB0byBnbz8gMjQtaG91ciBoYWNrZXIgbG91bmdlLiBSZWdp
c3RlciB0b2RheSEKaHR0cDovL2FkLmRvdWJsZWNsaWNrLm5ldC9jbGs7MjE1ODQ0MzI0OzEzNTAz
MDM4O3Y/aHR0cDovL29wZW5zb3VyY2VicmlkZ2Uub3JnCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMv
bGlzdGluZm8vbHRwLWxpc3QK
