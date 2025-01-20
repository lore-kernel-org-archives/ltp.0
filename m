Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512DDC02185
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 09:12:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1DB73C18AB
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 10:12:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9149A3C1812
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 10:11:56 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 16EB4600046
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 10:11:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 986CF2116D;
 Mon, 20 Jan 2025 09:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737364314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPls2FAr0wGhTPUwEsgQqvhY7cC8kEohs8lPZOI9q14=;
 b=kNvmEWRS3JEprLFUjyI0Dp+/8wiM+VDMHjVm0wnaX5sPwa/Az9S6UMNjeUZ6wdNZXSP1KY
 uvLTrijQQrFNE0PAhaDRNdzK8SKbU1wQHAEeJ9tPIfA5JGhJx47gc8d4MwOkQiLvuEar2F
 ui+H4j7rC3yeaZ7UBoGYm3qswjjIgWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737364314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPls2FAr0wGhTPUwEsgQqvhY7cC8kEohs8lPZOI9q14=;
 b=42Gg0P0hqIjjc3/tyzp8ZOJVqL7f5+OgUMTnPUNrU/Cot9d/kQUB88HxEwxe1saVzL8tIJ
 Gf7BwCqK+pf2pfAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kNvmEWRS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=42Gg0P0h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737364314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPls2FAr0wGhTPUwEsgQqvhY7cC8kEohs8lPZOI9q14=;
 b=kNvmEWRS3JEprLFUjyI0Dp+/8wiM+VDMHjVm0wnaX5sPwa/Az9S6UMNjeUZ6wdNZXSP1KY
 uvLTrijQQrFNE0PAhaDRNdzK8SKbU1wQHAEeJ9tPIfA5JGhJx47gc8d4MwOkQiLvuEar2F
 ui+H4j7rC3yeaZ7UBoGYm3qswjjIgWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737364314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPls2FAr0wGhTPUwEsgQqvhY7cC8kEohs8lPZOI9q14=;
 b=42Gg0P0hqIjjc3/tyzp8ZOJVqL7f5+OgUMTnPUNrU/Cot9d/kQUB88HxEwxe1saVzL8tIJ
 Gf7BwCqK+pf2pfAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21ECE1393E;
 Mon, 20 Jan 2025 09:11:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pCWHBVoTjmdoeQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 09:11:54 +0000
Date: Mon, 20 Jan 2025 10:11:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>,
 ltp@lists.linux.it, Avinesh Kumar <akumar@suse.de>,
 Martin Doucha <martin.doucha@suse.com>, Jan Stancek <jstancek@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250120091137.GC794282@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250120090740.GB794282@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250120090740.GB794282@pevik>
X-Rspamd-Queue-Id: 986CF2116D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] pidns05 timeout (was: [PATCH 1/2] lib:
 multiply the timeout if detect slow kconfigs)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiA+IE9uIFRodSwgSmFuIDE2LCAyMDI1IGF0IDY6NDLigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cgo+ID4gPiBIaSBMaSwgQ3lyaWwsIGFsbCwKCj4gPiA+IC4uLgo+ID4g
