Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0F4C88E45
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:59:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45B593E72B3
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:59:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E272F3D227C
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:59:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2FCB600B22
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:59:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2702C21CD3;
 Fri, 11 Sep 2026 13:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789135154;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKB3Om5WRzBwCkNvEJ0v08Ag/b1F6enpTvUdq5cdpgk=;
 b=sL5klSdJ9rgVzrogwr9tL5AfZqj0UdYlq75/Vetyh22si01wLnXl87CkNudXzTNjnJ589C
 XtHuChfmK3J4xPnHfLhF0Ixfjz6SRrYjJXJojdBWLwAAoC26nIixIUXjQGMJI6+7Yf3Ovb
 GrirVZNwr1AxaLkRtZfSaQNYBpGN0o8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789135154;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKB3Om5WRzBwCkNvEJ0v08Ag/b1F6enpTvUdq5cdpgk=;
 b=zK5uJxaAxor/JJFS3lkK1S41oGgQvAy4Qgc0sc2wKPMLhTRHbEuM8RRykyXjwY+uLhnanv
 SFSy3gVMIP9BpZAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ykjF0Qxw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="a7gN9/q7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789135150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKB3Om5WRzBwCkNvEJ0v08Ag/b1F6enpTvUdq5cdpgk=;
 b=ykjF0QxwsqXxMGbBE7SZzC6pBSMslIRf1JsmvECqVN7TGtton3zkHiNePMbezykLdKLCwp
 xsXqmxLg7rslHamawzgf2E9kIXp84Lq6jpNii5c0xi6+jpSzSjsKMvXINEgcpSxuehYb5u
 qbvEzyK7xAce/Ojj31lneTDbw9xT0y4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789135150;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nKB3Om5WRzBwCkNvEJ0v08Ag/b1F6enpTvUdq5cdpgk=;
 b=a7gN9/q76PYQoN6b1vlogeT7G2CKdaPE5jQ/gGCRoVtNDtCYQl6pM8Zzpnrd/wUeZMLklv
 2bcYzZccf7WmqMBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C545013715;
 Fri, 11 Sep 2026 13:59:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pumELS0JpGoGWwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 11 Sep 2026 13:59:09 +0000
