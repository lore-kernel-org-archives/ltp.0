Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2A9C4345F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 18:01:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCF693CFA4F
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 20:01:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E08F3CFA3D
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 20:01:08 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9156D200774
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 20:01:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EBC8637366;
 Mon, 15 Apr 2024 18:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713204066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
 b=AuTufYMydkQsuiuIuRfbcR+lRR/LDyE8LJeIf56A/Pfb0P+vCYTBc1pCELpbxjSrP1os8X
 Qh+ubnhPfvbEOntNN426lRB9usrAdsYTkngr3IFzFvXS5wm7xH/7hak3DXB9/fZ9W/S0xv
 88esEDXBsSmNgHWHRDzEqRZ31z9QVAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713204066;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
 b=gn9MgtQhFkKfV8vKLwwRpJPpx1hpDAHjnoUcAoRUpxmk3ELpmAuRJ/pXscf/1SvPSR+PY4
 5VO5L6DSqqILJWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713204064;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
 b=xqQGUWUCfzS3bb/hILwYesdedKVo8HNVJYXxJ++woFoSUNDapIX9wwDxVd2AP9v0jOCl5H
 22IaHtCS6vJurcSjxnuSYrmbKhsiWUP9Pa3MwywBToTmZlKog9M0ZFaTBM0SdwUhx6yAf/
 qIFFKH1rRswe44PI2kEpGqaoVHT6LuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713204064;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DVPzuRztccGar0a2zidEjL9tL6GgmvUZi2+GCTZyfxg=;
 b=Vn8eUG2/rKRY+bxUzDQIeV6wCNbEkWJ9zBV/xBWaeAu469MPsHK/6PRj1d39I32WzNjkYy
 u3H1PRMytqQE7FBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9126A1386E;
 Mon, 15 Apr 2024 18:01:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7FyLIWBrHWarawAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Apr 2024 18:01:04 +0000
