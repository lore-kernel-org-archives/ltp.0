Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76F08C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:13:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37A443C7BDE
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 14:13:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0AD0A3C7B97
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 14:13:07 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 28E4B11FB12A
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 14:13:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F375C211E5;
 Thu, 16 Jan 2025 13:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737033183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pPfIcYt/53hI1c4BwOMdUWBDOrn5DiITRkrFF+GPTo=;
 b=H4UBt9HV7yfcYkX3+3Yn2KrqxlbM6RZ1mbKhsQJsjzr/+xz+qPkDbddplHVEMWtWQyhT/H
 Vp5sEYoZt2JjnUVuEMvdEM/ny5gOwID46IIUeMM+6lvhu8CWvIWdmutq+3PCvjy1wN0FpW
 dlVqmz2dBRdWLe+dJgkmRglOPCXmTjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737033183;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pPfIcYt/53hI1c4BwOMdUWBDOrn5DiITRkrFF+GPTo=;
 b=HLIXZnpq3FRE6BtVBKthd5NwNT63Kogn97ubKbgfgS6xKY74bTriPom9jHLpqRYl395FWR
 PD0NZuMnjSka9eDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="uTMcd/4t";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AlLuRHhj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737033182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pPfIcYt/53hI1c4BwOMdUWBDOrn5DiITRkrFF+GPTo=;
 b=uTMcd/4tE04KR+Zdle8/2CMGPtVb1wICMaVX0VnITaWkRxEhcQUhJN57y68MWR1NIFL9Jc
 odRBB0pUQHsAqdH+Dpi5SnqPmWhewVR4TmSXE5Wa94BKmSLRj+SlJrHjRxadKvKtzSQ3hZ
 0+Z3LjvfDu0KVVWyLuyngFCV0ZAy/24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737033182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/pPfIcYt/53hI1c4BwOMdUWBDOrn5DiITRkrFF+GPTo=;
 b=AlLuRHhjJPLr06ftC6FbfDHNDhaGyARdzVT+LVwQ78Y9P4T06xBuyucm/7k7i+piiC2RlD
 QEEYLn5cr0aEKSBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCBCC13332;
 Thu, 16 Jan 2025 13:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 66JjMN0FiWf2YAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Jan 2025 13:13:01 +0000
Date: Thu, 16 Jan 2025 14:13:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250116131300.GB692568@pevik>
References: <20241222072251.13150-1-liwang@redhat.com>
 <20250115224154.GA664782@pevik>
 <CAEemH2e+Cb8R0kS5a8FnETcMiafWeD529CO3=AtHk310vyckbg@mail.gmail.com>
 <20250116083812.GB670376@pevik>
 <CAEemH2d6RJ8yd4TcLt-z49fmNKt7eAGg=VhdASkNtE=7cR7bgg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d6RJ8yd4TcLt-z49fmNKt7eAGg=VhdASkNtE=7cR7bgg@mail.gmail.com>
