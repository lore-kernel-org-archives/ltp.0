Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B210BC433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 08:18:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4487D3CCABC
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:18:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66A4A3CCABC
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:18:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 69B3163AC0C
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:18:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E3051F86B;
 Tue, 22 Nov 2022 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669105082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJoPTZf8dhDcnxxab0x6OJp05J8RUzh4Vf+qP2IcuRE=;
 b=c0/0fLMJEPD2u8wfCvzsKPGCYnU205rheZJQpr+J7hq65gvbP/UDK57RWBAeTDOAKOlJhF
 ILYi+iEL8bLKd/w5KEw+0kCwJi24FR8e0smOovoC32rShpM3NOx9j5R2ZhjntSrC5VFLqZ
 IbUCkNLKqRtxs5d/v7MdXB96IK5A7pQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669105082;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DJoPTZf8dhDcnxxab0x6OJp05J8RUzh4Vf+qP2IcuRE=;
 b=t6ZlHVlT/+KGzPXTBHeAnzZItQXrwLXyPEhbR8Ys19jsGwr5at6afes38YMxn5kX5H9baR
 tL4NacFQHcLEeuDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF57013B01;
 Tue, 22 Nov 2022 08:18:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +ngRLbmFfGNyFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Nov 2022 08:18:01 +0000
