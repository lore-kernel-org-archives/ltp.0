Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA1C2D0CD
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 11:31:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DEA53CC7D4
	for <ltp@archiver.kernel.org>; Wed, 21 May 2025 13:31:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 530563CA55C
 for <ltp@lists.linux.it>; Wed, 21 May 2025 13:31:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id AAEEF1A0069F
 for <ltp@lists.linux.it>; Wed, 21 May 2025 13:31:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5E62E20936;
 Wed, 21 May 2025 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747827073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mNozMQn6oEi9/QV7QrUZGZK/w7by6G4KF8DE97FYDj0=;
 b=h1oZYPQu2G9Gi9b0dYQ0k0bg1XbSNrLIvDoBga/I5O08dvAjgbbU07gVCCJiQIeHxXbMwb
 nTqxo35tHvAF2Xi0bN564lKBfXR9lG5vouyEi9JkNd34MPORks7rcdQF+Wl73RyKxtnEtz
 CTZmUM30Otx78ojB/eKkghMm4F2RF5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747827073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mNozMQn6oEi9/QV7QrUZGZK/w7by6G4KF8DE97FYDj0=;
 b=/dxH21HmLBZnbAVIOr5XqycgRAZdbFi16E9hIoIfj95fxexWRGz+d2BxyRoXucuLGjOaKc
 RVYHpp4ZzzXcqTBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h1oZYPQu;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/dxH21Hm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747827073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mNozMQn6oEi9/QV7QrUZGZK/w7by6G4KF8DE97FYDj0=;
 b=h1oZYPQu2G9Gi9b0dYQ0k0bg1XbSNrLIvDoBga/I5O08dvAjgbbU07gVCCJiQIeHxXbMwb
 nTqxo35tHvAF2Xi0bN564lKBfXR9lG5vouyEi9JkNd34MPORks7rcdQF+Wl73RyKxtnEtz
 CTZmUM30Otx78ojB/eKkghMm4F2RF5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747827073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mNozMQn6oEi9/QV7QrUZGZK/w7by6G4KF8DE97FYDj0=;
 b=/dxH21HmLBZnbAVIOr5XqycgRAZdbFi16E9hIoIfj95fxexWRGz+d2BxyRoXucuLGjOaKc
 RVYHpp4ZzzXcqTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 528FE13888;
 Wed, 21 May 2025 11:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uCSqE4G5LWiCYgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Wed, 21 May 2025 11:31:13 +0000
