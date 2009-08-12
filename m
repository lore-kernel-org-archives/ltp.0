Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MbBtl-00036o-Mq
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 11:21:41 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MbBth-0003io-PG
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 11:21:41 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7CBH2cu012776
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 05:17:02 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7CBLRH2174450
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 05:21:27 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7CBLRwn026468
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 05:21:27 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A81B1A0.5050708@ubuntu.com>
References: <20090811172957.7074.62874.sendpatchset@subratamodak.linux.ibm.com>
	<20090811173101.7074.31798.sendpatchset@subratamodak.linux.ibm.com>
	<4A81B1A0.5050708@ubuntu.com>
Date: Wed, 12 Aug 2009 16:51:03 +0530
Message-Id: <1250076064.5373.23.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 05/05] Add the necessary Interface and
	Option	through "runltp"
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
To: Paul Larson <paul.larson@ubuntu.com>
Cc: Sachin P Sant <sachinp@linux.vnet.ibm.com>, LTP Mailing List <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>, Michael Reed <mreed10@us.ibm.com>, Nate Straz <nate@refried.org>, Manoj Iyer <manoj.iyer@ubuntu.com>, Balbir Singh <balbir@linux.vnet.ibm.com>

SGV5IFBhdWwsCgpUaGFua3MgZm9yIHRha2luZyBvdXQgdGltZSB0byByZXBseS4KCk9uIFR1ZSwg
MjAwOS0wOC0xMSBhdCAxMzowMCAtMDUwMCwgUGF1bCBMYXJzb24gd3JvdGU6IAo+IFN1YnJhdGEg
TW9kYWsgd3JvdGU6Cj4gLi4uCj4gPiArCS1GIExPT1BTLFBFUkNFTlRBR0UgSW5kdWNlIFBFUkNF
TlRBR0UgRmF1bHQgaW4gdGhlIEtlcm5lbCBTdWJzeXN0ZW1zLCBhbmQsIHJ1biBlYWNoIHRlc3Qg
Zm9yIExPT1BTIGxvb3AKPiAKPiBJIGhhdmVuJ3QgaGFkIHRpbWUgZm9yIGFuIGV4aGF1c3RpdmUg
cmV2aWV3LCBidXQgaGVyZSBhcmUgYSBmZXcKPiBxdWVzdGlvbnMvY29tbWVudHMgSSBoYWQ6Cj4g
Cj4gMS4gV2h5IGludHJvZHVjZSB5ZXQgYW5vdGhlciBsb29waW5nIG1lY2hhbmlzbSB3aXRoaW4g
TFRQIHdoZW4gd2UKPiBhbHJlYWR5IGhhdmUgb25lPyAgSXMgdGhlcmUgYW4gYWR2YW50YWdlIHRo
YXQgeW91IHNlZSB0byBkb2luZyBpdCB0aGlzCgpJIGFtIG5vdCB1c2luZyBhZGRpdGlvbmFsIG1l
Y2hhbmlzbSB0byBnZW5lcmF0ZSBMT09QUy4gSXTFmyBsaWtlIHRoZQpzY3JpcHQganVzdCByZWFk
cyBlYWNoIGxpbmUgb2YgZW50cnkgaW4gdGhlIGNvbW1hbmQgZmlsZSwgdGhlbiBqdXN0CnJld3Jp
dGVzIHRoYXQgbGluZSB3aXRoIHRoZSBmb2xsb3dpbmcgbisxIGVudHJpZXM6CgoxKSAxc3QgZW50
cnkgZXhhY3RseSBzYW1lIGFzIHRoZSBvcmlnaW5hbCBvbmUuIE1lYW50IHRvIHNlZSB0aGUgdGVz
dApvdXRwdXQgaW4gbm9ybWFsIGtlcm5lbCwKMikgbiBlbnRyaWVzIHJ1biB3aXRoaW4gdGhlIGZh
dWx0IGtlcm5lbCBhbmQgZmF1bHQgd2l0aGRyYXduIGltbWVkaWF0ZWx5CmFmdGVyIHRoZSBudGgg
ZW50cnkgaXMgd3JpdHRlbi4KCkhlcmUsIGx0cC1wYW4gZG9lc27CtHQgZXZlbiBrbm93IHdobyBn
ZW5lcmF0ZWQgJiB3aXRoZHJldyB0aGVzZSBmYXVsdHMKYW5kIGhvdyB0aG9zZSBsb29wcyBjYW1l
IGludG8gYmVpbmcuIEluIGFsbCBvdGhlciBjYXNlcyBvZiBsb29wCmdlbmVyYXRpb24sIGx0cC1w
YW4gYW5kIHJ1bmx0cCBoYXMga25vd2xlZGdlLCBoZXJlIHRoZXkgZG8gbm90LgoKSGVyZSB3ZSB3
YW50IHRvIHJ1biBmZXcgbG9vcHMoY2hvc2VuIGJ5IHRoZSB1c2VyKSBvZiB0aGUgc2FtZSB0ZXN0
IHVuZGVyCmZhdWx0ZWQga2VybmVsIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSB0ZXN0IGlzIGV4aGli
aXRpbmcgc29tZSBhYm5vcm1hbApiZWhhdmlvdXIgdW5kZXIgdGhlIGZhdWx0ZWQga2VybmVsLCB3
aGljaCBtYXkgbm90IGJlIHBvc3NpYmxlIGlmIGp1c3QgMQpsb29wIGlzIHJ1biB1bmRlciBmYXVs
dC4KCj4gd2F5LCByYXRoZXIgdGhhbiBqdXN0IGhhdmluZyBhbiBhZGRpdGlvbmFsIG9wdGlvbiB0
aGF0IGNhbGxzIHRoZSBzY3JpcHQKPiB0byBnZW5lcmF0ZSB0aGlzIGFkZGl0aW9uYWwgcmFuZG9t
IGZhdWx0IGluamVjdGlvbj8KPiAKPiAyLiBXb3VsZCBiZSBnb29kIHRvIHB1c2ggdGhlIGNoZWNr
IGZvciAvZGVidWcgYmVpbmcgbW91bnRlZCBkb3duIGludG8KPiBvbmUgb2YgdGhlIG90aGVyIHNj
cmlwdHMgcmF0aGVyIHRoYW4gaW4gcnVubHRwLiAgcnVubHRwIGlzIGFscmVhZHkKPiBoaWRlb3Vz
bHkgYmxvYXRlZCBhbmQgdGhpcyB3b3VsZCBtYWtlIGl0IG1vcmUgdXNlZnVsIHdoZW4gcnVubmlu
Zwo+IHN0YW5kYWxvbmUuCgpIbW1tLiBJIHdpbGwgbG9vayBpbnRvIHRoaXMuCgo+IAo+IDMuIHdv
dWxkIGJlIGdyZWF0IGlmIHRoZXJlIHdlcmUgc29tZSB3YXkgdG8gdGFnIHRoZSByZXN1bHRzIHRv
IHNheSB3aGVuCj4gYSBmYXVsdCB3YXMgb3Igd2FzIG5vdCBpbiB0aGUgcHJvY2VzcyBvZiBiZWlu
ZyBnZW5lcmF0ZWQuICBUaGF0IGlzLAo+IHBlcmhhcHMsIG5vdCBwb3NzaWJsZSBhdCB0aGlzIHRp
bWUgdGhvdWdoLgoKR29vZyBzdWdnZXN0aW9uIHRob3VnaC4gUHJvYmFibHkgaSBuZWVkIHRvIGNo
YW5nZSB0aGUgd2F5IHRhZ3MgYXJlCmdlbmVyYXRlZCwgaSBjYW4ganVzdCByZXBsYWNlOgp0YWdf
bmFtZV9sb29wKG4pCndpdGgKdGFnX25hbWVfbG9vcChuKV9rZXJuZWxfdW5kZXJfZmF1bHQKc29y
dCBvZiBzdHVmZi4KCj4gCj4gNC4gbW9yZSBncmFudWxhcml0eSBwb3NzaWJsZSB3aXRoIHRoZSBm
YXVsdCBpbmplY3Rpb25zIHRvIHNwZWNpZnkgdGhlCj4gdHlwZSBvZiBmYXVsdHMsIG9yIG9wdGlv
bmFsbHksIHRoZSBiZWhhdmlvdXIgeW91IGhhdmUgaGVyZT8KClllcy4gVGhlc2UgZW5oYW5jZW1l
bnRzIGFyZSBwb3NzaWJsZSB0byBiZSBkb25lIGluIGZ1dHVyZS4gSSB3YW50ZWQgdG8KdXNlIGFs
bCB0aGUgZmF1bHRzIHByb3ZpZGVkIGJ5IHRoZSBrZXJuZWwgYXQgdGhlIHRpbWUgYmVpbmcuCgpS
ZWdhcmRzLS0KU3VicmF0YQoKPiAKPiBUaGFua3MsCj4gUGF1bCBMYXJzb24KCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KTGV0IENyeXN0YWwgUmVwb3J0cyBoYW5kbGUgdGhlIHJlcG9ydGluZyAtIEZy
ZWUgQ3J5c3RhbCBSZXBvcnRzIDIwMDggMzAtRGF5IAp0cmlhbC4gU2ltcGxpZnkgeW91ciByZXBv
cnQgZGVzaWduLCBpbnRlZ3JhdGlvbiBhbmQgZGVwbG95bWVudCAtIGFuZCBmb2N1cyBvbiAKd2hh
dCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNhdGlvbiBjb2RpbmcuIERpc2NvdmVyIHdoYXQncyBu
ZXcgd2l0aCAKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1q
dWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1s
aXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
