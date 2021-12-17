Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22769C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 14:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 937D73C9120
	for <ltp@archiver.kernel.org>; Fri, 17 Dec 2021 15:48:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA4163C71AA
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:48:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2B9582005DC
 for <ltp@lists.linux.it>; Fri, 17 Dec 2021 15:48:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6275121115;
 Fri, 17 Dec 2021 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639752503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rN/veuXj6VZHalAMUu09dUQTNyacKTIPjuZt/1OA1n0=;
 b=q5o9ATblaLCYCYDLjMjhWLbehtJ7xuNwFz1zw3YnTQ2kui6bBCEg3f++KIGVsfYPwB0jJe
 UNHVkqo6Oen4DE4lx5H/53uxPnvgNHIHtZvGdncFC4GzoDldrEwjfv2NTfDwce7l4Y0TaT
 XTxg/HH7GYrMeb1TXPGQcLeRTag5eec=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639752503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rN/veuXj6VZHalAMUu09dUQTNyacKTIPjuZt/1OA1n0=;
 b=dxuebfytVOw3WoxW/ID2WA+sdPoaxIyrhRxYSeIaqH7WTdn99L2NHAH/ymXdTpmNWIiIfh
 JuLoR2/3fBLdyCCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4E92213E1C;
 Fri, 17 Dec 2021 14:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VZzXETejvGEPLQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 17 Dec 2021 14:48:23 +0000
Date: Fri, 17 Dec 2021 15:49:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Ybyjj40TuKTkeOW/@yuki>
References: <20211217113751.359613-1-liwang@redhat.com>
 <20211217113751.359613-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211217113751.359613-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib: enable OOM protection for the main
 process
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Here invoke OOM protection in fork_testrun, since it is the key point
> to distiguish many process branches. We do protect main ($PID) process
> from killing by OOM Killer, hope this can help to get the completed
> correct report for all of LTP tests.
> 
> Fundamental principle:
> 
>                    ltp test harness --> library process
>   (oom protection)   main --> tst_run_tcases --> ... --> fork_testrun
>   (cancel protection)  testrun --> run_tests --> ... --> testname
>                          child_test --> ... --> end
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
> 
> Notes:
>     Changes v1->v2:
>         * remove the protection for parent process as suggested by Martin
> 
>  lib/tst_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index ce2b8239d..0b370e691 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1441,11 +1441,14 @@ static int fork_testrun(void)
>  
>  	SAFE_SIGNAL(SIGINT, sigint_handler);
>  
> +	tst_enable_oom_protection(getpid());
> +
>  	test_pid = fork();
>  	if (test_pid < 0)
>  		tst_brk(TBROK | TERRNO, "fork()");
>  
>  	if (!test_pid) {
> +		tst_cancel_oom_protection(getpid());
>  		SAFE_SIGNAL(SIGALRM, SIG_DFL);
>  		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
>  		SAFE_SIGNAL(SIGINT, SIG_DFL);

The fork_testrun() function is called in a loop, it would be a bit
cleaner to put the tst_enable_protection() call to the tst_run_tcases()
instead since we don't have to enable it over and over.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