Message-ID: <2b58e361-39f0-4d31-a285-c6908c4a8931@suse.cz>
Date: Wed, 21 May 2025 13:31:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250512-fixes-modify_ldt-v2-1-eaef5577e44e@suse.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5E62E20936
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ldt.h: Add workaround for x86_64
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCml0IHR1cm5zIG91dCB0aGF0IHRoZXJlJ3MgYSBtaXN0YWtlIGluIHRoaXMgcGF0Y2guIFNl
ZSBiZWxvdy4KCk9uIDEyLiAwNS4gMjUgMTI6MDUsIFJpY2FyZG8gQi4gTWFybGnDqHJlIHdyb3Rl
Ogo+IEZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gCj4gVGhlIGNv
bW1pdCBiZTBhYWNhMmY3NDIgKCJzeXNjYWxscy9tb2RpZnlfbGR0OiBBZGQgbGFwaS9sZHQuaCIp
IGxlZnQgYmVoaW5kCj4gYW4gaW1wb3J0YW50IGZhY3RvciBvZiBtb2RpZnlfbGR0KCk6IHRoZSBr
ZXJuZWwgaW50ZW50aW9uYWxseSBjYXN0cyB0aGUKPiByZXR1cm4gdmFsdWUgdG8gdW5zaWduZWQg
aW50LiBUaGlzIHdhcyBoYW5kbGVkIGluCj4gdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMg
YnV0IHdhcyByZW1vdmVkLiBBZGQgaXQgYmFjayB0byB0aGUgcmVsZXZhbnQKPiBmaWxlLgo+IAo+
IFJlcG9ydGVkLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+Cj4gU2lnbmVkLW9m
Zi1ieTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiAtLS0KPiBDaGFuZ2Vz
IGluIHYyOgo+IC0gQWRkZWQgVEJST0sgZm9yIGFueSByZXQgIT0gMCBpbiBtb2RpZnlfbGR0IGNh
bGwgaW4gY3ZlLTIwMTUtMzI5MC5jCj4gLSBMaW5rIHRvIHYxOiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9yLzIwMjUwNTA3LWZpeGVzLW1vZGlmeV9sZHQtdjEtMS03MGEyNjk0Y2ZkZGNAc3VzZS5j
b20KPiAtLS0KPiAgIGluY2x1ZGUvbGFwaS9sZHQuaCAgICAgICAgICAgIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrLQo+ICAgdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMgfCAgOCArKysr
KysrLQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0
LmgKPiBpbmRleCA2YjVhMmQ1OWNiNDFiZmMyNGViNWFjMjZjM2Q0N2Q0OWZiOGZmNzhmLi4xNzMz
MjFkZDlhYzM0YmE4N2VmZjBlZWU5NjA2MzVmMzBkODc4OTkxIDEwMDY0NAo+IC0tLSBhL2luY2x1
ZGUvbGFwaS9sZHQuaAo+ICsrKyBiL2luY2x1ZGUvbGFwaS9sZHQuaAo+IEBAIC0zMSw3ICszMSwy
NyBAQCBzdHJ1Y3QgdXNlcl9kZXNjIHsKPiAgIHN0YXRpYyBpbmxpbmUgaW50IG1vZGlmeV9sZHQo
aW50IGZ1bmMsIGNvbnN0IHN0cnVjdCB1c2VyX2Rlc2MgKnB0ciwKPiAgIAkJCSAgICAgdW5zaWdu
ZWQgbG9uZyBieXRlY291bnQpCj4gICB7Cj4gLQlyZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9tb2Rp
ZnlfbGR0LCBmdW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4gKwlsb25nIHJ2YWw7Cj4gKwo+ICsJZXJy
bm8gPSAwOwo+ICsJcnZhbCA9IHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRy
LCBieXRlY291bnQpOwo+ICsKPiArI2lmZGVmIF9feDg2XzY0X18KPiArCS8qCj4gKwkgKiBUaGUg
a2VybmVsIGludGVudGlvbmFsbHkgY2FzdHMgbW9kaWZ5X2xkdCgpIHJldHVybiB2YWx1ZQo+ICsJ
ICogdG8gdW5zaWduZWQgaW50IHRvIHByZXZlbnQgc2lnbiBleHRlbnNpb24gdG8gNjQgYml0cy4g
VGhpcyBtYXkKPiArCSAqIHJlc3VsdCBpbiBzeXNjYWxsKCkgcmV0dXJuaW5nIHRoZSB2YWx1ZSBh
cyBpcyBpbnN0ZWFkIG9mIHNldHRpbmcKPiArCSAqIGVycm5vIGFuZCByZXR1cm5pbmcgLTEuCj4g
KwkgKi8KPiArCWlmIChydmFsID4gMCAmJiAoaW50KXJ2YWwgPCAwKSB7Cj4gKwkJdHN0X3JlcyhU
SU5GTywKPiArCQkJIldBUk5JTkc6IExpYmMgbWlzaGFuZGxlZCBtb2RpZnlfbGR0KCkgcmV0dXJu
IHZhbHVlIik7Cj4gKwkJZXJybm8gPSAtKGludCllcnJubzsKCkkndmUgY29tcGxldGVseSBtaXNz
ZWQgdGhhdCB0aGlzIGxpbmUgaXMgc3VwcG9zZWQgdG8gYmU6CmVycm5vID0gLShpbnQpcnZhbDsK
Cj4gKwkJcnZhbCA9IC0xOwo+ICsJfQo+ICsjZW5kaWYgLyogX194ODZfNjRfXyAqLwo+ICsKPiAr
CXJldHVybiBydmFsOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW5saW5lIGludCBzYWZlX21vZGlm
eV9sZHQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50IGZ1bmMsCj4gZGlm
ZiAtLWdpdCBhL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIGIvdGVzdGNhc2VzL2N2ZS9j
dmUtMjAxNS0zMjkwLmMKPiBpbmRleCA4ZWMxZDUzYmJiNWE5ZjNlNzc2MWQzOTg1NWQzNGY1OTNl
MTE4YTI4Li5lNzA3NDJhY2M4N2MzOTA4ODk1M2UwMmYxNjE0NmI3YjU4YTc1ZmQxIDEwMDY0NAo+
IC0tLSBhL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jCj4gKysrIGIvdGVzdGNhc2VzL2N2
ZS9jdmUtMjAxNS0zMjkwLmMKPiBAQCAtMTk3LDcgKzE5NywxMyBAQCBzdGF0aWMgdm9pZCBzZXRf
bGR0KHZvaWQpCj4gICAJCS51c2VhYmxlCSA9IDAKPiAgIAl9Owo+ICAgCj4gLQlTQUZFX01PRElG
WV9MRFQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFfZGVzYykpOwo+ICsJVEVTVChtb2RpZnlf
bGR0KDEsICZkYXRhX2Rlc2MsIHNpemVvZihkYXRhX2Rlc2MpKSk7Cj4gKwlpZiAoVFNUX1JFVCA9
PSAtMSAmJiBUU1RfRVJSID09IEVJTlZBTCkgewo+ICsJCXRzdF9icmsoVENPTkYgfCBUVEVSUk5P
LAo+ICsJCQkibW9kaWZ5X2xkdDogMTYtYml0IGRhdGEgc2VnbWVudHMgYXJlIHByb2JhYmx5IGRp
c2FibGVkIik7Cj4gKwl9IGVsc2UgaWYgKFRTVF9SRVQgIT0gMCkgewo+ICsJCXRzdF9icmsoVEJS
T0sgfCBUVEVSUk5PLCAibW9kaWZ5X2xkdCIpOwo+ICsJfQo+ICAgfQo+ICAgCj4gICBzdGF0aWMg
dm9pZCB0cnlfY29ycnVwdF9zdGFjayh1bnNpZ25lZCBzaG9ydCAqb3JpZ19zcykKPiAKPiAtLS0K
PiBiYXNlLWNvbW1pdDogYjA3MGE1NjkyZTAzNWVjMTJjM2QzYzdhN2U5ZTk3YzI3MGZkNGQ3ZAo+
IGNoYW5nZS1pZDogMjAyNTA1MDctZml4ZXMtbW9kaWZ5X2xkdC1lYmNmZGQyYTdkMzAKPiAKPiBC
ZXN0IHJlZ2FyZHMsCgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oKU1cgUXVh
bGl0eSBFbmdpbmVlcgpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXppa292YSAxNDgv
MzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
