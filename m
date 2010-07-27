Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1Odo7p-00025z-9G
	for ltp-list@lists.sourceforge.net; Tue, 27 Jul 2010 17:39:33 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Odo7m-0001fx-Vp
	for ltp-list@lists.sourceforge.net; Tue, 27 Jul 2010 17:39:33 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e34.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6RHUrfl003454
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 11:30:53 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o6RHdAcR031402
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 11:39:10 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6RHd8sh000986
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Jul 2010 11:39:08 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <BFAB6806-3BF8-4649-8CBF-B52A51AA4977@gmail.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065713.23879.94813.sendpatchset@subratamodak.linux.ibm.com>
	<BFAB6806-3BF8-4649-8CBF-B52A51AA4977@gmail.com>
Date: Tue, 27 Jul 2010 23:08:16 +0530
Message-Id: <1280252297.7374.2.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [05/12 FAILURE] LTP? proc01 test fails
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
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

VGhpcyBpcyBmaXhlZCBub3cgaW4gbGF0ZXN0IExUUC4KClJlZ2FyZHMtLQpTdWJyYXRhCgpPbiBU
aHUsIDIwMTAtMDUtMDYgYXQgMDE6MDQgLTA3MDAsIEdhcnJldHQgQ29vcGVyIHdyb3RlOgo+IE9u
IE1heSA1LCAyMDEwLCBhdCAxMTo1NyBQTSwgU3VicmF0YSBNb2RhayB3cm90ZToKPiAKPiA+IFN1
YmplY3Q6IExUUMWbIHByb2MwMSB0ZXN0IGZhaWwKPiA+IAo+ID4gSXNzdWVzIERlc2NyaXB0aW9u
IGJlbG93Ogo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gPiAjIC4v
cnVubHRwIC1zIHByb2MwMQo+ID4gCj4gPiA8PDx0ZXN0X291dHB1dD4+Pgo+ID4gcHJvYzAxICAg
ICAgMCAgVElORk8gIDogIC9wcm9jL3N5c3JxLXRyaWdnZXI6IGlzIHdyaXRlLW9ubHkuCj4gPiBw
cm9jMDEgICAgICAwICBUSU5GTyAgOiAgL3Byb2Mva21zZzoga25vd24gaXNzdWU6IGVycm5vPUVB
R0FJTigxMSk6IFJlc291cmNlCj4gPiB0ZW1wb3JhcmlseSB1bmF2YWlsYWJsZQo+ID4gcHJvYzAx
ICAgICAgMCAgVElORk8gIDogIC9wcm9jL3Bvd2VycGMvb2ZkdDogaXMgd3JpdGUtb25seS4KPiA+
IHByb2MwMSAgICAgIDEgIFRGQUlMICA6ICByZWFkIGZhaWxlZDogL3Byb2MvcG93ZXJwYy9ydGFz
L2Vycm9yX2xvZzoKPiA+IGVycm5vPUVJTlZBTCgyMik6IEludmFsaWQgYXJndW1lbnQKPiAKPiAJ
Tm90IGEga25vd24gaXNzdWUuIEknZCBjaGVjayBhbmQgc2VlIHdoZXRoZXIgb3Igbm90IHRoaXMg
aXRlbSBpcyB2YWxpZC4gU2VlbXMgbGlrZSBhIGZ1bmt5IGVycm9yIGNvZGUgdGhvdWdoLgo+IEhU
SCwKPiAtR2FycmV0dAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGUgUGFsbSBQREsgSG90IEFw
cHMgUHJvZ3JhbSBvZmZlcnMgZGV2ZWxvcGVycyB3aG8gdXNlIHRoZQpQbHVnLUluIERldmVsb3Bt
ZW50IEtpdCB0byBicmluZyB0aGVpciBDL0MrKyBhcHBzIHRvIFBhbG0gZm9yIGEgc2hhcmUgCm9m
ICQxIE1pbGxpb24gaW4gY2FzaCBvciBIUCBQcm9kdWN0cy4gVmlzaXQgdXMgaGVyZSBmb3IgbW9y
ZSBkZXRhaWxzOgpodHRwOi8vYWQuZG91YmxlY2xpY2submV0L2NsazsyMjY4NzkzMzk7MTM1MDMw
Mzg7bD8KaHR0cDovL2Nsay5hdGRtdC5jb20vQ1JTL2dvLzI0Nzc2NTUzMi9kaXJlY3QvMDEvCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1h
aWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5z
b3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
