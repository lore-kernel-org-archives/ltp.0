Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97ECC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 09:54:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 068E13CCB97
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 10:54:01 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46D203C0F12
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:53:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 870AF1BC6DC3
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 10:53:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4B341F85D;
 Mon, 21 Nov 2022 09:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669024425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Coh9JOSrCXV8KecRbrkb0lOMdR+a4bd2/SSh1W7K8PA=;
 b=Rwbg51PB/CMLN8IhdN8nfQcqaAgwdsxr692PqWfdq9dGp05TDbndIJVeibnUQoczz6616t
 TMYccFgRFKFc4PqVr7kDX+mhdat9QhHpBuiK5dXBOgffLh8R1awJwUKgs93ZFUoMVeSJLp
 njl/yrXz7RhaIAiRnPebj14aT6sLOlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669024425;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Coh9JOSrCXV8KecRbrkb0lOMdR+a4bd2/SSh1W7K8PA=;
 b=3UefBaHdUZ3W2GTfa4XepuQgXuB/aKtM0McBeLQCvYVqx/E8gzj5iA1yAWvXI8sTGiFOTy
 tuYOC1iZmoGedCBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF8E51377F;
 Mon, 21 Nov 2022 09:53:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gwQ4LqlKe2OhegAAMHmgww
 (envelope-from <jack@suse.cz>); Mon, 21 Nov 2022 09:53:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 459B8A070A; Mon, 21 Nov 2022 10:53:45 +0100 (CET)
Date: Mon, 21 Nov 2022 10:53:45 +0100
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20221121095345.2m7aze7xtlmxb4hy@quack3>
References: <20221115123721.12176-1-jack@suse.cz>
 <20221115124741.14400-2-jack@suse.cz> <Y3ZaOqpTvvBgUTTi@pevik>
 <20221121091438.qpx3u5vpdu5afucg@quack3> <Y3tF2XF1xVlOE3fA@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y3tF2XF1xVlOE3fA@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIDIxLTExLTIyIDEwOjMzOjEzLCBQZXRyIFZvcmVsIHdyb3RlOgo+IEhpIEphbiwgYWxs