Date: Fri, 11 Sep 2026 15:59:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260911135907.GC1488703@pevik>
References: <20260828-mmap_32bit_coverage-v1-0-7f0b8b589773@suse.com>
 <20260828-mmap_32bit_coverage-v1-3-7f0b8b589773@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828-mmap_32bit_coverage-v1-3-7f0b8b589773@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2702C21CD3
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] mmap24: add test for MAP_32BIT address limit
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKPiBBZGQgYSB0ZXN0IHZlcmlmeWluZyB0aGF0IG1tYXAoKSB3aXRoIHRoZSBN
QVBfMzJCSVQgZmxhZyByZXN0cmljdHMKPiBtYXBwaW5ncyB0byB0aGUgZmlyc3QgMkdCIG9mIGFk
ZHJlc3Mgc3BhY2UgYW5kIGZhaWxzIHdpdGggRU5PTUVNCj4gd2hlbiB0aGUgMzItYml0IGFkZHJl
c3Mgc3BhY2UgaXMgZXhoYXVzdGVkIHdpdGhvdXQgZmFsbGluZyBiYWNrIHRvCj4gaGlnaGVyIGFk
ZHJlc3Nlcy4KClRoYW5rcyEKCi4uLgo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
bW1hcC9tbWFwMjQuYwouLi4KPiArCj4gKwkJaWYgKCh1bnNpZ25lZCBsb25nKWFkZHIgKyBDSFVO
S19TWiA+IEFERFJfTElNSVQpIHsKPiArCQkJdHN0X3JlcyhURkFJTCwgIm1hcHBpbmcgYXQgJXAg
KyAlenUgZXhjZWVkcyAyR0IgbGltaXQiLAolenUgaXMgd3Jvbmcgb24gMzIgYml0LgoKLi4vLi4v
Li4vLi4vaW5jbHVkZS90c3RfdGVzdC5oOjc1OjU1OiB3YXJuaW5nOiBmb3JtYXQg4oCYJXp14oCZ
IGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSDigJhzaXplX3TigJksIGJ1dCBhcmd1bWVudCA2IGhh
cyB0eXBlIOKAmGxvbmcgdW5zaWduZWQgaW504oCZIFstV2Zvcm1hdD1dCiAgIDc1IHwgICAgICAg
ICAgICAgICAgIHRzdF9yZXNfKF9fRklMRV9fLCBfX0xJTkVfXywgKHR0eXBlKSwgKGFyZ19mbXQp
LCAjI19fVkFfQVJHU19fKTtcCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+Cm1tYXAyNC5jOjYzOjI1OiBub3RlOiBp
biBleHBhbnNpb24gb2YgbWFjcm8g4oCYdHN0X3Jlc+KAmQogICA2MyB8ICAgICAgICAgICAgICAg
ICAgICAgICAgIHRzdF9yZXMoVEZBSUwsICJtYXBwaW5nIGF0ICVwICsgJXp1IGV4Y2VlZHMgMkdC
IGxpbWl0IiwKICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn5+Cgo+ICsJCQkJ
YWRkciwgQ0hVTktfU1opOwo+ICsJCQlhZGRyc1tudW1fY2h1bmtzKytdID0gYWRkcjsKPiArCQkJ
Y2xlYW51cCgpOwo+ICsJCQlyZXR1cm47Cj4gKwkJfQo+ICsKPiArCQkoKGNoYXIgKilhZGRyKVsw
XSA9ICdhJzsKPiArCQkoKGNoYXIgKilhZGRyKVtDSFVOS19TWiAtIDFdID0gJ3onOwo+ICsKPiAr
CQlhZGRyc1tudW1fY2h1bmtzKytdID0gYWRkcjsKPiArCX0KPiArCj4gKwlpZiAoIWZhaWxlZF93
aXRoX2Vub21lbSkgewo+ICsJCXRzdF9yZXMoVEZBSUwsICIzMi1iaXQgYWRkcmVzcyBzcGFjZSB3
YXMgbm90IGV4aGF1c3RlZCIpOwo+ICsJfSBlbHNlIGlmICghbnVtX2NodW5rcykgewo+ICsJCXRz
dF9yZXMoVEZBSUwsICJmYWlsZWQgdG8gbWFwIGFueSBjaHVuayB3aXRoIE1BUF8zMkJJVCIpOwo+
ICsJfSBlbHNlIHsKPiArCQl0c3RfcmVzKFRQQVNTLAo+ICsJCQkiTWFwcGVkICV6dSBNQiBhY3Jv
c3MgJXp1IGNodW5rcyB3aXRoaW4gMkdCIGJlZm9yZSBFTk9NRU0iLApBbmQgaGVyZSBhcyB3ZWxs
Lgo+ICsJCQkobnVtX2NodW5rcyAqIENIVU5LX1NaKSAvIFRTVF9NQiwgbnVtX2NodW5rcyk7Cj4g
Kwl9Cj4gKwo+ICsJY2xlYW51cCgpOwo+ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0
IHRlc3QgPSB7Cj4gKwkuY2xlYW51cCA9IGNsZWFudXAsCj4gKwkudGVzdF9hbGwgPSBydW4sCj4g
Kwkuc3VwcG9ydGVkX2FyY2hzID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtdKXsKPiArCQkieDg2XzY0
IiwKPiArCQlOVUxMCj4gKwl9LAo+ICt9OwoKCkJUVyBJIHdhcyB3b25kZXJpbmcgaWYgSSBjYW4g
Z2V0IHRoaXMgZmFpbGluZyB3aGVuIHJ1bm5pbmcgb24gVk0gd2l0aCByZWFsbHkKc21hbGwgUkFN
LCBidXQgZXZlbiB3aXRoIDI0OSBNQiBJIGdldCBnZXQgbWFwcGVkIDkyOCBNQiAob3IgOTYwIE1C
IHdoZW4gSSBydW4Kd2l0aCAtaSk6CgptbWFwMjQuYzo4MTogVFBBU1M6IE1hcHBlZCA5MjggTUIg
YWNyb3NzIDI5IGNodW5rcyB3aXRoaW4gMkdCIGJlZm9yZSBFTk9NRU0KCldoYXQgYW0gSSBtaXNz
aW5nPwoKQW55d2F5LCBMR1RNLgpSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+CgpLaW5kIHJlZ2FyZHMsClBldHIKCkJlZm9yZSBtZXJnZSBwbGVhc2U6CgpkaWZmIC0tZ2l0
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjQuYyB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL21tYXAvbW1hcDI0LmMKaW5kZXggNTBkZTYyMGY0Mi4uOTRkMDkyYjgwOSAxMDA2
NDQKLS0tIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjQuYworKysgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyNC5jCkBAIC02MCw3ICs2MCw3IEBAIHN0YXRp
YyB2b2lkIHJ1bih2b2lkKQogCQl9CiAKIAkJaWYgKCh1bnNpZ25lZCBsb25nKWFkZHIgKyBDSFVO
S19TWiA+IEFERFJfTElNSVQpIHsKLQkJCXRzdF9yZXMoVEZBSUwsICJtYXBwaW5nIGF0ICVwICsg
JXp1IGV4Y2VlZHMgMkdCIGxpbWl0IiwKKwkJCXRzdF9yZXMoVEZBSUwsICJtYXBwaW5nIGF0ICVw
ICsgJWx1IGV4Y2VlZHMgMkdCIGxpbWl0IiwKIAkJCQlhZGRyLCBDSFVOS19TWik7CiAJCQlhZGRy
c1tudW1fY2h1bmtzKytdID0gYWRkcjsKIAkJCWNsZWFudXAoKTsKQEAgLTc5LDcgKzc5LDcgQEAg
c3RhdGljIHZvaWQgcnVuKHZvaWQpCiAJCXRzdF9yZXMoVEZBSUwsICJmYWlsZWQgdG8gbWFwIGFu
eSBjaHVuayB3aXRoIE1BUF8zMkJJVCIpOwogCX0gZWxzZSB7CiAJCXRzdF9yZXMoVFBBU1MsCi0J
CQkiTWFwcGVkICV6dSBNQiBhY3Jvc3MgJXp1IGNodW5rcyB3aXRoaW4gMkdCIGJlZm9yZSBFTk9N
RU0iLAorCQkJIk1hcHBlZCAlbHUgTUIgYWNyb3NzICV6dSBjaHVua3Mgd2l0aGluIDJHQiBiZWZv
cmUgRU5PTUVNIiwKIAkJCShudW1fY2h1bmtzICogQ0hVTktfU1opIC8gVFNUX01CLCBudW1fY2h1
bmtzKTsKIAl9CiAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
