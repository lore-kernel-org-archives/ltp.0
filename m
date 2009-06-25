Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MJkzM-00058w-LU
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:11:24 +0000
Received: from e7.ny.us.ibm.com ([32.97.182.137])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MJkzG-0002Fe-D7
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 09:11:19 +0000
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e7.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5P8wiCE025891
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 04:58:44 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5P9BHN4245272
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 05:11:17 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5P9BHeM028930
	for <ltp-list@lists.sourceforge.net>; Thu, 25 Jun 2009 05:11:17 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <200906231721.51688.vapier@gentoo.org>
References: <4a413e95.8d13f30a.1199.ffffdccbSMTPIN_ADDED@mx.google.com>
	<200906231721.51688.vapier@gentoo.org>
Date: Thu, 25 Jun 2009 14:39:38 +0530
Message-Id: <1245920978.5542.34.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fix some bashisms
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Jiri Palecek <jpalecek@web.de>

TmV3IENoYW5nZXMgdG8gTWlrZcWbIGNvbW1lbnRzID8KClJlZ2FyZHMtLQpTdWJyYXRhCgpPbiBU
dWUsIDIwMDktMDYtMjMgYXQgMTc6MjEgLTA0MDAsIE1pa2UgRnJ5c2luZ2VyIHdyb3RlOiAKPiBP
biBTdW5kYXkgMzEgTWF5IDIwMDkgMTc6Mjc6NTEgSmlyaSBQYWxlY2VrID4gd3JvdGU6Cj4gPiAt
ZWNobyAtZSAiQ29tcGxldGVkIHJ1bm5pbmcgRGVmYXVsdCBMVFBcblxuIgo+ID4gK2VjaG8gIkNv
bXBsZXRlZCBydW5uaW5nIERlZmF1bHQgTFRQIgo+ID4gK2VjaG8KPiA+ICtlY2hvCj4gCj4gdXNl
IHByaW50Ziwgbm90IGJsb2F0IHRoZSBmaWxlIHdpdGggZWNob3MKPiAKPiA+IC1lY2hvICJEaXN0
cm8gdHlwZSBpczogJHR2YXIgXG4iCj4gPiArZWNobyAiRGlzdHJvIHR5cGUgaXM6ICR0dmFyIgo+
ID4KPiAKPiB0aGVzZSBhcmUgbm90IGVxdWl2YWxlbnQKPiAKPiA+IC0tLSBhL3Rlc3RjYXNlcy9j
b21tYW5kcy91bnppcC91bnppcF90ZXN0cy5zaAo+ID4gKysrIGIvdGVzdGNhc2VzL2NvbW1hbmRz
L3VuemlwL3VuemlwX3Rlc3RzLnNoCj4gPiBAQCAtNjIsNyArNjIsNiBAQCBjaGtfaWZleGlzdHMo
KQo+ID4gICMgCQkJCS0gbm9uLXplcm8gb24gZmFpbHVyZS4KPiA+ICBjbGVhbnVwKCkKPiA+ICB7
Cj4gPiAtCXBvcGQKPiA+ICAJIyByZW1vdmUgYWxsIHRoZSB0ZW1wb3JhcnkgZmlsZXMgY3JlYXRl
ZCBieSB0aGlzIHRlc3QuCj4gPiAgCXRzdF9yZXNtIFRJTkZPICJDTEVBTjogcmVtb3ZpbmcgXCIk
TFRQVE1QXCIiCj4gPiAgCXJtIC1mciAiJExUUFRNUCIKPiA+IEBAIC05MCw3ICs4OSw2IEBAIGlu
aXQoKQo+ID4gIAkjIGNyZWF0ZSB0aGUgdGVtcG9yYXJ5IGRpcmVjdG9yeSB1c2VkIGJ5IHRoaXMg
dGVzdGNhc2UKPiA+ICAJTFRQVE1QPWBta3RlbXAgLWQgLXQgJCQuWFhYWFhYYCB8fCB0c3RfcmVz
bSBUQlJPSyAiVW5hYmxlIHRvIGNyZWF0ZQo+ID4gdGVtcG9yYXJ5IGRpcmVjdG9yeSB3aXRoOiBt
a3RlbXAgLWQgJCQuWFhYWFhYIiB0cmFwICJjbGVhbnVwIiAwCj4gPiAtCXB1c2hkICIkTFRQVE1Q
Igo+ID4KPiA+ICAJIyBjaGVjayBpZiBjb21tYW5kcyB0c3RfKiwgdW56aXAsIGF3aywgZXRjIGV4
aXN0cy4KPiA+ICAJY2hrX2lmZXhpc3RzIElOSVQgdHN0X3Jlc20gIHx8IHJldHVybiAkUkMKPiAK
PiB1bW0sIHlvdSByZW1vdmUgdGhlIHB1c2gvcG9wZCwgYnV0IGRvbnQgcmVwbGFjZSBpdCB3aXRo
IHByb3BlciBjZCBzdGF0ZW1lbnRzID8gIAo+IGknbSBndWVzc2luZyB5b3UgZGlkbnQgdGVzdCB0
aGlzIGNoYW5nZS4KPiAKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9uZXRu
cy9kZWxjaGlsZC5zaAo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL25ldG5z
L2RlbGNoaWxkLnNoCj4gPiAtICAgIGtpbGwgLTkgJHNzaHBpZCAkcGlkID4gL2Rldi9udWxsIDI+
JjEKPiA+ICsgICAga2lsbCAtcyBLSUxMICRzc2hwaWQgJHBpZCA+IC9kZXYvbnVsbCAyPiYxCj4g
Cj4gdGhpcyBpc250IGEgYmFzaGlzbSwgdGhpcyBpcyBhIGNyYXBweSBraWxsIGltcGxlbWVudGF0
aW9uCj4gCj4gPiAgZm9yIHR0dHlwZSBpbiBgbHMgL2Rldi90dHkqYAo+ID4gIGRvCj4gPiAtZGV2
aWNlX25vPSR7dHR0eXBlOjh9Cj4gPiArZGV2aWNlX25vPSR7dHR0eXBlIyMvZGV2L3R0eX0KPiA+
IC4uLgo+ID4gIGZvciB0dHR5cGUgaW4gYGxzIC9kZXYvdHR5KmAKPiA+ICBkbwo+ID4gLWRldmlj
ZV9ubz0ke3R0dHlwZTo4fQo+ID4gK2RldmljZV9ubz0ke3R0dHlwZSMjL2Rldi90dHl9Cj4gCj4g
dXNpbmcgdGhlIGdyZWVkeSBleHBhbnNpb24gKCMjKSBkb2VzbnQgbWFrZSBtdWNoIHNlbnNlLiAg
cmVhbGx5IHNob3VsZCBiZSAjLgo+IAo+ID4gLSAgICBsZXQgc3RlcF9lcnJvcnM9IiRzdGVwX2Vy
cm9ycyArIDEiCj4gPiArICAgIHN0ZXBfZXJyb3JzPSQoKCRzdGVwX2Vycm9ycyArIDEpKQo+ID4g
LSAgICAgICAgbGV0IGk9IiRpICsgMSIKPiA+ICsgICAgICAgIGk9JCgoJGkgKyAxKSkKPiA+IC0g
ICAgICAgICAgICBsZXQgaz0iJGsgKyAxIgo+ID4gKyAgICAgICAgICAgIGs9JCgoJGsgKyAxKSkK
PiA+IC0gICAgICAgIGxldCBqPSIkaiArIDEiCj4gPiArICAgICAgICBqPSQoKCRqICsgMSkpCj4g
PiAuLi4uLgo+IAo+IHRoaXMgc3ludGF4IHN1Y2tzLiAgcGxlYXNlIHVzZSBzb21ldGhpbmcgbGlr
ZToKPiA6ICQoKCBzdGVwX2Vycm9ycyArPSAxKSkKPiAKPiA+IC0gICAgZWNobyAkImZzX2lub2Qg
b24gJFRDdG1wIGZpbmlzaGVkLiIKPiA+ICsgICAgZWNobyAiZnNfaW5vZCBvbiAkVEN0bXAgZmlu
aXNoZWQuIgo+IAo+IHRoZXNlIGFyZSBub3QgZXF1aXZhbGVudCwgYnV0IGkgZG91YnQgdGhpcyBz
aGVsbCBzY3JpcHQgaXMgdXNpbmcgdGhlIGJhc2ggCj4gZ2V0dGV4dCBmdW5jdGlvbiBpbiB0aGUg
Zmlyc3QgcGxhY2UsIHNvIGl0J3MgZmluZQo+IC1taWtlCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMdHAt
bGlzdCBtYWlsaW5nIGxpc3QKPiBMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKPiBodHRw
czovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlzdAoKCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0
Cg==
