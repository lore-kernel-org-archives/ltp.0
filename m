Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CAB5C3DA6E
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 11:50:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E08583CE771
	for <ltp@archiver.kernel.org>; Wed,  3 Jan 2024 12:50:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73F203CB5F0
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 12:50:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65CDB200C01
 for <ltp@lists.linux.it>; Wed,  3 Jan 2024 12:50:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A2631FD11;
 Wed,  3 Jan 2024 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704282603;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
 b=lxh76lr9a6cbz3B6qoyE8LPDLwWWQF1FeaeqZtfPa/v5e6hKcT1b41M7ERVBjkC/xW5t+r
 4PtniK6PAw1bQ0db6TZzy63bS9Xy3ljX3Bv8tYmBzteLBuXl69jIDgXZrgOuDOwqbgy7g/
 ZpeFoPPMW1U6qu9iyy8bt74Z3LIk5Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704282603;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
 b=NJsmI7frp5883kcBjR9Ni4dpvu/+KpdWksbvv1Sb9NSv14BCefu6tmpAky9P06OONciofG
 3TywemivWGyh+vCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704282603;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
 b=lxh76lr9a6cbz3B6qoyE8LPDLwWWQF1FeaeqZtfPa/v5e6hKcT1b41M7ERVBjkC/xW5t+r
 4PtniK6PAw1bQ0db6TZzy63bS9Xy3ljX3Bv8tYmBzteLBuXl69jIDgXZrgOuDOwqbgy7g/
 ZpeFoPPMW1U6qu9iyy8bt74Z3LIk5Ho=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704282603;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4Zgez0zMWtIyb5Ng80nLKb/YRtWuLRDBmlGiyWt1MzQ=;
 b=NJsmI7frp5883kcBjR9Ni4dpvu/+KpdWksbvv1Sb9NSv14BCefu6tmpAky9P06OONciofG
 3TywemivWGyh+vCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C665C13AA6;
 Wed,  3 Jan 2024 11:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /EQSL+pJlWU9GAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 03 Jan 2024 11:50:02 +0000
Date: Wed, 3 Jan 2024 12:49:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Message-ID: <20240103114957.GD1073466@pevik>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
X-Spamd-Result: default: False [0.55 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[15];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.15)[68.61%]
Authentication-Results: smtp-out2.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 00/36] Remove UCLINUX from LTP
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
Cc: Jonathan Corbet <corbet@lwn.net>, Linux-sh list <linux-sh@vger.kernel.org>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Greg Ungerer <gerg@linux-m68k.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgR2VlcnQsCgo+IEhpIFBldHIsCgo+IENDIG90aGVyIHVDbGludXggYXJjaCBsaXN0cwoKPiBP
biBXZWQsIEphbiAzLCAyMDI0IGF0IDI6NTLigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5j
ej4gd3JvdGU6Cj4gPiBVQ0xJTlVYIGlzIGJyb2tlbiBpbiBMVFAgYW5kIG5vYm9keSByZWFsbHkg
Y2FyZXMuIEFjdHVhbGx5IEkgZGFyZSB0bwo+ID4gc2F5IFVDTElOVVggaXMgZGVhZC4gVGhlcmVm
b3JlIEkgcHJlcGFyZWQgcGF0Y2hzZXQgdG8gcmVtb3ZlIFVDTElOVVgKPiA+IGZyb20gTFRQLiBX
ZSBoYXZlIGJlZW4gYWN0aXZlbHkgcmVtb3ZpbmcgVUNMSU5VWCBmcm9tIExUUCBkdXJpbmcgcmV3
cml0ZQo+ID4gdGVzdHMgdG8gbmV3IExUUCBBUEkuIFRoaXMgcmVtb3ZlcyB0aGUgcmVzdCBmcm9t
IHRoZSBvbGQgdGVzdHMgKHdoaWNoCj4gPiB3aWxsIGJlIHNvb25lciBvciBsYXRlciByZXdyaXR0
ZW4gdG8gbmV3IEFQSSkuCgo+ID4gQmVjYXVzZSB0aGUgcGF0Y2hzZXQgaXMgcXVpdGUgYmlnLCBJ
IGRpZCBub3Qgd2FudCB0byBzZW5kIGl0IHRvIG1haWxpbmcKPiA+IGxpc3RzIChidXQgSSBjYW4g
ZG8gaXQgaWYgeW91IHdhbnQpLgoKPiA+IENhbiB5b3UgcGxlYXNlIGhhdmUgbG9vayBhdCBteSBm
b3JrIG9uIGdpdGxhYiwgYnJhbmNoOiByZW1vdmUtVUNMSU5VWAo+ID4gaHR0cHM6Ly9naXRsYWIu
Y29tL3BldmlrL2x0cC8tL2NvbW1pdHMvcmVtb3ZlLVVDTElOVVg/cmVmX3R5cGU9aGVhZHMKCj4g
PiBCdWlsZCB0ZXN0Ogo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9hY3Rpb25zL3J1
bnMvNzM5MjQ3MDIxNQoKPiBUaGFua3MgZm9yIHlvdXIgc2VyaWVzIQoKVGhhbmsgeW91IGZvciB5
b3VyIGZlZWRiYWNrLiAgTWF5IEkgYWRkIHlvdXIgQWNrZWQtYnk6IHRhZyB0byB0aGUgc2VyaWVz
IHdoZW4gd2UKYWdyZWUgdG8gbWVyZ2U/Cgo+IEkgc2VlIHlvdSBvbmx5IENDZWQgbGludXgtbTY4
aywgYnV0IEFGQUlLLCB1Q2xpbnV4IGlzIG5vdCByZXN0cmljdGVkCj4gdG8gbTY4ay9jb2xkZmly
ZSwgYnV0IGFsc28gYXZhaWxhYmxlIG9uIGFybTMyLCByaXNjdiwgc2gsIGFuZCB4dGVuc2EuCgpH
b29kIHBvaW50LCBJJ2xsIHJlcGx5IHRvIHRoZWlyIGxpc3RzIGFzIHdlbGwuCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCj4gR3J7b2V0amUsZWV0aW5nfXMsCgo+ICAgICAgICAgICAgICAgICAgICAgICAg
IEdlZXJ0CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
