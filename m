Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5152C25B75
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 11:31:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D97D3CF106
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 13:31:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5BCA3CE757
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:31:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D8F31A00E60
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:31:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B196520E40;
 Mon, 13 May 2024 11:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715599880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pa80CACersVcOSR0fJlN63r4Y2tDjt5+cp7asloqM8=;
 b=0h1hJLgBi8wEC72Va2FCZoi8+AgCqFu8IdhxvChGzriikDfFPgoQeB05frcURJhD6mg7eb
 hVpDd7p1OiToATLw8bqhxUMjvCXcGCJ/vv9PBiayOFYDf9U65NRohwKOlwP52cF164J7TE
 5U2PDGHsZuYAFNv0Qfm9D6yFyx7Pc1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715599880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pa80CACersVcOSR0fJlN63r4Y2tDjt5+cp7asloqM8=;
 b=6su1nZJlc6JeRjNfUb/Xj1/bH0bSQJBIVl9KSYGgewAm5BngsKeXWmWX1R8zjLZNiWHgKb
 ZVvPIKIAYFG7oZAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715599880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pa80CACersVcOSR0fJlN63r4Y2tDjt5+cp7asloqM8=;
 b=0h1hJLgBi8wEC72Va2FCZoi8+AgCqFu8IdhxvChGzriikDfFPgoQeB05frcURJhD6mg7eb
 hVpDd7p1OiToATLw8bqhxUMjvCXcGCJ/vv9PBiayOFYDf9U65NRohwKOlwP52cF164J7TE
 5U2PDGHsZuYAFNv0Qfm9D6yFyx7Pc1E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715599880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Pa80CACersVcOSR0fJlN63r4Y2tDjt5+cp7asloqM8=;
 b=6su1nZJlc6JeRjNfUb/Xj1/bH0bSQJBIVl9KSYGgewAm5BngsKeXWmWX1R8zjLZNiWHgKb
 ZVvPIKIAYFG7oZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FEEB13A52;
 Mon, 13 May 2024 11:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +gokJgj6QWa/ZgAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 13 May 2024 11:31:20 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 May 2024 13:31:20 +0200
