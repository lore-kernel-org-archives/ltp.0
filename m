Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A790C44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:32:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60973CB4D6
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:32:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 010133CAEBB
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:32:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 48128600A86
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:32:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEA9333702;
 Thu, 22 Jan 2026 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769085121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9sfc7SctuQHLwP/h6hrOjirJ9nFG+7Yq79MuZqqkxw=;
 b=Aou+ELDKoZjMz3ztFb685bZKgIZ+Jt1TkbAwsYrXDxo1t9L2LJbP0Tl2xpp1sEEureBDw4
 lR2xE5Ch+CdY1XfHB+kO+hnuFn40Bv2lULAQbauTa/4G7/jQWjXghQg6VlMjBkXtJk2J6Z
 BYCVcgCLeEFvVz+ZaCKiXEWDMkXkJNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769085121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9sfc7SctuQHLwP/h6hrOjirJ9nFG+7Yq79MuZqqkxw=;
 b=/oP2ZgwWoF4mUepRn8icDtWoeepI23WD52R/njrmqqmu1QjnFIeaX7wQnPW56IveR1sgxt
 JLddLHXAFp2GrCBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xj5XSvyv;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bK3ykWAT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769085120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9sfc7SctuQHLwP/h6hrOjirJ9nFG+7Yq79MuZqqkxw=;
 b=xj5XSvyv6ldnUuECo8DO5ZqkKph36raR5wF32ZQQL3IBLB23FvJodbEyoKx7jLNcjWTVBJ
 LyFf6bc0bRtnTAP+Qetb7Wp6h+MsOSq2HOjYEtFVO4smPUmLfV20PffxrFuZ6UV0utFtk+
 nVTupprX1Ek7JRfKVpIGbTMLTgYt3e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769085120;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9sfc7SctuQHLwP/h6hrOjirJ9nFG+7Yq79MuZqqkxw=;
 b=bK3ykWAT6c4GaJGaGd3nBv09I60qbCz7nEjCeJCtaA2RKdKKHqEpa2hTKh4MRjFT+4tpR4
 n/p8fgxCcpx5QVAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 998C01395E;
 Thu, 22 Jan 2026 12:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id v3nuI8AYcmlcCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jan 2026 12:32:00 +0000
Date: Thu, 22 Jan 2026 13:31:54 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20260122123154.GC64562@pevik>
References: <20260122102606.87754-1-liwang@redhat.com>
 <CAASaF6w3S2STiyS9LvOsK_uVEvRoO6uq=XNMG-cMNheC0k1RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w3S2STiyS9LvOsK_uVEvRoO6uq=XNMG-cMNheC0k1RHg@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CEA9333702
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone10: add support archs
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

SGkgTGksIEphbiwKCj4gT24gVGh1LCBKYW4gMjIsIDIwMjYgYXQgMTE6MjbigK9BTSBMaSBXYW5n
IHZpYSBsdHAgPGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+ID4gU2lnbmVkLW9mZi1ieTog
TGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gPiAtLS0KPiA+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2Nsb25lL2Nsb25lMTAuYyB8IDYgKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQs
IDYgaW5zZXJ0aW9ucygrKQoKPiA+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Nsb25lL2Nsb25lMTAuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xv
bmUxMC5jCj4gPiBpbmRleCBhNTJhYzM1NjguLjlmZmI0OWMzNyAxMDA2NDQKPiA+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUxMC5jCj4gPiArKysgYi90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL2Nsb25lL2Nsb25lMTAuYwo+ID4gQEAgLTkxLDQgKzkxLDEwIEBA
IHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAgICAgICAgLmNsZWFudXAgPSBj
bGVhbnVwLAo+ID4gICAgICAgICAubmVlZHNfY2hlY2twb2ludHMgPSAxLAo+ID4gICAgICAgICAu
dGVzdF9hbGwgPSB2ZXJpZnlfdGxzLAo+ID4gKyAgICAgICAuc3VwcG9ydGVkX2FyY2hzID0gKGNv
bnN0IGNoYXIgKmNvbnN0IFtdKSB7Cj4gPiArICAgICAgICAgICAgICAgIng4Nl82NCIsCj4gPiAr
ICAgICAgICAgICAgICAgImFhcmNoNjQiLAo+ID4gKyAgICAgICAgICAgICAgICJzMzkweCIsCj4g
PiArICAgICAgICAgICAgICAgTlVMTAo+ID4gKyAgICAgICB9Cj4gPiAgfTsKCj4gQWNrZWQtYnk6
IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoKTEdUTS4gSW5kZWVkIG9ubHkgdGhl
c2UgMyBhcmNocyBkb24ndCBUQ09ORi4KQWNrZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PgoKT3V0IG9mIGN1cmlvc2l0eSwgd2hlcmUgaXMgdGhlIHN1cHBvcnQgZGVmaW5lZCBpbiBr
ZXJuZWw/CiJpZiAoY2xvbmVfZmxhZ3MgJiBDTE9ORV9TRVRUTFMpIiBpcyBpbiBtYW55IGFyY2hz
OgoKJCBnaXQgZ3JlcCBDTE9ORV9TRVRUTFMKLi4uCmFyY2gvbG9vbmdhcmNoL2tlcm5lbC9wcm9j
ZXNzLmM6MjIwOiAgICBpZiAoY2xvbmVfZmxhZ3MgJiBDTE9ORV9TRVRUTFMpCmFyY2gvbTY4ay9r
ZXJuZWwvcHJvY2Vzcy5jOjE3OTogaWYgKGNsb25lX2ZsYWdzICYgQ0xPTkVfU0VUVExTKQphcmNo
L21pY3JvYmxhemUva2VybmVsL3Byb2Nlc3MuYzoxMTA6ICAgaWYgKGNsb25lX2ZsYWdzICYgQ0xP
TkVfU0VUVExTKQphcmNoL21pcHMva2VybmVsL3Byb2Nlc3MuYzoxNzE6IGlmIChjbG9uZV9mbGFn
cyAmIENMT05FX1NFVFRMUykKYXJjaC9uaW9zMi9rZXJuZWwvcHJvY2Vzcy5jOjE0MzogICAgICAg
IGlmIChjbG9uZV9mbGFncyAmIENMT05FX1NFVFRMUykKYXJjaC9vcGVucmlzYy9rZXJuZWwvcHJv
Y2Vzcy5jOjE5OTogICAgICAgICAgICAgICogRm9yIENMT05FX1NFVFRMUyBzZXQgInRwIiAocjEw
KSB0byB0aGUgVExTIHBvaW50ZXIuCmFyY2gvb3BlbnJpc2Mva2VybmVsL3Byb2Nlc3MuYzoyMDE6
ICAgICAgICAgICAgIGlmIChjbG9uZV9mbGFncyAmIENMT05FX1NFVFRMUykKYXJjaC9wYXJpc2Mv
a2VybmVsL3Byb2Nlc3MuYzoyNTE6ICAgICAgICAgICAgICAgaWYgKGNsb25lX2ZsYWdzICYgQ0xP
TkVfU0VUVExTKQphcmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYzoxODE5OiAgICAgICAgICAg
ICAgICAgICAgIGlmIChjbG9uZV9mbGFncyAmIENMT05FX1NFVFRMUykgewoKS2luZCByZWdhcmRz
LApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
