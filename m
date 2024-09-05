Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D6FCD5BCC
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 15:05:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0541E3C24C2
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 17:05:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2103C2145
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 17:05:14 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8F4A0200970
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 17:05:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 846F81F826;
 Thu,  5 Sep 2024 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725548712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtQDsvuq4BnPnnSsOpQcgmnQI45R6FpJVUGXql6KGU4=;
 b=ZcqfSycE6QyHGoQ1saBJWmJpey6arSZCCIIY5QYCcwVbHMzoTpWyeRpYMkivguIXJNW64O
 QuW8JEZZGKydDb4uE24icuFj5RIsxSCzaObIyVQRPP9k12BThfAyWYVVzA300EsyGMFIAe
 1A915HdtWpj9ApLaT8i5mEMmOChtaUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725548712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtQDsvuq4BnPnnSsOpQcgmnQI45R6FpJVUGXql6KGU4=;
 b=fG3kUeM+1KIncpW5+IUNI8aAYw5f4dpcMhnaWXv/ZKibxDqvYMLIlrf97yGOEiJc6VqL8e
 a0qnHzQhX/mNnHCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725548712; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtQDsvuq4BnPnnSsOpQcgmnQI45R6FpJVUGXql6KGU4=;
 b=ZcqfSycE6QyHGoQ1saBJWmJpey6arSZCCIIY5QYCcwVbHMzoTpWyeRpYMkivguIXJNW64O
 QuW8JEZZGKydDb4uE24icuFj5RIsxSCzaObIyVQRPP9k12BThfAyWYVVzA300EsyGMFIAe
 1A915HdtWpj9ApLaT8i5mEMmOChtaUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725548712;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mtQDsvuq4BnPnnSsOpQcgmnQI45R6FpJVUGXql6KGU4=;
 b=fG3kUeM+1KIncpW5+IUNI8aAYw5f4dpcMhnaWXv/ZKibxDqvYMLIlrf97yGOEiJc6VqL8e
 a0qnHzQhX/mNnHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CC441395F;
 Thu,  5 Sep 2024 15:05:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MJKDGajI2Wa2JQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 05 Sep 2024 15:05:12 +0000