Date: Tue, 22 Nov 2022 09:17:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y3yFs2/jU1IBL+Xx@pevik>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
 <20221121091438.qpx3u5vpdu5afucg@quack3> <Y3tF2XF1xVlOE3fA@pevik>
 <20221121095345.2m7aze7xtlmxb4hy@quack3> <87r0xwfk0m.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87r0xwfk0m.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] fanotify10: Add support for multiple event
 files
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIZWxsbywKCj4gSmFuIEthcmEgPGphY2tAc3VzZS5jej4gd3JpdGVzOgoKPiA+IE9uIE1vbiAy
MS0xMS0yMiAxMDozMzoxMywgUGV0ciBWb3JlbCB3cm90ZToKPiA+PiBIaSBKYW4sIGFsbCwKCj4g
Pj4gPiBPbiBUaHUgMTctMTEtMjIgMTY6NTg6NTAsIFBldHIgVm9yZWwgd3JvdGU6Cj4gPj4gPiA+
IEhpIEphbiwgYWxsLAoKPiA+PiA+ID4gPiArI2RlZmluZSBmb3JlYWNoX3BhdGgodGMsIGJ1Ziwg
cG5hbWUpIFwKPiA+PiA+ID4gPiArCWZvciAoaW50IHBpdGVyID0gMDsgZm9ybWF0X3BhdGhfY2hl
Y2soKGJ1ZiksICh0YyktPnBuYW1lIyNfZm10LAlcCj4gPj4gPiA+IFVuZm9ydHVuYXRlbHkgd2Ug
c3RpbGwgc3VwcG9ydCBDOTkgZHVlIG9sZCBjb21waWxlciBvbiBDZW50T1MgNywKPiA+PiA+ID4g
dGhlcmVmb3JlIGludCBwaXRlciBuZWVkcyB0byBiZSBkZWZpbmVkIG91dHNpZGUgb2YgZm9yIGxv
b3AuCgo+ID4+ID4gSHVtLCBidXQgdmFyaWFibGUgZGVjbGFyYXRpb24gaW4gdGhlIGZvciBsb29w
IGlzIHBhcnQgb2YgQzk5IHN0YW5kYXJkIChhcwo+ID4+ID4gdGhlIGVycm9yIG1lc3NhZ2UgYWxz
byBzYXlzKS4gU28gZGlkIHlvdSB3YW50IHRvIHNheSB5b3UgYXJlIGNvbXBpbGluZwo+ID4+ID4g
YWdhaW5zdCBDODkgc3RhbmRhcmQ/IEFuZCBDZW50T1MgNyBzaGlwcyB3aXRoIEdDQyA0LjguNSBB
RkFJQ1Mgd2hpY2ggc2hvdWxkCj4gPj4gPiBiZSBmdWxseSBDOTkgY29tcGxpYW50IEJUVy4gU28g
d2hhdCdzIHRoZSBzaXR1YXRpb24gaGVyZT8KPiA+PiBJJ20gc29ycnksIEkgZGlkbid0IGV4cHJl
c3MgY2xlYXJseSBteXNlbGYuIFllcywgNC44LjUgc3VwcG9ydHMgQzk5LAo+ID4+IGJ1dCB0aGUg
ZGVmYXVsdCBpcyBDOTAgWzFdLgoKPiA+IE9LLCB0aGFua3MgZm9yIGV4cGxhbmF0aW9uLgoKPiA+
PiA+IFRoYXQgYmVpbmcgc2FpZCBJIGNhbiB3b3JrYXJvdW5kIHRoZSBwcm9ibGVtIGluIHRoZSBt
YWNybywgaXQgd2lsbCBqdXN0IGJlCj4gPj4gPiBzb21ld2hhdCB1Z2xpZXIuIFNvIGJlZm9yZSBk
b2luZyB0aGF0IEknZCBsaWtlIHRvIHVuZGVyc3RhbmQgd2hldGhlcgo+ID4+ID4gZm9sbG93aW5n
IEM4OSBpcyByZWFsbHkgcmVxdWlyZWQuLi4KCj4gPj4gSSdtIGRvbid0IHJlbWVtYmVyIHdoeSB3
ZSBoYXZlIGp1c3Qgbm90IHNwZWNpZmllZCAtc3RkPS4uLiBhbHJlYWR5LCBDeXJpbCBoYWQKPiA+
PiBzb21lIG9iamVjdGlvbnMsIHRodXMgQ2MgaGltLgoKPiA+PiBDZW50MFMgRU9MIGluIDIwMjQt
MDYsIHdlIG1pZ2h0IHJlY29uc2lkZXIgdG8gYWRkIC1zdGQ9Li4uIHRvIGVuZHVwIHRoaXMgYWdv
bnkKPiA+PiAoZXJyb3JzIGxpa2UgdGhpcyBvZnRlbiBuZWVkIHRvIGJlIGZpeGVkKS4KCj4gPj4g
WzFdIGh0dHBzOi8vZ2NjLmdudS5vcmcvb25saW5lZG9jcy9nY2MtNC44LjUvZ2NjL1N0YW5kYXJk
cy5odG1sCgo+ID4gR2l2ZW4gQ3lyaWwncyByZXBseSwgc2hvdWxkIEkgcmV3b3JrIG15IHBhdGNo
IG9yIGFyZSB3ZSBmaW5lIHdpdGggdXNpbmcKPiA+IEM5OT8KCj4gV2VsbCAtc3RkPWM5OSBkb2Vz
bid0IHdvcmssIGJ1dCB3ZSBjYW4gdXNlIC1zdGQ9Z251OTkuIElmIHRoYXQgZG9lc24ndAo+IGZp
eCBpdCB0aGVuIHdlIHNob3VsZCBkcm9wIGNlbnRvczA3IG5vdyBJTU8uCkknZCBiZSBvayB0byBw
dXQgZmFub3RpZnkxMDogQ0ZMQUdTICs9IC1zdGQ9Z251OTkgb3IgZXZlbiBDRkxBR1MgKz0gLXN0
ZD1nbnU5OQooZm9yIGFsbCB0ZXN0cykgaW50byBmYW5vdGlmeSdzIE1ha2VmaWxlLCB3aGljaCBm
aXhlcyB0aGUgcHJvYmxlbS4KVW5sZXNzIGFueWJvZHkgb2JqZWN0cywgSSBjYW4gY2hhbmdlIGl0
IGJlZm9yZSBtZXJnZS4KCkBSaWNoaWU6IHdlIG5lZWQgdG8ga2VlcCBDZW50MFMgNyB3b3JraW5n
IHVudGlsIGl0cyBFT0wgaW4gMjAyNC0wNi4KCkkgZ3Vlc3MgdGhlIHJlYXNvbiBub3QgdG8gc3Bl
Y2lmeSBpdCBpbiB0b3AgbGV2ZWwgTWFrZWZpbGUgd2FzIHRvIGhhdmUgTFRQIGNvZGUKYmVpbmcg
dGVzdGVkIG9uIG5ld2VyIHN0YW5kYXJkcy4gVW5sZXNzIHRoZXJlIGlzIGEgZ29vZCByZWFzb24g
Zm9yIGl0LCBJJ2Qgdm90ZQpmb3IgcHV0dGluZyAtc3RkPWdudTk5IGludG8gdG9wIGxldmVsIENG
TEFHUyAoYW5kIGluY3JlYXNlIGl0IGFmdGVyIENlbnRPUyA3IEVPTCkuCgpLaW5kIHJlZ2FyZHMs
ClBldHIKCj4gPiAJCQkJCQkJCUhvbnphCgo+ID4+ID4gPiBmYW5vdGlmeTEwLmM6NDcwOjI6IGVy
cm9yOiDigJhmb3LigJkgbG9vcCBpbml0aWFsIGRlY2xhcmF0aW9ucyBhcmUgb25seSBhbGxvd2Vk
IGluIEM5OSBtb2RlCj4gPj4gPiA+ICAgZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9j
aGVjaygoYnVmKSwgKHRjKS0+cG5hbWUjI19mbXQsIFwKPiA+PiA+ID4gICBeCgo+ID4+ID4gPiBm
YW5vdGlmeTEwLmM6NDcwOjExOiBlcnJvcjogcmVkZWZpbml0aW9uIG9mIOKAmHBpdGVy4oCZCj4g
Pj4gPiA+ICAgZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9jaGVjaygoYnVmKSwgKHRj
KS0+cG5hbWUjI19mbXQsIFwKPiA+PiA+ID4gICAgICAgICAgICBeCj4gPj4gPiA+IEtpbmQgcmVn
YXJkcywKPiA+PiA+ID4gUGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
