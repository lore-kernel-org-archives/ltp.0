Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E30CA0ED3
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 10:08:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3BEDA3C1CB9
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 12:08:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F0EF3C0BA7
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 12:08:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4E77E10004A0
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 12:08:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D2A04219AF;
 Wed,  4 Sep 2024 10:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725444483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH+dkpR8M3p1YMmQdJJtB+9mEgzsx8YVofqKVr2i65c=;
 b=UIQIoInuawVRdiXE1D2duLCrSvxfvMc/yYM3rzWWXYAKKUDezqRHNg/itNOI+d3EHq9bXb
 nMP/+aTr/Qlu9pLA55c33m3npw06BLMbP5rtt7lWa0RwXNOo+y3nLP7NLNGHWiC6EQsWTx
 oF9drhujouSXKsFzjxydmsP19OZGmu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725444483;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH+dkpR8M3p1YMmQdJJtB+9mEgzsx8YVofqKVr2i65c=;
 b=Pxo8Mrr1ozSUsfHncdFlz1avMF5uAL27BC+K0gwbEoFjdlmmd5bOLD0/nH43DjzDGN2oV1
 4XOp8XyhcwYEkPAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1725444482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH+dkpR8M3p1YMmQdJJtB+9mEgzsx8YVofqKVr2i65c=;
 b=o3zWgQAl7x2Dxy6l5rsOcvJS4TkdhrXc1rYG107R3llQjjFO4eCpvd1AVomomn13Nkb1ou
 zRYKSFfTysGY1SdqD/rJbYb8AdtUJLpiDVyr1+ilif75w88rIqNc8CLhDEnDPMzczZIFhV
 y0DEZXj7tjOvaLJKVtyW4zT9P2rqUA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1725444482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH+dkpR8M3p1YMmQdJJtB+9mEgzsx8YVofqKVr2i65c=;
 b=RSoIcByExzISJCdp8UOwVBLP/zALxvol1NKSLn0iMmMa4g3Gw1kjP7c6uQ1dQvYuI8w5vH
 qr5d8LZ5ixGnuUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B414B139D2;
 Wed,  4 Sep 2024 10:08:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rb36KoIx2GaOIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Sep 2024 10:08:02 +0000
Date: Wed, 4 Sep 2024 12:07:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240904100753.GB849136@pevik>
References: <20240903140326.773060-1-pvorel@suse.cz>
 <ZtcoDmsWrMu8Qaze@yuki.lan> <20240904053157.GA836933@pevik>
 <Ztgfu4bTVyw7hvdP@yuki.lan>
 <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
 <CAEemH2cg=mk7XzwZj+oYOM5BRzjewE9vHVMnDnX+UmQ4YZTT_g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cg=mk7XzwZj+oYOM5BRzjewE9vHVMnDnX+UmQ4YZTT_g@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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

