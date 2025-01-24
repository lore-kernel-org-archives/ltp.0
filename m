Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316C1C02181
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 12:31:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E2D83C5654
	for <ltp@archiver.kernel.org>; Fri, 24 Jan 2025 13:31:34 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 804D93C4FB6
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 13:31:16 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 276922309FF
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 13:31:15 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9646E1F815;
 Fri, 24 Jan 2025 12:31:14 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B0F913999;
 Fri, 24 Jan 2025 12:31:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tvL0HBKIk2eoLQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 24 Jan 2025 12:31:14 +0000
Message-ID: <71d4414b-802f-4019-8527-e8886e2d1aeb@suse.cz>
Date: Fri, 24 Jan 2025 13:30:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Amir Goldstein <amir73il@gmail.com>, Petr Vorel <pvorel@suse.cz>
References: <20250124100151.GD159953@pevik>
 <CAOQ4uxgSLN9QgoZOaB4H+80AjgnLEHOQOcH-BpM=yAfQO47MTw@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <CAOQ4uxgSLN9QgoZOaB4H+80AjgnLEHOQOcH-BpM=yAfQO47MTw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 9646E1F815
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Split some fanotify tests
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiAyNC4gMDEuIDI1IDExOjIxLCBBbWlyIEdvbGRzdGVpbiB3cm90ZToKPiBPbiBGcmks
IEphbiAyNCwgMjAyNSBhdCAxMTowMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3
cm90ZToKPj4KPj4gSGkgQW1pciwKPj4KPj4gRllJIHdlIHdlcmUgdGhpbmtpbmcgd2l0aCBNYXJ0
aW4gYWJvdXQgc3BsaXR0aW5nIHNvbWUgb2YgdGhlIGZhbm90aWZ5IHRlc3RzLgo+PiBXaHk/Cj4+
Cj4+IFNvbWUgb2YgdGhlIGZhbm90aWZ5IHRlc3RzIGFyZSBoYXJkIHRvIHJldmlldyAoZS5nLiBm
YW5vdGlmeXsxMCwxMywxNH0uYywpLAo+PiBiZWNhdXNlIHRoZSBoYXZlIGEgbG90IG9mIHJlc3Vs
dHMuCj4gCj4gSSBhc3N1bWUgeW91IGFyZSByZWZlcnJpbmcgdG8gdGVzdCBjYXNlcyB0aGF0IGFy
ZSBkZWNsYXJlZCBhcyByZWdyZXNzaW9uCj4gdGVzdHMgZm9yIGEgZml4IGNvbW1pdC4KPiBEbyB5
b3UgaW50ZW5kIHRvIHNwbGl0IGV2ZXJ5IHN1Y2ggdGVzdCBjYXNlIGludG8gaXRzIG93biB0ZXN0
Pwo+IAo+IEkgYWdyZWUgdGhhdCB0aGUgRkFOX0RFTEVURV9TRUxGIHRlc3QgY2FzZSBpcyBhIGdv
b2QgY2FuZGlkYXRlCj4gZm9yIHNwbGl0dGluZywgaWYgbm90IGZvciBhbnl0aGluZyBlbHNlLCBi
ZWNhdXNlIHRoZSB1Z2xpbmVzcyBvZiByZXF1aXJpbmcgdGhpcwo+IHRlc3QgY2FzZSB0byBiZSB0
aGUgbGFzdCB0ZXN0IGNhc2UuCgpZZXMsIHRoYXQgd291bGQgYmUgYSBnb29kIGNhbmRpZGF0ZSBm
b3IgaXRzIG93biB0ZXN0LiBCdXQgaW4gZ2VuZXJhbCwgCm9uZSB0ZXN0IHByb2dyYW0gc2hvdWxk
IGhhdmUgYXQgbW9zdCA1LTEwIHN1YnRlc3RzIHNvIHRoYXQgd2hlbiB5b3UgbmVlZCAKdG8gd2hp
dGVsaXN0IGl0IGFzIGEgd2hvbGUsIHlvdSBkb24ndCBsb3NlIHRvbyBtdWNoIHRlc3QgY292ZXJh
Z2UgZHVlIHRvIApvbmUgZmFpbGluZyBzdWJ0ZXN0LiBUaGVyZSBhcmUgb2YgY291cnNlIGV4Y2Vw
dGlvbnMsIGNsb3NlbHkgcmVsYXRlZCAKc3VidGVzdHMgKGUuZy4gYSBzaW5nbGUgc2V0IG9mIGlu
aXQgYW5kIG1hcmsgZmxhZ3MgdGVzdGVkIG9uIGRpZmZlcmVudCAKdHlwZXMgb2YgZmlsZXN5c3Rl
bSBvYmplY3RzKSBjYW4gYmUgaW4gdGhlIHNhbWUgdGVzdCBwcm9ncmFtIGV2ZW4gaWYgCnRoZXJl
J3Mgd2F5IG1vcmUgdGhhbiAxMCBvZiB0aGVtLgoKPiBJZiB0aGUgdGVzdCBydW5uZXIgd2hpdGVs
aXN0cyBhIHRlc3QgaXQncyB1cCB0byB0aGVtLgo+IEl0IHdvdWxkIGJlIG5pY2UgaWYgTFRQIGNv
dWxkIGFkZCB0aGUgYWJpbGl0eSB0byB3aGl0ZWxpc3QgYSB0ZXN0IGNhc2UvdmFyaWFudAo+IG9y
IGV2ZW4gYSBzcGVjaWZpYyBmaWxlc3lzdGVtIGZvciBhIHNwZWNpZmljIGFsbF9maWxlc3lzdGVt
cyB0ZXN0LCBidXQKPiBpdCdzIHVwIHRvCj4geW91IGd1eXMgdG8gZGVjaWRlIGlmIGl0IGlzIHdv
cnRoIGl0LgoKRXhpdGluZyBhIHN1YnRlc3Qgd2l0aCBUQ09ORiBpcyB0aGUgb25seSB3YXkgb2Yg
d2hpdGVsaXN0aW5nIGlzc3VlcyAKaW5zaWRlIExUUCBhdCB0aGUgbW9tZW50LiBUaGUgbWFpbiBj
b25jZXJuIGluIHRoaXMgdGhyZWFkIGlzIHRoZSAKZGlmZmljdWx0eSBhbmQgdHJhZGUtb2ZmcyBv
ZiB3aGl0ZWxpc3RpbmcgYXQgdGhlIHRlc3QgcnVubmVyIGxldmVsLgoKPiBUaGUgcmVhc29uIEkg
dGVuZCB0byBhZGQgdGVzdCBjYXNlcyBpcyB0byBzYXZlIGNvZGUgZHVwbGljYXRpb24gYmV0d2Vl
biB0ZXN0cywKPiBiZWNhdXNlIHRoZXJlIGlzIGEgbG90IG9mIGJvaWxlcnBsYXRlIGNvZGUgZm9y
IGV2ZW50IHZlcmlmaWNhdGlvbiwgd2hpY2ggb2Z0ZW4KPiBoYXMgYnVncyBhbmQgbmVlZHMgZml4
aW5nIGluIG11bHRpcGxlIHRlc3RzLgo+IFRoZXJlIGlzIGFub3RoZXIgc29sdXRpb24gZm9yIGNv
ZGUgZHVwbGljYXRpb24gLSB0byB3cml0ZSBnZW5lcmljIGZhbm90aWZ5IGV2ZW50Cj4gdmVyaWZp
Y2F0aW9uIGhlbHBlcnMuCj4gCj4gSXQncyB1cCB0byB5b3UgdG8gZGVjaWRlIGlmIHRoZXJlIGlz
IHJvb20gZm9yIHNvbWUgaGVscGVycyBmb3IgZmFub3RpZnkgZXZlbnQKPiB2ZXJpZmljYXRpb24g
b3IgaWYgeW91IHdhbnQgdG8gZm9yayB0aGUgdGVzdHMgd2l0aCBjb2RlIGR1cGxpY2F0aW9uLgo+
IFdEWVQ/CgpTaGFyZWQgZmlsZSB3aXRoIGZhbm90aWZ5IHZlcmlmaWNhdGlvbiBoZWxwZXIgY29k
ZSB3b3VsZCBiZSBncmVhdC4gClRoYW5rcyBpbiBhZHZhbmNlLgoKLS0gCk1hcnRpbiBEb3VjaGEg
ICBtZG91Y2hhQHN1c2UuY3oKU1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNFIExJTlVYLCBzLnIuby4K
Q09SU08gSUlhCktyaXppa292YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGlj
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
