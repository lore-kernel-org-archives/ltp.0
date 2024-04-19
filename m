Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF61C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 09:40:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 669973CFD4A
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 11:40:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A22893CF3FC
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 11:40:40 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03720208E0D
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 11:40:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DDF6034713;
 Fri, 19 Apr 2024 09:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713519639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSaL897Hj7ZdXBzQoVEFwgNZThIAHSfOXHWHZaPN3Kw=;
 b=JUGP4OvSZrbS1JqouDOUHsLjNWpAvGCtpPJOkHdAL9Fqjwbmcf4vpnds9rlSGWlNUkEKrt
 +5weDu3EtlH4s3j59sYMZS/xj2jGYenDHbRLmr6pd4PcL4MXtHpFTaRNfbAo8624mdoqmy
 QZRiqTQg7Cg/RoujVoEP4yqwYyH6igg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713519639;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSaL897Hj7ZdXBzQoVEFwgNZThIAHSfOXHWHZaPN3Kw=;
 b=aQpNqu2OYchvNePHaklmB1SZirREIWn2fXCbvCS4uIYqlmplMs3JDazDMwGxt+/unw1stk
 C8f/trCInpOvuRCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713519637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSaL897Hj7ZdXBzQoVEFwgNZThIAHSfOXHWHZaPN3Kw=;
 b=PqaebfNwNRID5IYKzD0y914ClkXl3Kjw0dYNhOFOOgNc9Lvg+nUWd81a8FhgYQCG+D2IZA
 DPA81OC9alF55x3OMWSW+CBUUPuhBi4FfzC8pMvm+pgwC+S9MgPw5xf4/erqi6leVZfnxz
 7aas4iUpuXCps/0Pmbm5Kwh/cea9cww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713519637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XSaL897Hj7ZdXBzQoVEFwgNZThIAHSfOXHWHZaPN3Kw=;
 b=k391k7Vj0cj07dgrce90zxC2H7h6QykPDaa0bYkFKGBoOQnYLn5QBJ3eGZIH+RdpilHYKI
 tGceIO/GZVdtMMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0D3A1398B;
 Fri, 19 Apr 2024 09:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qDT5LBU8ImY2BQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 09:40:37 +0000
Date: Fri, 19 Apr 2024 11:40:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240419094027.GA149169@pevik>
References: <20240418185210.132137-1-pvorel@suse.cz>
 <20240418185210.132137-2-pvorel@suse.cz>
 <CAEemH2dw83UCUg7tXnVuKqwDZtFfc8zEWq=SvLuRtzcA_4AV=w@mail.gmail.com>
 <CAEemH2fr5+L0UK4McWf7Aos9TciME7wHMQmVujNX8xQtZYUsqQ@mail.gmail.com>
 <20240419061206.GA143961@pevik>
 <CAEemH2fOvSCmnQfS2+w_mWxm6cxMy_-EVjT0-c6WL_w6krNF4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fOvSCmnQfS2+w_mWxm6cxMy_-EVjT0-c6WL_w6krNF4Q@mail.gmail.com>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] libswap: Add {SAFE_,
 }MAKE_MINIMAL_SWAPFILE() macros
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

