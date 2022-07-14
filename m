Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9E0C43334
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 17:56:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 276DB3CAA52
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 19:56:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 249D83CA9FC
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 19:56:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 44B67200C7C
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 19:56:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7245B1F949;
 Thu, 14 Jul 2022 17:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657821363;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHsF81jQbIaS4QdL1ctQPGsRftT/F9QoOBAZHFwZfaI=;
 b=dhF/vqYrcgowaRK5k4L4HApn1t5Jei3LV9CYAWtc48zOZxF6fB1VaFx83RVdMCWTSMmoqJ
 xrWeqJaasMtL4mrlwoFJIyyAy7T0qept+4PlbmR70r5gcHqudJcSl86zrv0y4GVf5ErVE7
 por/s42fyfBQ2cHzV3+BR9Fr3CpuKug=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657821363;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hHsF81jQbIaS4QdL1ctQPGsRftT/F9QoOBAZHFwZfaI=;
 b=4M2vkWqpFXeLk6jOtCDL2YDZKFKoF2cb1t+dw+kRl2m2CrcDAzq4/TzB+ZI5ZoBliUmvnC
 AuU6bZ/ioRMP5bBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2BA2713A61;
 Thu, 14 Jul 2022 17:56:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pnoICbNY0GLfAwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Jul 2022 17:56:03 +0000
Date: Thu, 14 Jul 2022 19:56:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YtBYsYOMskQ6v3dD@pevik>
References: <20220712124617.23139-1-rpalethorpe@suse.com>
 <CAASaF6xwEpong-apUxxZxQB47cw-2yaBEpn+AjjogU3qxHag1g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xwEpong-apUxxZxQB47cw-2yaBEpn+AjjogU3qxHag1g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] read_all: Add worker timeout
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > +static void restart_worker(struct worker *const worker)
> > +{
> > +       int wstatus, ret, i, q_len;
> > +       struct timespec now;
> > +
> > +       kill(worker->pid, SIGKILL);
> > +       ret = waitpid(worker->pid, &wstatus, 0);

> Is there a chance we could get stuck in uninterruptible read? I think I saw some
> in past, but those may be blacklisted already, so this may only be something
> to watch for if we still get test timeouts in future.

+1

...
> > +       if (ret != worker->pid) {
> > +               tst_brk(TBROK | TERRNO, "waitpid(%d, ...) = %d",
> > +                       worker->pid, ret);
> > +       }
> > +
> > +       /* Make sure the queue length and semaphore match. Threre is a
> > +        * race in qeuue_pop where the semaphore can be decremented
> ^^ typo in queue_pop above

...
> > +               tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
> > +               elapsed =
> > +                       tst_timespec_to_ms(now) - tst_atomic_load(&w->last_seen);
> > +
> > +               if (elapsed > worker_timeout) {
> > +                       if (!quiet) {
> > +                               tst_res(TINFO,
> > +                                       "Worker %d (%d) stuck for %dms, restarting it",
> > +                                       i, w->pid, elapsed);

> Can we also print file worker is stuck on?
> And as Li pointed out, I'd also extend max_runtime to 60 seconds.

+1, all these additional changes make sense to me.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
