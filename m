Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814AAC3ABBC
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:11:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C917D3CC29B
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 12:11:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E06CC3CC17D
 for <ltp@lists.linux.it>; Mon, 12 May 2025 12:11:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1955F100023E
 for <ltp@lists.linux.it>; Mon, 12 May 2025 12:11:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 377732116A;
 Mon, 12 May 2025 10:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747044661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DuU4eb4aOV7PiApzcjeTtOZw+wkloSwIkW2ZxQHtzEo=;
 b=TLiv4+4VjU3wNOIfsXOjXc3GNbFupmID/SRuVgwEGiY2cC0/tBPrxE/ESsw/gEq/ZKNri1
 vJ5Tu/hm1/f6cNLTiIKIqZQpZRX9kFudxr9X6xjikKcEkRPb7H+1noiLiIR5agP0aZgvLZ
 ThzpaE0qeizXTv+HV62LLTA1l+F+lW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747044661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DuU4eb4aOV7PiApzcjeTtOZw+wkloSwIkW2ZxQHtzEo=;
 b=7WbGM9bXe4leAXZVYf7ktcEtiwdq/i+hTDkqcEVQFtzU0zzJUme0ZJWtxlrJJVQrFFbssL
 Ib8P5AVgPpwsvfDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cKl3URfH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lKHIziPS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747044660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DuU4eb4aOV7PiApzcjeTtOZw+wkloSwIkW2ZxQHtzEo=;
 b=cKl3URfHCksEaFx9UyP9qZPdg6nM0QPK4vJVxCfRsjemRxgEQGs1f/OYsNTT2mI3fWWSAZ
 l8WQB5If7Eno+gJkXVimyqqcQdm/vm0Bps7RopP7ThhJ0Us2VonF6rWxdicxVyhFkjzj/L
 qYvZfurygZz6TYokbYt35vII+zsoXtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747044660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DuU4eb4aOV7PiApzcjeTtOZw+wkloSwIkW2ZxQHtzEo=;
 b=lKHIziPSUaMSQLGkDuQcpSzQzgU+LMwJKP3qOHDFMQ9WRlQS88erHxw5TqrMPUpTBF3YJV
 IM6FEV393kinvYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2709313A30;
 Mon, 12 May 2025 10:11:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fZnNCDTJIWjsSgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 12 May 2025 10:11:00 +0000
Message-ID: <f4e06a94-e613-4afb-bc7b-afc833fcc5c1@suse.cz>
Date: Mon, 12 May 2025 12:10:51 +0200
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
X-Rspamd-Queue-Id: 377732116A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
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

