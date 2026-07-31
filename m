Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0CAC5516D
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:20:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 517A73E7200
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 14:20:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8EE73E4AD2
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:20:25 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 793C01A00CC2
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 14:20:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 82B767DF3C;
 Fri, 31 Jul 2026 12:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785500420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sLw+/sr0Ux2UcvOmgdfClPK6sux2FNVOqIQVfC/vdY=;
 b=GOUzk7PxIkAFvTG662h5UPZxWskkxOajUHTip2pC3wnplVa1MvGf5CcWWAsc/gbmiA6ySn
 ahPHCqkVa9VpnDXp2lyspT2+kmDn2gyDgzB+M0XrcLeFgUFhecs2sjzk033mYJYKxgMmlj
 +CVoFkWOpQ+QxcxWwTD+I0pVYsx0Lqs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785500420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sLw+/sr0Ux2UcvOmgdfClPK6sux2FNVOqIQVfC/vdY=;
 b=J5ODmD53gNws5qi0IsXpfAn1OEPwaKKb3n6xnNaVHWKMYcIrAlhzdGQ7SpqC3c/TvvYc73
 w8mVzws4J0a6gCCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=04w4GW1w;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=opWMeRBk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1785500416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sLw+/sr0Ux2UcvOmgdfClPK6sux2FNVOqIQVfC/vdY=;
 b=04w4GW1wXmql4wgdQMvWftfszoKnmS4XHEc6daup16zMKPRWdUtR5JXTtdiPt/9TLDMBs4
 Nmf3MT/YCCDwHSYitkakQGKafVoU1Kj94+UTZqUFu8q8rebrpQkNy5SDgagAbGCPpD9CRr
 bxpKcGULEcg156t7FpvNfnMi2ETdJ2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1785500416;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5sLw+/sr0Ux2UcvOmgdfClPK6sux2FNVOqIQVfC/vdY=;
 b=opWMeRBkAAOlK0WjJ6pxOEVFoZHHg+cxlPGm2jbzqxkVGNlZnswNBTOozSfPnrEFaEFuXB
 qpyxUqylOr3escCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10B5D779B0;
 Fri, 31 Jul 2026 12:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FajdN/+SbGqafgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 12:20:15 +0000
Date: Fri, 31 Jul 2026 14:20:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linuxtestproject.agent@gmail.com
Message-ID: <20260731122009.GA196217@pevik>
References: <20260731105132.187177-2-pvorel@suse.cz>
 <20260731115215.8956-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260731115215.8956-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-2.21 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 82B767DF3C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Rename function check_kver() => check_min_kver()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Petr,

> On Fri, 31 Jul 2026, Petr Vorel wrote:
> > lib: Rename function check_kver() => check_min_kver()

> --- [PATCH 1/5] ---

> > Preparation for a next commit.

> Could the message explain that the rename distinguishes the minimum-version
> helper from the new maximum-version helper, without referring to a later
> patch? The current body does not explain the change independently.

Hm, I'm not sure if that's needed

> --- [PATCH 2/5] ---

> > + * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
> > + * 7.1.5). Stable releases are compared as expected.

> Could this example use ``max_kver``? As written, the new field documents the
> opposite API.

Ah, thanks! Before merge I'll amend:

- * on any stable release (test with ``min_kver = "7.1"`` runs also on kernel
+ * on any stable release (test with ``max_kver = "7.1"`` runs also on kernel

> > +	for (i=0, dots=0; max_kver[i]; i++)

> Could spaces be added around both assignment operators to follow kernel
> coding style?

Ah, thanks! Before merge I'll amend:

-	for (i=0, dots=0; max_kver[i]; i++)
+	for (i = 0, dots = 0; max_kver[i]; i++)

> --- [PATCH 3/5] ---

> > +	.max_kver = "6.10",

> Could this test be allowed to run again on Linux 7.2? In that tree,
> do_open_execat() calls exe_file_deny_write_access() and returns ETXTBSY when
> the executable is open for writing (fs/exec.c:800-802).

> A permanent maximum version therefore reports TCONF for behavior that is
> valid again. It cannot represent the temporary 6.11 through 7.1 behavior
> window.

@Cyril @Andrea could you also please double check?

> --- [PATCH 4/5] ---

> > +	.max_kver = "6.10",

> Could creat07 also be allowed to run again on Linux 7.2? The exec path makes
> i_writecount negative through exe_file_deny_write_access(), and creat() then
> reaches get_write_access(), which returns ETXTBSY for a negative count
> (include/linux/fs.h:2813-2816).

> This maximum bound suppresses valid 7.2 coverage and cannot describe the
> temporary 6.11 through 7.1 behavior window.

@Cyril @Andrea could you also please double check?

> --- [PATCH 5/5] ---

> > Because the above flag combinations are already "tested" by the tests
> > that use them and we don't have any tests that >= 5.10 has support for
> > FAN_MARK_FILESYSTEM etc just simply skip the test on v7.2.

> Could this claim be corrected? Other tests exercise FAN_REPORT_TID and
> FAN_REPORT_PIDFD separately, but fanotify20 is the only LTP test combining
> them.

Hm, do we care when Amir is ok with it?

Kind regards,
Petr

> > +	.max_kver = "7.1",

> Could the first case instead expect success when thread pidfds are supported,
> while retaining the second valid-combination check? Linux 7.2 now uses
> task_pid(current) for FAN_REPORT_TID and creates a thread pidfd
> (fs/notify/fanotify/fanotify.c:843-849 and
> fs/notify/fanotify/fanotify_user.c:906-913). Skipping the whole test removes
> the only coverage of the newly valid combination.

> Verdict - Needs revision

> ---
> Note:

> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.

> Regards,
> LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
