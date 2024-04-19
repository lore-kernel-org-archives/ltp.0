Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E51C4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 06:12:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09E103CFD29
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 08:12:27 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C4823CF3D9
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 08:12:11 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0B06603467
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 08:12:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 10E3A5D34F;
 Fri, 19 Apr 2024 06:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713507128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYjs2pYL8OuKARGhLkxPWeFPsFjjR8DSYtCks2lzVnU=;
 b=Em8WlXLO+61Lh8GmQijm1vrYzPS9i5IXjbE4jglbSsTKqcr7VqFkaAVcaB+YzZ43uFcle3
 PQ5PloYs4CA9jNG7nHu4Jkdubs/FNwt1a3Em8hPL1V0yS6v2rCtbnD7Fdi9zzWo18ymKar
 vPFZ+iORgKZyx4/3Ar02lyUgHeLKMj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713507128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYjs2pYL8OuKARGhLkxPWeFPsFjjR8DSYtCks2lzVnU=;
 b=2/Z6I1Nyf3VZpRE6dtzFlI1HHLWZkCsvkGRFM0WZdBKN+FjzweK6t0TunPI2fOIvGH9vJL
 EnysiifFm3iy9dDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713507128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYjs2pYL8OuKARGhLkxPWeFPsFjjR8DSYtCks2lzVnU=;
 b=Em8WlXLO+61Lh8GmQijm1vrYzPS9i5IXjbE4jglbSsTKqcr7VqFkaAVcaB+YzZ43uFcle3
 PQ5PloYs4CA9jNG7nHu4Jkdubs/FNwt1a3Em8hPL1V0yS6v2rCtbnD7Fdi9zzWo18ymKar
 vPFZ+iORgKZyx4/3Ar02lyUgHeLKMj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713507128;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CYjs2pYL8OuKARGhLkxPWeFPsFjjR8DSYtCks2lzVnU=;
 b=2/Z6I1Nyf3VZpRE6dtzFlI1HHLWZkCsvkGRFM0WZdBKN+FjzweK6t0TunPI2fOIvGH9vJL
 EnysiifFm3iy9dDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA06A13687;
 Fri, 19 Apr 2024 06:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xYEqODcLImaAPAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 06:12:07 +0000
Date: Fri, 19 Apr 2024 08:12:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240419061206.GA143961@pevik>
References: <20240418185210.132137-1-pvorel@suse.cz>
 <20240418185210.132137-2-pvorel@suse.cz>
 <CAEemH2dw83UCUg7tXnVuKqwDZtFfc8zEWq=SvLuRtzcA_4AV=w@mail.gmail.com>
 <CAEemH2fr5+L0UK4McWf7Aos9TciME7wHMQmVujNX8xQtZYUsqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fr5+L0UK4McWf7Aos9TciME7wHMQmVujNX8xQtZYUsqQ@mail.gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

PiBPbiBGcmksIEFwciAxOSwgMjAyNCBhdCA5OjUw4oCvQU0gTGkgV2FuZyA8bGl3YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgoKPiA+IEhpIFBldHIsIEN5cmlsLAoKPiA+IFRoZSBwYXRjaHNldCBnZW5l
cmFsbHkgbG9va3MgZ29vZC4KCj4gPiBCdXQgSSBoYXZlIGEgY29uY2VybiBhYm91dCB0aGUgbWFj
cm8gbmFtZSAiTUlOSU1BTCIgd29yZCwKPiA+IHdoaWNoIG1pc2xlZCBwZW9wbGUgdG8gdGhpbmsg
dGhhdCBpcyB0aGUgbWluaW1hbCBzd2FwZmlsZSBzaXplIHdlCj4gPiBjYW4gbWFrZSBvbiB0aGUg
c3lzdGVtLCBidXQgb2J2aW91c2x5IGl0IGlzIG5vdCwgd2UgY291bGQgZXZlbgo+ID4gY3JlYXRl
IGEgc21hbGxlciBvbmUsIHJpZ2h0PwoKPiA+IENhbiB3ZSByZW5hbWUgaXQgd2l0aCBhIGJldHRl
ciBvbmU/CgoKPiBXaGF0IGFib3V0IE1BS0VfREVGQVVMVF9TV0FQRklMRSwgb3IgTUFLRV9URVNU
X1NXQVBGSUxFPwoKSSB3YW50IHRvIHNvbWVob3cgZXhwcmVzcyB0aGF0IGl0J3MgYSByZWFsbHkg
c21hbGwgc3dhcCBmaWxlCihhbHRob3VnaCBzdXJlLCBub3QgbWluaW1hbCkuIFN1cmUsIGl0IGNh
biBiZSAiZGVmYXVsdCIgb3IgInRlc3QiLApidXQgaXQgZG9lcyBub3Qgc2F5IGFueXRoaW5nIGFi
b3V0IHRoZSBzaXplLgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