Date: Mon, 15 Apr 2024 20:00:55 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Layton <jlayton@kernel.org>
Message-ID: <20240415180055.GA557009@pevik>
References: <20240415172133.553441-1-pvorel@suse.cz>
 <7A48C70E-BAAB-4A1C-A41B-ABC30287D8B7@oracle.com>
 <d895ad115632912df228913d4a86e7f597b22599.camel@kernel.org>
 <6820832A-9F38-4DE7-8EE4-7AAC8CF06FD4@oracle.com>
 <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5052616ca4c2789ffcc51a27cbff060e2fbdb7b4.camel@kernel.org>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_EQ_ADDR_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] proc01: Whitelist
 /proc/fs/nfsd/nfsv4recoverydir
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
Cc: Neil Brown <neilb@suse.de>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Chuck Lever III <chuck.lever@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBNb24sIDIwMjQtMDQtMTUgYXQgMTc6MzcgKzAwMDAsIENodWNrIExldmVyIElJSSB3cm90
ZToKCj4gPiA+IE9uIEFwciAxNSwgMjAyNCwgYXQgMTozNeKAr1BNLCBKZWZmIExheXRvbiA8amxh
eXRvbkBrZXJuZWwub3JnPiB3cm90ZToKCj4gPiA+IE9uIE1vbiwgMjAyNC0wNC0xNSBhdCAxNzoy
NyArMDAwMCwgQ2h1Y2sgTGV2ZXIgSUlJIHdyb3RlOgoKPiA+ID4gPiA+IE9uIEFwciAxNSwgMjAy
NCwgYXQgMToyMeKAr1BNLCBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4g
PiA+ID4gL3Byb2MvZnMvbmZzZC9uZnN2NHJlY292ZXJ5ZGlyIHN0YXJ0ZWQgZnJvbSBrZXJuZWwg
Ni44IHJlcG9ydCBFSU5WQUwuCgo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8
cHZvcmVsQHN1c2UuY3o+Cj4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+IEhpLAoKPiA+ID4gPiA+IEAg
SmVmZiwgQ2h1Y2ssIE5laWwsIE5GUyBkZXZzOiBUaGUgcGF0Y2ggaXRzZWxmIHdoaXRlbGlzdCBy
ZWFkaW5nCj4gPiA+ID4gPiAvcHJvYy9mcy9uZnNkL25mc3Y0cmVjb3ZlcnlkaXIgaW4gTFRQIHRl
c3QuIEkgc3VzcGVjdCByZWFkaW5nIGZhaWxlZAo+ID4gPiA+ID4gd2l0aCBFSU5WQUwgaW4gNi44
IHdhcyBhIGRlbGliZXJhdGUgY2hhbmdlIGFuZCBleHBlY3RlZCBiZWhhdmlvciB3aGVuCj4gPiA+
ID4gPiBDT05GSUdfTkZTRF9MRUdBQ1lfQ0xJRU5UX1RSQUNLSU5HIGlzIG5vdCBzZXQ6Cgo+ID4g
PiA+IEknbSBub3Qgc3VyZSBpdCB3YXMgZGVsaWJlcmF0ZS4gVGhpcyBzZWVtcyBsaWtlIGEgYmVo
YXZpb3IKPiA+ID4gPiByZWdyZXNzaW9uLiBKZWZmPwoKCj4gPiA+IEkgZG9uJ3QgdGhpbmsgSSBp
bnRlbmRlZCB0byBtYWtlIGl0IHJldHVybiAtRUlOVkFMLiBJIGd1ZXNzIHRoYXQncyB3aGF0Cj4g
PiA+IGhhcHBlbnMgd2hlbiB0aGVyZSBpcyBubyBlbnRyeSBmb3IgaXQgaW4gdGhlIHdyaXRlX29w
IGFycmF5LgoKPiA+ID4gV2l0aCBDT05GSUdfTkZTRF9MRUdBQ1lfQ0xJRU5UX1RSQUNLSU5HIGRp
c2FibGVkLCB0aGF0IGZpbGUgaGFzIG5vCj4gPiA+IG1lYW5pbmcgb3IgdmFsdWUgYXQgYWxsIGFu
eW1vcmUuIE1heWJlIHdlIHNob3VsZCBqdXN0IHJlbW92ZSB0aGUgZGVudHJ5Cj4gPiA+IGFsdG9n
ZXRoZXIgd2hlbiBDT05GSUdfTkZTRF9MRUdBQ1lfQ0xJRU5UX1RSQUNLSU5HIGlzIGRpc2FibGVk
PwoKPiA+IE15IHVuZGVyc3RhbmRpbmcgb2YgdGhlIHJ1bGVzIGFib3V0IG1vZGlmeWluZyB0aGlz
IHBhcnQgb2YKPiA+IHRoZSBrZXJuZWwtdXNlciBpbnRlcmZhY2UgaXMgdGhhdCB0aGUgZmlsZSBo
YXMgdG8gc3RheSwgZXZlbgo+ID4gdGhvdWdoIGl0J3Mgbm93IGEgbm8tb3AuCgpGaXJzdCwgdGhh
bmtzIGEgbG90IGZvciBoYW5kbGluZyB0aGlzLgoKPiBEb2VzIGl0PyBXaGVyZSBhcmUgdGhlc2Ug
cnVsZXMgd3JpdHRlbj8gCgpJIHdvbmRlciBteXNlbGYgYXMgd2VsbC4KCj4gV2hhdCBzaG91bGQg
d2UgaGF2ZSBpdCBkbyBub3cgd2hlbiByZWFkIGFuZCB3cml0dGVuPyBNYXliZSBFT1BOT1RTVVBQ
Cj4gd291bGQgYmUgYmV0dGVyLCBpZiB3ZSBjYW4gbWFrZSBpdCBqdXN0IHJldHVybiBhbiBlcnJv
cj8KCkZZSSBjdXJyZW50IGV4Y2VwdGlvbnMgb24gL3Byb2MgZmlsZXMgaW4gd2hvbGUga2VybmVs
IGhhdmUgdmFyaW91cyBlcnJub3MsIGUuZy4KRUlOVkFMLCBFT1BOT1RTVVBQOgpodHRwczovL2dp
dGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci90ZXN0Y2FzZXMva2Vy
bmVsL2ZzL3Byb2MvcHJvYzAxLmMjTDgxCgpLaW5kIHJlZ2FyZHMsClBldHIKCj4gV2UgY291bGQg
YWxzbyBtYWtlIGl0IGp1c3QgZGlzY2FyZCB3cml0dGVuIGRhdGEsIGFuZCBwcmVzZW50IGEgYmxh
bmsKPiBzdHJpbmcgd2hlbiByZWFkLiBXaGF0IGRvIHRoZSBydWxlcyBzYXkgd2UgYXJlIHJlcXVp
cmVkIHRvIGRvIGhlcmU/CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
