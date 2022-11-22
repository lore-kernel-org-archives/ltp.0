Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69D4C433FE
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 08:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9CD893CCAC4
	for <ltp@archiver.kernel.org>; Tue, 22 Nov 2022 09:54:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 989503CCABC
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:53:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E7F8E20B486
 for <ltp@lists.linux.it>; Tue, 22 Nov 2022 09:53:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 491EE1F8B8;
 Tue, 22 Nov 2022 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669107235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JnNJ2b10FhczVQqhuxwgli00kkUVJltI798NVhXMII=;
 b=ZPigLy5feWqV1QQmUTyDvE8N2S+qHnVcnKWS8rsBtG2WggMpPd3kgVTHkX+QQ8wDMkniFs
 C2clw17HRY6G9ULCTLJq7d9fDCaFNPTuwVnmfgIJauIIFE4dRopFFkUnSHVDJc45rT0NKJ
 djrZ7cQEfyFQp4EL3q9hTTPfylOK8OQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669107235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7JnNJ2b10FhczVQqhuxwgli00kkUVJltI798NVhXMII=;
 b=bUsgdklOLmvVy5Ur5vm2tg5+AAMMLGnFZojZbeWgkCd3oViR6VV4M1JSRK8m3Z/bol5aOu
 qsRveGPzk6GZVuCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 17C882C142;
 Tue, 22 Nov 2022 08:53:55 +0000 (UTC)
References: <20221121144505.1496-1-rpalethorpe@suse.com>
 <Y3uUk6nKsASeFRf7@yuki> <87mt8kfgad.fsf@suse.de> <Y3ukncX84lQTJNe9@rei>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Nov 2022 08:11:41 +0000
Organization: Linux Private Site
In-reply-to: <Y3ukncX84lQTJNe9@rei>
Message-ID: <87ilj7fjz6.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4gd3JpdGVzOgoKPiBIaSEKPj4g
PiBJIHdvZGVyIGlmIHRoaXMgd291bGQgd29yayB3aXRoIGRpZmZlcmVudCBjb21waWxlcnMuIEkg
c3VwcG9zZSBjbGFuZwo+PiA+IGRvZXMgd29yaywgYnV0IHdoYXQgYWJvdXQgaWNjPwo+PiAKPj4g
Q2xhbmcgaXMgZmluZS4gSSBkb3VidCB0aGF0IGljYyBjb21waWxlcyBMVFAgYXQgcHJlc2VudCB1
bmxlc3MgaXQgZG9lcwo+PiBzdXBwb3J0IEdOVSBleHRlbnNpb25zLgo+Cj4gRmFpciBlbm91Z2gu
Cj4KPj4gPiBJIHN1cG9zZSB0aGF0IHdlIGdldCB0b25zIG9mICdjYW4ndCBkbyBwb2ludGVyIGFy
aXRobWV0aWNzIG9uIHZvaWQqCj4+ID4gcG9pbnRlcnMgYW5kIHN0dWZmJyB3aXRoIHBsYWluIGM5
OS4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNsZWFuCj4+ID4gdGhlc2Ugb3V0IGluc3Rl
YWQuCj4+IAo+PiBodHRwczovL2dpdGh1Yi5jb20vcmljaGllanAvbHRwL2FjdGlvbnMvcnVucy8z
NTE1MTY1ODAzL2pvYnMvNTg5MDA4MTczNgo+PiAKPj4gU29tZSBvZiB0aGlzIGlzIHNvbHZlZCBi
eSAtRF9YT1BFTl9TT1VSQ0U9NzAwIG9yIHNvbWUgb3RoZXIgbWFjcm8gKHdlCj4+IG5lZWQgbXVs
dGlwbGUpLiBIb3dldmVyIGl0IGRvZXNuJ3QgZW5kIHRoZXJlOgo+PiAKPj4gIG1ha2UgU1REQ0ZM
QUdTPSctc3RkPWMyeCAtRF9YT1BFTl9TT1VSQ0U9NzAwJwo+PiBtYWtlIC1DICJsaWIiIFwKPj4g
CS1mICIvaG9tZS9yaWNoL3FhL2x0cC9saWIvTWFrZWZpbGUiIGFsbAo+PiBtYWtlWzFdOiBFbnRl
cmluZyBkaXJlY3RvcnkgJy9ob21lL3JpY2gvcWEvbHRwL2xpYicKPj4gSW4gZmlsZSBpbmNsdWRl
ZCBmcm9tIC4uL2luY2x1ZGUvb2xkL3Rlc3QuaDozNywKPj4gICAgICAgICAgICAgICAgICBmcm9t
IGdldF9wYXRoLmM6NDE6Cj4+IGdldF9wYXRoLmM6IEluIGZ1bmN0aW9uIOKAmHRzdF9nZXRfcGF0
aOKAmToKPj4gLi4vaW5jbHVkZS90c3RfbWlubWF4Lmg6MTA6OTogd2FybmluZzogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYdHlwZW9m4oCZIFstV2ltcGxpY2l0LWZ1bmN0aW9u
LWRlY2xhcmF0aW9uXQo+PiAgICAxMCB8ICAgICAgICAgdHlwZW9mKGEpIF9hID0gKGEpOyBcCj4+
ICAgICAgIHwgICAgICAgICBefn5+fn4KPgo+Cj4gSG1tIHRoYXQncyBzdHJhbmdlLCBzdXBwb3Nl
ZGx5IHR5cGVvZigpIGlzIGZpbmFsbHkgc3RhbmRhcnRpemVkIGluIGMyeCwKPiBidXQgaXQgd291
bGQgYmUgb2J2aW91c2x5IG1pc3NpbmcgZnJvbSBhbnl0aGluZyBvbGRlci4KPgo+PiBXZSBwcm9i
YWJseSBhbHNvIHVzZSAneCA/OiB5JyBhbmQgc3R1ZmYgbGlrZSB0aGF0Lgo+PiAKPj4gU28gdGhp
cyBvcGVucyB1cCBhIHJhdHMgbmVzdCBiYXNpY2FsbHkuCj4KPiBTaWdoLCB3ZWxsIExUUCB3YXMg
bmV2ZXIgYSBuaWNlIGNvZGViYXNlLCBhdCBsZWFzdCBpdCBjb21waWxlcyBtb3N0IG9mCj4gdGhl
IHRpbWUgdGhlc2UgZGF5cy4KClVzaW5nIHdoYXRldmVyIGxhbmd1YWdlIGZlYXR1cmVzIHNlZW0g
cmVhc29uYWJsZSBhbmQgYWRkaW5nIGNvbXBpbGF0aW9uCnRhcmdldHMgdG8gdGhlIENJIHNlZW1z
IGxpa2UgdGhlIGJlc3Qgd2F5IHRvIGdvIElNTy4KCi0tIApUaGFuayB5b3UsClJpY2hhcmQuCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