LAo+IAo+ID4gT24gVGh1IDE3LTExLTIyIDE2OjU4OjUwLCBQZXRyIFZvcmVsIHdyb3RlOgo+ID4g
PiBIaSBKYW4sIGFsbCwKPiAKPiA+ID4gPiArI2RlZmluZSBmb3JlYWNoX3BhdGgodGMsIGJ1Ziwg
cG5hbWUpIFwKPiA+ID4gPiArCWZvciAoaW50IHBpdGVyID0gMDsgZm9ybWF0X3BhdGhfY2hlY2so
KGJ1ZiksICh0YyktPnBuYW1lIyNfZm10LAlcCj4gPiA+IFVuZm9ydHVuYXRlbHkgd2Ugc3RpbGwg
c3VwcG9ydCBDOTkgZHVlIG9sZCBjb21waWxlciBvbiBDZW50T1MgNywKPiA+ID4gdGhlcmVmb3Jl
IGludCBwaXRlciBuZWVkcyB0byBiZSBkZWZpbmVkIG91dHNpZGUgb2YgZm9yIGxvb3AuCj4gCj4g
PiBIdW0sIGJ1dCB2YXJpYWJsZSBkZWNsYXJhdGlvbiBpbiB0aGUgZm9yIGxvb3AgaXMgcGFydCBv
ZiBDOTkgc3RhbmRhcmQgKGFzCj4gPiB0aGUgZXJyb3IgbWVzc2FnZSBhbHNvIHNheXMpLiBTbyBk
aWQgeW91IHdhbnQgdG8gc2F5IHlvdSBhcmUgY29tcGlsaW5nCj4gPiBhZ2FpbnN0IEM4OSBzdGFu
ZGFyZD8gQW5kIENlbnRPUyA3IHNoaXBzIHdpdGggR0NDIDQuOC41IEFGQUlDUyB3aGljaCBzaG91
bGQKPiA+IGJlIGZ1bGx5IEM5OSBjb21wbGlhbnQgQlRXLiBTbyB3aGF0J3MgdGhlIHNpdHVhdGlv
biBoZXJlPwo+IEknbSBzb3JyeSwgSSBkaWRuJ3QgZXhwcmVzcyBjbGVhcmx5IG15c2VsZi4gWWVz
LCA0LjguNSBzdXBwb3J0cyBDOTksCj4gYnV0IHRoZSBkZWZhdWx0IGlzIEM5MCBbMV0uCgpPSywg
dGhhbmtzIGZvciBleHBsYW5hdGlvbi4KCj4gPiBUaGF0IGJlaW5nIHNhaWQgSSBjYW4gd29ya2Fy
b3VuZCB0aGUgcHJvYmxlbSBpbiB0aGUgbWFjcm8sIGl0IHdpbGwganVzdCBiZQo+ID4gc29tZXdo
YXQgdWdsaWVyLiBTbyBiZWZvcmUgZG9pbmcgdGhhdCBJJ2QgbGlrZSB0byB1bmRlcnN0YW5kIHdo
ZXRoZXIKPiA+IGZvbGxvd2luZyBDODkgaXMgcmVhbGx5IHJlcXVpcmVkLi4uCj4gCj4gSSdtIGRv
bid0IHJlbWVtYmVyIHdoeSB3ZSBoYXZlIGp1c3Qgbm90IHNwZWNpZmllZCAtc3RkPS4uLiBhbHJl
YWR5LCBDeXJpbCBoYWQKPiBzb21lIG9iamVjdGlvbnMsIHRodXMgQ2MgaGltLgo+IAo+IENlbnQw
UyBFT0wgaW4gMjAyNC0wNiwgd2UgbWlnaHQgcmVjb25zaWRlciB0byBhZGQgLXN0ZD0uLi4gdG8g
ZW5kdXAgdGhpcyBhZ29ueQo+IChlcnJvcnMgbGlrZSB0aGlzIG9mdGVuIG5lZWQgdG8gYmUgZml4
ZWQpLgo+IAo+IFsxXSBodHRwczovL2djYy5nbnUub3JnL29ubGluZWRvY3MvZ2NjLTQuOC41L2dj
Yy9TdGFuZGFyZHMuaHRtbAoKR2l2ZW4gQ3lyaWwncyByZXBseSwgc2hvdWxkIEkgcmV3b3JrIG15
IHBhdGNoIG9yIGFyZSB3ZSBmaW5lIHdpdGggdXNpbmcKQzk5PwoKCQkJCQkJCQlIb256YQoKPiA+
ID4gZmFub3RpZnkxMC5jOjQ3MDoyOiBlcnJvcjog4oCYZm9y4oCZIGxvb3AgaW5pdGlhbCBkZWNs
YXJhdGlvbnMgYXJlIG9ubHkgYWxsb3dlZCBpbiBDOTkgbW9kZQo+ID4gPiAgIGZvciAoaW50IHBp
dGVyID0gMDsgZm9ybWF0X3BhdGhfY2hlY2soKGJ1ZiksICh0YyktPnBuYW1lIyNfZm10LCBcCj4g
PiA+ICAgXgo+IAo+ID4gPiBmYW5vdGlmeTEwLmM6NDcwOjExOiBlcnJvcjogcmVkZWZpbml0aW9u
IG9mIOKAmHBpdGVy4oCZCj4gPiA+ICAgZm9yIChpbnQgcGl0ZXIgPSAwOyBmb3JtYXRfcGF0aF9j
aGVjaygoYnVmKSwgKHRjKS0+cG5hbWUjI19mbXQsIFwKPiA+ID4gICAgICAgICAgICBeCj4gPiA+
IEtpbmQgcmVnYXJkcywKPiA+ID4gUGV0cgotLSAKSmFuIEthcmEgPGphY2tAc3VzZS5jb20+ClNV
U0UgTGFicywgQ1IKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