PiBPbiBGcmksIEFwciAxOSwgMjAyNCBhdCAyOjEy4oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+ID4gT24gRnJpLCBBcHIgMTksIDIwMjQgYXQgOTo1MOKAr0FNIExp
IFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKCj4gPiA+ID4gSGkgUGV0ciwgQ3lyaWws
Cgo+ID4gPiA+IFRoZSBwYXRjaHNldCBnZW5lcmFsbHkgbG9va3MgZ29vZC4KCj4gPiA+ID4gQnV0
IEkgaGF2ZSBhIGNvbmNlcm4gYWJvdXQgdGhlIG1hY3JvIG5hbWUgIk1JTklNQUwiIHdvcmQsCj4g
PiA+ID4gd2hpY2ggbWlzbGVkIHBlb3BsZSB0byB0aGluayB0aGF0IGlzIHRoZSBtaW5pbWFsIHN3
YXBmaWxlIHNpemUgd2UKPiA+ID4gPiBjYW4gbWFrZSBvbiB0aGUgc3lzdGVtLCBidXQgb2J2aW91
c2x5IGl0IGlzIG5vdCwgd2UgY291bGQgZXZlbgo+ID4gPiA+IGNyZWF0ZSBhIHNtYWxsZXIgb25l
LCByaWdodD8KCj4gPiA+ID4gQ2FuIHdlIHJlbmFtZSBpdCB3aXRoIGEgYmV0dGVyIG9uZT8KCgo+
ID4gPiBXaGF0IGFib3V0IE1BS0VfREVGQVVMVF9TV0FQRklMRSwgb3IgTUFLRV9URVNUX1NXQVBG
SUxFPwoKPiA+IEkgd2FudCB0byBzb21laG93IGV4cHJlc3MgdGhhdCBpdCdzIGEgcmVhbGx5IHNt
YWxsIHN3YXAgZmlsZQo+ID4gKGFsdGhvdWdoIHN1cmUsIG5vdCBtaW5pbWFsKS4gU3VyZSwgaXQg
Y2FuIGJlICJkZWZhdWx0IiBvciAidGVzdCIsCj4gPiBidXQgaXQgZG9lcyBub3Qgc2F5IGFueXRo
aW5nIGFib3V0IHRoZSBzaXplLgoKCj4gV2h5IGRvIHdlIGhhdmUgdG8gZW1waGFzaXplIHRoZSAi
c21hbGwiIHN3YXAgZmlsZT8KClRvIG1ha2Ugb2J2aW91cyBvbiBhIGZpcnN0IGxvb2sgdGhhdCB3
ZSBhcmUgdGVzdGluZyBzb21ldGhpbmcgd2hpY2ggaXMgbm90CnR5cGljYWwgdXNlIGNhc2UgKHdo
byBjcmVhdGVzIDFNQiBzd2FwIGZpbGUgaW4gcmVhbGl0eT8pLgoKV2UgaGF2ZSA1IHN3YXAgdGVz
dHM6IDJ4IG5vdCB0aGF0IGJpZyBidXQgaXQgY291bGQgYmUgcmVhbCBzd2FwIHVzYWdlICg2NTUz
NgpibG9ja3MgfiAyNjIgTUIgd2hlbiA0a2IgYW5kIDEyOCBNQikgYW5kIHRoZSByZXN0IGlzIDV4
IHRoYXQgMTAgYmxvY2tzLCB3aGljaAp3b3VsZCBiZSBub3cgY2hhbmdlZCAxIE1CLiBUaGVyZWZv
cmUgbW9zdCBvZiB0aGVtIGFyZSBzbWFsbCwgbm90IHJlYWxseQpyZWFsaXN0aWMgc2l6ZS4gVGhl
cmVmb3JlIGl0J2QgYmUgZ29vZCB0byBtYWtlIGl0IG9idmlvdXMgYWxyZWFkeSBmcm9tIHRoZSB0
ZXN0CnNvdXJjZS4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiBJZiB3ZSBjaG9vc2UgdG8gdXNlIG9m
ICJkZWZhdWx0IiAxTUIgZm9yIExUUCB0ZXN0IGJ1dCBub3QKPiBleHBsaWNpdGx5IGRlY2xhcmFu
dCBpbiB0aGUgbmFtZSwgdGhhdCdzIG9rYXksIHBlb3BsZSBjYW4KPiBjaGVjayB0aGUgZGVmaW5l
ZCB2YWx1ZSBpZiB0aGV5IGFyZSBpbnRlcmVzdGVkLgoKCgoKPiA+IEtpbmQgcmVnYXJkcywKPiA+
IFBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
