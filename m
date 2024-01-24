Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B59C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:51:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA15A3CFB3E
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 16:51:09 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E0C103CE2A5
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 16:50:54 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 341706018DC
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 16:50:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 04F5B1FD5E;
 Wed, 24 Jan 2024 15:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706111453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awyahpuWiwdeh4zQJiAE10rNJDTPlg5gdwgvUPc6v9s=;
 b=ZVmXatOsc66X60GzqFBCIaIT3IsSmm7BKBFxPf2IOz/6VHM1CYdWr+GXnBYHMxVbFmdUqv
 ypLiVbCMU/jeW/n2eYunXYX2DWcynn/47zr8Ms9wVYMKsECXuVTNSGBmwKY9pG+1gklHe4
 BwJb/XRDcsX6DPbCaWPS79BuO0HBh1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706111453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awyahpuWiwdeh4zQJiAE10rNJDTPlg5gdwgvUPc6v9s=;
 b=Agg0FSU0iUaparLQuI77jFZkIei66WBpA1LGd9YT+HBexsWp1WB/NJHB+Yhhni0Cj0L1AL
 dxffbQ+JStbfzvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706111453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awyahpuWiwdeh4zQJiAE10rNJDTPlg5gdwgvUPc6v9s=;
 b=ZVmXatOsc66X60GzqFBCIaIT3IsSmm7BKBFxPf2IOz/6VHM1CYdWr+GXnBYHMxVbFmdUqv
 ypLiVbCMU/jeW/n2eYunXYX2DWcynn/47zr8Ms9wVYMKsECXuVTNSGBmwKY9pG+1gklHe4
 BwJb/XRDcsX6DPbCaWPS79BuO0HBh1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706111453;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=awyahpuWiwdeh4zQJiAE10rNJDTPlg5gdwgvUPc6v9s=;
 b=Agg0FSU0iUaparLQuI77jFZkIei66WBpA1LGd9YT+HBexsWp1WB/NJHB+Yhhni0Cj0L1AL
 dxffbQ+JStbfzvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A91421333E;
 Wed, 24 Jan 2024 15:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /+b7JtwxsWVvFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 15:50:52 +0000
Date: Wed, 24 Jan 2024 16:50:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240124155051.GB309254@pevik>
References: <20240124125813.6611-1-chrubis@suse.cz>
 <20240124141625.GC299755@pevik> <ZbEc3IMfG1d_bm4t@yuki>
 <3d81343b-4e46-440e-99d6-c9870866ca86@suse.cz>
 <20240124145632.GA307120@pevik> <ZbEqfGw9rbGzdDiD@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbEqfGw9rbGzdDiD@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[18.91%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tst_fd: Avoid tst_brk(TCONF,
 ...) on older distros
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Actually, the solution I posted [1] works on both old (affected) kernel and new
> > one:

> > -	fd->fd = syscall(__NR_pidfd_open, getpid(), 0);
> > +	fd->fd = tst_syscall(__NR_pidfd_open, getpid(), 0);
> >  	if (fd->fd < 0)
> >  		tst_brk(TBROK | TERRNO, "pidfd_open()");

> This cannot work on kenrel that does not implement pidfd_open. That's
> what the code in tst_syscall() does:

> #define tst_syscall(NR, ...) ({ \
>         intptr_t tst_ret; \
>         if (NR == __LTP__NR_INVALID_SYSCALL) { \
>                 errno = ENOSYS; \
>                 tst_ret = -1; \
>         } else { \
>                 tst_ret = syscall(NR, ##__VA_ARGS__); \
>         } \
>         if (tst_ret == -1 && errno == ENOSYS) { \
>                 TST_SYSCALL_BRK__(NR, #NR); \
>         } \
>         tst_ret; \
> })

> This means that either if the syscall number is undefined or if the
> actuall syscall fails with ENOSYS we call tst_brk(TCONF, ...) or
> tst_brkm(TCONF, ...) on old API.

> > I guess we should merge your solution (otherwise we would need to change other
> > cases to be consistent), but I'm a bit confused. Is it the reason why we use
> > syscall() + tst_res(TCONF) instead of tst_syscall() + tst_brk(TBROK) that for
> > some cases it's expected to fail, thus TBROK is not accepted? Again, I was blind
> > when doing review.

> The problem is that if kernel does not implement a particular syscall
> the tst_syscall() calls tst_brk() which ends the tst_fd iteration in the
> middle. The tst_fd iterator just loop over different types of file
> descriptors, if you call tst_brk() anywhere the test ends before we
> managed to finish the loop. We do not want that to happen because of
> either syscall not implemented in older kernels or syscalls disabled by
> CONFIG options.

> That's why we have to call syscall() and do tst_res(TCONF, ...) when the
> syscall had failed. The tst_fd_next() will just continue with next fd
> type if we failed to produce a valid fd.

Understand, you want to keep tst_res(), that makes sense.
And it does not make sense whether the failure is due ENOSYS or due other
failure (most likely due expected error).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
