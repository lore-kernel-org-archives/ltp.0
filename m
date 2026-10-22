Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAA5606A31A
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 08:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lhDuTrrk;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=MSFxgUHS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HpABZqeA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8I+OyfwL
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 708F33D23D7
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 10:54:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95D923CFE78
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 10:52:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 542F01400DF5
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 10:52:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D46E7220B6;
 Thu, 22 Oct 2026 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792659141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8sgGNmu0H15X0x+56o35aA4wFsxcQDHDu3tyk4HjC0=;
 b=lhDuTrrk/Vgdp55jbJMKQUjn1XVgnvzkS3UxSc92dTp2d+iql03dxPLz+QVqcJwZ6paEsS
 TdYjTRc2yiIagOPuJD0tz862TlLQ1dufJKIN/qsPtHLl19o6ldyDkRf8qz4LB45HQbyxJ6
 WyXgfbJ9IVZ411AUnMF8ZyE0hpK4Las=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792659141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8sgGNmu0H15X0x+56o35aA4wFsxcQDHDu3tyk4HjC0=;
 b=MSFxgUHSt3DA+uUy/hzDB0Jb8kocWJfrqYvAQzuRtvWRo/z7NaKl2CoFlmGpsevk0Of3rA
 /zv9FvvDN1fOKoBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792659139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8sgGNmu0H15X0x+56o35aA4wFsxcQDHDu3tyk4HjC0=;
 b=HpABZqeAfayQBjZPTeQtgsE4zWKGmLh2cr1A8nseHSZDX2JNQKD0qsUantHuKWJjehIv1e
 KBLE3+BHlfz2qpdixrnNLhJBB4sWinJW9VuQM+QSM0Arh4IyXf7tORywcwo5scixiXDqcv
 GUG4r90kjl3jd++D2/0HWE4aFpSJ+RU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792659139;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8sgGNmu0H15X0x+56o35aA4wFsxcQDHDu3tyk4HjC0=;
 b=8I+OyfwLhwtPjhxQ99Pb6mIzHbWOkeUj5+/7+Sg4gS+CL2akkMDV1heTPItnBwQ9UtzfzW
 BLikGPq+i+8bStAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F29134E6;
 Thu, 22 Oct 2026 08:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cSNhG8PO2WrwQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Oct 2026 08:52:19 +0000
Date: Thu, 22 Oct 2026 10:52:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>, LTP List <ltp@lists.linux.it>
Message-ID: <20261022085218.GA317756@pevik>
References: <as2dZ8VBuN2NM3TZ@linux.dev>
 <4EkJ88xMyWBqTKeQ8KRctlqrIv8JfY4VYo5D@localhost.localdomain>
 <athrEiFc8i3Tf-3G@yuki.lan> <20261021120751.GA265579@pevik>
 <atltORji4cZMrRs3@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atltORji4cZMrRs3@linux.dev>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgYWxsLAoKWyBDYyBKYW4gXQoKPiA+ID4gSGkhCj4gPiA+ID4gPiA+IHdoYXQgYWJvdXQgc2No
ZWR1bGluZyBhIG5ldyBMVFAgbWVldGluZyBhZnRlciB0aGUgcmVsZWFzZT8KPiA+ID4gPiA+ID4g
V2hlbidzIHlvdXIgZmlyc3QgYXZhaWxhYmxlIGRhdGU/Cgo+ID4gPiA+ID4gU291bmRzIGdvb2Qu
Cgo+ID4gPiA+ID4gTXkgYXZhaWxhYmlsaXR5IGlzIG9uIHdlZWtkYXlzLCA04oCTNiBQTSBCZWlq
aW5nIHRpbWUgKFVUQys4KSwgd2hpY2gKPiA+ID4gPiA+IHNob3VsZCBiZSA54oCTMTEgQU0gQ0VU
LiAKCj4gPiBATGkgZG8geW91IGhhdmUgdGltZSBvbmx5IG9uIHdlZWtlbmRzPyBJJ20gcXVpdGUg
YnVzeSBvbiB3ZWVrZW5kcyBhbHJlYWR5LgoKPiBObywgSSBtZWFudCBNb25kYXkgdG8gRnJpZGF5
LCBub3Qgd2Vla2VuZHMuIDopCgoKPiA+ID4gPiA+IEl0IG1pZ2h0IGJlIGJldHRlciB0byBzaGFy
ZSBhbiBhZ2VuZGEgb3IgZGlzY3VzcyB0aGUgdG9waWNzIGJlZm9yZWhhbmQuCgo+ID4gPiA+IHNv
cnJ5IGZvciBteSBkZWxheSwgY3JhenkgdGltZXMuCgo+ID4gPiA+IEkgd291bGQgbGlrZSB0byBo
YXZlIGEgTFRQIG1lZXRpbmcsIGlmIHlvdSB3YW50IHdlIGNhbiBkbyBpdCBhdCAxMGFtIHRoZSBu
ZXh0Cj4gPiA+ID4gd2VlayBpZiB3ZWRuZXNkYXkgYXJlIHRoZSBvbmx5IG9wdGlvbi4KCj4gPiA+
ID4gQFBldHIgQEN5cmlsIFdEWVQ/Cgo+ID4gPiBXZWRuZXNkYXkgMjguIE9jdCBpcyBiYW5rIGhv
bGxpZGF5IGluIEN6ZWNoIHJlcHVibGljLCBhbiBpbmRlcGVuZGVuY2UgZGF5LgoKPiA+ICsxCgo+
ID4gSWYgaXQgbmVlZHMgdG8gYmUgV2VkbmVzZGF5LCB0aGVuIG5leHQgb25lIDR0aCBPY3QgZnJv
bSAxMCB3b3VsZCB3b3JrIGZvciBtZS4KCj4gSSBndWVzcyB5b3UgbWVhbiA0dGggTm92LiBPZiBj
b3Vyc2UsIHRoYXQncyBmaW5lIHdpdGggbWUuCgpBaCwgSSdtIHNvcnJ5LCB5ZXMgNHRoIE5vdi4K
Cj4gPiBPciB3ZSBjYW4gdHJ5IHRvIGZpbmQgYW5vdGhlciBkYXkgbmV4dCB3ZWVrICgyNnRoLTMw
dGggU2VwKSwgZS5nLiBUdWUgMjd0aCBmcm9tCj4gPiAxMS4wMCBhbSB3b3VsZCB3b3JrIGZvciBt
ZSAobWVldGluZyBmcm9tIDExLjAwIHNoaWZ0ZWQgdG8gMTAuMDApLgoKPiBJIHZvdGUgdG8gMTBh
bSBDRVQuCgorMQoKRGVwZW5kcyBpZiB0aGF0J3Mgb2sgZm9yIEN5cmlsIGFuZCBBbmRyZWEgYXQg
bGVhc3QuCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
