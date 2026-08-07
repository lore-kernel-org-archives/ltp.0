Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAF2C5AC80
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 02:00:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 915773E74A4
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 04:00:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AAFE3C5880
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 04:00:37 +0200 (CEST)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CFDE61000945
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 04:00:35 +0200 (CEST)
X-UUID: c35b5a08920311f1aa26b74ffac11d73-20260807
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:50453cce-e3f8-4b08-ae4f-454bf6b137d8, IP:20,
 URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:15
X-CID-INFO: VERSION:1.3.12, REQID:50453cce-e3f8-4b08-ae4f-454bf6b137d8, IP:20,
 UR
 L:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:15
X-CID-META: VersionHash:e7bac3a, CLOUDID:740678f7574374fe21320454acd67808,
 BulkI
 D:2608071000303IT7URXS,BulkQuantity:0,Recheck:0,SF:17|19|38|64|66|78|80|81
 |82|83|102|127|841|865|898,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:0,File:
 nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR
 :0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c35b5a08920311f1aa26b74ffac11d73-20260807
X-User: wangxuewen@kylinos.cn
Received: from [192.168.111.73] [(223.70.159.239)] by mailgw.kylinos.cn
 (envelope-from <wangxuewen@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
 with ESMTP id 787896767; Fri, 07 Aug 2026 10:00:28 +0800
Message-ID: <0a480ba8-f51b-43dc-83fb-0dda1fa85144@kylinos.cn>
Date: Fri, 7 Aug 2026 10:00:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, liwang@hygon.cn
References: <20260805064053.916492-1-wangxuewen@kylinos.cn>
 <anLnmVKGARAsrV6O@linux.dev>
From: Xuewen Wang <wangxuewen@kylinos.cn>
In-Reply-To: <anLnmVKGARAsrV6O@linux.dev>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] memcg/functional: fix memcg_failcnt
 intermittent timeout by disabling swap
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGkgV2FuZywKVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3IGFuZCB0aGUgc3VnZ2VzdGlvbnMu
IEkndmUgc2VudCB2MyB3aXRoIHRoZSBjaGFuZ2VzIHlvdSBwcm9wb3NlZDoKCi0gTW92ZSBzd2Fw
b2ZmIHRvIGRvX3NldHVwKCkgYW5kIHN3YXBvbiB0byBkb19jbGVhbnVwKCkKLSBBZGp1c3QgdGhl
IG9yZGVyIGluIGRvX2NsZWFudXAoKSB0byBzd2Fwb24gZmlyc3QsIHRoZW4gbWVtY2dfY2xlYW51
cAoKUGxlYXNlIHRha2UgYSBsb29rIHdoZW4geW91IGhhdmUgdGltZS4KQmVzdCByZWdhcmRzLApY
dWV3ZW4gV2FuZwoK5ZyoIDIwMjYvOC81IDE1OjM0LCBMaSBXYW5nIOWGmemBkzoKPiBIaSBYdWV3
ZW4sCj4gCj4gWHVld2VuIFdhbmcgd3JvdGU6Cj4gCj4+IG1lbWNnX2ZhaWxjbnQuc2ggdGVzdHMg
dGhlIG1lbW9yeS5mYWlsY250IGNvdW50ZXIgYnkgYWxsb2NhdGluZwo+PiByZWNsYWltYWJsZSBt
ZW1vcnkgKG1tYXAtYW5vbi9tbWFwLWZpbGUvc2htKSBiZXlvbmQgYSB0aW55IGNncm91cAo+PiBs
aW1pdCAoMSBwYWdlKS4gSXQgcmVsaWVzIG9uIHRoZSBwcm9jZXNzIGJlaW5nIE9PTS1raWxsZWQg
c28gdGhhdAo+PiBzaWduYWxfbWVtY2dfcHJvY2VzcygpJ3Mgd2FpdCBsb29wIGV4aXRzLgo+Pgo+
PiBXaXRoIHN3YXAgZW5hYmxlZCB0aGUga2VybmVsIHVzdWFsbHkgc3RpbGwgT09NLWtpbGxzIHRo
ZSBwcm9jZXNzLAo+PiBidXQgb24gYXJtNjQgcmVjbGFpbSAoc3dhcCBvdXQpIHNvbWV0aW1lcyBz
dWNjZWVkcyBpbnN0ZWFkOgo+PiB1c2FnZV9pbl9ieXRlcyBzdGF5cyBhdCB0aGUgbGltaXQgYW5k
IHRoZSBwcm9jZXNzIGtlZXBzIHJ1bm5pbmcsCj4+IHNvIHRoZSB3YWl0IGxvb3AgdGltZXMgb3V0
IChUQlJPSykgaW50ZXJtaXR0ZW50bHkuCj4+Cj4+IEV4YW1wbGUgZmFpbHVyZSBvbiBhcm02NCAo
a2VybmVsIDYuNik6Cj4+ICAgbWVtY2dfZmFpbGNudCAyIFRCUk9LOiB0aW1lZCBvdXQgb24gbWVt
b3J5LnVzYWdlX2luX2J5dGVzIDQwOTYgMCA4MTkyCj4+Cj4+IERpc2FibGUgc3dhcCBhcm91bmQg
dGhlIGFsbG9jYXRpb24gYW5kIHJlLWVuYWJsZSBpdCBhZnRlcndhcmRzLAo+PiBtaXJyb3Jpbmcg
d2hhdCBtZW1jZ19saW1pdF9pbl9ieXRlcy5zaCBhbHJlYWR5IGRvZXMgZm9yIHRoZSBzYW1lCj4+
IHJlY2xhaW1hYmxlIG1lbW9yeSB0eXBlcy4KPiAKPiBUaGlzIGZpeCBtYWtlIHNlbnNlLCBidXQg
SSdkIHJhdGhlciBnbyB3aXRoIGEgdGlkeSB3YXk6Cj4gCj4gLi4uCj4gVFNUX1NFVFVQPWRvX3Nl
dHVwCj4gVFNUX0NMRUFOVVA9ZG9fY2xlYW51cAo+IAo+IGRvX3NldHVwKCkKPiB7Cj4gICAgICAg
ICBtZW1jZ19zZXR1cAo+ICAgICAgICAgc3dhcG9mZiAtYQo+IH0KPiAKPiBkb19jbGVhbnVwKCkK
PiB7Cj4gICAgICAgICBzd2Fwb24gLWEKPiAgICAgICAgIG1lbWNnX2NsZWFudXAKPiB9Cj4gCj4g
Li4uCj4gCj4gTXkgUmVkIEhhdCBlbWFpbCBhZGRyZXNzIGlzIG5vIGxvbmdlciB1c2VkLiBQbGVh
c2UgQ0MgbXkgbmV3Cj4gYWRkcmVzcyBmb3IgZnV0dXJlIHZlcnNpb25zOgo+IAo+ICAgbGkud2Fu
Z0BsaW51eC5kZXYKPiBvcjoKPiAgIGxpd2FuZ0BoeWdvbi5jbgo+IAoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
