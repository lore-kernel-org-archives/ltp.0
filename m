Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE230C433EF
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 11:07:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E6303CAA74
	for <ltp@archiver.kernel.org>; Tue, 17 May 2022 13:07:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7C263C0370
 for <ltp@lists.linux.it>; Tue, 17 May 2022 13:07:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 37C781400184
 for <ltp@lists.linux.it>; Tue, 17 May 2022 13:07:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 71FCD21CFB;
 Tue, 17 May 2022 11:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652785635;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0ScsRlj3bZu/mfN+ySiyR/u/LoLj6mIoR9P0dDm/O8=;
 b=cngOgJIvHARQh+JTw9ElKWpEqrWBRrfs7FAYYm28XYFMS2rOKaFnB/nJBoMw8hO3d1Pnv1
 EjWvht+Y8EmadS3xTzZayA8QW364kPNYaZ0LVhJt0ZS8jYDWs6eOWCl7Q6Q/gAcMKFUN/h
 5qde/DsAwCdA1JI+1EKPjv2bDL8JYAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652785635;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T0ScsRlj3bZu/mfN+ySiyR/u/LoLj6mIoR9P0dDm/O8=;
 b=DRjlxNLw10u2tsYHkIqOt9wMvmC1NtUAOIEiIepKvFaC5xr/Ikp30fHZrjE2s5O9BcjLZ3
 BKCMHEVv7MUgITBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 295DA13AA2;
 Tue, 17 May 2022 11:07:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aMpFCOOBg2LIZwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 17 May 2022 11:07:15 +0000
Date: Tue, 17 May 2022 13:07:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YoOB4SxiNFAg7nhW@pevik>
References: <20220512123816.24399-1-chrubis@suse.cz>
 <20220512123816.24399-23-chrubis@suse.cz>
 <CAEemH2dAfUEjA877h0Lwy9Qw12YgQ6zgQbf1BJemyr7=xfj0Rg@mail.gmail.com>
 <Yn5NGPpfoddFYTs2@yuki>
 <CAEemH2fHsa+JECK5dW64-coQBwdGR3W9W+jKex8zRmKzfLX1=w@mail.gmail.com>
 <Yn5prUjpZEUjoxbL@yuki> <875ym5di8f.fsf@suse.de>
 <YoN/W4wbow2fyOut@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YoN/W4wbow2fyOut@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v3 22/29] fuzzy_sync: Convert
 to runtime
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
Cc: LTP List <ltp@lists.linux.it>, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi!
> > >> I guess the root cause is that 'pair->time_exec_start' has a possibility
> > >> to reach zero. in pty03 it has ".tcnt = 9" which made the
> > >> tst_fzsync_pair_reset()
> > >> to be re-run many times, but in that function 'pair->time_exec_start' will
> > >> be set only based on the original .max_runtime, with time elapsed the
> > >> remaining time tends to be zero.

> > > I guess that that the interaction of tcnt and runtime is not optimal
> > > here. You are right that as long as we call tst_fzsync_pair_reset() on
> > > each invocation of the run() function we may eventually get to state
> > > where the runtime is exhausted, especially on slower hardware we end up
> > > with division by zero and overflow.

> > > The cleanest solution would be to rewrite the test to use .test_variants = 9
> > > and setting the .max_runtime to a smaller value. That way we would have
> > > precisely defined runtime for each iteration. What do you think?

> > Or each test case (defined by tcnt) could be given an equal share of the
> > runtime?
LGTM

> That would be solution as well. If everyone agrees on this I will go
> with this version, it should be as easy as:

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index dad8aad92..69d7799c3 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1349,6 +1349,8 @@ static void run_tests(void)

>                 if (results_equal(&saved_results, results))
>                         tst_brk(TBROK, "Test %i haven't reported results!", i);
> +
> +               kill(getppid(), SIGUSR1);
>         }
>  }


> With this we do reset the test timeout after each test iteration.

+1.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
