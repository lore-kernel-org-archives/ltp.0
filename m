Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9901FC54E94
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 10:40:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 755773CB387
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 11:40:13 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6D043CB355
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:40:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 129D41400431
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:40:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBF7221E3F;
 Thu, 26 Jan 2023 10:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674729600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bAa6tZOaDSzh1jYd0xZcrG2hyx087j6Qdw+e3JX5GM=;
 b=sy9/K/G0bav0j8qnsXy1ZIXJb4NFNqyFrjf7hVIomVObWYs3yP1BbQehR4wr1YBur1SvY/
 7LA68XM/F6JgzrerYLaBX7FGQF7G/YCwX6HEOqFGcx0NFJjozD9XJPa2IhXYO7tFnBIJjv
 ByF7nIdFOHPEfzgWdheDgMY9td1F9GA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674729600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8bAa6tZOaDSzh1jYd0xZcrG2hyx087j6Qdw+e3JX5GM=;
 b=l1DEWspTsczeoPNAqhwa7kTmTbaLEpaL/gqf/x1TGYPv+FoVMvHnSZHXFNh4/MjbfYN3pn
 3Ebp+vCJ3Vr4AtBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A28EF13A09;
 Thu, 26 Jan 2023 10:40:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UT4gI4BY0mP0AgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 26 Jan 2023 10:40:00 +0000
Date: Thu, 26 Jan 2023 11:39:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y9JYfuWB2cdYgMQ+@pevik>
References: <20230125232751.31809-1-pvorel@suse.cz>
 <Y9JVZdbm/1yLwAKs@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y9JVZdbm/1yLwAKs@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify.h: Include <linux/types.h>
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBIaSEKPiA+IHRvIGFkZCBrZXJuZWwgdHlwZXMgKF9fczMyLCBfX3UzMiwgLi4uKS4KCj4gPiBU
aGlzIGZpeGVzIGJ1aWxkIG9uIHZhcmlvdXMgQnVpbGRyb290IHRvb2xjaGFpbnM6Cgo+ID4gSW4g
ZmlsZSBpbmNsdWRlZCBmcm9tIGZhbm90aWZ5Lmg6MTQsCj4gPiAgICAgICAgICAgICAgICAgIGZy
b20gZmFub3RpZnkwNC5jOjI1Ogo+ID4gLi4vLi4vLi4vLi4vaW5jbHVkZS9sYXBpL2Zhbm90aWZ5
Lmg6MTk4OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3MzMuKAmQo+ID4gICAxOTgg
fCAgX19zMzIgZXJyb3I7Cj4gPiAgICAgICB8ICBefn5+fgo+ID4gLi4vLi4vLi4vLi4vaW5jbHVk
ZS9sYXBpL2Zhbm90aWZ5Lmg6MTk5OjI6IGVycm9yOiB1bmtub3duIHR5cGUgbmFtZSDigJhfX3Uz
MuKAmQo+ID4gICAxOTkgfCAgX191MzIgZXJyb3JfY291bnQ7Cj4gPiAgICAgICB8ICBefn5+fgoK
PiA+IE5PVEU6IEhpc3RvcmljYWxseSB3ZSB0cmllZCB0byBtaW5pbWl6ZSBudW1iZXIgb2YgbGlu
dXggaW5jbHVkZXMsCj4gPiBiZWNhdXNlIGl0IHdvdWxkIG9mdGVuIGxlYWQgdG8gYnJva2VuIGJ1
aWxkcy4gSGVhZGVycyBnb3QgYmV0dGVyIG92ZXIKPiA+IHRpbWUgYW5kIExUUCBhbHNvIGRyb3Bw
ZWQgc3VwcG9ydCBmb3IgYXJjaGFpYyBrZXJuZWxzIG92ZXIgdGltZS4KPiA+IFRoZXJlZm9yZSB3
ZSBjYW4ga2VlcCBvcmlnaW5hbCBrZXJuZWwgdHlwZXMgaGVyZS4KCj4gPiBGaXhlczogNjcwNjlm
YzQ2YSAoInN5c2NhbGxzL2Zhbm90aWZ5MjI6IFZhbGlkYXRlIHRoZSBnZW5lcmljIGVycm9yIGlu
Zm8iKQoKPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHBldHIudm9yZWxAZ21haWwuY29t
Pgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlm
eS5oIHwgMSArCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgo+ID4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaCBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+ID4gaW5kZXggNTEw
NzgxMDNlYi4uZGE3ODc4ODM3OCAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gPiBAQCAtMTEsNiArMTEsNyBAQAo+ID4gICNpbmNs
dWRlIDxzeXMvdHlwZXMuaD4KPiA+ICAjaW5jbHVkZSA8c3lzL3N0YXQuaD4KPiA+ICAjaW5jbHVk
ZSA8ZXJybm8uaD4KPiA+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4KCj4gU2hvdWxkbid0IHRo
YXQgZ28gaW50byB0aGUgbGFwaS9mYW5vdGlmeS5oIGluc3RlYWQ/IE90aGVyd2lzZSB0aGUgbmV4
dAo+IGZpbGUgdGhhdCBpbmNsdWRlcyB0aGUgaGVhZGVyIHdpbGwgaGF2ZSB0aGUgZXhhY3RseSBz
YW1lIHByb2JsZW0uCgpBaCB5ZXMsIHlvdSdyZSByaWdodCwgSSBkb24ndCBrbm93IG15c2VsZiB3
aHkgSSBwdXQgaXQgdGhhdCBpbnRvIHRoZSBvdGhlciBvbmUuCgpLaW5kIHJlZ2FyZHMsClBldHIK
Cj4gPiAgI2luY2x1ZGUgImxhcGkvZmFub3RpZnkuaCIKPiA+ICAjaW5jbHVkZSAibGFwaS9mY250
bC5oIgoKPiA+IC0tIAo+ID4gMi4zOS4xCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
