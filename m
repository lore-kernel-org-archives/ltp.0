Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E1DECE57A
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 10:15:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10DE63C176D
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 12:15:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB99D3C02D1
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:15:21 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 00CAE601F8E
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 12:15:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B95A219A6;
 Mon,  9 Sep 2024 10:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4hXvqB6MJfZynCxK94o9MoSukhJqEnsIWqZSSxdMC4=;
 b=G/WVa0h2zbaOvVlzXpchzJY4BQjukBZNz5MtUqdfGiz4KGWaoOXGO0Vxdr/UeB+ghefRXm
 mF4iCN01+hXMm5eZeeQKJNIDO/pWjR6cYB0v2UPIcCHXJ1wqx/JXGUn+KDPtqHJsu5blOr
 ZfxDWNapPNzdTwrfIMmh+e+ENej8ZFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4hXvqB6MJfZynCxK94o9MoSukhJqEnsIWqZSSxdMC4=;
 b=0e2OdxBIsz7QNoi7eEupzAgaNkvlfndGud4n8bTuQUAUBG1BnUv75FwUe9RQQ+k0HluIXm
 7tyT3TYmaw6GSFDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725876920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4hXvqB6MJfZynCxK94o9MoSukhJqEnsIWqZSSxdMC4=;
 b=G/WVa0h2zbaOvVlzXpchzJY4BQjukBZNz5MtUqdfGiz4KGWaoOXGO0Vxdr/UeB+ghefRXm
 mF4iCN01+hXMm5eZeeQKJNIDO/pWjR6cYB0v2UPIcCHXJ1wqx/JXGUn+KDPtqHJsu5blOr
 ZfxDWNapPNzdTwrfIMmh+e+ENej8ZFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725876920;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D4hXvqB6MJfZynCxK94o9MoSukhJqEnsIWqZSSxdMC4=;
 b=0e2OdxBIsz7QNoi7eEupzAgaNkvlfndGud4n8bTuQUAUBG1BnUv75FwUe9RQQ+k0HluIXm
 7tyT3TYmaw6GSFDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F05613312;
 Mon,  9 Sep 2024 10:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KwYJA7jK3ma4EwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 09 Sep 2024 10:15:20 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Nirjhar Roy <nirjhar@linux.ibm.com>
