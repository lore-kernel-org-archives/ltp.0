Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5789CC25B74
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 07:28:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 852983CBF3E
	for <ltp@archiver.kernel.org>; Tue,  7 May 2024 09:28:39 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7706D3C0562
 for <ltp@lists.linux.it>; Tue,  7 May 2024 09:28:24 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D0153102E714
 for <ltp@lists.linux.it>; Tue,  7 May 2024 09:28:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA24620575;
 Tue,  7 May 2024 07:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715066902;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSix1hj9vN6vu66sIBdbPjp0mn8nTSyjEhdfyqMD1hA=;
 b=H+nh2Rn6V6vKS/tuHGgfGlrkxWUNTtEOcauWHMIXI5/Nqd0g2RsC28gp6+J1AITzAF/9SZ
 Gj0fp3wQSuv7M0CdunBzVLRd7Pabhvhm87I0vVeIZCUrBZ7tts1dCPHlKk6pXBFUSjLTIh
 dwbVLU3cP/wl6AaT0n6oJZRQ6MrCYbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715066902;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSix1hj9vN6vu66sIBdbPjp0mn8nTSyjEhdfyqMD1hA=;
 b=8j0P/AgJIr8BG4UVrUWHTcITILuORlIkHWMchvqsL1FLSPcCOCO0vFAt1bx67R/NKC7fCa
 A+RGWa+PQR8vhLAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DnPQ4eBi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a9MNT2kg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715066901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSix1hj9vN6vu66sIBdbPjp0mn8nTSyjEhdfyqMD1hA=;
 b=DnPQ4eBi8jHuqteb65tmweVq19uX1M2XZgrwH6uLoFqc7PLQqjXVGiADb7LyCLPFxz+4TL
 Dx1+R6hmqaRqtA/4EhEYOJzCsgffbOaC387kt2Nvlpl0TOZ8/8sHCEo06EO3a+vSdw/O9I
 hFeDYd4HQE1MLPP+dri2hMiumvYThyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715066901;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KSix1hj9vN6vu66sIBdbPjp0mn8nTSyjEhdfyqMD1hA=;
 b=a9MNT2kglAEbZ2HpsCrQIuP+SlZnOsRSJaZXDWebVkuw4gBUeTZ7gs41I2OCf3nxbW+OOL
 81lHzp4FMCqnISDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B55139CB;
 Tue,  7 May 2024 07:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yz9lLhXYOWYuJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 07 May 2024 07:28:21 +0000
Date: Tue, 7 May 2024 09:28:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Khem Raj <raj.khem@gmail.com>
Message-ID: <20240507072820.GA90516@pevik>
References: <20240506190348.1448707-1-raj.khem@gmail.com>
 <20240506210010.GD38981@pevik>
 <CAMKF1sr_s8qnm3++7gea+UuShkB6KYQOz2t2ooCcbNaBjxv8vA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMKF1sr_s8qnm3++7gea+UuShkB6KYQOz2t2ooCcbNaBjxv8vA@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DA24620575
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_stress: Use time_t instead of long for type
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

PiBPbiBNb24sIE1heSA2LCAyMDI0IGF0IDI6MDDigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+ID4gSGkgS2hlbSwKCj4gPiA+IFRoaXMgZW5zdXJlcyBpdCB3b3JrcyBh
Y3Jvc3MgZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMKPiA+ID4gRml4ZXMKCj4gPiA+IHwgc2NoZWRf
ZHJpdmVyLmM6NzQ0OjQzOiBlcnJvcjogcGFzc2luZyBhcmd1bWVudCAxIG9mICdjdGltZScgZnJv
bQo+ID4gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSBbLVdpbmNvbXBhdGlibGUtcG9pbnRlci10
eXBlc10KPiA+ID4gfCAgIDc0NCB8ICAgICAgICAgcHJpbnRmKCJcbmVuZCB0aW1lID0gJXNcbiIs
IGN0aW1lKCZlbmRfdGltZSkpOwo+ID4gPiB8ICAgICAgIHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+Cgo+ID4gPiBXaXRoIGdjYy0xNAoKPiA+IFRo
aXMgd2FzIGFjdHVhbGx5IHByb2JsZW0gb24gbXVzbCwgcmlnaHQ/CgoKPiBUaGlzIGlzIHdpdGgg
MzIgYml0IHg4NiB1c2luZyA2NGJpdCB0aW1lX3IgdGhpcyB0aW1lIDopIHdlIGhhdmUgdW1wdGVl
bgo+IHdheXMgdG8gYnVpbGQgc3lzdGVtcyB3aXRoIHlvY3RvCgpUaGFua3MgZm9yIGluZm8hIEkg
d29uZGVyIGlmIHRoaXMgaXMgdGhlIG9ubHkgcGxhY2Ugd2hlcmUgaXQncyBuZWVkZWQuCgpJJ20g
bm90IHN1cmUgaG93IG11Y2ggaXMgc2NoZWRfZHJpdmVyLmMgcmVsZXZhbnQgbm93YWRheXMuIElm
IHllcywKaXQgd291bGQgYmUgd29ydGggdG8gYXQgbGVhc3QgZml4IG90aGVyIHdhcm5pbmdzLCBy
ZW1vdmUgaWE2NCBzdXBwb3J0IGFuZAojaWYgMC4KCktpbmQgcmVnYXJkcywKUGV0cgoKPiA+IEFu
eXdheSwgdGhhbmtzIGZvciB0aGUgZml4LCBtZXJnZWQuCgo+ID4gS2luZCByZWdhcmRzLAo+ID4g
UGV0cgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
