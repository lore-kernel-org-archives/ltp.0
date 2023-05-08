Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62517C77B75
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 01:43:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9EA573C02E6
	for <ltp@archiver.kernel.org>; Mon,  8 May 2023 03:43:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292483C0189
 for <ltp@lists.linux.it>; Mon,  8 May 2023 03:43:44 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A929600045
 for <ltp@lists.linux.it>; Mon,  8 May 2023 03:43:42 +0200 (CEST)
X-UUID: 86eaa0aa359c4387b376670f36dd0256-20230508
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22, REQID:63fb0f6b-8140-4884-a7f2-0a06cc50fc34, IP:15,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
 ION:release,TS:-5
X-CID-INFO: VERSION:1.1.22, REQID:63fb0f6b-8140-4884-a7f2-0a06cc50fc34, IP:15,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:-5
X-CID-META: VersionHash:120426c, CLOUDID:6c610b6b-2f20-4998-991c-3b78627e4938,
 B
 ulkID:2305070255394V6AH5D3,BulkQuantity:1,Recheck:0,SF:24|17|19|44|102,TC:
 nil,Content:0,EDM:-3,IP:-2,URL:11|1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,
 OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 86eaa0aa359c4387b376670f36dd0256-20230508
X-User: zenghao@kylinos.cn
Received: from [172.20.12.253] [(116.128.244.169)] by mailgw
 (envelope-from <zenghao@kylinos.cn>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 4969635; Mon, 08 May 2023 09:43:34 +0800
Message-ID: <26c958c1cda9a1f19ac3afb8d80fa42e0a18a022.camel@kylinos.cn>
From: Hao Zeng <zenghao@kylinos.cn>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 08 May 2023 09:43:32 +0800
In-Reply-To: <20230506185522.GA105601@pevik>
References: <20230506092702.203395-1-zenghao@kylinos.cn>
 <20230506185522.GA105601@pevik>
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] testcases:Fix the failure of shell script to
 get path
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCAyMDIzLTA1LTA2IGF0IDIwOjU1ICswMjAwLCBQZXRyIFZvcmVsIHdyb3RlOgpIaSBQ
ZXRyLApTb3JyeSwgdGhpcyBvbmUgd2FzIGFuIG92ZXJzaWdodCBvbiBteSBwYXJ0LiBJdCBoYXMg
YmVlbiBhZGRlZCBhbmQKc3VibWl0dGVkIGFnYWluLgoKQmVzdCByZWdhcmRzCkhhbwo+IEhpIEhh
bywKPiAKPiA+IEZvciBleGFtcGxlOgo+ID4gaW4gdGhlIGZpbGUgdGVzdGNhc2VzL2tlcm5lbC9j
b250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNzLnNoLAo+ID4gaWYgdGhlIHBhdGggaXMgb2J0
YWluZWQgYnkKPiA+IGZpbmQgIiRDUFVTRVQiIC10eXBlIGQgfCBzb3J0IHwgc2VkIC1uICcyLCRw
JyB8IHRhYyB8IHdoaWxlIHJlYWQKPiA+IHN1YmRpciwKPiA+IHRoZSBlc2NhcGVkIGNoYXJhY3Rl
cnMgd2lsbCBiZSBsb3N0LGFuZCBieSBhZGRpbmcgdGhlIC1yIG9wdGlvbiwKPiA+IHRoZSBlc2Nh
cGVkIGNoYXJhY3RlcnMgd2lsbCBiZSBrZXB0IGFzIHRoZXkgYXJlIHdpdGhvdXQgZXNjYXBpbmcK
PiA+IFRoZSBlcnJvcnMgYXJlIGFzIGZvbGxvd3M6Cj4gPiAvb3B0L2x0cC90ZXN0Y2FzZXMvYmlu
L2NwdXNldF9mdW5jcy5zaDpsaW5lMTc4Ogo+ID4gL2Rldi9jcHVzZXQvbWFjaGluZS5zbGljZS9t
YWNoaW5lLQo+ID4gcWVtdXgyZDE1N3gyZHpoeDJkc3hmLnNjb3BlL3ZjcHU3L3Rhc2tzOgo+ID4g
VGhlIGZpbGUgb3IgZGlyZWN0b3J5IGlzIG5vdCBhdmFpbGFibGUKPiA+IHJtZGlyOiBkZWxldGUK
PiA+ICcvZGV2L2NwdXNldC9tYWNoaW5lLnNsaWNlL21hY2hpbmUtCj4gPiBxZW11eDJkMTU3eDJk
emh4MmRzeGYuc2NvcGUvdmNwdTcnCj4gPiBGYWlsdXJlOiBUaGUgZmlsZSBvciBkaXJlY3Rvcnkg
aXMgbm90IGF2YWlsYWJsZQo+ID4gY3B1c2V0X21lbW9yeV9wcmVzc3VyZSAxIFRGQUlMOiBDb3Vs
ZG4ndCByZW1vdmUgc3ViZGlyIC0KPiA+IC9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4vY3B1c2V0X2Z1
bmNzLnNoOmxpbmUxNzg6Cj4gPiAvZGV2L2NwdXNldC9tYWNoaW5lLnNsaWNlL21hY2hpbmUtCj4g
PiBxZW11eDJkMTU3eDJkemh4MmRzeGYuc2NvcGUvdmNwdTcvdGFza3M6Cj4gPiBUaGUgZmlsZSBv
ciBkaXJlY3RvcnkgaXMgbm90IGF2YWlsYWJsZQo+ID4gcm1kaXI6IGRlbGV0ZQo+ID4gJy9kZXYv
Y3B1c2V0L21hY2hpbmUuc2xpY2UvbWFjaGluZS0KPiA+IHFlbXV4MmQxNTd4MmR6aHgyZHN4Zi5z
Y29wZS92Y3B1NycKPiA+IEZhaWx1cmU6IFRoZSBmaWxlIG9yIGRpcmVjdG9yeSBpcyBub3QgYXZh
aWxhYmxlCj4gPiBjcHVzZXRfbWVtb3J5X3ByZXNzdXJlIDEgVEZBSUw6IENvdWxkbid0IHJlbW92
ZSBzdWJkaXIgLQo+IAo+ID4gU2lnbmVkLW9mZi1ieTogSGFvIFplbmcgPHplbmdoYW9Aa3lsaW5v
cy5jbj4KPiA+IFN1Z2dlc3RlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gPiAt
LS0KPiA+IMKgdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Z1bmNz
LnNoIHwgMiArLQo+ID4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKPiAKPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL2Nw
dXNldC9jcHVzZXRfZnVuY3Muc2gKPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9j
cHVzZXQvY3B1c2V0X2Z1bmNzLnNoCj4gPiBpbmRleCA4N2JhN2RhMWYuLjBjZmEwYzE3ZSAxMDA3
NTUKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9m
dW5jcy5zaAo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVzZXQvY3B1
c2V0X2Z1bmNzLnNoCj4gPiBAQCAtMTg0LDcgKzE4NCw3IEBAIGNsZWFudXAoKQo+ID4gwqDCoMKg
wqDCoMKgwqDCoGVjaG8gJENISUxEUkVOX1ZBTFVFID4gJENMT05FX0NISUxEUkVOCj4gPiDCoMKg
wqDCoMKgwqDCoMKgZWNobyAkU0NIRURfTEJfVkFMVUUgPiAkU0NIRURfTEIKPiAKPiA+IC3CoMKg
wqDCoMKgwqDCoGZpbmQgIiRDUFVTRVQiIC10eXBlIGQgfCBzb3J0IHwgc2VkIC1uICcyLCRwJyB8
IHRhYyB8IHdoaWxlCj4gPiByZWFkIHN1YmRpcgo+ID4gK8KgwqDCoMKgwqDCoMKgZmluZCAiJENQ
VVNFVCIgLXR5cGUgZCB8IHNvcnQgfCBzZWQgLW4gJzIsJHAnIHwgdGFjIHwgd2hpbGUKPiA+IHJl
YWQgLXIgc3ViZGlyCj4gCj4gSXMgaXQgdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVj
dGxfZmovcnVuX2NwdWN0bF90ZXN0X2ZqLnNoCj4gd29ya2luZwo+IHdpdGhvdXQgLXIgPyBJJ2Qg
ZXhwZWN0IGl0J2QgYmUgYWxzbyBuZWVkZWQgKGl0IHdhcyBpbiB5b3VyIHYxIHBhdGNoCj4gWzFd
KS4KPiAKPiBJIG9ubHkgZGlkbid0IHdhbnQgdG8gdGFrZQo+IHRlc3RjYXNlcy9vcGVuX3Bvc2l4
X3Rlc3RzdWl0ZS9zY3JpcHRzL2dlbmVyYXRlLW1ha2VmaWxlcy5zaCBiZWNhdXNlCj4gaXQgZG9l
cyBub3QKPiB3b3JrIHdpdGggL2Rldi9jcHVzZXQvLgo+IAo+IEtpbmQgcmVnYXJkcywKPiBQZXRy
Cj4gCj4gWzFdCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzZiMmE3Y2ViLjQ0NjYuMTg3
NGE1Mzc0MzAuQ29yZW1haWwuY3Jhd2xlcjIwMTVAMTYzLmNvbS8KPiA+IMKgwqDCoMKgwqDCoMKg
wqBkbwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3aGlsZSByZWFkIHBpZAo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkbwoKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
