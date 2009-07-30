Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MWaO6-0006IA-Nd
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:58 +0000
Received: from e35.co.us.ibm.com ([32.97.110.153])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWaNz-0001vT-L6
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2009 18:29:58 +0000
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n6UILIUK029335
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:21:18 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n6UITf5x239420
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:43 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n6UITeqU004965
	for <ltp-list@lists.sourceforge.net>; Thu, 30 Jul 2009 12:29:41 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20090724182457.GJ5878@count0.beaverton.ibm.com>
References: <1248272525-13205-1-git-send-email-nobuhiro@andestech.com>
	<20090724182457.GJ5878@count0.beaverton.ibm.com>
Date: Thu, 30 Jul 2009 23:59:25 +0530
Message-Id: <1248978565.5788.63.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] Fixed static build which needs
	to	link	the	pthread library in pidns and pipeio.
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
To: nobuhiro <nobuhiro@andestech.com>
Cc: ltp-list@lists.sourceforge.net

T24gRnJpLCAyMDA5LTA3LTI0IGF0IDExOjI0IC0wNzAwLCBNYXR0IEhlbHNsZXkgd3JvdGU6IAo+
IE9uIFdlZCwgSnVsIDIyLCAyMDA5IGF0IDEwOjIyOjA1UE0gKzA4MDAsIG5vYnVoaXJvIHdyb3Rl
Ogo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBub2J1aGlybyA8bm9idWhpcm9AYW5kZXN0ZWNoLmNv
bT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9waWRucy9NYWtlZmls
ZSB8ICAgIDIgKy0KPiA+ICB0ZXN0Y2FzZXMva2VybmVsL2lwYy9waXBlaW8vTWFrZWZpbGUgICAg
ICAgfCAgICAyICstCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4gPiAKPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5l
cnMvcGlkbnMvTWFrZWZpbGUgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvTWFr
ZWZpbGUKPiA+IGluZGV4IDQ4ODZkNTguLjE0ZjQ5ZGEgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvTWFrZWZpbGUKPiA+ICsrKyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvY29udGFpbmVycy9waWRucy9NYWtlZmlsZQo+ID4gQEAgLTIwLDcgKzIwLDcgQEAKPiA+
IAo+ID4gIENGTEFHUyArPSAtV2FsbAo+ID4gIENQUEZMQUdTICs9IC1JLi4vLi4vLi4vLi4vaW5j
bHVkZSAtSS4uL2xpYmNsb25lCj4gPiAtTERMSUJTICs9IC1MLi4vLi4vLi4vLi4vbGliIC1MLi4v
bGliY2xvbmUgLi4vbGliY2xvbmUvbGliY2xvbmUuYSAtbGx0cCAtbHJ0Cj4gPiArTERMSUJTICs9
IC1MLi4vLi4vLi4vLi4vbGliIC1MLi4vbGliY2xvbmUgLi4vbGliY2xvbmUvbGliY2xvbmUuYSAt
bGx0cCAtbHJ0IC1scHRocmVhZAo+IAo+IEknbSBub3Qgc3VyZSB0aGlzIGlzIGNvcnJlY3QuIEkg
anVzdCBkaWQgYSBDVlMgdXBkYXRlIGFuZCBncmVwcGVkIGZvcgo+ICJwdGhyZWFkIi4gSSBkb24n
dCBzZWUgYSBzaW5nbGUgdXNlIG9mIHB0aHJlYWRzIGluIHRoZXJlLiBXaGF0IG91dHB1dAo+IHN1
Z2dlc3RlZCBhbGwgb2YgdGhlc2UgdGVzdHMgbmVlZCB0byBsaW5rIHRvIHB0aHJlYWRzPyBDb3Vs
ZCB5b3UgYXQKPiBsZWFzdCBzdGljayB0aGF0IGluIHRoZSBjaGFuZ2Vsb2c/Cj4gCgpEaWQgeW91
IHJlcGx5IHRvIE1hdHTFmyBtYWlsIG9uIHRoaXMgPwoKUmVnYXJkcy0tClN1YnJhdGEKCj4gPiAK
PiA+ICBTUkNTICAgIDo9ICQod2lsZGNhcmQgKi5jKQo+ID4gIFRBUkdFVFMgOj0gJChTUkNTOiUu
Yz0lKQo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvaXBjL3BpcGVpby9NYWtlZmls
ZSBiL3Rlc3RjYXNlcy9rZXJuZWwvaXBjL3BpcGVpby9NYWtlZmlsZQo+ID4gaW5kZXggYWZkM2U4
ZC4uZDJhMWQ1ZiAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvaXBjL3BpcGVpby9N
YWtlZmlsZQo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9pcGMvcGlwZWlvL01ha2VmaWxlCj4g
PiBAQCAtMjIsNyArMjIsNyBAQAo+ID4gICMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIwo+ID4gIENGTEFHUyAg
ICs9IC1XYWxsCj4gPiAgQ1BQRkxBR1MgKz0gLUkuLi8uLi8uLi8uLi9pbmNsdWRlCj4gPiAtTERM
SUJTICAgKz0gLUwuLi8uLi8uLi8uLi9saWIgLWxsdHAgLWxydAo+ID4gK0xETElCUyAgICs9IC1M
Li4vLi4vLi4vLi4vbGliIC1sbHRwIC1scnQgLWxwdGhyZWFkCj4gCj4gU2FtZSBoZXJlLgo+IAo+
IENoZWVycywKPiAJLU1hdHQgSGVsc2xleQo+IAo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTHRwLWxpc3Qg
bWFpbGluZyBsaXN0Cj4gTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cj4gaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QKCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KTGV0IENyeXN0YWwgUmVwb3J0cyBoYW5kbGUgdGhlIHJlcG9ydGluZyAtIEZy
ZWUgQ3J5c3RhbCBSZXBvcnRzIDIwMDggMzAtRGF5IAp0cmlhbC4gU2ltcGxpZnkgeW91ciByZXBv
cnQgZGVzaWduLCBpbnRlZ3JhdGlvbiBhbmQgZGVwbG95bWVudCAtIGFuZCBmb2N1cyBvbiAKd2hh
dCB5b3UgZG8gYmVzdCwgY29yZSBhcHBsaWNhdGlvbiBjb2RpbmcuIERpc2NvdmVyIHdoYXQncyBu
ZXcgd2l0aCAKQ3J5c3RhbCBSZXBvcnRzIG5vdy4gIGh0dHA6Ly9wLnNmLm5ldC9zZnUvYm9iai1q
dWx5Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkx0cC1s
aXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9s
aXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