Message-ID: <2689176.lGaqSPkdTl@localhost>
Organization: SUSE
In-Reply-To: <20240425052536.68290-1-xuyang2018.jy@fujitsu.com>
References: <20240425052536.68290-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 HAS_ORG_HEADER(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lseek: Add negative tests for lseek
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWWFuZyBYdSwKCk92ZXJhbGwgdGVzdCBsb29rcyBmaW5lLiBCdXQgSSB0aGluayB3ZSBzaG91
bGQgZW5hYmxlIHRoaXMgZm9yIGFsbCBmaWxlc3lzdGVtcy4KCk9uIFRodXJzZGF5LCBBcHJpbCAy
NSwgMjAyNCA3OjI1OjM24oCvQU0gR01UKzIgWWFuZyBYdSB2aWEgbHRwIHdyb3RlOgo+IEFkZCBu
ZWdhdGl2ZSB0ZXN0cyBmb3IgbHNlZWsoKSwgd2hlbiBlcnJubyBpcyBFTlhJTwo+IAo+IFNpZ25l
ZC1vZmYtYnk6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+Cj4gLS0tCj4gIHJ1
bnRlc3Qvc3lzY2FsbHMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay8uZ2l0aWdub3JlIHwgIDEgKwo+ICB0ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xzZWVrL2xzZWVrMTIuYyAgfCA4MCArKysrKysrKysrKysrKysrKysr
KysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgODIgaW5zZXJ0aW9ucygrKQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay9sc2VlazEyLmMKPiAKPiBkaWZm
IC0tZ2l0IGEvcnVudGVzdC9zeXNjYWxscyBiL3J1bnRlc3Qvc3lzY2FsbHMKPiBpbmRleCA2MmVi
NGMxY2QuLjc1NzViMjdiMSAxMDA2NDQKPiAtLS0gYS9ydW50ZXN0L3N5c2NhbGxzCj4gKysrIGIv
cnVudGVzdC9zeXNjYWxscwo+IEBAIC03MjYsNiArNzI2LDcgQEAgbHNlZWswMSBsc2VlazAxCj4g
IGxzZWVrMDIgbHNlZWswMgo+ICBsc2VlazA3IGxzZWVrMDcKPiAgbHNlZWsxMSBsc2VlazExCj4g
K2xzZWVrMTIgbHNlZWsxMgo+ICAKPiAgbHN0YXQwMUEgc3ltbGluazAxIC1UIGxzdGF0MDEKPiAg
bHN0YXQwMUFfNjQgc3ltbGluazAxIC1UIGxzdGF0MDFfNjQKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9sc2Vlay8uZ2l0aWdub3JlCj4gaW5kZXggMWRjMTQ2NWVlLi5jNDk3Mjg2MDcgMTAw
NjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay8uZ2l0aWdub3JlCj4g
KysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay8uZ2l0aWdub3JlCj4gQEAgLTIs
MyArMiw0IEBACj4gIC9sc2VlazAyCj4gIC9sc2VlazA3Cj4gIC9sc2VlazExCj4gKy9sc2VlazEy
Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvbHNlZWsxMi5j
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sc2Vlay9sc2VlazEyLmMKPiBuZXcgZmlsZSBt
b2RlIDEwMDY0NAo+IGluZGV4IDAwMDAwMDAwMC4uOWQ4MGU2MzJiCj4gLS0tIC9kZXYvbnVsbAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbHNlZWsvbHNlZWsxMi5jCj4gQEAgLTAs
MCArMSw4MCBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjQgRlVKSVRTVSBMSU1JVEVELiBBbGwgUmln
aHRzIFJlc2VydmVkLgo+ICsgKiBBdXRob3I6IFlhbmcgWHUgPHh1eWFuZzIwMTguanlAZnVqaXRz
dS5jb20+Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiArICoKPiArICog
VmVyaWZ5IHRoYXQgbHNlZWsoMikgZmFpbHMgd2l0aAo+ICsgKgo+ICsgKiAtIEVOWElPIHdoZW4g
d2hlbmNlIGlzIFNFRUtfREFUQSwgZmlsZSBvZmZzZXQgaXMgYmV5b25kIHRoZSBlbmQgb2YgdGhl
IGZpbGUKPiArICogLSBFTlhJTyB3aGVuIHdoZW5jZSBpcyBTRUVLX0hPTEUsIGZpbGUgb2Zmc2V0
IGlzIGJleW9uZCB0aGUgZW5kIG9mIHRoZSBmaWxlCj4gKyAqLwo+ICsKPiArI2RlZmluZSBfR05V
X1NPVVJDRQo+ICsKPiArI2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ICsjaW5jbHVkZSAidHN0X3Rl
c3QuaCIKPiArI2luY2x1ZGUgImxhcGkvc2Vlay5oIgo+ICsKPiArI2RlZmluZSBURVNUX0VOWElP
ICJ0ZXN0X2VueGlvIgo+ICsKPiArc3RhdGljIGludCBmZF9lbnhpbzsKPiArCj4gK3N0YXRpYyBz
dHJ1Y3QgdGVzdF9jYXNlX3Qgewo+ICsJaW50ICpmZDsKPiArCW9mZl90IG9mZnNldDsKPiArCWlu
dCB3aGVuY2U7Cj4gKwlpbnQgZXhwZWN0ZWRfZXJybm87Cj4gKwljaGFyICpkZXNjOwo+ICt9IHRj
YXNlc1tdID0gewo+ICsJeyZmZF9lbnhpbywgMTAsIFNFRUtfREFUQSwgRU5YSU8sCj4gKwkJIndo
ZW5jZSBpcyBTRUVLX0RBVEEsICIKPiArCQkiZmlsZSBvZmZzZXQgaXMgYmV5b25kIHRoZSBlbmQg
b2YgdGhlIGZpbGUifSwKPiArCXsmZmRfZW54aW8sIDEwLCBTRUVLX0hPTEUsIEVOWElPLAo+ICsJ
CSJ3aGVuY2UgaXMgU0VFS19IT0xFLCAiCj4gKwkJImZpbGUgb2Zmc2V0IGlzIGJleW9uZCB0aGUg
ZW5kIG9mIHRoZSBmaWxlIn0sCj4gK307Cj4gKwo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+
ICt7Cj4gKwlTQUZFX1RPVUNIKFRFU1RfRU5YSU8sIDA3NzcsIE5VTEwpOwo+ICsJZmRfZW54aW8g
PSBTQUZFX09QRU4oVEVTVF9FTlhJTywgT19SRFdSLCAwNzc3KTsKPiArfQo+ICsKPiArc3RhdGlj
IHZvaWQgY2xlYW51cCh2b2lkKQo+ICt7Cj4gKwlTQUZFX0NMT1NFKGZkX2VueGlvKTsKPiArfQo+
ICsKPiArc3RhdGljIHZvaWQgdmVyaWZ5X2xzZWVrKHVuc2lnbmVkIGludCBpKQo+ICt7Cj4gKwlz
dHJ1Y3QgdGVzdF9jYXNlX3QgKnRjID0gJnRjYXNlc1tpXTsKPiArCW9mZl90IG9mZnNldDsKPiAr
Cj4gKwlvZmZzZXQgPSBsc2VlaygqKHRjLT5mZCksIHRjLT5vZmZzZXQsIHRjLT53aGVuY2UpOwo+
ICsJaWYgKG9mZnNldCA9PSAtMSkgewo+ICsJCWlmIChlcnJubyA9PSBFSU5WQUwpIHsKPiArCQkJ
dHN0X3JlcyhUQ09ORiwgIlNFRUtfREFUQS9TRUVLX0hPTEUgYXJlIG5vdCBzdXBwb3J0ZWQiKTsK
PiArCQl9IGVsc2Ugewo+ICsJCQlpZiAoZXJybm8gPT0gdGMtPmV4cGVjdGVkX2Vycm5vKSB7Cj4g
KwkJCQl0c3RfcmVzKFRQQVNTIHwgVEVSUk5PLCB0Yy0+ZGVzYyk7Cj4gKwkJCX0gZWxzZSB7Cj4g
KwkJCQl0c3RfcmVzKFRGQUlMIHwgVEVSUk5PLAo+ICsJCQkJCSJsc2VlaygpIGZhaWxlZCB1bmV4
cGVjdGVkbHkiKTsKPiArCQkJfQo+ICsJCX0KPiArCX0gZWxzZSB7Cj4gKwkJdHN0X3JlcyhURkFJ
TCwgImxzZWVrKCkgc3VjY2VlZGVkIHVuZXhwZWN0ZWRseSIpOwo+ICsJfQoKPiArfQo+ICsKPiAr
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsJLnNldHVwID0gc2V0dXAsCj4gKwku
Y2xlYW51cCA9IGNsZWFudXAsCj4gKwkudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKSwKPiArCS50
ZXN0ID0gdmVyaWZ5X2xzZWVrLAo+ICsJLm5lZWRzX3RtcGRpciA9IDEsCj4gK307Cj4gCgpSZWdh
cmRzLApBdmluZXNoCgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