SGksClJldmlld2VkLWJ5OiBNYXJ0aW4gRG91Y2hhIDxtZG91Y2hhQHN1c2UuY3o+CgpPbiAxMi4g
MDUuIDI1IDEyOjA1LCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPiBGcm9tOiBSaWNhcmRv
IEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IAo+IFRoZSBjb21taXQgYmUwYWFjYTJmNzQy
ICgic3lzY2FsbHMvbW9kaWZ5X2xkdDogQWRkIGxhcGkvbGR0LmgiKSBsZWZ0IGJlaGluZAo+IGFu
IGltcG9ydGFudCBmYWN0b3Igb2YgbW9kaWZ5X2xkdCgpOiB0aGUga2VybmVsIGludGVudGlvbmFs
bHkgY2FzdHMgdGhlCj4gcmV0dXJuIHZhbHVlIHRvIHVuc2lnbmVkIGludC4gVGhpcyB3YXMgaGFu
ZGxlZCBpbgo+IHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIGJ1dCB3YXMgcmVtb3ZlZC4g
QWRkIGl0IGJhY2sgdG8gdGhlIHJlbGV2YW50Cj4gZmlsZS4KPiAKPiBSZXBvcnRlZC1ieTogTWFy
dGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6Pgo+IFNpZ25lZC1vZmYtYnk6IFJpY2FyZG8gQi4g
TWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4gLS0tCj4gQ2hhbmdlcyBpbiB2MjoKPiAtIEFkZGVk
IFRCUk9LIGZvciBhbnkgcmV0ICE9IDAgaW4gbW9kaWZ5X2xkdCBjYWxsIGluIGN2ZS0yMDE1LTMy
OTAuYwo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI1MDUwNy1m
aXhlcy1tb2RpZnlfbGR0LXYxLTEtNzBhMjY5NGNmZGRjQHN1c2UuY29tCj4gLS0tCj4gICBpbmNs
dWRlL2xhcGkvbGR0LmggICAgICAgICAgICB8IDIyICsrKysrKysrKysrKysrKysrKysrKy0KPiAg
IHRlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jIHwgIDggKysrKysrKy0KPiAgIDIgZmlsZXMg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9sYXBpL2xkdC5oIGIvaW5jbHVkZS9sYXBpL2xkdC5oCj4gaW5kZXggNmI1YTJk
NTljYjQxYmZjMjRlYjVhYzI2YzNkNDdkNDlmYjhmZjc4Zi4uMTczMzIxZGQ5YWMzNGJhODdlZmYw
ZWVlOTYwNjM1ZjMwZDg3ODk5MSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xhcGkvbGR0LmgKPiAr
KysgYi9pbmNsdWRlL2xhcGkvbGR0LmgKPiBAQCAtMzEsNyArMzEsMjcgQEAgc3RydWN0IHVzZXJf
ZGVzYyB7Cj4gICBzdGF0aWMgaW5saW5lIGludCBtb2RpZnlfbGR0KGludCBmdW5jLCBjb25zdCBz
dHJ1Y3QgdXNlcl9kZXNjICpwdHIsCj4gICAJCQkgICAgIHVuc2lnbmVkIGxvbmcgYnl0ZWNvdW50
KQo+ICAgewo+IC0JcmV0dXJuIHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRy
LCBieXRlY291bnQpOwo+ICsJbG9uZyBydmFsOwo+ICsKPiArCWVycm5vID0gMDsKPiArCXJ2YWwg
PSB0c3Rfc3lzY2FsbChfX05SX21vZGlmeV9sZHQsIGZ1bmMsIHB0ciwgYnl0ZWNvdW50KTsKPiAr
Cj4gKyNpZmRlZiBfX3g4Nl82NF9fCj4gKwkvKgo+ICsJICogVGhlIGtlcm5lbCBpbnRlbnRpb25h
bGx5IGNhc3RzIG1vZGlmeV9sZHQoKSByZXR1cm4gdmFsdWUKPiArCSAqIHRvIHVuc2lnbmVkIGlu
dCB0byBwcmV2ZW50IHNpZ24gZXh0ZW5zaW9uIHRvIDY0IGJpdHMuIFRoaXMgbWF5Cj4gKwkgKiBy
ZXN1bHQgaW4gc3lzY2FsbCgpIHJldHVybmluZyB0aGUgdmFsdWUgYXMgaXMgaW5zdGVhZCBvZiBz
ZXR0aW5nCj4gKwkgKiBlcnJubyBhbmQgcmV0dXJuaW5nIC0xLgo+ICsJICovCj4gKwlpZiAocnZh
bCA+IDAgJiYgKGludClydmFsIDwgMCkgewo+ICsJCXRzdF9yZXMoVElORk8sCj4gKwkJCSJXQVJO
SU5HOiBMaWJjIG1pc2hhbmRsZWQgbW9kaWZ5X2xkdCgpIHJldHVybiB2YWx1ZSIpOwo+ICsJCWVy
cm5vID0gLShpbnQpZXJybm87Cj4gKwkJcnZhbCA9IC0xOwo+ICsJfQo+ICsjZW5kaWYgLyogX194
ODZfNjRfXyAqLwo+ICsKPiArCXJldHVybiBydmFsOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW5s
aW5lIGludCBzYWZlX21vZGlmeV9sZHQoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVu
bywgaW50IGZ1bmMsCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5j
IGIvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMKPiBpbmRleCA4ZWMxZDUzYmJiNWE5ZjNl
Nzc2MWQzOTg1NWQzNGY1OTNlMTE4YTI4Li5lNzA3NDJhY2M4N2MzOTA4ODk1M2UwMmYxNjE0NmI3
YjU4YTc1ZmQxIDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9jdmUvY3ZlLTIwMTUtMzI5MC5jCj4g
KysrIGIvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0zMjkwLmMKPiBAQCAtMTk3LDcgKzE5NywxMyBA
QCBzdGF0aWMgdm9pZCBzZXRfbGR0KHZvaWQpCj4gICAJCS51c2VhYmxlCSA9IDAKPiAgIAl9Owo+
ICAgCj4gLQlTQUZFX01PRElGWV9MRFQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFfZGVzYykp
Owo+ICsJVEVTVChtb2RpZnlfbGR0KDEsICZkYXRhX2Rlc2MsIHNpemVvZihkYXRhX2Rlc2MpKSk7
Cj4gKwlpZiAoVFNUX1JFVCA9PSAtMSAmJiBUU1RfRVJSID09IEVJTlZBTCkgewo+ICsJCXRzdF9i
cmsoVENPTkYgfCBUVEVSUk5PLAo+ICsJCQkibW9kaWZ5X2xkdDogMTYtYml0IGRhdGEgc2VnbWVu
dHMgYXJlIHByb2JhYmx5IGRpc2FibGVkIik7Cj4gKwl9IGVsc2UgaWYgKFRTVF9SRVQgIT0gMCkg
ewo+ICsJCXRzdF9icmsoVEJST0sgfCBUVEVSUk5PLCAibW9kaWZ5X2xkdCIpOwo+ICsJfQo+ICAg
fQo+ICAgCj4gICBzdGF0aWMgdm9pZCB0cnlfY29ycnVwdF9zdGFjayh1bnNpZ25lZCBzaG9ydCAq
b3JpZ19zcykKPiAKPiAtLS0KPiBiYXNlLWNvbW1pdDogYjA3MGE1NjkyZTAzNWVjMTJjM2QzYzdh
N2U5ZTk3YzI3MGZkNGQ3ZAo+IGNoYW5nZS1pZDogMjAyNTA1MDctZml4ZXMtbW9kaWZ5X2xkdC1l
YmNmZGQyYTdkMzAKPiAKPiBCZXN0IHJlZ2FyZHMsCgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91
Y2hhQHN1c2UuY3oKU1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08g
SUlhCktyaXppa292YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