X-Rspamd-Queue-Id: F375C211E5
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] Broken tests using tst_net.sh by 893ca0abe7
 (was: [PATCH 1/2] lib: multiply the timeout if detect slow kconfigs)
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIEphbiAxNiwgMjAyNSBhdCA0OjM44oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+IHdyb3RlOgoKPiA+IC4uLgo+ID4gPiA+IGluaXRfbHRwX25ldHNwYWNlKCkKPiA+ID4g
PiB7Cj4gPiA+ID4gICAgICAgICAuLi4KPiA+ID4gPiAgICAgICAgICAgICAgICAgcGlkPSIkKFJP
RCB0c3RfbnNfY3JlYXRlIG5ldCxtbnQpIgo+ID4gPiA+ICAgICAgICAgLi4uCj4gPiA+ID4gICAg
ICAgICBleHBvcnQgTFRQX05FVE5TPSIke0xUUF9ORVROUzotdHN0X25zX2V4ZWMgJHBpZCBuZXQs
bW50fSIKCj4gPiA+ID4gSSB3aWxsIHByb2JhYmx5IHNvbHZlIGl0IGJ5IGFkZGluZyB5ZXQgYW5v
dGhlciBwYXJhbWV0ZXIgdG8KPiA+ID4gPiB0c3Rfcmhvc3RfcnVuKCksCj4gPiA+ID4gd2hpY2gg
aWdub3JlcyBzdGRlcnIgYW5kIHVzZSBpdCBmb3IgdHN0X25zX3tjcmVhdGUsZXhlY30uIEJ1dCBt
YXliZQo+ID4gdGhlcmUKPiA+ID4gPiBpcwo+ID4gPiA+IGFub3RoZXIgc29sdXRpb24gKG9yIGFu
b3RoZXIgcHJvYmxlbSkuCgoKPiA+ID4gT3IsIGFub3RoZXIgd2F5IGlzIGp1c3QgdG8gc2V0ICd0
c3RfdGVzdC0+dGltZW91dCA9PQo+ID4gVFNUX1VOTElNSVRFRF9USU1FT1VUJwo+ID4gPiBpbiB0
aG9zZSB0ZXN0Y2FzZS9saWIgdG9vbHMuCgo+ID4gT3IsIHdlIGNvdWxkIGhhdmUgeWV0IGFub3Ro
ZXIgZmxhZyBUU1RfU0tJUF9TTE9XX0RFVEVDVElPTiB3aGljaCBjb3VsZCBiZQo+ID4gdXNlZAo+
ID4gZm9yIHRoZXNlIHRvb2xzLgoKCj4gU291bmRzIGJldHRlci4gQnV0IG1heWJlIG5hbWUgaXQg
VFNUX05PX1NMT1dfQ09ORklHX0NIRUNLID8KCj4gZGlmZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5j
IGIvbGliL3RzdF90ZXN0LmMKPiBpbmRleCBiMjA0YWQ5NzUuLjFlOTUwNGYyOSAxMDA2NDQKPiAt
LS0gYS9saWIvdHN0X3Rlc3QuYwo+ICsrKyBiL2xpYi90c3RfdGVzdC5jCj4gQEAgLTE3MDIsOCAr
MTcwMiwxMCBAQCB1bnNpZ25lZCBpbnQgdHN0X211bHRpcGx5X3RpbWVvdXQodW5zaWduZWQgaW50
Cj4gdGltZW91dCkKPiAgICAgICAgIGlmICh0aW1lb3V0IDwgMSkKPiAgICAgICAgICAgICAgICAg
dHN0X2JyayhUQlJPSywgInRpbWVvdXQgbXVzdCB0byBiZSA+PSAxISAoJWQpIiwgdGltZW91dCk7
Cgo+ICsjaWZuZGVmIFRTVF9OT19TTE9XX0NPTkZJR19DSEVDSwo+ICAgICAgICAgaWYgKHRzdF9o
YXNfc2xvd19rY29uZmlnKCkpCj4gICAgICAgICAgICAgICAgIHRpbWVvdXQgKj0gNDsKPiArI2Vu
ZGlmCgo+ICAgICAgICAgcmV0dXJuIHRpbWVvdXQgKiB0aW1lb3V0X211bDsKPiAgfQo+IGRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMvbGliL3RzdF9uc19leGVjLmMgYi90ZXN0Y2FzZXMvbGliL3RzdF9u
c19leGVjLmMKPiBpbmRleCA2YThlMzkzMzkuLmExYjc4MGFiNyAxMDA2NDQKPiAtLS0gYS90ZXN0
Y2FzZXMvbGliL3RzdF9uc19leGVjLmMKPiArKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9uc19leGVj
LmMKPiBAQCAtMTQsNiArMTQsNyBAQAo+ICAgKi8KCj4gICNkZWZpbmUgVFNUX05PX0RFRkFVTFRf
TUFJTgo+ICsjZGVmaW5lIFRTVF9OT19TTE9XX0NPTkZJR19DSEVDSwoKPiAgI2luY2x1ZGUgPHN0
ZGlvLmg+Cj4gICNpbmNsdWRlIDxzeXMvd2FpdC5oPgoKTG9va3MgdXNlZnVsLCBJIHZvdGUgdG8g
YWRkIGl0IGZvciBhbGwgdG9vbHMgaW4gdGVzdGNhc2VzL2xpYi8gd2hpY2ggZGVmaW5lClRTVF9O
T19ERUZBVUxUX01BSU4uCgpGWUkgSSBhZGRlZCBvdGhlciBoYXJkZW5pbmcsIHdoaWNoIHByZXZl
bnRzIG90aGVyIHBvdGVudGlhbCBwcm9ibGVtcyB3aXRoCnVud2FudGVkIG91dHB1dCBmcm9tIHRo
ZSBsaWJyYXJ5OgpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2plY3QvbHRwL3BhdGNo
LzIwMjUwMTE2MTMwOTM2LjcwMDQ0MS0xLXB2b3JlbEBzdXNlLmN6LwoKS2luZCByZWdhcmRzLApQ
ZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
