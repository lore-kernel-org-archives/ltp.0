Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B4AEB64D8
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 10:25:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A04A3CA8D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 12:25:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84C463C9CCB
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 12:25:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 324C9600830
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 12:25:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBF301FD8A;
 Wed, 21 Jun 2023 10:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687343107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OOsD/KUWBTVfL9jzNxhTwmrctNGv7+CtWKSL70pbK0U=;
 b=N3Vp/5gE7aa7jOfuc2TPraPYingF79z3sKtV4K+N90dT7xjLrcrb2dfJl3Tq7qjM9De8sn
 zLzFfG4/Suh04Wn9vMWXcQ4IVfjwg8/+nvmuSyRWTrZ2v2BgVmEnEQyX5AVbZJzwrXDn/Y
 Eb7XcVuNC1DboJwgKdT/Uo48ggdZ9O8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687343107;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OOsD/KUWBTVfL9jzNxhTwmrctNGv7+CtWKSL70pbK0U=;
 b=6u7TL1U6fZ+xb6g9cwQGl/c0KnztWo+8LfxUqNYIRpKjKJ2eeoDp62jXcgloBXLvedK7P9
 vaai9VobSJkGkqAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A9019133E6;
 Wed, 21 Jun 2023 10:25:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mY8uJwPQkmTmDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 10:25:07 +0000
Date: Wed, 21 Jun 2023 12:25:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230621102506.GB393195@pevik>
References: <20230316072231.19157-3-wegao@suse.com>
 <20230530120723.29745-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230530120723.29745-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v5,2/2] semop04: Refactor with new API
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

Hi Wei,

> -void delayloop()
> +static void delayloop(void)
>  {
>  	int delay;
> +
>  	delay = 1 + ((100.0 * rand()) / RAND_MAX);
> -	if (verbose)
> -		printf("in delay function for %d microseconds\n", delay);
>  	usleep(delay);
>  }

...
> +	for (i = 0; i < LOOPS; i++) {
> +		semdown(semid);
>  		delayloop();
Why not just:

	usleep(1 + ((100.0 * rand()) / RAND_MAX));

and delete whole delayloop() function?

> -		if (semup(semid)) {
> -			printf("semup failed\n");
> -		}
> -		if (verbose)
> -			printf("sem is up\n");
> +		semup(semid);
>  	}

...
>  	/* set up the semaphore */
> -	if ((semid = semget((key_t) 9142, 1, 0666 | IPC_CREAT)) < 0) {
> -		printf("error in semget()\n");
> -		exit(-1);
> -	}
> +	semid = SAFE_SEMGET((key_t) 9142, 1, 0666 | IPC_CREAT);
> +
>  	semunion.val = 1;
> -	if (semctl(semid, 0, SETVAL, semunion) == -1) {
> -		printf("error in semctl\n");
> -	}

> -	if ((pid = fork()) < 0) {
> -		printf("fork error\n");
> -		exit(-1);
> -	}
> +	SAFE_SEMCTL(semid, 0, SETVAL, semunion);
> +
> +	pid = SAFE_FORK();
> +
>  	if (pid) {
> -		/* parent */
>  		srand(pid);
>  		mainloop(semid);
> -		waitpid(pid, &chstat, 0);
> -		if (!WIFEXITED(chstat)) {
> -			printf("child exited with status\n");
> -			exit(-1);
> -		}
> -		if (semctl(semid, 0, IPC_RMID, semunion) == -1) {
> -			printf("error in semctl\n");
> -		}
> -		if (errors) {
> -			printf("FAIL: there were %d errors\n", errors);
> -		} else {
> -			printf("PASS: error count is 0\n");
> -		}
> -		exit(errors);
> +		tst_reap_children();
> +		SAFE_SEMCTL(semid, 0, IPC_RMID, semunion);
> +		tst_res(TPASS, "Semaphore up/down check success");

Maybe here use plain semctl() verified with TST_EXP_POSITIVE() from
tst_test_macros.h? This way we'd get TFAIL on failure instead of TPASS.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
