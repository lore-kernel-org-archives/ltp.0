Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1Nfid8-0002qn-80
	for ltp-list@lists.sourceforge.net; Thu, 11 Feb 2010 23:39:30 +0000
Received: from e5.ny.us.ibm.com ([32.97.182.145])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nfid7-0001L2-Bi
	for ltp-list@lists.sourceforge.net; Thu, 11 Feb 2010 23:39:30 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e5.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o1BNQ7U5009365
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 18:26:07 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1BNdNEI145246
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 18:39:23 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1BNdNar030625
	for <ltp-list@lists.sourceforge.net>; Thu, 11 Feb 2010 21:39:23 -0200
Date: Fri, 12 Feb 2010 05:09:19 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100211233919.GB19098@rishikesh.in.ibm.com>
References: <1265891406.10768.10.camel@munipradeep-laptop>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1265891406.10768.10.camel@munipradeep-laptop>
Subject: Re: [LTP] memory_hotplug tests are not compiling properly
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

T24gVGh1LCBGZWIgMTEsIDIwMTAgYXQgMDY6MDA6MDZQTSArMDUzMCwgTXVuaXByYWRlZXAgQmVl
cmFrYW0gd3JvdGU6Cj4gSGkgUmlzaGksCj4gCj4gSSBhbSB1bmFibGUgdG8gY29tcGlsZSB0aGUg
bWVtb3J5X2hvdHBsdWcgdGVzdHMgaW4gTFRQIFNlcCAyMDA5IHJlbGVhc2UuCj4gSSBhbSBnZXR0
aW5nIHRoZSBiZWxvdyBlcnJvci4KPiAKPiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMKPiBjYyAtc3RkPWdudTk5IC1PMiAgLURfR05VX1NPVVJDRSAtRF9O
RUVEX01JR1JBVEVfUEFHRVMgICAgIC1jIC1vCj4gbWVtdG95Lm8gbWVtdG95LmMKPiBjYyAtc3Rk
PWdudTk5IC1PMiAgLURfR05VX1NPVVJDRSAtRF9ORUVEX01JR1JBVEVfUEFHRVMgICAgIC1jIC1v
Cj4gY29tbWFuZHMubyBjb21tYW5kcy5jCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGNvbW1hbmRz
LmM6NDU6Cj4gbWlncmF0ZV9wYWdlcy5oOjEwOiBlcnJvcjogY29uZmxpY3RpbmcgdHlwZXMgZm9y
IOKAmG1pZ3JhdGVfcGFnZXPigJkKPiAvdXNyL2luY2x1ZGUvbnVtYWlmLmg6MTc6IGVycm9yOiBw
cmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhtaWdyYXRlX3BhZ2Vz4oCZCj4gd2FzIGhlcmUKPiBt
YWtlOiAqKiogW2NvbW1hbmRzLm9dIEVycm9yIDEKPiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMKPiAKPiBFdmVuIHRoZSBwYXRjaCBpcyBub3QgYXBwbHlp
bmcgcHJvcGVybHkuIAo+IAo+IEBBbGwsIEFueSBoZWxwIGlzIGFwcHJlY2lhdGVkLgpIaSBNdW5p
LAoKUGxlYXNlIHVzZSBsYXRlc3QgbHRwLCBhcyBpIGhhdmUgc2VlbiBzb21lIGNoYW5nZXMgaGFz
IGdvbmUgZnJvbSBnYXJyZXQgZm9yIGZpeGluZiBjb21waWxhdGlvbiBpc3N1ZXMuCgpUaGFua3MK
UmlzaGkKPiAKPiBUaGFua3MKPiBNdW5pCj4gCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KU09MQVJJ
UyAxMCBpcyB0aGUgT1MgZm9yIERhdGEgQ2VudGVycyAtIHByb3ZpZGVzIGZlYXR1cmVzIHN1Y2gg
YXMgRFRyYWNlLApQcmVkaWN0aXZlIFNlbGYgSGVhbGluZyBhbmQgQXdhcmQgV2lubmluZyBaRlMu
IEdldCBTb2xhcmlzIDEwIE5PVwpodHRwOi8vcC5zZi5uZXQvc2Z1L3NvbGFyaXMtZGV2MmRldgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBt
YWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMu
c291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
