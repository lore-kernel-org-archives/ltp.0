Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mpradeep@linux.vnet.ibm.com>) id 1NhzGB-0006pn-Ev
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 05:49:11 +0000
Received: from e23smtp05.au.ibm.com ([202.81.31.147])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NhzG9-0004Kk-Ud
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 05:49:11 +0000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp05.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1I5jZnZ024342
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 16:45:35 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1I5heix1642532
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 16:43:41 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1I5n1oe014611
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Feb 2010 16:49:01 +1100
From: Munipradeep Beerakam <mpradeep@linux.vnet.ibm.com>
In-Reply-To: <20100217173226.GA11743@rishikesh.in.ibm.com>
References: <1265891406.10768.10.camel@munipradeep-laptop>
	<20100211233919.GB19098@rishikesh.in.ibm.com>
	<20100217173226.GA11743@rishikesh.in.ibm.com>
Date: Thu, 18 Feb 2010 11:18:59 +0530
Message-ID: <1266472139.4066.1.camel@munipradeep-laptop>
Mime-Version: 1.0
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
To: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net

SGkgUmlzaGksCgpXaXRoIEphbiAyMDEwIGJ1aWxkIG1lbXRveSBpcyB3b3JraW5nIGZpbmUKClRo
YW5rcwpNdW5pCgpPbiBXZWQsIDIwMTAtMDItMTcgYXQgMjM6MDIgKzA1MzAsIFJpc2hpa2VzaCBL
IFJhamFrIHdyb3RlOgo+IE9uIEZyaSwgRmViIDEyLCAyMDEwIGF0IDA1OjA5OjE5QU0gKzA1MzAs
IFJpc2hpa2VzaCBLIFJhamFrIHdyb3RlOgo+ID4gT24gVGh1LCBGZWIgMTEsIDIwMTAgYXQgMDY6
MDA6MDZQTSArMDUzMCwgTXVuaXByYWRlZXAgQmVlcmFrYW0gd3JvdGU6Cj4gPiA+IEhpIFJpc2hp
LAo+ID4gPiAKPiA+ID4gSSBhbSB1bmFibGUgdG8gY29tcGlsZSB0aGUgbWVtb3J5X2hvdHBsdWcg
dGVzdHMgaW4gTFRQIFNlcCAyMDA5IHJlbGVhc2UuCj4gPiA+IEkgYW0gZ2V0dGluZyB0aGUgYmVs
b3cgZXJyb3IuCj4gPiA+IAo+ID4gPiAjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMKPiA+ID4gY2MgLXN0ZD1nbnU5OSAtTzIgIC1EX0dOVV9TT1VSQ0UgLURf
TkVFRF9NSUdSQVRFX1BBR0VTICAgICAtYyAtbwo+ID4gPiBtZW10b3kubyBtZW10b3kuYwo+ID4g
PiBjYyAtc3RkPWdudTk5IC1PMiAgLURfR05VX1NPVVJDRSAtRF9ORUVEX01JR1JBVEVfUEFHRVMg
ICAgIC1jIC1vCj4gPiA+IGNvbW1hbmRzLm8gY29tbWFuZHMuYwo+ID4gPiBJbiBmaWxlIGluY2x1
ZGVkIGZyb20gY29tbWFuZHMuYzo0NToKPiA+ID4gbWlncmF0ZV9wYWdlcy5oOjEwOiBlcnJvcjog
Y29uZmxpY3RpbmcgdHlwZXMgZm9yIOKAmG1pZ3JhdGVfcGFnZXPigJkKPiA+ID4gL3Vzci9pbmNs
dWRlL251bWFpZi5oOjE3OiBlcnJvcjogcHJldmlvdXMgZGVjbGFyYXRpb24gb2Yg4oCYbWlncmF0
ZV9wYWdlc+KAmQo+ID4gPiB3YXMgaGVyZQo+ID4gPiBtYWtlOiAqKiogW2NvbW1hbmRzLm9dIEVy
cm9yIDEKPiA+ID4gIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjCj4gPiA+IAo+ID4gPiBFdmVuIHRoZSBwYXRjaCBpcyBub3QgYXBwbHlpbmcgcHJvcGVybHku
IAo+ID4gPiAKPiA+ID4gQEFsbCwgQW55IGhlbHAgaXMgYXBwcmVjaWF0ZWQuCj4gPiBIaSBNdW5p
LAo+ID4gCj4gPiBQbGVhc2UgdXNlIGxhdGVzdCBsdHAsIGFzIGkgaGF2ZSBzZWVuIHNvbWUgY2hh
bmdlcyBoYXMgZ29uZSBmcm9tIGdhcnJldCBmb3IgZml4aW5mIGNvbXBpbGF0aW9uIGlzc3Vlcy4K
PiAKPiBIaSBNdW5pLAo+IExldCB1cyBrbm93IGlmIHlvdSBnZXQgYSBjaGFuY2UgdG8gdGVzdCB3
aXRoIGxhdGVzdCBDVlMgb3IKPiBsdHAtZnVsbC0yMDEwMDEzMS4xLnRneiA/Cj4gCj4gVGhhbmtz
IGZvciB5b3VyIHN1cHBvcnQuCj4gCj4gTXVuaQo+ID4gCj4gPiBUaGFua3MKPiA+IFJpc2hpCj4g
PiA+IAo+ID4gPiBUaGFua3MKPiA+ID4gTXVuaQo+ID4gPiAKCgoKLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkRvd25sb2FkIEludGVsJnJlZzsgUGFyYWxsZWwgU3R1ZGlvIEV2YWwKVHJ5IHRoZSBuZXcg
c29mdHdhcmUgdG9vbHMgZm9yIHlvdXJzZWxmLiBTcGVlZCBjb21waWxpbmcsIGZpbmQgYnVncyAK
cHJvYWN0aXZlbHksIGFuZCBmaW5lLXR1bmUgYXBwbGljYXRpb25zIGZvciBwYXJhbGxlbCBwZXJm
b3JtYW5jZS4gClNlZSB3aHkgSW50ZWwgUGFyYWxsZWwgU3R1ZGlvIGdvdCBoaWdoIG1hcmtzIGR1
cmluZyBiZXRhLgpodHRwOi8vcC5zZi5uZXQvc2Z1L2ludGVsLXN3LWRldgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QK
THRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2Uu
bmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