PiBPbiBXZWQsIFNlcCA0LCAyMDI0IGF0IDU6MjbigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cgo+ID4gT24gV2VkLCBTZXAgNCwgMjAyNCBhdCA0OjUz4oCvUE0gQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgoKPiA+ID4gSGkhCj4gPiA+ID4gPiBTbyB5
ZXMgaXQgbG9va3MgbGlrZSB0aGUgYWN0dWFsIHRlc3QgbmVlZHMgc29tZSBydW50aW1lIGRlZmlu
ZWQsCj4gPiA+ID4gPiBhbHRob3VnaCBJJ20gbm90IHN1cmUgaG93IGxvbmcgaXQgc2hvdWxkIGJl
LiBXZSBwcm9iYWJseSBuZWVkIGEKPiA+ID4gPiA+IHJlZmVyZW5jZSBtYWNoaW5lIHRvIGNhbGxp
YnJhdGUgdGhpcyBvbi4gSSB3b3VsZCBhdm9pZCBhbnkgZW11bGF0ZWQgQ1BVCj4gPiA+ID4gPiBh
bmQgY2hvb3NlIGEgcmVhbCBoYXJkd2FyZS4gSSBndWVzcyBvbmUgb2YgdGhlIFJQaXMgZS5nLiBQ
aSBaZXJvIHdvdWxkCj4gPiA+ID4gPiBiZSBhIGdvb2QgY2hvaWNlIHNpbmNlIHRoZXkgYXJlIHdp
ZGVseSBhdmFpbGFibGUgYW5kIHNsb3cgYnkgYW55IG1vZGVybgo+ID4gPiA+ID4gc3RhbmRhcmRz
LgoKUGkgWmVybyBpcyBnb29kIHRoYXQgaXQncyBzbG93IGVub3VnaCB0aGF0IGV2ZW4gZW11bGF0
ZWQgcmlzYy12IHdpbGwgd29yay4KCkJ1dCBPVE9IIG1pZ2h0IGJlIG1vcmUgcHJhY3RpY2FsIHRv
IG1lYXN1cmUgb24gUlBJNCBvciBSUEkzIChtYXliZSBtb3JlIG9mIHVzCmhhcyBSUEk0IG9yIFJQ
STMgcGVyc29uYWxseSBvciBpbiBDSSkuIEkgbWVhbiB1bmxlc3Mgb3RoZXJzIGhhdmUvd2lsbCBi
dXkgUGkKWmVybyB5b3Ugd2lsbCBiZSBmb3JjZWQgdG8gZG8gdGhlIHJlZmVyZW5jZS4gQWxzbyBQ
aSBaZXJvIGlzIHNsb3cgKHlvdSBuZWVkIHRvCmNvbXBpbGUsIHRodXMgSSB3aWxsIG5vdCBsb3Zl
IHRvIGRvIHRoZSBtZWFzdXJlbWVudHMuCgpBbHNvIGVtdWxhdGVkIHJpc2MtdiBhbmQgUGkgWmVy
byB3aWxsIGFsd2F5cyBuZWVkIHRvIHNldCBMVFBfUlVOVElNRV9NVUwsIHJpZ2h0PwpPciBkbyB3
ZSB3YW50IHRvIGRvIG1lYXN1cmVtZW50cyB0aGF0IGV2ZW4gdGhlc2Ugd2lsbCBydW4gd2l0aG91
dApMVFBfUlVOVElNRV9NVUw/IFRoYXQgd291bGQgaGVscCB1c2VycyBub3QgaGF2aW5nIHRvIGJv
dGhlciwgYnV0IGluY3JlYXNpbmcKbGltaXRzIGZvciBmYXN0IGRldmljZXMgbWlnaHQgbm90IGJl
IGEgZ29vZCBpZGVhLgoKPiA+ID4gPiBUaGlzIG1ha2VzIHNlbnNlLgoKPiA+ID4gU28gSSBkdXN0
ZWQgb2ZmIG15IFBpIFplcm8gYW5kIGluZGVlZCB0aGUgdGVzdCB0aW1lb3V0cyB0aGVyZSBhcyB3
ZWxsLgo+ID4gPiBUaGUgbnRmcyBmaWxlc3lzdGVtIHRha2VzIDc4cywgZXh0MiAyOXMsIGV4ZmF0
IDIwcy4gU28gSSB3b3VsZCBzYXkgdGhhdAoKPiA+IEknbSB3b25kZXJpbmcgd2hpY2ggZGlzdHJp
YnV0aW9uIChhbmQga2VybmVsIHZlcnNpb24pIGRpZCB5b3UgdXNlIG9uIHJhc3BpLTA/CgpZZXMs
IDc4cywgZXh0MiAyOXMsIGV4ZmF0IDIwcyBpcyBmYXN0ZXIsIGJ1dCB0aGF0J3MgZHVlIFJhc3Bi
ZXJyeSBQaSBaZXJvIHVzaW5nCmp1c3QgQnJvYWRjb20gQkNNMjgzNSBTb0MgYXMgdGhlIGZpcnN0
IGdlbmVyYXRpb24gUmFzcGJlcnJ5IFBpIFsxXSAoMzIgYml0IGFybSkuClJQSTQgdXNlcyBCcm9h
ZGNvbSBCQ00yNzExIFNvQyAoNjQtYml0IHF1YWQtY29yZSkuCgpLaW5kIHJlZ2FyZHMsClBldHIK
ClsxXSBodHRwczovL2VuLndpa2lwZWRpYS5vcmcvd2lraS9SYXNwYmVycnlfUGkjUHJvY2Vzc29y
Cgo+IEkgYXNrIHRoaXMgYmVjYXVzZSB3ZSBtaWdodCBuZWVkIHRvIGNvbnNpZGVyIHRoZSBvbGRl
c3Qgc3VwcG9ydGVkIHN5c3RlbXM6Cj4gLSBodHRwczovL2xpbnV4LXRlc3QtcHJvamVjdC5yZWFk
dGhlZG9jcy5pby9lbi9sYXRlc3QvdXNlcnMvc3VwcG9ydGVkX3N5c3RlbXMuaHRtbAoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
