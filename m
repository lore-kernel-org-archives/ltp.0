Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13D4C87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 14:04:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5D553CAB6E
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 16:04:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28E073C9BD8
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 16:04:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 95E0D2001C8
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 16:04:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 445C45BDDF;
 Fri,  8 Aug 2025 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754661878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pak4pJE3bh6tzUKiPh8PYSLPIngg67D6kZ1b+8MyL+g=;
 b=v+dLZX/1CNrVrNCG7PBwcwqosATPy/XSjI3eO3oIKdoDtFfxVsV5JGkyVA2JE+BcVBMKH/
 74aNGHYopXkU5BYCWn+V23WeqE39Aee/kI8Mw66+2/V/I3MsINjpYE2MsHJcAll6vP1p86
 QpDktlNajgYDtIbfHXAufdiC2u+NHGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754661878;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pak4pJE3bh6tzUKiPh8PYSLPIngg67D6kZ1b+8MyL+g=;
 b=VKEjQr2frBHZddp2Qh5gIJxBj0ogjMBZCK5vuUtWzOfkS81fNbyGlyT5G0fYHTrgW4hMUo
 O8Dm8epvq3h3IPBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WnaNkrMe;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a2gtmTo9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754661877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pak4pJE3bh6tzUKiPh8PYSLPIngg67D6kZ1b+8MyL+g=;
 b=WnaNkrMeE1k0VD54NGQv+udvbssVVTFSZeAfha9CeTqYv2xKJqLvuGK6fqf6RNmKM7P1x/
 mtxXcqJnaIUFWqL5PGz6K+MZv+0sgGa0+bciRPFsAkUw2OAA3kAKcdRIUADFIvh+so5/zr
 BMqoe2gy7w207vsj2DfAXVgHhSMj534=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754661877;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pak4pJE3bh6tzUKiPh8PYSLPIngg67D6kZ1b+8MyL+g=;
 b=a2gtmTo9wW4HOBmb3eHRguwSlFXy2URcRvyFApuQxb7VcLgyPW2YLZ3WbfUKl10/b1RhhK
 o4Oox/h4FOKPrgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15C951392A;
 Fri,  8 Aug 2025 14:04:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g4o1A/UDlmg/LgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 14:04:37 +0000
