Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3482EC4332F
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 16:17:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52DA93CCBF4
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 17:17:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AA003C0F12
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 17:17:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A91A01416A01
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 17:17:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79FA022044;
 Mon, 21 Nov 2022 16:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669047452; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX3HLEBTDUy3ttXPT+1MKjElB4AL3UkzudP+5rrPIOs=;
 b=Iu9heGag9iebKkq9WXtGbscGfmF9V7N4nvhhMPpbnydZEYcdQAmGOoPSf6PuhRDb5JBuR8
 v1mkv+ddELIreVrPZ52Gh908G0bsYXkzTntflvex+MtcrBfM/D90CRxcth4HHwfsaQsv1y
 TQd5rLrjA0SKdkbPHzZ4Yi8c5HUG6WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669047452;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RX3HLEBTDUy3ttXPT+1MKjElB4AL3UkzudP+5rrPIOs=;
 b=UHkW0YT/d11XJ0j4Xs+AavpzjnhOMr3r3O6GoC1VGKcqh/8QcyzDz8DbQ/Zw6h+cim8lMD
 eq/y+Neyb0jGYCAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 607381377F;
 Mon, 21 Nov 2022 16:17:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S/DuFpyke2NLXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 21 Nov 2022 16:17:32 +0000
Date: Mon, 21 Nov 2022 17:17:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y3ukncX84lQTJNe9@rei>
References: <20221121144505.1496-1-rpalethorpe@suse.com>
 <Y3uUk6nKsASeFRf7@yuki> <87mt8kfgad.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mt8kfgad.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gPiBJIHdvZGVyIGlmIHRoaXMgd291bGQgd29yayB3aXRoIGRpZmZlcmVudCBjb21waWxl
cnMuIEkgc3VwcG9zZSBjbGFuZwo+ID4gZG9lcyB3b3JrLCBidXQgd2hhdCBhYm91dCBpY2M/Cj4g
Cj4gQ2xhbmcgaXMgZmluZS4gSSBkb3VidCB0aGF0IGljYyBjb21waWxlcyBMVFAgYXQgcHJlc2Vu
dCB1bmxlc3MgaXQgZG9lcwo+IHN1cHBvcnQgR05VIGV4dGVuc2lvbnMuCgpGYWlyIGVub3VnaC4K
Cj4gPiBJIHN1cG9zZSB0aGF0IHdlIGdldCB0b25zIG9mICdjYW4ndCBkbyBwb2ludGVyIGFyaXRo
bWV0aWNzIG9uIHZvaWQqCj4gPiBwb2ludGVycyBhbmQgc3R1ZmYnIHdpdGggcGxhaW4gYzk5LiBN
YXliZSBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gY2xlYW4KPiA+IHRoZXNlIG91dCBpbnN0ZWFkLgo+
IAo+IGh0dHBzOi8vZ2l0aHViLmNvbS9yaWNoaWVqcC9sdHAvYWN0aW9ucy9ydW5zLzM1MTUxNjU4
MDMvam9icy81ODkwMDgxNzM2Cj4gCj4gU29tZSBvZiB0aGlzIGlzIHNvbHZlZCBieSAtRF9YT1BF
Tl9TT1VSQ0U9NzAwIG9yIHNvbWUgb3RoZXIgbWFjcm8gKHdlCj4gbmVlZCBtdWx0aXBsZSkuIEhv
d2V2ZXIgaXQgZG9lc24ndCBlbmQgdGhlcmU6Cj4gCj4gIG1ha2UgU1REQ0ZMQUdTPSctc3RkPWMy
eCAtRF9YT1BFTl9TT1VSQ0U9NzAwJwo+IG1ha2UgLUMgImxpYiIgXAo+IAktZiAiL2hvbWUvcmlj
aC9xYS9sdHAvbGliL01ha2VmaWxlIiBhbGwKPiBtYWtlWzFdOiBFbnRlcmluZyBkaXJlY3Rvcnkg
Jy9ob21lL3JpY2gvcWEvbHRwL2xpYicKPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vaW5jbHVk
ZS9vbGQvdGVzdC5oOjM3LAo+ICAgICAgICAgICAgICAgICAgZnJvbSBnZXRfcGF0aC5jOjQxOgo+
IGdldF9wYXRoLmM6IEluIGZ1bmN0aW9uIOKAmHRzdF9nZXRfcGF0aOKAmToKPiAuLi9pbmNsdWRl
L3RzdF9taW5tYXguaDoxMDo5OiB3YXJuaW5nOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5j
dGlvbiDigJh0eXBlb2bigJkgWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICAg
MTAgfCAgICAgICAgIHR5cGVvZihhKSBfYSA9IChhKTsgXAo+ICAgICAgIHwgICAgICAgICBefn5+
fn4KCgpIbW0gdGhhdCdzIHN0cmFuZ2UsIHN1cHBvc2VkbHkgdHlwZW9mKCkgaXMgZmluYWxseSBz
dGFuZGFydGl6ZWQgaW4gYzJ4LApidXQgaXQgd291bGQgYmUgb2J2aW91c2x5IG1pc3NpbmcgZnJv
bSBhbnl0aGluZyBvbGRlci4KCj4gV2UgcHJvYmFibHkgYWxzbyB1c2UgJ3ggPzogeScgYW5kIHN0
dWZmIGxpa2UgdGhhdC4KPiAKPiBTbyB0aGlzIG9wZW5zIHVwIGEgcmF0cyBuZXN0IGJhc2ljYWxs
eS4KClNpZ2gsIHdlbGwgTFRQIHdhcyBuZXZlciBhIG5pY2UgY29kZWJhc2UsIGF0IGxlYXN0IGl0
IGNvbXBpbGVzIG1vc3Qgb2YKdGhlIHRpbWUgdGhlc2UgZGF5cy4KCi0tIApDeXJpbCBIcnViaXMK
Y2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
