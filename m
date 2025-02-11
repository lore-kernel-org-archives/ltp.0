Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE046C0219B
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 17:57:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2ACD23C997F
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 18:57:01 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C46173C04A5
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 18:56:42 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AB2C6620979
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 18:56:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4495204D5;
 Tue, 11 Feb 2025 17:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739296601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGsBnoop0n1e2lNdRjRFuSVQJI8R07TuBOsShJTcWy4=;
 b=nPg09jAiS+po9QXc9AhS1GpPDAWfFxz4hQLIJC7Au1dSoEN2WrO7R1PPbaXQtYPaspwH3n
 2OSS+zil3qbnDu1O0X+qunYd5Obk1EpyrhXYQ63Cm2TQacsjEXFf1PUbP9lpdGj7o7Qc7b
 XEAzzGK/Jld4vmUkDJ6t70A+qwo24i0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739296601;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGsBnoop0n1e2lNdRjRFuSVQJI8R07TuBOsShJTcWy4=;
 b=96WK+w8L6OQbirl+SweSrK6hd4KC0/XWEmQNWe30RM8k8RpCRl8BhG0LNCCM7jQX3KSXhT
 Bvs2tNvgHwjyNtBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cTjw2FD6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/TMj5pPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739296600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGsBnoop0n1e2lNdRjRFuSVQJI8R07TuBOsShJTcWy4=;
 b=cTjw2FD6hmxQ3IvR/p0JxNTaPQCtkaaj5WMMfJ+fOyAxxeRHmlqV3BXUyfkC3zRv0ineDH
 VZelPEQxCS7QQmHYTYtsDF1AGOv2t4KaIErTtgK9zQxLphU03tMdAC1TfgaY0OTA6Rm4ye
 jWIr4H/lWGqSWqWVARkE8ZJ2x6xBdac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739296600;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YGsBnoop0n1e2lNdRjRFuSVQJI8R07TuBOsShJTcWy4=;
 b=/TMj5pPIV0eXNP8tD6pgZ0h+mEBuAIleWpZ42j4UgLp2K5GKJ3LhIiD0GcVdAX21JrSZ6m
 s9ourE4alPqTrBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1B7113715;
 Tue, 11 Feb 2025 17:56:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OHmbKliPq2dyFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 17:56:40 +0000
Date: Tue, 11 Feb 2025 18:56:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250211175639.GB1911494@pevik>
References: <20250210151316.246079-1-amir73il@gmail.com>
 <20250210151316.246079-3-amir73il@gmail.com>
 <betolcydydpyyd45jncnozi6g7phk32anhn4kx3jvgrk4kvwzx@5covq3yufbp3>
 <CAOQ4uxgu16dOsU4uuq66CGqXw6wY8c8jK7sL1QheB8kTPU=X+g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgu16dOsU4uuq66CGqXw6wY8c8jK7sL1QheB8kTPU=X+g@mail.gmail.com>
X-Rspamd-Queue-Id: E4495204D5
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] fanotify03: Add test cases for permission
 events on children
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

