Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316EFC27C76
	for <ltp@archiver.kernel.org>; Wed, 25 Jan 2023 23:29:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4E463CD3BC
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 00:29:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 668653CB38E
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 00:28:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F371410007C1
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 00:28:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42EA521C27;
 Wed, 25 Jan 2023 23:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674689335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfSxDqeLRj/zLpBRTD9SlvIqC/RLX9lx8rXBMuJBcXQ=;
 b=fDv6KqGfK64oLcV6xm+ITln2HUQfGHmVGthnMT19C5pOYD+ri0x1nnXiun5vURRRRnEEwA
 q5zpARw/8whVvfE0K14ezINGt5DIIUysEzrJzG39TZtZY34hzufw8LTu1/CEK57XUJwknp
 E8lQJlkO6uBNGYOYeNiMEbvaS3CdH3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674689335;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dfSxDqeLRj/zLpBRTD9SlvIqC/RLX9lx8rXBMuJBcXQ=;
 b=9GdLWH5jANRw9oHX/SsZq2W6TzVJr0Pt/RjTso93zQzN69stQs+IcA/1qBzISi22vg95Cz
 IBAe3jrtmV61y7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C87831358F;
 Wed, 25 Jan 2023 23:28:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w/jPLja70WMwUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Jan 2023 23:28:54 +0000
Date: Thu, 26 Jan 2023 00:28:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <Y9G7NK0ptEIUliA3@pevik>
References: <20230125232751.31809-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230125232751.31809-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpDYyBKYW4sIHdoaWNoIHJlcGxpZWQgdG8gbXkgcXVlc3Rpb24gaW4gcHJpdmF0ZSBtYWls
LgoKS2luZCByZWdhcmRzLApQZXRyCgo+IHRvIGFkZCBrZXJuZWwgdHlwZXMgKF9fczMyLCBfX3Uz
MiwgLi4uKS4KCj4gVGhpcyBmaXhlcyBidWlsZCBvbiB2YXJpb3VzIEJ1aWxkcm9vdCB0b29sY2hh
aW5zOgoKPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gZmFub3RpZnkuaDoxNCwKPiAgICAgICAgICAg
ICAgICAgIGZyb20gZmFub3RpZnkwNC5jOjI1Ogo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9m
YW5vdGlmeS5oOjE5ODoyOiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX19zMzLigJkKPiAg
IDE5OCB8ICBfX3MzMiBlcnJvcjsKPiAgICAgICB8ICBefn5+fgo+IC4uLy4uLy4uLy4uL2luY2x1
ZGUvbGFwaS9mYW5vdGlmeS5oOjE5OToyOiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX191
MzLigJkKPiAgIDE5OSB8ICBfX3UzMiBlcnJvcl9jb3VudDsKPiAgICAgICB8ICBefn5+fgoKPiBO
T1RFOiBIaXN0b3JpY2FsbHkgd2UgdHJpZWQgdG8gbWluaW1pemUgbnVtYmVyIG9mIGxpbnV4IGlu
Y2x1ZGVzLAo+IGJlY2F1c2UgaXQgd291bGQgb2Z0ZW4gbGVhZCB0byBicm9rZW4gYnVpbGRzLiBI
ZWFkZXJzIGdvdCBiZXR0ZXIgb3Zlcgo+IHRpbWUgYW5kIExUUCBhbHNvIGRyb3BwZWQgc3VwcG9y
dCBmb3IgYXJjaGFpYyBrZXJuZWxzIG92ZXIgdGltZS4KPiBUaGVyZWZvcmUgd2UgY2FuIGtlZXAg
b3JpZ2luYWwga2VybmVsIHR5cGVzIGhlcmUuCgo+IEZpeGVzOiA2NzA2OWZjNDZhICgic3lzY2Fs
bHMvZmFub3RpZnkyMjogVmFsaWRhdGUgdGhlIGdlbmVyaWMgZXJyb3IgaW5mbyIpCgo+IFNpZ25l
ZC1vZmYtYnk6IFBldHIgVm9yZWwgPHBldHIudm9yZWxAZ21haWwuY29tPgo+IC0tLQo+ICB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggfCAxICsKPiAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2Zhbm90aWZ5L2Zhbm90aWZ5LmgKPiBpbmRleCA1MTA3ODEwM2ViLi5kYTc4Nzg4Mzc4IDEwMDY0
NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkuaAo+IEBA
IC0xMSw2ICsxMSw3IEBACj4gICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KPiAgI2luY2x1ZGUgPHN5
cy9zdGF0Lmg+Cj4gICNpbmNsdWRlIDxlcnJuby5oPgo+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMu
aD4KPiAgI2luY2x1ZGUgImxhcGkvZmFub3RpZnkuaCIKPiAgI2luY2x1ZGUgImxhcGkvZmNudGwu
aCIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