Date: Thu, 5 Sep 2024 17:04:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Geetika <geetika@linux.ibm.com>
Message-ID: <ZtnIY1Ia8PB6x0lU@yuki.lan>
References: <20240802061342.8540-1-geetika@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240802061342.8540-1-geetika@linux.ibm.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Hugetlb: Migrating libhugetlbfs test
 truncate_reserve_wraparound.c
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
Cc: donettom@linux.ibm.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gVGVzdCB0byB2ZXJpZnkgdGhlIEh1Z2VwYWdlc19Sc3ZkIGJlZm9yZSBhbmQgYWZ0ZXIg
bW1hcCwgdHJ1bmNhdGUgYW5kIHNpZ2J1cyBvcGVyYXRpb25zLgo+IEF0IG9uZSBzdGFnZSwgaW1w
cm9wZXIgaGFuZGxpbmcgb2YgdGVzdHMgYWdhaW5zdCBpX3NpemUgY291bGQgbWVzcwo+IHVwIGFj
Y291bnRpbmcgb2YgcmVzZXJ2ZWQgaHVnZXBhZ2VzIG9uIGNlcnRhaW4gdHJ1bmNhdGUgb3BlcmF0
aW9ucy4KPiAKPiBUZXN0ZWQgYW5kIHZlcmlmaWVkIHRoYXQgdGVzdCBwYXNzZXMgZm9yIGl0ZXJh
dGlvbnM6IGkyLCBpNSBhbmQgaTEwCj4gCj4gU2lnbmVkLW9mZi1ieTogR2VldGlrYSA8Z2VldGlr
YUBsaW51eC5pYm0uY29tPgo+IC0tLQo+IENoYW5nZXMgaW4gdjM6Cj4gLSBGaXhlZCB0aGUgaW5k
ZW50YXRpb24KPiAtIENvcnJlY3RlZCBhbGwgdGhlIHRzdF9yZXMoKSBmb3JtYXQgc3RyaW5nCj4g
LS0tCj4gQ2hhbmdlcyBpbiB2MjoKPiAtIE1vZGlmaWVkIHRoZSBEZXNjcmlwdGlvbiBzZWN0aW9u
IG9mIHRlc3QKPiAtIFJlbW92ZWQgZGVmaW5pdGlvbiBvZiB1bnN1ZWQgUkFORE9NX0NPTlNUQU5U
Cj4gLSBGaXhlZCB3YXJuaW5nOiB1bnVzZWQgcGFyYW1ldGVyIOKAmHNpZ251beKAmSBbLVd1bnVz
ZWQtcGFyYW1ldGVyXQo+IC0gRml4ZWQgd2FybmluZzogdW51c2VkIHBhcmFtZXRlciDigJhzaeKA
mSBbLVd1bnVzZWQtcGFyYW1ldGVyXQo+IC0gRml4ZWQgd2FybmluZzogdW51c2VkIHBhcmFtZXRl
ciDigJh1Y+KAmSBbLVd1bnVzZWQtcGFyYW1ldGVyXQo+IC0tLQo+ICBydW50ZXN0L2h1Z2V0bGIg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVs
L21lbS8uZ2l0aWdub3JlICAgICAgICAgICAgICAgfCAgIDEgKwo+ICAuLi4va2VybmVsL21lbS9o
dWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzguYyAgfCAxMjIgKysrKysrKysrKysrKysrKysrCj4g
IDMgZmlsZXMgY2hhbmdlZCwgMTI0IGluc2VydGlvbnMoKykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAzOC5jCj4gCj4g
ZGlmZiAtLWdpdCBhL3J1bnRlc3QvaHVnZXRsYiBiL3J1bnRlc3QvaHVnZXRsYgo+IGluZGV4IDI5
OWMwN2FjOS4uMmZmZDM1YWVjIDEwMDY0NAo+IC0tLSBhL3J1bnRlc3QvaHVnZXRsYgo+ICsrKyBi
L3J1bnRlc3QvaHVnZXRsYgo+IEBAIC0zNSw2ICszNSw3IEBAIGh1Z2VtbWFwMjkgaHVnZW1tYXAy
OQo+ICBodWdlbW1hcDMwIGh1Z2VtbWFwMzAKPiAgaHVnZW1tYXAzMSBodWdlbW1hcDMxCj4gIGh1
Z2VtbWFwMzIgaHVnZW1tYXAzMgo+ICtodWdlbW1hcDM4IGh1Z2VtbWFwMzgKPiAgaHVnZW1tYXAw
NV8xIGh1Z2VtbWFwMDUgLW0KPiAgaHVnZW1tYXAwNV8yIGh1Z2VtbWFwMDUgLXMKPiAgaHVnZW1t
YXAwNV8zIGh1Z2VtbWFwMDUgLXMgLW0KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vLmdpdGlnbm9yZSBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUKPiBpbmRleCBj
OTZmZThiZmMuLmRkMGM1OWU5OCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL21lbS8u
Z2l0aWdub3JlCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQo+IEBAIC0z
NCw2ICszNCw3IEBACj4gIC9odWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzAKPiAgL2h1Z2V0bGIv
aHVnZW1tYXAvaHVnZW1tYXAzMQo+ICAvaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDMyCj4gKy9o
dWdldGxiL2h1Z2VtbWFwL2h1Z2VtbWFwMzgKPiAgL2h1Z2V0bGIvaHVnZXNobWF0L2h1Z2VzaG1h
dDAxCj4gIC9odWdldGxiL2h1Z2VzaG1hdC9odWdlc2htYXQwMgo+ICAvaHVnZXRsYi9odWdlc2ht
YXQvaHVnZXNobWF0MDMKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRs
Yi9odWdlbW1hcC9odWdlbW1hcDM4LmMgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1
Z2VtbWFwL2h1Z2VtbWFwMzguYwo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggMDAwMDAw
MDAwLi4yMDg0NWI5NDYKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9t
ZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDM4LmMKPiBAQCAtMCwwICsxLDEyMiBAQAo+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogTEdQTC0yLjEtb3ItbGF0ZXIKPiArLyoKPiArICog
Q29weXJpZ2h0IChDKSAyMDA1LTIwMDYgRGF2aWQgR2lic29uICYgQWRhbSBMaXRrZSwgSUJNIENv
cnBvcmF0aW9uLgo+ICsgKi8KPiArCj4gKy8qXAo+ICsgKltEZXNjcmlwaXRvbl0KPiArICoKPiAr
ICogT3JpZ2luOiBodHRwczovL2dpdGh1Yi5jb20vbGliaHVnZXRsYmZzL2xpYmh1Z2V0bGJmcy9i
bG9iL21hc3Rlci90ZXN0cy90cnVuY2F0ZV9yZXNlcnZlX3dyYXBhcm91bmQuYwo+ICsgKgo+ICsg
KiBBdCBvbmUgc3RhZ2UsIGltcHJvcGVyIGhhbmRsaW5nIG9mIHRlc3RzIGFnYWluc3QgaV9zaXpl
IGNvdWxkIG1lc3MKPiArICogdXAgYWNjb3VudGluZyBvZiByZXNlcnZlZCBodWdlcGFnZXMgb24g
Y2VydGFpbiB0cnVuY2F0ZQo+ICsgKiBvcGVyYXRpb25zLgo+ICsgKgo+ICsgKi8KPiArCj4gKyNp
bmNsdWRlIDxzaWduYWwuaD4KPiArI2luY2x1ZGUgPHNldGptcC5oPgo+ICsjaW5jbHVkZSAiaHVn
ZXRsYi5oIgo+ICsKPiArI2RlZmluZSBNTlRQT0lOVCAiaHVnZXRsYmZzLyIKPiArCj4gK3N0YXRp
YyBsb25nIGhwYWdlX3NpemU7Cj4gK3N0YXRpYyBpbnQgZmQgPSAtMTsKCj4gK3N0YXRpYyBpbnQg
c2lnYnVzX2NvdW50Owo+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBpbml0aWFsX3JzdmQsIGFmdGVy
X21hcF9yc3ZkLCBhZnRlcl90b3VjaF9yc3ZkOwo+ICtzdGF0aWMgdW5zaWduZWQgbG9uZyBhZnRl
cl90cnVuY19yc3ZkLCBhZnRlcl91bm1hcF9yc3ZkLCBhZnRlcl9zaWdidXNfcnN2ZDsKPiArc3Rh
dGljIHZvbGF0aWxlIHVuc2lnbmVkIGludCAqcTsKCkFsbCB0aGVzZSBjYW4gYmUgZGVmaW5lZCBp
biB0aGUgcnVuX3Rlc3QoKSBmdW5jdGlvbiBpbnN0ZWFkLCBubyBuZWVkIHRvCmtlZXAgdGhlbSBn
bG9iYWwuCgo+ICtzdGF0aWMgc2lnam1wX2J1ZiBzaWdfZXNjYXBlOwo+ICsKPiArc3RhdGljIHZv
aWQgc2lnYnVzX2hhbmRsZXIoaW50IHNpZ251bSBMVFBfQVRUUklCVVRFX1VOVVNFRCwgc2lnaW5m
b190ICpzaSBMVFBfQVRUUklCVVRFX1VOVVNFRCwgdm9pZCAqdWMgTFRQX0FUVFJJQlVURV9VTlVT
RUQpCj4gK3sKPiArCXNpZ2xvbmdqbXAoc2lnX2VzY2FwZSwgMTcpOwo+ICt9Cj4gKwo+ICtzdGF0
aWMgdm9pZCBydW5fdGVzdCh2b2lkKQo+ICt7Cj4gKwl2b2lkICpwOwo+ICsJc3RydWN0IHNpZ2Fj
dGlvbiBzYSA9IHsKPiArCQkuc2Ffc2lnYWN0aW9uID0gc2lnYnVzX2hhbmRsZXIsCj4gKwkJLnNh
X2ZsYWdzID0gU0FfU0lHSU5GTywKPiArCX07CgpJZiBJIHJlbW1lYmVyIGNvcnJlY3RseSBJIGFz
a2VkIHRoaXMgdG8gYmUgbW92ZWQgaW50byB0aGUgdGVzdCBzZXR1cCgpCmFsb25nIHdpdGggdGhl
IGNvcnJlc3BvbmRpbmcgU0FGRV9TSUdBQ1RJT04oKSBjYWxsLgoKVGVyZSBpcyBubyBwb2ludCBp
biBzZXR0aW5nIHVwIHRoZSBzaWduYWwgaGFuZGxlciBpbiBlYWNoIGl0ZXJhdGlvbiBvZgp0aGUg
dGVzdC4KCj4gKwlzaWdidXNfY291bnQgPSAwOwo+ICsKPiArCWluaXRpYWxfcnN2ZCA9IFNBRkVf
UkVBRF9NRU1JTkZPKE1FTUlORk9fSFBBR0VfUlNWRCk7Cj4gKwl0c3RfcmVzKFRJTkZPLCAiUmVz
ZXJ2ZSBjb3VudCBiZWZvcmUgbWFwOiAlbHUiLCBpbml0aWFsX3JzdmQpOwo+ICsKPiArCXAgPSBT
QUZFX01NQVAoTlVMTCwgaHBhZ2Vfc2l6ZSwgUFJPVF9SRUFEfFBST1RfV1JJVEUsIE1BUF9TSEFS
RUQsCj4gKwkJCWZkLCAwKTsKPiArCXEgPSBwOwo+ICsKPiArCWFmdGVyX21hcF9yc3ZkID0gU0FG
RV9SRUFEX01FTUlORk8oTUVNSU5GT19IUEFHRV9SU1ZEKTsKPiArCXRzdF9yZXMoVElORk8sICJS
ZXNlcnZlIGNvdW50IGFmdGVyIG1hcDogJWx1IiwgYWZ0ZXJfbWFwX3JzdmQpOwo+ICsKPiArCSpx
ID0gMDsKPiArCWFmdGVyX3RvdWNoX3JzdmQgPSBTQUZFX1JFQURfTUVNSU5GTyhNRU1JTkZPX0hQ
QUdFX1JTVkQpOwo+ICsJdHN0X3JlcyhUSU5GTywgIlJlc2VydmUgY291bnQgYWZ0ZXIgdG91Y2g6
ICVsdSIsIGFmdGVyX3RvdWNoX3JzdmQpOwoKU28gaWYgSSB1bmRlcnN0YW5kIHRoaXMgY29ycmVj
dGx5IHRoZSBhZnRlcl90b3VjaF9yc3ZkIHNob3VsZCBiZSBiYWNrIHRvCmluaXRpYWxfcnN2ZCBi
ZWNhdXNlIHNpbmNlIHdlIGZhdWx0ZWQgdGhlIGh1Z2VwYWdlIGl0J3Mgbm8gbG9uZ2VyCnJlc2Vy
dmVkLiBTaG91bGRuJ3Qgd2UgY2hlY2sgdGhhdCBhZnRlcl90b3VjaF9yc3ZkID09IGluaXRpYWxf
cnN2ZCBhcwp3ZWxsPwoKPiArCVNBRkVfRlRSVU5DQVRFKGZkLCAwKTsKPiArCWFmdGVyX3RydW5j
X3JzdmQgPSBTQUZFX1JFQURfTUVNSU5GTyhNRU1JTkZPX0hQQUdFX1JTVkQpOwo+ICsJdHN0X3Jl
cyhUSU5GTywgIlJlc2VydmUgY291bnQgYWZ0ZXIgdHJ1bmNhdGU6ICVsdSIsIGFmdGVyX3RydW5j
X3JzdmQpOwo+ICsKPiArCWlmIChhZnRlcl90cnVuY19yc3ZkICE9IGluaXRpYWxfcnN2ZCkgewo+
ICsJCXRzdF9yZXMoVEZBSUwsICJSZXNlcnZlZCBjb3VudCBpcyBub3QgcmVzdG9yZWQgYWZ0ZXIg
dHJ1bmNhdGU6ICVsdSBpbnN0ZWFkIG9mICVsdSIsIGFmdGVyX3RydW5jX3JzdmQsIGluaXRpYWxf
cnN2ZCk7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCQkJ
CQkgICAgIEkgd291bGQgb21pdCB0aGUgImNvdW50IGlzIG5vdCByZXN0b3JlZCIKClNvIHRoYXQg
dGhlIG1lc3NhZ2Ugd291bGQgbG9vayBsaWtlICJSZXNlcnZlZCBhZnRlciB0cnVuY2F0ZSAlbHUg
aW5zdGVhZCBvZiAlbHUiCgpUaGF0IHdvdWxkIG1ha2UgdGhlIG1lc3NhZ2Ugc2hvcnRlciBhbmQg
bW9yZSB0byB0aGUgcG9pbnQgd2hpbGUga2VlcGluZwptb3N0IG9mIHRoZSBpbmZvcm1hdGlvbiBp
biB0aGVyZS4KCj4gKwkJZ290byB3aW5kdXA7Cj4gKwl9Cj4gKwo+ICsJU0FGRV9TSUdBQ1RJT04o
U0lHQlVTLCAmc2EsIE5VTEwpOwo+ICsJaWYgKHNpZ3NldGptcChzaWdfZXNjYXBlLCAxKSA9PSAw
KQo+ICsJCSpxOyAvKiBGYXVsdCwgdHJpZ2dlcmluZyBhIFNJR0JVUyAqLwo+ICsJZWxzZQo+ICsJ
CXNpZ2J1c19jb3VudCsrOwo+ICsKPiArCWlmIChzaWdidXNfY291bnQgIT0gMSkgewo+ICsJCXRz
dF9yZXMoVEZBSUwsICJEaWRuJ3QgU0lHQlVTIGFmdGVyIHRydW5jYXRlIik7Cj4gKwkJZ290byB3
aW5kdXA7Cj4gKwl9Cj4gKwo+ICsJYWZ0ZXJfc2lnYnVzX3JzdmQgPSBTQUZFX1JFQURfTUVNSU5G
TyhNRU1JTkZPX0hQQUdFX1JTVkQpOwo+ICsJdHN0X3JlcyhUSU5GTywgIlJlc2VydmUgY291bnQg
YWZ0ZXIgc2lnYnVzOiAlbHUiLCBhZnRlcl9zaWdidXNfcnN2ZCk7Cj4gKwo+ICsJaWYgKGFmdGVy
X3RydW5jX3JzdmQgIT0gaW5pdGlhbF9yc3ZkKSB7CiAgICAgICAgICAgICBeCgkgICAgIFNob3Vs
ZG4ndCB0aGlzIGJlIGFmdGVyX3NpZ2J1c19yc3ZkPwoKPiArCQl0c3RfcmVzKFRGQUlMLCAiUmVz
ZXJ2ZWQgY291bnQgaXMgYWx0ZXJlZCBieSBTSUdCVVMgZmF1bHQ6ICVsdSBpbnN0ZWFkIG9mICVs
dSIsIGFmdGVyX3NpZ2J1c19yc3ZkLCBpbml0aWFsX3JzdmQpOwogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoJCQkJCQkgQW5kIGNoYW5nZWQgdGhpcyB0
bzoKCgkJCQkJCSAiUmVzZXJ2ZWQgYWZ0ZXIgU0lHQlVTICVsdSBpbnN0ZWFkIG9mICVsdSIKCgpB
bGwgaW4gYWxsIHRoZXNlIGFyZSByZWFsbHkgbWlub3IgYW5kIHRoZSBjb2RlIGxvb2tzIG1vc3Rs
eSBmaW5lIG5vdy4KCi0tIApDeXJpbCBIcnViaXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