SGkgQW1pciwgSmFuLAoKPiBPbiBNb24sIEZlYiAxMCwgMjAyNSBhdCA0OjI14oCvUE0gSmFuIEth
cmEgPGphY2tAc3VzZS5jej4gd3JvdGU6Cgo+ID4gT24gTW9uIDEwLTAyLTI1IDE2OjEzOjE0LCBB
bWlyIEdvbGRzdGVpbiB3cm90ZToKPiA+ID4gVmVyaWZ5IHRoYXQgcGVybWlzc2lvbiBldmVudHMg
YXJlIGRlbGl2ZXJlZCBpZmYgcGFyZW50IGlzIHdhdGNoaW5nCj4gPiA+IGNoaWxkcmVuLgoKPiA+
ID4gU2lnbmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KCj4g
PiBPdmVyYWxsIGxvb2tzIG9rIGJ1dDoKCj4gPiA+IC0gICAgIGlmIChyZWFkKGZkLCBidWYsIEJV
Rl9TSVpFKSAhPSAtMSkKPiA+ID4gKyAgICAgZXhwX3JldCA9IGV4cF9lcnJubyA/IC0xIDogMTsK
PiA+ID4gKyAgICAgZXJybm8gPSAwOwo+ID4gPiArICAgICBpZiAocmVhZChmZCwgYnVmLCBCVUZf
U0laRSkgIT0gZXhwX3JldCB8fCBlcnJubyAhPSBleHBfZXJybm8pIHsKPiA+ID4gKyAgICAgICAg
ICAgICB0c3RfcmVzKFRGQUlMLCAicmVhZCgpIGdvdCBlcnJubyAlZCAoZXhwZWN0ZWQgJWQpIiwg
ZXJybm8sIGV4cF9lcnJubyk7Cj4gPiA+ICAgICAgICAgICAgICAgZXhpdCgzKTsKPiA+ID4gKyAg
ICAgfSBlbHNlIGlmIChlcnJubyA9PSBleHBfZXJybm8pIHsKPiA+ICAgICAgICAgICAgICAgICBe
XiBXaHkgaXMgdGhpcyBjb25kaXRpb24gbmVlZGVkPyBJdCBpcyBhbHdheXMgdHJ1ZSBBRkFJQ1Qu
Cgo+ID4gPiArICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJyZWFkKCkgZ290IGVycm5vICVk
IGFzIGV4cGVjdGVkIiwgZXJybm8pOwo+ID4gPiArICAgICB9Cgo+ID4gPiAgICAgICBTQUZFX0NM
T1NFKGZkKTsKCj4gPiA+IC0gICAgIGlmIChleGVjdmUoRklMRV9FWEVDX1BBVEgsIGFyZ3YsIGVu
dmlyb24pICE9IC0xKQo+ID4gPiArICAgICBleHBfcmV0ID0gZXhwX2Vycm5vID8gLTEgOiAwOwo+
ID4gPiArICAgICBlcnJubyA9IDA7Cj4gPiA+ICsgICAgIGlmIChleGVjdmUoRklMRV9FWEVDX1BB
VEgsIGFyZ3YsIGVudmlyb24pICE9IGV4cF9yZXQgfHwgZXJybm8gIT0gZXhwX2Vycm5vKSB7Cj4g
PiA+ICsgICAgICAgICAgICAgdHN0X3JlcyhURkFJTCwgImV4ZWN2ZSgpIGdvdCBlcnJubyAlZCAo
ZXhwZWN0ZWQgJWQpIiwgZXJybm8sIGV4cF9lcnJubyk7Cj4gPiA+ICAgICAgICAgICAgICAgZXhp
dCg1KTsKPiA+ID4gKyAgICAgfSBlbHNlIGlmIChlcnJubyA9PSBleHBfZXJybm8pIHsKPiA+ICAg
ICAgICAgICAgICAgICBeXl4gYW5kIGhlcmUgYXMgd2VsbC4uLgoKPiA+ID4gKyAgICAgICAgICAg
ICB0c3RfcmVzKFRJTkZPLCAiZXhlY3ZlKCkgZ290IGVycm5vICVkIGFzIGV4cGVjdGVkIiwgZXJy
bm8pOwoKPiBZb3UgYXJlIHJpZ2h0Lgo+IEkgd2FzICJiYWNrcG9ydGVkIiBmcm9tIHRoZSBwcmUt
Y29udGVudCB0ZXN0Lgo+IFRoZSB0d28gZWxzZSBzdGF0ZW1lbnRzIGNhbiBiZSByZW1vdmVkIGlu
IHRoaXMgcGF0Y2guCgpGWUkgSSdtIGdvaW5nIHRvIG1lcmdlIHdpdGggdGhlIGRpZmYgYmVsb3cg
KGRpc2N1c3NlZCBjaGFuZ2UpLgoKSmFuLCBtYXkgSSBhZGQgeW91ciBSQlQ/CgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCj4gVGhhbmtzLAo+IEFtaXIuCgpkaWZmIC0tZ2l0IHRlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZmFub3RpZnkvZmFub3RpZnkwMy5jIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
ZmFub3RpZnkvZmFub3RpZnkwMy5jCmluZGV4IDRiMmY2ZTQ1ZTEuLmExOWY0OWQxMzEgMTAwNjQ0
Ci0tLSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDMuYworKysg
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTAzLmMKQEAgLTE1OCw4
ICsxNTgsNiBAQCBzdGF0aWMgdm9pZCBnZW5lcmF0ZV9ldmVudHMoc3RydWN0IHRjYXNlICp0YykK
IAlpZiAocmVhZChmZCwgYnVmLCBCVUZfU0laRSkgIT0gZXhwX3JldCB8fCBlcnJubyAhPSBleHBf
ZXJybm8pIHsKIAkJdHN0X3JlcyhURkFJTCwgInJlYWQoKSBnb3QgZXJybm8gJWQgKGV4cGVjdGVk
ICVkKSIsIGVycm5vLCBleHBfZXJybm8pOwogCQlleGl0KDMpOwotCX0gZWxzZSBpZiAoZXJybm8g
PT0gZXhwX2Vycm5vKSB7Ci0JCXRzdF9yZXMoVElORk8sICJyZWFkKCkgZ290IGVycm5vICVkIGFz
IGV4cGVjdGVkIiwgZXJybm8pOwogCX0KIAogCVNBRkVfQ0xPU0UoZmQpOwpAQCAtMTY5LDggKzE2
Nyw2IEBAIHN0YXRpYyB2b2lkIGdlbmVyYXRlX2V2ZW50cyhzdHJ1Y3QgdGNhc2UgKnRjKQogCWlm
IChleGVjdmUoRklMRV9FWEVDX1BBVEgsIGFyZ3YsIGVudmlyb24pICE9IGV4cF9yZXQgfHwgZXJy
bm8gIT0gZXhwX2Vycm5vKSB7CiAJCXRzdF9yZXMoVEZBSUwsICJleGVjdmUoKSBnb3QgZXJybm8g
JWQgKGV4cGVjdGVkICVkKSIsIGVycm5vLCBleHBfZXJybm8pOwogCQlleGl0KDUpOwotCX0gZWxz
ZSBpZiAoZXJybm8gPT0gZXhwX2Vycm5vKSB7Ci0JCXRzdF9yZXMoVElORk8sICJleGVjdmUoKSBn
b3QgZXJybm8gJWQgYXMgZXhwZWN0ZWQiLCBlcnJubyk7CiAJfQogfQogCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
