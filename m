Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D411C77B7F
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 11:41:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C19C3CCA86
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 13:40:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46B563C01FE
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 13:40:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3D6F160064D
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 13:40:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B5EF81F385;
 Mon, 23 Jun 2025 11:40:38 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A92C613A27;
 Mon, 23 Jun 2025 11:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yLe+KDY9WWh3MwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 23 Jun 2025 11:40:38 +0000
Message-ID: <7c62d451-71c2-47a8-9ea1-080d612391d9@suse.cz>
Date: Mon, 23 Jun 2025 13:40:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.com>, ltp@lists.linux.it
References: <20250611-crash02_rewrite-v1-1-1becd9dc163d@suse.com>
 <62f31420-ad63-4c03-a42f-2cc0f7c2722e@suse.cz>
 <2f75ea2e-4d1a-4165-89cf-11e67c1d947c@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <2f75ea2e-4d1a-4165-89cf-11e67c1d947c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B5EF81F385
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] misc: rewrite crash02 test
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjMuIDA2LiAyNSAxMDoxNSwgQW5kcmVhIENlcnZlc2F0byB3cm90ZToKPj4+IMKgIC3CoMKg
wqAgaWYgKGxfb3B0KQo+Pj4gLcKgwqDCoMKgwqDCoMKgIHN5c25vX21heCA9IGF0b2kobF9jb3B0
KTsKPj4+ICvCoMKgwqAgbnVtID0gKGJ1ZmZbMF0gPDwgMjQpIHwgKGJ1ZmZbMV0gPDwgMTYpIHwg
KGJ1ZmZbMl0gPDwgOCkgfCBidWZmWzNdOwo+Pj4gK8KgwqDCoCBpZiAobnVtIDwgMCkKPj4+ICvC
oMKgwqDCoMKgwqDCoCBudW0gKj0gLTE7Cj4+PiArwqDCoMKgIG51bSA9IChudW0gJSBNQVhfU1lT
Q0FMTFMpIC0gMTsKPj4KPj4gV2h5IGRvIHlvdSBzdWJ0cmFjdCBvbiB0aGUgbGFzdCBsaW5lIGFi
b3ZlPyAKPiBTb21lIHN5c2NhbGxzIG5lZWQgdG8gc2V0IHRoZWlyIGFyZ3VtZW50IHRvIC0xIHNv
bWV0aW1lcy4KCk9LLCB3ZSBzaG91bGQgdGVzdCB0aGUgd2hvbGUgdmFsdWUgcmFuZ2UsIHRob3Vn
aC4gT3RoZXIgbmVnYXRpdmUgdmFsdWVzIAptaWdodCB0cmlnZ2VyIGNvcm5lciBjYXNlcyB3ZSdy
ZSBzdGlsbCBpbnRlcmVzdGVkIGluLgoKPj4gQWxzbywgdGhpcyB3b3VsZCBiZSBtdWNoIHNpbXBs
ZXIgYW5kIHRoZSB0cnVuY2F0aW9uIHRvIE1BWF9TWVNDQUxMUyAKPj4gc2hvdWxkIGJlIGRvbmUg
YnkgY2FsbGVyIHdoZW4gbmVlZGVkLgo+Pgo+PiBzdGF0aWMgaW5saW5lIGxvbmcgcmFuZF9sb25n
KHZvaWQpCj4+IHsKPj4gwqDCoMKgwqBsb25nIHJldDsKPj4KPj4gwqDCoMKgwqBpZiAoZ2V0cmFu
ZG9tKCZyZXQsIHNpemVvZihyZXQpLCAwKSA8IDApCj4+IMKgwqDCoMKgwqDCoMKgIHRzdF9icmso
Li4uKTsKPj4KPj4gwqDCoMKgwqByZXR1cm4gcmV0Owo+PiB9Cj4+Cj4+IEFsdGhvdWdoIGl0J3Mg
YmUgZ3JlYXQgdG8gc3VwcG9ydCBzZXR0aW5nIHJhbmRvbSBzZWVkIGxpa2UgaW4gdGhlIAo+PiBv
cmlnaW5hbCB0ZXN0IHNvIHRoYXQgY3Jhc2hlcyBjYW4gYmUgcmVwcm9kdWNlZC4KPiAKPiBJIGRv
bid0IHRoaW5rIEkgdW5kZXJzdGFuZCB0aGlzIHNlbnRlbmNlLiBUaGlzIGNvZGUgaXMgdGFraW5n
IGludG8gCj4gYWNjb3VudCB0aGUgc3BlY2lmaWMgbnVtZXJpYyBhcmNoIHNpemUsIGJ5IGNhc3Rp
bmcgYSA2NGJpdCBudW1iZXIgdG8gCj4gImxvbmciIHR5cGUuIGxvbmcgaGFzIHZhcmlhYmxlIGJ5
dGVzIGFuZCBpdCdzIGV2ZW50dWFsbHkgY3V0IGR1cmluZyB0aGUgCj4gY2FzdC4KPiAKPiBUaGUg
Y3Jhc2ggY2FuIGJlIHJlcHJvZHVjZWQgYmVjYXVzZSB3ZSBhcmUgVERFQlVHIHRoZSBmdWxsIHN5
c2NhbGwgCj4gYWRkcmVzcyBhbmQgYXJndW1lbnRzIHdoaWNoIGFyZSBnaXZlbiB0byBpdC4KClNv
bWUgY3Jhc2hlcyBtYXkgbmVlZCBtdWx0aXBsZSBzeXNjYWxscyB0byBzZXQgdXAuIFJ1bm5pbmcK
Y3Jhc2gwMiAtcyAkcm5kX3NlZWQKYWxsb3dzIGZvciBlYXNpZXIgcmVwcm9kdWN0aW9uIHRoYW4g
Y29weS1wYXN0aW5nIHRoZSBlbnRpcmUgY2FsbCBsb2cgCmludG8gYSBuZXcgdGVzdC4KCj4+PiAr
wqDCoMKgIGRvIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpbnZhbGlkID0gMDsKPj4+ICvCoMKgwqDC
oMKgwqDCoCBzeXNubyA9IHJhbmRfbnVtYmVyKCkgJSBNQVhfU1lTQ0FMTFM7Cj4+PiArCj4+PiAr
wqDCoMKgwqDCoMKgwqAgZm9yIChzaXplX3QgaSA9IDA7IGkgPCBBUlJBWV9TSVpFKGJsYWNrbGlz
dCk7IGkrKykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGJsYWNrbGlzdFtpXSA9
PSBzeXNubykgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnZhbGlkID0g
MTsKPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB9Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pgo+PiBUaGUgb3Jp
Z2luYWwgYXBwcm9hY2ggd2l0aCBpbl9ibGFja2xpc3QoKSBoZWxwZXIgZnVuY3Rpb24gd2FzIGNs
ZWFuZXIuIAo+PiBBbHNvIG5vdGUgdGhhdCBib3RoIHlvdXIgcmFuZF9udW1iZXIoKSBhbmQgbXkg
cmFuZF9sb25nKCkgY2FuIHJldHVybiAKPj4gbmVnYXRpdmUgdmFsdWVzLgo+IFRoZXkgY2FuIHJl
dHVybiAtMSBvbmx5LiBBbGwgdGhlIG5lZ2F0aXZlIHZhbHVlcyBiZWxvdyB0aGlzIHZhbHVlIGFy
ZSAKPiBjb252ZXJ0ZWQgdG8gcG9zaXRpdmUgbnVtYmVycy4KClJldHVybmluZyAtMSBtaWdodCBi
ZSBlbm91Z2ggdG8gY2F1c2UgdHJvdWJsZSBoZXJlLiBXaGlsZSB5b3UgZGlkIGFkZCAKX19MVFBf
X05SX0lOVkFMSURfU1lTQ0FMTCB0byB0aGUgYmxhY2tsaXN0LCBpZiB0aGUgY29uc3RhbnQgY2hh
bmdlcywgCnlvdSdsbCBlbmQgdXAgY2FsbGluZyBzeXNjYWxsKC0xLCAuLi4pIG9uIHNvbWUgYXJj
aHMgYW5kIApzeXNjYWxsKE1BWF9TWVNDQUxMUy0xLCAuLi4pIG9uIG90aGVycy4gVGhlIEMgc3Rh
bmRhcmQgZG9lc24ndCBkZWZpbmUgCndoaWNoIG9mIHRoZXNlIHZhbHVlcyBpcyB0aGUgY29ycmVj
dCByZXN1bHQgb2YgbW9kdWxvIG9wZXJhdGlvbiB3aXRoIGEgCm5lZ2F0aXZlIGxlZnQgb3BlcmFu
ZC4KCi0tIApNYXJ0aW4gRG91Y2hhICAgbWRvdWNoYUBzdXNlLmN6ClNXIFF1YWxpdHkgRW5naW5l
ZXIKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtvdmEgMTQ4LzM0CjE4NiAwMCBQ
cmFndWUgOApDemVjaCBSZXB1YmxpYwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