Date: Fri, 8 Aug 2025 16:04:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <20250808140435.GB470368@pevik>
References: <20250731065708.638005-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250731065708.638005-1-florian.schmaus@codasip.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 445C45BDDF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sigrelse01: Check if signal 34 is available for
 musl compat
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgRmxvcmlhbiwKCj4gRG8gbm90IHNlbGVjdCBzaWduYWwgMzQgd2hlbiB0aGUgdGVzdCBpcyBy
dW4gdXNpbmcgbXVzbC4gU2lnbmFsIDM0IGlzCj4gdXNlZCBpbnRlcm5hbGx5IGJ5IG11c2wgYXMg
U0lHU1lOQ0NBTEwuIENvbnNlcXVlbnRseSwgbXVzbCdzIHNpZ25hbCgpCj4gd2lsbCByZXR1cm4g
d2l0aCBhbiBlcnJvciBzdGF0dXMgYW5kIGVycm5vIHNldCB0byBFSU5WQUwgd2hlbiB0cnlpbmcK
PiB0byBzZXR1cCBhIHNpZ25hbCBoYW5kbGVyIGZvciBzaWduYWwgMzQsIGNhdXNpbmcgdGhlIHNp
Z3JlbHNlMDEgdGVzdAo+IHRvIGZhaWwuCgo+IFNpbmNlIG11c2wgcHJvdmlkZXMgbm8gcHJlcHJv
Y2Vzc29yIG1hY3JvLCB3ZSBjaGVjayBmb3IgdGhlCj4gYXZhaWxhYmlsaXR5IG9mIHNpZ25hbCAz
NCBieSBhdHRlbXB0aW5nIHRvIHNldHVwIGEgc2lnbmFsIGhhbmRsZXIuIElmCj4gc2lnbmFsKCkg
cmV0dXJucyBTSUdfRVJSIHdpdGggZXJybm8gc2V0IHRvIEVJTlZBTCB0aGVuIHdlIGFzc3VtZSB0
aGUKPiBzaWduYWwgaXMgdW5hdmFpbGFibGUuIEtub3dpbmcgc2lnbmFsIDM0IGlzIGF2YWlsYWJs
ZSB3aXRoIGdsaWJjLCB3ZQo+IHBlcmZvcm0gdGhpcyBjaGVjayBvbmx5IGlmIF9fR0xJQkNfXyBp
cyBub3QgZGVmaW5lZC4KCi4uLgo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2ln
cmVsc2Uvc2lncmVsc2UwMS5jCgo+ICsjZGVmaW5lIF9HTlVfU09VUkNFCgpVbmZvcnR1bmF0ZWx5
ICsjZGVmaW5lIF9HTlVfU09VUkNFIGNhdXNlcyB0ZXN0IHRvIGhhbmcsIGF0IGxlYXN0IG9uIGds
aWJjLgpBbmQgSSBzZWUgZm9yIG11c2wgaXQgaXMgbmVjZXNzYXJ5IHRvIGdldCBzaWdoYW5kbGVy
X3QuClVudGlsIHlvdSBmaXggZ2xpYmMgd2l0aCBfR05VX1NPVVJDRSBOQUNLLgoKQnV0IG9uIGds
aWJjIGl0IGFsc28gYnJvdWdodCBhIHdhcm5pbmcsIHdoaWNoIG1lYW5zIF9HTlVfU09VUkNFIHJl
YWxseSBzd2l0Y2hlcwpzb21ldGhpbmcgb246CgpzaWdyZWxzZTAxLmM6IEluIGZ1bmN0aW9uIOKA
mGNoaWxk4oCZOgpzaWdyZWxzZTAxLmM6Mzk3OjMzOiB3YXJuaW5nOiDigJhzaWdob2xk4oCZIGlz
IGRlcHJlY2F0ZWQ6IFVzZSB0aGUgc2lncHJvY21hc2sgZnVuY3Rpb24gaW5zdGVhZCBbLVdkZXBy
ZWNhdGVkLWRlY2xhcmF0aW9uc10KICAzOTcgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICgocnYgPSBzaWdob2xkKHNpZykpICE9IDApIHsKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+CkluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUv
c3lzL3dhaXQuaDozNiwKICAgICAgICAgICAgICAgICBmcm9tIHNpZ3JlbHNlMDEuYzoxMDQ6Ci91
c3IvaW5jbHVkZS9zaWduYWwuaDozNTU6MTI6IG5vdGU6IGRlY2xhcmVkIGhlcmUKICAzNTUgfCBl
eHRlcm4gaW50IHNpZ2hvbGQgKGludCBfX3NpZykgX19USFJPVwogICAgICB8ICAgICAgICAgICAg
Xn5+fn5+fgpzaWdyZWxzZTAxLmM6NDcyOjI1OiB3YXJuaW5nOiDigJhzaWdyZWxzZeKAmSBpcyBk
ZXByZWNhdGVkOiBVc2UgdGhlIHNpZ3Byb2NtYXNrIGZ1bmN0aW9uIGluc3RlYWQgWy1XZGVwcmVj
YXRlZC1kZWNsYXJhdGlvbnNdCiAgNDcyIHwgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKChy
diA9IHNpZ3JlbHNlKHNpZykpICE9IDApIHsKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAg
ICBefgovdXNyL2luY2x1ZGUvc2lnbmFsLmg6MzU5OjEyOiBub3RlOiBkZWNsYXJlZCBoZXJlCiAg
MzU5IHwgZXh0ZXJuIGludCBzaWdyZWxzZSAoaW50IF9fc2lnKSBfX1RIUk9XCiAgICAgIHwgICAg
ICAgICAgICBefn5+fn5+fgpzaWdyZWxzZTAxLmM6IEluIGZ1bmN0aW9uIOKAmHRpbWVvdXTigJk6
CnNpZ3JlbHNlMDEuYzo2NzU6MjU6IHdhcm5pbmc6IHVudXNlZCBwYXJhbWV0ZXIg4oCYc2ln4oCZ
IFstV3VudXNlZC1wYXJhbWV0ZXJdCiAgNjc1IHwgc3RhdGljIHZvaWQgdGltZW91dChpbnQgc2ln
KQogICAgICB8ICAgICAgICAgICAgICAgICAgICAgfn5+fl5+fgoKQWxzbyB0aGlzIGlzIGEgdmVy
eSBvbGQgdGVzdCwgd2hpY2ggbmVlZHMgY2xlYW51cCBhbmQgcmV3cml0ZSB0byBuZXcgTFRQIEFQ
SQooZS5nLiByZW1vdmUgb2xkIHVuaXhlcywgZS5nLiBWQVggYW5kIGdldCB0ZXN0IG1vcmUgcmVs
aWFibGUpLiBJIHN1cHBvc2UKaGFuZGxpbmcgc2lnbmFscyB3aXRoIExUUCBsZWdhY3kgQVBJIGlz
IGJyb2tlbi4KCj4gKwo+ICAjaW5jbHVkZSA8c3lzL3R5cGVzLmg+Cj4gICNpbmNsdWRlIDxzeXMv
d2FpdC5oPgo+ICAjaW5jbHVkZSA8ZXJybm8uaD4KPiAgI2luY2x1ZGUgPGZjbnRsLmg+Cj4gICNp
bmNsdWRlIDxzaWduYWwuaD4KPiArI2luY2x1ZGUgPHN0ZGJvb2wuaD4KCm5pdDogSSB3b3VsZCBw
b3N0cG9uZSB0aGlzIGFmdGVyIGNvbnZlcnNpb24gdGhpcyB0byBuZXcgTFRQIEFQSS4KU2NyaXB0
IGFscmVhZHkgdXNlcyBsZWdhY3kgZGVmaW5pdGlvbnMKI2RlZmluZSBUUlVFIDEKI2RlZmluZSBG
QUxTRSAwCmFuZCBvbiBhIGRpZmZlcmVudCBwbGFjZSBoYXBwaWx5IHJldHVybnMgMCBvciAxLgpN
aXhpbmcgdGhhdCB3aXRoIDxzdGRib29sLmg+IG1ha2VzIGV2ZW4gbW9yZSBtZXNzLgoKS2luZCBy
ZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
