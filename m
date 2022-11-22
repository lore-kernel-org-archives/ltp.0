Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4E9C43217
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 08:26:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE31A3CCAFB
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:26:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C20D93C0367
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:26:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A703124AAA5
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:26:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F00021EE8;
 Tue, 22 Nov 2022 08:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669105575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iW1vl6/KwpDW6BuxQS4F3nIfK/wsLxgRWizBqbn7PI=;
 b=25gIg/PlgeAKXUbFFYX+SGX0HMzwrxoJkdKuZ/uvD2QFK2Ge9bkalPSya7NlD32IA35SFn
 ccmNGON1HwPaJJmrke2aKySIOZCCaL3zInOm7OHOEYJMnied7IIcQwkNLe7R61Uf0Rbmgy
 xWU24CEKDKACkCjolLRCR/QqqGQvcAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669105575;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/iW1vl6/KwpDW6BuxQS4F3nIfK/wsLxgRWizBqbn7PI=;
 b=phYejexvfKVbB9uyLlbkv4y4u56+qvagasZLn0vZfAOQhCUiYlLlYeHbSSu0E/LwES3Mjf
 3RNf9lEZ3I8+wIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6663113B01;
 Tue, 22 Nov 2022 08:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id cD2oF6eHfGMXGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 22 Nov 2022 08:26:15 +0000
Date: Tue, 22 Nov 2022 09:26:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y3yHo7tw4kT8J4H7@pevik>
References: <20221121144505.1496-1-rpalethorpe@suse.com>
 <Y3uUk6nKsASeFRf7@yuki> <87mt8kfgad.fsf@suse.de>
 <Y3ukncX84lQTJNe9@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3ukncX84lQTJNe9@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] config: Explicitly set gnu99
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
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKUmV2aWV3ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKPiBIaSEK
PiA+ID4gSSB3b2RlciBpZiB0aGlzIHdvdWxkIHdvcmsgd2l0aCBkaWZmZXJlbnQgY29tcGlsZXJz
LiBJIHN1cHBvc2UgY2xhbmcKPiA+ID4gZG9lcyB3b3JrLCBidXQgd2hhdCBhYm91dCBpY2M/Cgo+
ID4gQ2xhbmcgaXMgZmluZS4gSSBkb3VidCB0aGF0IGljYyBjb21waWxlcyBMVFAgYXQgcHJlc2Vu
dCB1bmxlc3MgaXQgZG9lcwo+ID4gc3VwcG9ydCBHTlUgZXh0ZW5zaW9ucy4KCj4gRmFpciBlbm91
Z2guCgpGWUkgVGhlIGNvZGUgd2FzIGNvbXBpbGVkIGFsc28gd2l0aCAtc3RkPWM5OSBvbiBib3Ro
IGdjYyBhbmQgY2xhbmcKKGp1c3QgaW4gY2FzZSBzb21lIHN0cmFuZ2UgY29tcGlsZXIgaGFkIHBy
b2JsZW1zIHdpdGggZ251OTkpLgoKPiA+ID4gSSBzdXBvc2UgdGhhdCB3ZSBnZXQgdG9ucyBvZiAn
Y2FuJ3QgZG8gcG9pbnRlciBhcml0aG1ldGljcyBvbiB2b2lkKgo+ID4gPiBwb2ludGVycyBhbmQg
c3R1ZmYnIHdpdGggcGxhaW4gYzk5LiBNYXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2xlYW4K
PiA+ID4gdGhlc2Ugb3V0IGluc3RlYWQuCgo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3JpY2hpZWpw
L2x0cC9hY3Rpb25zL3J1bnMvMzUxNTE2NTgwMy9qb2JzLzU4OTAwODE3MzYKCj4gPiBTb21lIG9m
IHRoaXMgaXMgc29sdmVkIGJ5IC1EX1hPUEVOX1NPVVJDRT03MDAgb3Igc29tZSBvdGhlciBtYWNy
byAod2UKPiA+IG5lZWQgbXVsdGlwbGUpLiBIb3dldmVyIGl0IGRvZXNuJ3QgZW5kIHRoZXJlOgoK
PiA+ICBtYWtlIFNURENGTEFHUz0nLXN0ZD1jMnggLURfWE9QRU5fU09VUkNFPTcwMCcKPiA+IG1h
a2UgLUMgImxpYiIgXAo+ID4gCS1mICIvaG9tZS9yaWNoL3FhL2x0cC9saWIvTWFrZWZpbGUiIGFs
bAo+ID4gbWFrZVsxXTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvaG9tZS9yaWNoL3FhL2x0cC9saWIn
Cj4gPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vaW5jbHVkZS9vbGQvdGVzdC5oOjM3LAo+ID4g
ICAgICAgICAgICAgICAgICBmcm9tIGdldF9wYXRoLmM6NDE6Cj4gPiBnZXRfcGF0aC5jOiBJbiBm
dW5jdGlvbiDigJh0c3RfZ2V0X3BhdGjigJk6Cj4gPiAuLi9pbmNsdWRlL3RzdF9taW5tYXguaDox
MDo5OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlvbiDigJh0eXBlb2bi
gJkgWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gPiAgICAxMCB8ICAgICAgICAg
dHlwZW9mKGEpIF9hID0gKGEpOyBcCj4gPiAgICAgICB8ICAgICAgICAgXn5+fn5+CgoKPiBIbW0g
dGhhdCdzIHN0cmFuZ2UsIHN1cHBvc2VkbHkgdHlwZW9mKCkgaXMgZmluYWxseSBzdGFuZGFydGl6
ZWQgaW4gYzJ4LAo+IGJ1dCBpdCB3b3VsZCBiZSBvYnZpb3VzbHkgbWlzc2luZyBmcm9tIGFueXRo
aW5nIG9sZGVyLgoKPiA+IFdlIHByb2JhYmx5IGFsc28gdXNlICd4ID86IHknIGFuZCBzdHVmZiBs
aWtlIHRoYXQuCgo+ID4gU28gdGhpcyBvcGVucyB1cCBhIHJhdHMgbmVzdCBiYXNpY2FsbHkuCgo+
IFNpZ2gsIHdlbGwgTFRQIHdhcyBuZXZlciBhIG5pY2UgY29kZWJhc2UsIGF0IGxlYXN0IGl0IGNv
bXBpbGVzIG1vc3Qgb2YKPiB0aGUgdGltZSB0aGVzZSBkYXlzLgoKS2luZCByZWdhcmRzLApQZXRy
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
