Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42391CD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 07:38:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C33C83C74EF
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 09:38:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B7883C064D
 for <ltp@lists.linux.it>; Wed, 27 May 2026 09:37:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB05D10007E3
 for <ltp@lists.linux.it>; Wed, 27 May 2026 09:37:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D9CA066D0C;
 Wed, 27 May 2026 07:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779867476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZH0NAIdSTHG+MKQvaHl8jw0IMaIdebpECyXdkQR5WkI=;
 b=Eg4h4G2gU7Lqdz9Ot45iJoL6nOJP7CI2IqevYKl4IrIVWym75kx1rDEAbHRwPt+3+im371
 q1vudWwVgWsFd0RMJ66lkwTiohEls4bFX5Aqi8QZwCuZY1jUx0UwlOgxockI+1pFh+XBsk
 DyXlm4Y70ahujTT6SHukLX6J/Aimrlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779867476;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZH0NAIdSTHG+MKQvaHl8jw0IMaIdebpECyXdkQR5WkI=;
 b=tOti/Vi4AnK8YV83qTOdGyT9RhZAOrFtpgR3uf+AugnWFDLnChPcA8n88Z49n0BI/J6Ays
 LbL5KnO2rguLd2Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779867474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZH0NAIdSTHG+MKQvaHl8jw0IMaIdebpECyXdkQR5WkI=;
 b=n7xhqNJM4cIzslSf59ZMf2BDcwOIac3E31YeBJkFfV2H/opdJciNc/blj+tTmB57X3a/WV
 TG279Oo1uYVmn6Xg0vS6pfun/+/UinZYNg6FS/DkaKNHYcTyjSMCqu4LCWhfgML9/YVEkX
 JaZz0iQNCDaaF9SK9FxHHohS0TnkmeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779867474;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZH0NAIdSTHG+MKQvaHl8jw0IMaIdebpECyXdkQR5WkI=;
 b=Qxv0Yx/v0ldN1D6A1lz8IawAhzonaGgjIUO3KcGx1lfRxHwlgHIO+EONeuD6XHRTO3TIIh
 k1zD1+zHF0LKXTBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B37D85A6FD;
 Wed, 27 May 2026 07:37:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PZUAK1KfFmpqPwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 May 2026 07:37:54 +0000
Date: Wed, 27 May 2026 09:37:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260527073749.GB231966@pevik>
References: <20260513162256.3968-1-linuxtestproject.agent@gmail.com>
 <6a0c25a4.a8d7227c.15d3fa.10da@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a0c25a4.a8d7227c.15d3fa.10da@mx.google.com>
X-Spamd-Result: default: False [-2.00 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_THREE(0.00)[4]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it,noreply.github.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,linux.it:url,ozlabs.org:url,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] checkpatch: Pass git root
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
Cc: LTP AI Reviewer <ltp-ai@noreply.github.com>, ltp@lists.linux.it,
 linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> > Hi Petr,

> > On Wed, 13 May 2026, Petr Vorel wrote:
> > > checkpatch: Pass git root

> > > -CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f
> > > +CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f  --root $(abs_top_srcdir)

The original patch is:

-CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f
+CHECK_NOFLAGS			?= CHECKPATCH_CONFIG_DIR="$(abs_top_srcdir)" $(abs_top_srcdir)/scripts/checkpatch.pl -f --root $(abs_top_srcdir)

https://lists.linux.it/pipermail/ltp/2026-May/048397.html
https://lore.kernel.org/ltp/20260513134948.77923-1-pvorel@suse.cz/
https://patchwork.ozlabs.org/project/ltp/patch/20260513134948.77923-1-pvorel@suse.cz/

> > Note: there is a double space between `-f` and `--root`; consider collapsing
> > to a single space for consistency.


> Can you please fix this before merging the patch?

This is really funny. Interesting variant of hallucination. AI just added space
and pointed it out as my error.

Anyway, patch merged, no modification was needed. Thanks for your review.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