Date: Mon, 09 Sep 2024 12:15:19 +0200
Message-ID: <4767877.vXUDI8C0e8@localhost>
Organization: SUSE
In-Reply-To: <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
References: <cover.1725601646.git.nirjhar@linux.ibm.com>
 <5488fdbd9f26f1826fb083cfdbc357ac9ca954a4.1725601646.git.nirjhar@linux.ibm.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 HAS_ORG_HEADER(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] syscalls/<delete, init,
 finit>_module: Rename /proc/dummy to module specific path name
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CgoKT24gTW9u
ZGF5LCBTZXB0ZW1iZXIgOSwgMjAyNCA2OjQyOjM04oCvQU0gR01UKzIgTmlyamhhciBSb3kgd3Jv
dGU6Cj4gVGVzdHMgaW4gc3lzY2FsbHMvZGVsZXRlX21vZHVsZS8sIHN5c2NhbGxzL2luaXRfbW9k
dWxlIGFuZCBzeXNjYWxscy9maW5pdF9tb2R1bGUgdXNlIGtlcm5lbAo+IG1vZHVsZXMgYWxsIG9m
IHdoaWNoIGNyZWF0ZSBhIC9wcm9jL2R1bW15IG5vZGUuIFdoZW4gdGhlc2UgdGVzdHMgcnVuIGlu
IHBhcnJhbGVsLCB0aGVyZSBhcHBlYXJzCj4gdG8gYmUgYSBzaXR1YXRpb24gd2hlcmUgdGhlc2Ug
dGVzdHMgc2ltdWxhdGVub3VzbHkgdHJpZXMgdG8gY3JlYXRlIC9wcm9jL2R1bW15IG5vZGUuIFRo
aXMgZ2VuZXJhdGVzCj4gYSBrZXJuZWwgd2FybmluZyAicHJvY19kaXJfZW50cnkgJy9wcm9jL2R1
bW15JyBhbHJlYWR5IHJlZ2lzdGVyZWQiLgo+IFRoaXMgcGF0Y2ggcmVuYW1lcyB0aGUgL3Byb2Mv
ZHVtbXkgbm9kZSB0byBtb2R1bGUgc3BlY2lmaWMgbmFtZSBpbiBvcmRlciB0byBhdm9pZCB0aGUg
Y29uZmxpY3QuCj4gCj4gU2lnbmVkLW9mZi1ieTogTmlyamhhciBSb3kgPG5pcmpoYXJAbGludXgu
aWJtLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kZWxldGVfbW9kdWxl
L2R1bW15X2RlbF9tb2QuYyAgICAgfCA2ICsrKystLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2RlbGV0ZV9tb2R1bGUvZHVtbXlfZGVsX21vZF9kZXAuYyB8IDYgKysrKy0tCj4gIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZmluaXRfbW9kdWxlL2Zpbml0X21vZHVsZS5jICAgICAgIHwg
NiArKysrLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pbml0X21vZHVsZS9pbml0X21v
ZHVsZS5jICAgICAgICAgfCA2ICsrKystLQo+ICA0IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZGVsZXRlX21vZHVsZS9kdW1teV9kZWxfbW9kLmMgYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2RlbGV0ZV9tb2R1bGUvZHVtbXlfZGVsX21vZC5jCj4gaW5kZXggMGNhN2JlYTM3
Li40MjU3YmI1MDQgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9kZWxl
dGVfbW9kdWxlL2R1bW15X2RlbF9tb2QuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZGVsZXRlX21vZHVsZS9kdW1teV9kZWxfbW9kLmMKPiBAQCAtMTQsNiArMTQsOCBAQAo+ICAj
aW5jbHVkZSA8bGludXgvcHJvY19mcy5oPgo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4g
IAo+ICsjZGVmaW5lIERJUk5BTUUgImR1bW15X2RlbG1vZCIKPiArCj4gIC8qIER1bW15IGZ1bmN0
aW9uIGNhbGxlZCBieSBkZXBlbmRlbnQgbW9kdWxlICovCj4gIGludCBkdW1teV9mdW5jX3Rlc3Qo
dm9pZCkKPiAgewo+IEBAIC0yNSwxMyArMjcsMTMgQEAgc3RhdGljIGludCBfX2luaXQgZHVtbXlf
aW5pdCh2b2lkKQo+ICB7Cj4gIAlzdHJ1Y3QgcHJvY19kaXJfZW50cnkgKnByb2NfZHVtbXk7Cj4g
IAo+IC0JcHJvY19kdW1teSA9IHByb2NfbWtkaXIoImR1bW15IiwgMCk7Cj4gKwlwcm9jX2R1bW15
ID0gcHJvY19ta2RpcihESVJOQU1FLCAwKTsKPiAgCXJldHVybiAwOwo+ICB9Cj4gIAo+ICBzdGF0
aWMgdm9pZCBfX2V4aXQgZHVtbXlfZXhpdCh2b2lkKQo+ICB7Cj4gLQlyZW1vdmVfcHJvY19lbnRy
eSgiZHVtbXkiLCAwKTsKPiArCXJlbW92ZV9wcm9jX2VudHJ5KERJUk5BTUUsIDApOwo+ICB9Cj4g
IAo+ICBtb2R1bGVfaW5pdChkdW1teV9pbml0KTsKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9kZWxldGVfbW9kdWxlL2R1bW15X2RlbF9tb2RfZGVwLmMgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2RlbGV0ZV9tb2R1bGUvZHVtbXlfZGVsX21vZF9kZXAuYwo+IGlu
ZGV4IDg1YjMyNzkxMS4uOGM4OTFjZjQ5IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvZGVsZXRlX21vZHVsZS9kdW1teV9kZWxfbW9kX2RlcC5jCj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9kZWxldGVfbW9kdWxlL2R1bW15X2RlbF9tb2RfZGVwLmMKPiBA
QCAtMTYsMjAgKzE2LDIyIEBACj4gICNpbmNsdWRlIDxsaW51eC9wcm9jX2ZzLmg+Cj4gICNpbmNs
dWRlIDxsaW51eC9rZXJuZWwuaD4KPiAgCj4gKyNkZWZpbmUgRElSTkFNRSAiZHVtbXlfZGVwIgo+
ICsKPiAgZXh0ZXJuIGludCBkdW1teV9mdW5jX3Rlc3Qodm9pZCk7Cj4gIAo+ICBzdGF0aWMgaW50
IF9faW5pdCBkdW1teV9pbml0KHZvaWQpCj4gIHsKPiAgCXN0cnVjdCBwcm9jX2Rpcl9lbnRyeSAq
cHJvY19kdW1teTsKPiAgCj4gLQlwcm9jX2R1bW15ID0gcHJvY19ta2RpcigiZHVtbXlfZGVwIiwg
MCk7Cj4gKwlwcm9jX2R1bW15ID0gcHJvY19ta2RpcihESVJOQU1FLCAwKTsKPiAgCWR1bW15X2Z1
bmNfdGVzdCgpOwo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAgCj4gIHN0YXRpYyB2b2lkIF9fZXhpdCBk
dW1teV9leGl0KHZvaWQpCj4gIHsKPiAtCXJlbW92ZV9wcm9jX2VudHJ5KCJkdW1teV9kZXAiLCAw
KTsKPiArCXJlbW92ZV9wcm9jX2VudHJ5KERJUk5BTUUsIDApOwo+ICB9Cj4gIAo+ICBtb2R1bGVf
aW5pdChkdW1teV9pbml0KTsKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9maW5pdF9tb2R1bGUvZmluaXRfbW9kdWxlLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L2Zpbml0X21vZHVsZS9maW5pdF9tb2R1bGUuYwo+IGluZGV4IDc4ZDAzYjg5OS4uYTdiMWU0M2M1
IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmluaXRfbW9kdWxlL2Zp
bml0X21vZHVsZS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9maW5pdF9tb2R1
bGUvZmluaXRfbW9kdWxlLmMKPiBAQCAtMTMsNiArMTMsOCBAQAo+ICAjaW5jbHVkZSA8bGludXgv
cHJvY19mcy5oPgo+ICAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+Cj4gIAo+ICsjZGVmaW5lIERJ
Uk5BTUUgImR1bW15X2Zpbml0Igo+ICsKPiAgc3RhdGljIGNoYXIgc3RhdHVzWzIwXTsKPiAgbW9k
dWxlX3BhcmFtX3N0cmluZyhzdGF0dXMsIHN0YXR1cywgMjAsIDA0NDQpOwo+ICAKPiBAQCAtMjMs
MTQgKzI1LDE0IEBAIHN0YXRpYyBpbnQgZHVtbXlfaW5pdCh2b2lkKQo+ICAJaWYgKCFzdHJjbXAo
c3RhdHVzLCAiaW52YWxpZCIpKQo+ICAJCXJldHVybiAtRUlOVkFMOwo+ICAKPiAtCXByb2NfZHVt
bXkgPSBwcm9jX21rZGlyKCJkdW1teSIsIDApOwo+ICsJcHJvY19kdW1teSA9IHByb2NfbWtkaXIo
RElSTkFNRSwgMCk7Cj4gIAlyZXR1cm4gMDsKPiAgfQo+ICBtb2R1bGVfaW5pdChkdW1teV9pbml0
KTsKPiAgCj4gIHN0YXRpYyB2b2lkIGR1bW15X2V4aXQodm9pZCkKPiAgewo+IC0JcmVtb3ZlX3By
b2NfZW50cnkoImR1bW15IiwgMCk7Cj4gKwlyZW1vdmVfcHJvY19lbnRyeShESVJOQU1FLCAwKTsK
PiAgfQo+ICBtb2R1bGVfZXhpdChkdW1teV9leGl0KTsKPiAgCj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvaW5pdF9tb2R1bGUvaW5pdF9tb2R1bGUuYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvc3lzY2FsbHMvaW5pdF9tb2R1bGUvaW5pdF9tb2R1bGUuYwo+IGluZGV4IDc4ZDAz
Yjg5OS4uZjE0Y2Q4MGI2IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
aW5pdF9tb2R1bGUvaW5pdF9tb2R1bGUuYwo+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaW5pdF9tb2R1bGUvaW5pdF9tb2R1bGUuYwo+IEBAIC0xMyw2ICsxMyw4IEBACj4gICNpbmNs
dWRlIDxsaW51eC9wcm9jX2ZzLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiAgCj4g
KyNkZWZpbmUgRElSTkFNRSAiZHVtbXlfaW5pdCIKPiArCj4gIHN0YXRpYyBjaGFyIHN0YXR1c1sy
MF07Cj4gIG1vZHVsZV9wYXJhbV9zdHJpbmcoc3RhdHVzLCBzdGF0dXMsIDIwLCAwNDQ0KTsKPiAg
Cj4gQEAgLTIzLDE0ICsyNSwxNCBAQCBzdGF0aWMgaW50IGR1bW15X2luaXQodm9pZCkKPiAgCWlm
ICghc3RyY21wKHN0YXR1cywgImludmFsaWQiKSkKPiAgCQlyZXR1cm4gLUVJTlZBTDsKPiAgCj4g
LQlwcm9jX2R1bW15ID0gcHJvY19ta2RpcigiZHVtbXkiLCAwKTsKPiArCXByb2NfZHVtbXkgPSBw
cm9jX21rZGlyKERJUk5BTUUsIDApOwo+ICAJcmV0dXJuIDA7Cj4gIH0KPiAgbW9kdWxlX2luaXQo
ZHVtbXlfaW5pdCk7Cj4gIAo+ICBzdGF0aWMgdm9pZCBkdW1teV9leGl0KHZvaWQpCj4gIHsKPiAt
CXJlbW92ZV9wcm9jX2VudHJ5KCJkdW1teSIsIDApOwo+ICsJcmVtb3ZlX3Byb2NfZW50cnkoRElS
TkFNRSwgMCk7Cj4gIH0KPiAgbW9kdWxlX2V4aXQoZHVtbXlfZXhpdCk7Cj4gIAo+IAoKUmVnYXJk
cywKQXZpbmVzaAoKCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
