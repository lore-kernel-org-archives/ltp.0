Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C353C4345F
	for <ltp@archiver.kernel.org>; Sat, 20 Apr 2024 08:55:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EBB13CFDF9
	for <ltp@archiver.kernel.org>; Sat, 20 Apr 2024 10:55:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7ADA3CE4DB
 for <ltp@lists.linux.it>; Sat, 20 Apr 2024 10:54:47 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EED636126D1
 for <ltp@lists.linux.it>; Sat, 20 Apr 2024 10:54:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A26B03819A;
 Sat, 20 Apr 2024 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713603284;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClJ+Vks2d4pRefHIr2E9ETZ8VQQC6bkGAHqmy4LhnWU=;
 b=nHt0hLb1C/9gugGCUKETpB98q5B91u4wlYobfuu5k/c9+a9woE/8v7bfAue45UUJ1yKYGM
 4IJvrm+T9f4WqHMNnL8BDqBbF9JU6Ei9mK4FrufxFplM9M04pqtwMHPLZbpyOhgTyWl3oI
 MKmlMI75opoATxZ+gGZ7Ebxf0iLEeFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713603284;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClJ+Vks2d4pRefHIr2E9ETZ8VQQC6bkGAHqmy4LhnWU=;
 b=WVqRxLFK1LZVX/QlJE0xTh7Kg7/HAJhTqRYH04QPE4fF/zHUKVSjhzyD7Lk17kbWus6ri6
 ygtoGZe6JqWZjQDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VwA92ok6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=S6g3hHXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713603283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClJ+Vks2d4pRefHIr2E9ETZ8VQQC6bkGAHqmy4LhnWU=;
 b=VwA92ok6LvqTyR7VANcFIc7kBAtqHAJplfCH4TRnPn5qd1TMMvEPmSe+bVcVicFgWTnjAc
 sDg9wheVa9yEWv+AT+KRG/kw8diZxkImD8pS1a2OSVOpiO+3TfbQgfd8tiJBKtlJhu8v//
 Q6Lve7JSt7eTFAj+02SCYgcd90r4lgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713603283;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClJ+Vks2d4pRefHIr2E9ETZ8VQQC6bkGAHqmy4LhnWU=;
 b=S6g3hHXD4uGHkGdxFYoYl+R0Ve2iW7L4UN3vuk90GXFz96XKngN4py2aC00Jj4S4NzuSUM
 P/MpkMXIrLObPnCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A4C013931;
 Sat, 20 Apr 2024 08:54:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cvzyC9OCI2Z9IAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sat, 20 Apr 2024 08:54:43 +0000
Date: Sat, 20 Apr 2024 10:54:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240420085437.GA66478@pevik>
References: <20240419110230.191809-1-pvorel@suse.cz>
 <CAEemH2eZNO=P5c_igqNKSva-q37y7GSK=d44wUHd=Ua=DTUNDw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eZNO=P5c_igqNKSva-q37y7GSK=d44wUHd=Ua=DTUNDw@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A26B03819A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libs: Remove 'libltp' prefix from libs source
 directories
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

SGkgTGksIEN5cmlsLAoKPiBIaSBQZXRyLCBDeXJpbCwKCj4gT24gRnJpLCBBcHIgMTksIDIwMjQg
YXQgNzowMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gPiBMVFAg
aW50ZXJuYWwgbGlicmFyaWVzIGFyZSBsb2NhdGVkIGluIGxpYnMvIGRpcmVjdG9yeS4gVGhlcmUg
aXMgbm8gbmVlZAo+ID4gdG8ga2VlcCAnbGlibHRwJyBwcmVmaXggaW4gdGhlaXIgb3duIGRpcmVj
dG9yaWVzLiBOT1RFOiByZXN1bHRlZAo+ID4gbGlicmFyaWVzICgqLmEpIGtlZXAgZXhwZWN0ZWQg
J2xpYmx0cCcgcHJlZml4LgoKPiA+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBz
dXNlLmN6Pgo+ID4gLS0tCj4gPiBIaSBMaSwgQ3lyaWwsCgo+ID4gSSBrbm93IHJlbmFtaW5nIGZp
bGVzIGlzIG5vdCBvcHRpbWFsLiBCdXQgaGlzdG9yeSB3aWxsIGJlIGtlcHQsIHdoZW4KPiA+IGJy
b3dzaW5nIHdpdGggZ2l0ayBvciBnaXQgZ3VpLgoKPiA+IEltcHJvdmVtZW50OiBsZXNzIHR5cGlu
ZyB3aGVuIGNkIHRvIHRoZSBkaXJlY3RvcnkuCgoKPiArMSBJIGFncmVlIHdpdGggdGhpcywgYW5k
IEkgYWx3YXlzIGhhdmUgYSBxdWVzdGlvbiwgd2h5Cj4gd2UgaGF2ZSBhZGRpdGlvbmFsIGxpYnMv
IHBhcmFsbGVsIHdpdGggbGliLywgaXMgdGhlcmUgYW55IHJvb3QKCmxpYi8gc291cmNlcyByZXN1
bHRzIGluIGxpYmx0cC5hLCB0aGUgb3RoZXJzIHJlc3VsdHMgaW4gdGhlaXIgb3duIGxpYnMuCgpB
bHRob3VnaCBsaWIvIHZzIGxpYnMvIGlzIGEgYml0IHN0cmFuZ2UsIGtlcHQgdGhlc2UgbGlicmFy
aWVzIHNlcGFyYXRlCihpLmUuIG5vIG1vdmUgbGlicy8qLyBpbnRvIGxpYi8pLCBiZWNhdXNlIHRo
ZXNlIGxpYnJhcmllcyBhcmUgYnVpbHQgb25seSB3aGVuCnRoZXkgYXJlIG5lZWRlZC4gSS5lLiBm
b3IgdGVzdGluZyByYW5kb20gdGVzdCBvbmUgZG9lcyBub3QgbmVlZCB0byB3YWl0IGZvcgpidWls
ZGluZyB0aGVzZSBhZGRpdGlvbmFsIGxpYnJhcmllcyAoYWx0aG91Z2ggYnVpbGRpbmcgdGhlbSBk
b2VzIG5vdCB0YWtlIGxvbmcsCmJ1aWxkaW5nIExUUCBtYWluIGxpYnJhcnkgYW5kIHRlc3RzIHRh
a2VzIG11Y2ggbG9uZ2VyKS4gQnV0IGlmIHdlIHdhbnQsIHdlIGNhbgptb3ZlIHRoZW0gdG8gbGli
LyAoYXMgYSBzZXBhcmF0ZSBlZmZvcnQsIGV2ZW4gdGhpcyBtaWdodCBtYWtlIHNvbWUgcGF0Y2hl
cyBpbgpNTCB1bmFwcGxpY2FibGUgd2l0aG91dCBwYXRjaCBtb2RpZmljYXRpb24pLgoKPiBkaWZm
ZXJlbmNlIGJldHdlZW4gdGhlbT8gb3IganVzdCBhIGhpc3RvcmljYWwgaXNzdWU/Cgo+IEFueXdh
eSwgdGhpcyBwYXRjaCBsb29rcyBnb29kIHRvIG1lLgoKVGhhbmtzIQoKS2luZCByZWdhcmRzLApQ
ZXRyCgo+ID4gVGVzdGVkOgo+ID4gaHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9hY3Rpb25z
L3J1bnMvODc1MjA0ODQ1MQoKPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
