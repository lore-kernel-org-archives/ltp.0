Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MLY0w-0006q5-Tm
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:44:26 +0000
Received: from [32.97.110.150] (helo=e32.co.us.ibm.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLY0v-0007il-E6
	for ltp-list@lists.sourceforge.net; Tue, 30 Jun 2009 07:44:26 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n5U7dcPa003666
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:39:38 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5U7hYnB231098
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:43:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5U7hYkj008503
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jun 2009 01:43:34 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1245920978.5542.34.camel@subratamodak.linux.ibm.com>
References: <4a413e95.8d13f30a.1199.ffffdccbSMTPIN_ADDED@mx.google.com>
	<200906231721.51688.vapier@gentoo.org>
	<1245920978.5542.34.camel@subratamodak.linux.ibm.com>
Date: Tue, 30 Jun 2009 13:11:10 +0530
Message-Id: <1246347670.4819.28.camel@subratamodak.linux.ibm.com>
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
To: Jiri Palecek <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

T24gVGh1LCAyMDA5LTA2LTI1IGF0IDE0OjM5ICswNTMwLCBTdWJyYXRhIE1vZGFrIHdyb3RlOiAK
PiBOZXcgQ2hhbmdlcyB0byBNaWtlxZsgY29tbWVudHMgPwoKUGluZy4KCj4gCj4gUmVnYXJkcy0t
Cj4gU3VicmF0YQo+IAo+IE9uIFR1ZSwgMjAwOS0wNi0yMyBhdCAxNzoyMSAtMDQwMCwgTWlrZSBG
cnlzaW5nZXIgd3JvdGU6IAo+ID4gT24gU3VuZGF5IDMxIE1heSAyMDA5IDE3OjI3OjUxIEppcmkg
UGFsZWNlayA+IHdyb3RlOgo+ID4gPiAtZWNobyAtZSAiQ29tcGxldGVkIHJ1bm5pbmcgRGVmYXVs
dCBMVFBcblxuIgo+ID4gPiArZWNobyAiQ29tcGxldGVkIHJ1bm5pbmcgRGVmYXVsdCBMVFAiCj4g
PiA+ICtlY2hvCj4gPiA+ICtlY2hvCj4gPiAKPiA+IHVzZSBwcmludGYsIG5vdCBibG9hdCB0aGUg
ZmlsZSB3aXRoIGVjaG9zCj4gPiAKPiA+ID4gLWVjaG8gIkRpc3RybyB0eXBlIGlzOiAkdHZhciBc
biIKPiA+ID4gK2VjaG8gIkRpc3RybyB0eXBlIGlzOiAkdHZhciIKPiA+ID4KPiA+IAo+ID4gdGhl
c2UgYXJlIG5vdCBlcXVpdmFsZW50Cj4gPiAKPiA+ID4gLS0tIGEvdGVzdGNhc2VzL2NvbW1hbmRz
L3VuemlwL3VuemlwX3Rlc3RzLnNoCj4gPiA+ICsrKyBiL3Rlc3RjYXNlcy9jb21tYW5kcy91bnpp
cC91bnppcF90ZXN0cy5zaAo+ID4gPiBAQCAtNjIsNyArNjIsNiBAQCBjaGtfaWZleGlzdHMoKQo+
ID4gPiAgIyAJCQkJLSBub24temVybyBvbiBmYWlsdXJlLgo+ID4gPiAgY2xlYW51cCgpCj4gPiA+
ICB7Cj4gPiA+IC0JcG9wZAo+ID4gPiAgCSMgcmVtb3ZlIGFsbCB0aGUgdGVtcG9yYXJ5IGZpbGVz
IGNyZWF0ZWQgYnkgdGhpcyB0ZXN0Lgo+ID4gPiAgCXRzdF9yZXNtIFRJTkZPICJDTEVBTjogcmVt
b3ZpbmcgXCIkTFRQVE1QXCIiCj4gPiA+ICAJcm0gLWZyICIkTFRQVE1QIgo+ID4gPiBAQCAtOTAs
NyArODksNiBAQCBpbml0KCkKPiA+ID4gIAkjIGNyZWF0ZSB0aGUgdGVtcG9yYXJ5IGRpcmVjdG9y
eSB1c2VkIGJ5IHRoaXMgdGVzdGNhc2UKPiA+ID4gIAlMVFBUTVA9YG1rdGVtcCAtZCAtdCAkJC5Y
WFhYWFhgIHx8IHRzdF9yZXNtIFRCUk9LICJVbmFibGUgdG8gY3JlYXRlCj4gPiA+IHRlbXBvcmFy
eSBkaXJlY3Rvcnkgd2l0aDogbWt0ZW1wIC1kICQkLlhYWFhYWCIgdHJhcCAiY2xlYW51cCIgMAo+
ID4gPiAtCXB1c2hkICIkTFRQVE1QIgo+ID4gPgo+ID4gPiAgCSMgY2hlY2sgaWYgY29tbWFuZHMg
dHN0XyosIHVuemlwLCBhd2ssIGV0YyBleGlzdHMuCj4gPiA+ICAJY2hrX2lmZXhpc3RzIElOSVQg
dHN0X3Jlc20gIHx8IHJldHVybiAkUkMKPiA+IAo+ID4gdW1tLCB5b3UgcmVtb3ZlIHRoZSBwdXNo
L3BvcGQsIGJ1dCBkb250IHJlcGxhY2UgaXQgd2l0aCBwcm9wZXIgY2Qgc3RhdGVtZW50cyA/ICAK
PiA+IGknbSBndWVzc2luZyB5b3UgZGlkbnQgdGVzdCB0aGlzIGNoYW5nZS4KPiA+IAo+ID4gPiAt
LS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvbmV0bnMvZGVsY2hpbGQuc2gKPiA+ID4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL25ldG5zL2RlbGNoaWxkLnNoCj4gPiA+
IC0gICAga2lsbCAtOSAkc3NocGlkICRwaWQgPiAvZGV2L251bGwgMj4mMQo+ID4gPiArICAgIGtp
bGwgLXMgS0lMTCAkc3NocGlkICRwaWQgPiAvZGV2L251bGwgMj4mMQo+ID4gCj4gPiB0aGlzIGlz
bnQgYSBiYXNoaXNtLCB0aGlzIGlzIGEgY3JhcHB5IGtpbGwgaW1wbGVtZW50YXRpb24KPiA+IAo+
ID4gPiAgZm9yIHR0dHlwZSBpbiBgbHMgL2Rldi90dHkqYAo+ID4gPiAgZG8KPiA+ID4gLWRldmlj
ZV9ubz0ke3R0dHlwZTo4fQo+ID4gPiArZGV2aWNlX25vPSR7dHR0eXBlIyMvZGV2L3R0eX0KPiA+
ID4gLi4uCj4gPiA+ICBmb3IgdHR0eXBlIGluIGBscyAvZGV2L3R0eSpgCj4gPiA+ICBkbwo+ID4g
PiAtZGV2aWNlX25vPSR7dHR0eXBlOjh9Cj4gPiA+ICtkZXZpY2Vfbm89JHt0dHR5cGUjIy9kZXYv
dHR5fQo+ID4gCj4gPiB1c2luZyB0aGUgZ3JlZWR5IGV4cGFuc2lvbiAoIyMpIGRvZXNudCBtYWtl
IG11Y2ggc2Vuc2UuICByZWFsbHkgc2hvdWxkIGJlICMuCj4gPiAKPiA+ID4gLSAgICBsZXQgc3Rl
cF9lcnJvcnM9IiRzdGVwX2Vycm9ycyArIDEiCj4gPiA+ICsgICAgc3RlcF9lcnJvcnM9JCgoJHN0
ZXBfZXJyb3JzICsgMSkpCj4gPiA+IC0gICAgICAgIGxldCBpPSIkaSArIDEiCj4gPiA+ICsgICAg
ICAgIGk9JCgoJGkgKyAxKSkKPiA+ID4gLSAgICAgICAgICAgIGxldCBrPSIkayArIDEiCj4gPiA+
ICsgICAgICAgICAgICBrPSQoKCRrICsgMSkpCj4gPiA+IC0gICAgICAgIGxldCBqPSIkaiArIDEi
Cj4gPiA+ICsgICAgICAgIGo9JCgoJGogKyAxKSkKPiA+ID4gLi4uLi4KPiA+IAo+ID4gdGhpcyBz
eW50YXggc3Vja3MuICBwbGVhc2UgdXNlIHNvbWV0aGluZyBsaWtlOgo+ID4gOiAkKCggc3RlcF9l
cnJvcnMgKz0gMSkpCj4gPiAKPiA+ID4gLSAgICBlY2hvICQiZnNfaW5vZCBvbiAkVEN0bXAgZmlu
aXNoZWQuIgo+ID4gPiArICAgIGVjaG8gImZzX2lub2Qgb24gJFRDdG1wIGZpbmlzaGVkLiIKPiA+
IAo+ID4gdGhlc2UgYXJlIG5vdCBlcXVpdmFsZW50LCBidXQgaSBkb3VidCB0aGlzIHNoZWxsIHNj
cmlwdCBpcyB1c2luZyB0aGUgYmFzaCAKPiA+IGdldHRleHQgZnVuY3Rpb24gaW4gdGhlIGZpcnN0
IHBsYWNlLCBzbyBpdCdzIGZpbmUKPiA+IC1taWtlCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
PiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiBM
dHAtbGlzdCBtYWlsaW5nIGxpc3QKPiA+IEx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+
ID4gaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
PiAKPiAKPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiBfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwo+IEx0cC1saXN0IG1haWxpbmcgbGlzdAo+IEx0cC1saXN0
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAo+IGh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xp
c3RzL2xpc3RpbmZvL2x0cC1saXN0CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlz
dApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
