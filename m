Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 645AEC54E94
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 10:25:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 827ED3CB38E
	for <ltp@archiver.kernel.org>; Thu, 26 Jan 2023 11:25:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D154D3C07B4
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:25:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 360B21A00A3F
 for <ltp@lists.linux.it>; Thu, 26 Jan 2023 11:25:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 09B2B1FEA2;
 Thu, 26 Jan 2023 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674728712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj3NzXIF7wrDMZmkutUpgIE+n48vqu6HMNy6v90assE=;
 b=v0BwF122QxS2pp4jdEO0TEhEaGu8m6v+CsJHKv7r0Sq9E9d2+uhAppLi0aCTUVkAECPjty
 K+P5JIlM0IZ0l6ohXa9c8gc9FemLkAMxwPsZHL3QQOgqdmhXvMNrU4fCFfsN+DYHtL/m7v
 se1AFOlgW+Q+qi3I8Szo+YwbdQwCx3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674728712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj3NzXIF7wrDMZmkutUpgIE+n48vqu6HMNy6v90assE=;
 b=0g7gMhlwH7bXSBGQqpXsTZeuRNeyQ8oDIVLXTTb8Dm2q3zONs9ZVT4lSMMamFRI3ooVHWy
 tUBlO3dLCY1Hq0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E585E13A09;
 Thu, 26 Jan 2023 10:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A+X3NgdV0mOAeQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 26 Jan 2023 10:25:11 +0000
Date: Thu, 26 Jan 2023 11:26:45 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y9JVZdbm/1yLwAKs@yuki>
References: <20230125232751.31809-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230125232751.31809-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: Gabriel Krisman Bertazi <krisman@collabora.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gdG8gYWRkIGtlcm5lbCB0eXBlcyAoX19zMzIsIF9fdTMyLCAuLi4pLgo+IAo+IFRoaXMg
Zml4ZXMgYnVpbGQgb24gdmFyaW91cyBCdWlsZHJvb3QgdG9vbGNoYWluczoKPiAKPiBJbiBmaWxl
IGluY2x1ZGVkIGZyb20gZmFub3RpZnkuaDoxNCwKPiAgICAgICAgICAgICAgICAgIGZyb20gZmFu
b3RpZnkwNC5jOjI1Ogo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mYW5vdGlmeS5oOjE5ODoy
OiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX19zMzLigJkKPiAgIDE5OCB8ICBfX3MzMiBl
cnJvcjsKPiAgICAgICB8ICBefn5+fgo+IC4uLy4uLy4uLy4uL2luY2x1ZGUvbGFwaS9mYW5vdGlm
eS5oOjE5OToyOiBlcnJvcjogdW5rbm93biB0eXBlIG5hbWUg4oCYX191MzLigJkKPiAgIDE5OSB8
ICBfX3UzMiBlcnJvcl9jb3VudDsKPiAgICAgICB8ICBefn5+fgo+IAo+IE5PVEU6IEhpc3Rvcmlj
YWxseSB3ZSB0cmllZCB0byBtaW5pbWl6ZSBudW1iZXIgb2YgbGludXggaW5jbHVkZXMsCj4gYmVj
YXVzZSBpdCB3b3VsZCBvZnRlbiBsZWFkIHRvIGJyb2tlbiBidWlsZHMuIEhlYWRlcnMgZ290IGJl
dHRlciBvdmVyCj4gdGltZSBhbmQgTFRQIGFsc28gZHJvcHBlZCBzdXBwb3J0IGZvciBhcmNoYWlj
IGtlcm5lbHMgb3ZlciB0aW1lLgo+IFRoZXJlZm9yZSB3ZSBjYW4ga2VlcCBvcmlnaW5hbCBrZXJu
ZWwgdHlwZXMgaGVyZS4KPiAKPiBGaXhlczogNjcwNjlmYzQ2YSAoInN5c2NhbGxzL2Zhbm90aWZ5
MjI6IFZhbGlkYXRlIHRoZSBnZW5lcmljIGVycm9yIGluZm8iKQo+IAo+IFNpZ25lZC1vZmYtYnk6
IFBldHIgVm9yZWwgPHBldHIudm9yZWxAZ21haWwuY29tPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5LmggfCAxICsKPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZmFub3RpZnkvZmFub3RpZnkuaCBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkuaAo+IGluZGV4IDUxMDc4MTAzZWIuLmRhNzg3ODgzNzggMTAwNjQ0Cj4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4gQEAgLTExLDYg
KzExLDcgQEAKPiAgI2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ICAjaW5jbHVkZSA8c3lzL3N0YXQu
aD4KPiAgI2luY2x1ZGUgPGVycm5vLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgoKU2hv
dWxkbid0IHRoYXQgZ28gaW50byB0aGUgbGFwaS9mYW5vdGlmeS5oIGluc3RlYWQ/IE90aGVyd2lz
ZSB0aGUgbmV4dApmaWxlIHRoYXQgaW5jbHVkZXMgdGhlIGhlYWRlciB3aWxsIGhhdmUgdGhlIGV4
YWN0bHkgc2FtZSBwcm9ibGVtLgoKPiAgI2luY2x1ZGUgImxhcGkvZmFub3RpZnkuaCIKPiAgI2lu
Y2x1ZGUgImxhcGkvZmNudGwuaCIKPiAgCj4gLS0gCj4gMi4zOS4xCj4gCgotLSAKQ3lyaWwgSHJ1
YmlzCmNocnViaXNAc3VzZS5jegoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3Rz
LmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