PiA+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4gPiA+ID4gQEAgLTU1NSw5ICs1NTUsNiBAQCBzdGF0
aWMgaW50IG11bHRpcGx5X3J1bnRpbWUoaW50IG1heF9ydW50aW1lKQoKPiA+ID4gPiAgICAgICBw
YXJzZV9tdWwoJnJ1bnRpbWVfbXVsLCAiTFRQX1JVTlRJTUVfTVVMIiwgMC4wMDk5LCAxMDApOwoK
PiA+ID4gPiAtICAgICBpZiAodHN0X2hhc19zbG93X2tjb25maWcoKSkKPiA+ID4gPiAtICAgICAg
ICAgICAgIG1heF9ydW50aW1lICo9IDQ7Cj4gPiA+ID4gLQo+ID4gPiA+ICAgICAgIHJldHVybiBt
YXhfcnVudGltZSAqIHJ1bnRpbWVfbXVsOwo+ID4gPiA+ICB9Cgo+ID4gPiA+IEBAIC0xNzA2LDYg
KzE3MDMsOSBAQCB1bnNpZ25lZCBpbnQgdHN0X211bHRpcGx5X3RpbWVvdXQodW5zaWduZWQgaW50
Cj4gPiA+IHRpbWVvdXQpCj4gPiA+ID4gICAgICAgaWYgKHRpbWVvdXQgPCAxKQo+ID4gPiA+ICAg
ICAgICAgICAgICAgdHN0X2JyayhUQlJPSywgInRpbWVvdXQgbXVzdCB0byBiZSA+PSAxISAoJWQp
IiwgdGltZW91dCk7Cgo+ID4gPiA+ICsgICAgIGlmICh0c3RfaGFzX3Nsb3dfa2NvbmZpZygpKQo+
ID4gPiA+ICsgICAgICAgICAgICAgdGltZW91dCAqPSA0OwoKPiA+ID4gRllJIHRoaXMgY2hhbmdl
LCBtZXJnZWQgYXMgODkzY2EwYWJlNyAoImxpYjogbXVsdGlwbHkgdGhlIHRpbWVvdXQgaWYKPiA+
ID4gZGV0ZWN0IHNsb3cKPiA+ID4ga2NvbmZpZ3MiKSBjYXVzZWQgYSByZWdyZXNzaW9uIG9uICph
bGwqIHRlc3RzIHdoaWNoIHVzZSB0c3RfbmV0LnNoLgo+IC4uLgoKPiBGWUkgYWxzbyBhdCBsZWFz
dCBwaWRuczA1LmMgc29tZXRpbWVzIGZhaWxzIGR1ZSB0aW1lb3V0IHdpdGggdGhpcyBjaGFuZ2Uu
Cj4gT24gc29tZSBvZiBTTEVTIHByb2R1Y3QgcHJldmlvdXNseSBwaWRuczA1LmMgcnVuIGZvciAz
IHNlYy4gV2l0aCB0aGlzIGNoYW5nZSBpdAo+IHJ1bnMgMTJzIGFuZCB0aGVyZWZvcmUgdGltZW91
dHMuCgpJJ20gc29ycnkgZm9yIGEgd3JvbmcgcmVwb3J0LiBMb29raW5nIGFib3V0IGl0IHR3aWNl
IHRoZXJlIGlzICIqKiogc3RhY2sKc21hc2hpbmcgZGV0ZWN0ZWQgKioqOiB0ZXJtaW5hdGVkIiA9
PiBzb21lIG90aGVyIHByb2JsZW0sIHdoaWNoIGNhdXNlcyBzbG93CmRvd24uIElNSE8gaXQncyBu
b3Qgb3B0aW1hbCB0byBydW4gdGhlIGRldGVjdGlvbiBtYW55IHRpbWVzICsgYmFzaWNhbGx5IG5v
dwpyZXF1aXJpbmcga2VybmVsIGNvbmZpZyBmb3IgZWFjaCBMVFAgdGVzdCwgYnV0IHBlcmZvcm1h
bmNlIGltcGFjdCBpcyBwcm9iYWJseQpsb3cuCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gSW4gcGlk
bnMwNS5jIGNhc2UgY2hpbGQgaXMgcnVuIDV4LiBGb3IgZWFjaCBvZiB0aGlzIGNoaWxkIHdlIGFn
YWluIGRldGVjdCBpZiB3ZQo+IHJ1biBvbiBzbG93IGNvbmZpZy4gTWF5YmUgd2Ugc2hvdWxkIGhh
dmUgdXNlZCBzdHJ1Y3QgdHN0X3Rlc3QgbWVtYmVyIHRvIGNhY2hlCj4gdGhlIHZhbHVlLgoKPiBX
aGF0IGJvdGhlcnMgbWUgbW9yZSB0aGF0IGhvdyBtdWNoIHRpbWUgd2Ugd2FzdGUgZm9yIHdob2xl
IExUUCB0ZXN0aW5nIHdpdGgKPiByZXBlYXRlZGx5IGRldGVjdGluZyBzbG93IGNvbmZpZyBmb3Ig
YWxsIHRlc3RzIChydW50ZXN0L3N5c2NhbGxzIGhhcyAxNDU3IGl0ZW1zLAo+IHdlIHJ1biBpdCBt
b3JlIHRpbWVzIGZvciBlYWNoIHByb2R1Y3Qgd2l0aCBkaWZmZXJlbnQga2VybmVsIGNtZGxpbmUg
cGFyYW1ldGVycykuCj4gSSBkb24ndCBrbm93IHdoYXQgd2FzIHN1cHBvc2VkIHRvIGJlIGZpeGVk
IGJ5IHRoaXMgZmVhdHVyZSwgaXMgaXQgcmVhbGx5IHdvcnRoCj4gb2Ygc2xvd2Rvd24/IFdoeSBu
b3QganVzdCBzZXQgTFRQX1JVTlRJTUVfTVVMPTIgb24gc2xvdyBrZXJuZWxzPyBXZSBjb3VsZCBo
YXZlCj4gdG9vbCB3aGljaCB3b3VsZCAnZXhpdCAxJyBvbiAic2xvdyIga2VybmVsIGFuZCAnZXhp
dCAwJyBvbiBub3JtYWwga2VybmVsIHRvIGRvCj4gYXV0b21hdGljIGRldGVjdGlvbiwgd2hpY2gg
Y291bGQgYmUgcnVuIGJ5IGZyYW1ld29ya3MganVzdCBvbmNlLgoKPiBLaW5kIHJlZ2FyZHMsCj4g
UGV0cgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
