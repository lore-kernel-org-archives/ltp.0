Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE57C00140
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 09:37:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41C183C7730
	for <ltp@archiver.kernel.org>; Wed, 10 Aug 2022 11:37:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3482E3C01CF
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 11:37:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3EDA200741
 for <ltp@lists.linux.it>; Wed, 10 Aug 2022 11:37:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15C5720248;
 Wed, 10 Aug 2022 09:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1660124234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogqOBkgYz8WmrGvM/MPd3P1eBFtMhw/Qv0vyoV2aESA=;
 b=x0ORFM7QKjbxYWix3cQ2ivvo9e9s02EnAE4lW3hEbdrXoGY7vqCZhEamdebJC8+kZaY/jx
 l3w2XBh1BOl2aOgqqR/XXPojs5UBiwKwm0NLW0wjSpKsN9atB48Jx1b0NO+0iHsuYk2lgs
 0PHFjCXsNk6d6w0gmFVDDFXjrKO8rHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1660124234;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ogqOBkgYz8WmrGvM/MPd3P1eBFtMhw/Qv0vyoV2aESA=;
 b=SIzngkZwG47F2WdIOyF3cAyydIwOft9+0BuEYYpN7Xza8ORSF6OI+GL7W0EPj5UZIWPDYa
 6J5ANpVDr9JkuQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F18AD13AB3;
 Wed, 10 Aug 2022 09:37:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ovjpOUl882JWIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 10 Aug 2022 09:37:13 +0000
Date: Wed, 10 Aug 2022 11:39:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <YvN8t4+xs04QnO5I@yuki>
References: <20220809112626.18526-1-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220809112626.18526-1-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns20 test using new LTP API
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
> -static void child_signal_handler(int sig, siginfo_t * si, void *unused)
> +static void child_signal_handler(LTP_ATTRIBUTE_UNUSED int sig, siginfo_t *si, LTP_ATTRIBUTE_UNUSED void *unused)
>  {
>  	if (si->si_signo != SIGUSR1)
> -		tst_resm(TBROK, "cinit: received %s unexpectedly!",
> -			 strsignal(si->si_signo));
> -	else
> -		tst_resm(TPASS, "cinit: user function is called as expected");
> +		tst_brk(TBROK, "Received %s unexpectedly!", tst_strsig(si->si_signo));

It's not safe to call tst_brk() from a signal handler.

The most safe way is to store the signo here and do the check in the
child func.

So here I would do:

	signals++;
	last_sig = si->si_signo;


And then in the main loop:

	if (singals != 1) {
		tst_res(TFAIL, "Received %i signals", signals);
		return 0;
	}

	if (last_sig != SIGUSR1) {
		...
	}

	...

> -	/* Disable broken flag */
> -	broken = 0;
> +	passed++;
>  }
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *arg)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> -	pid_t pid, ppid;
> -	sigset_t newset;
>  	struct sigaction sa;
> -	char buf[5];
> +	sigset_t newset;
> +	pid_t cpid, ppid;
>  
> -	/* Setup pipe read and write ends */
> -	pid = getpid();
> +	cpid = getpid();
>  	ppid = getppid();
>  
> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
> -		printf("cinit: pidns was not created properly\n");
> -		exit(1);
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> +		return 1;

No return 1 here, we already reported TFAIL and the non-zero return
value will cause TBROK in the test library when the process is waited
for.

>  	}
>  
> -	/* Setup pipes to communicate with parent */
> -	close(cinit_parent[0]);
> -	close(parent_cinit[1]);
> -
> -	/* Block SIGUSR1 signal */
> -	sigemptyset(&newset);
> -	sigaddset(&newset, SIGUSR1);
> -	if (sigprocmask(SIG_BLOCK, &newset, 0) == -1) {
> -		perror("cinit: sigprocmask() failed");
> -		exit(1);
> -	}
> -	tst_resm(TINFO, "cinit: blocked SIGUSR1");
> -
> -	/* Let parent to queue SIGUSR1 in pending */
> -	if (write(cinit_parent[1], "c:go", 5) != 5) {
> -		perror("cinit: pipe is broken to write");
> -		exit(1);
> -	}
> +	SAFE_SIGEMPTYSET(&newset);
> +	SAFE_SIGADDSET(&newset, SIGUSR1);
> +	SAFE_SIGPROCMASK(SIG_BLOCK, &newset, 0);
>  
> -	/* Check if parent has queued up SIGUSR1 */
> -	read(parent_cinit[0], buf, 5);
> -	if (strcmp(buf, "p:go") != 0) {
> -		printf("cinit: parent did not respond!\n");
> -		exit(1);
> -	}
> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>  
> -	/* Now redefine handler for SIGUSR1 */
>  	sa.sa_flags = SA_SIGINFO;
> -	sigfillset(&sa.sa_mask);
> +	SAFE_SIGFILLSET(&sa.sa_mask);
>  	sa.sa_sigaction = child_signal_handler;
> -	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
> -		perror("cinit: sigaction failed");
> -		exit(1);
> -	}
>  
> -	/* Unblock traffic on SIGUSR1 queue */
> -	tst_resm(TINFO, "cinit: unblocking SIGUSR1");
> -	sigprocmask(SIG_UNBLOCK, &newset, 0);
> +	SAFE_SIGACTION(SIGUSR1, &sa, NULL);
>  
> -	/* Check if new handler is called */
> -	if (broken == 1) {
> -		printf("cinit: broken flag didn't change\n");
> -		exit(1);
> +	SAFE_SIGPROCMASK(SIG_UNBLOCK, &newset, 0);
> +
> +	if (!passed){
                    ^
		    Missing space
> +		tst_res(TFAIL, "User function has not been called after unblocking signal");
> +		return 1;
>  	}
>  
> -	/* Cleanup and exit */
> -	close(cinit_parent[1]);
> -	close(parent_cinit[0]);
> -	exit(0);
> -}
> +	tst_res(TPASS, "User function is called as expected after unblocking signal");
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> +	return 0;
>  }
>  
> -int main(void)
> +static void run(void)
>  {
> -	int status;
> -	char buf[5];
> -	pid_t cpid;
> -
> -	setup();
> -
> -	/* Create pipes for intercommunication */
> -	if (pipe(parent_cinit) == -1 || pipe(cinit_parent) == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
> -	}
> +	int ret;
>  
> -	cpid = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_fn, NULL);
> -	if (cpid == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "clone failed");
> -	}
> -
> -	/* Setup pipe read and write ends */
> -	close(cinit_parent[1]);
> -	close(parent_cinit[0]);
> -
> -	/* Is container ready */
> -	read(cinit_parent[0], buf, 5);
> -	if (strcmp(buf, "c:go") != 0) {
> -		tst_brkm(TBROK, NULL, "parent: container did not respond!");
> -	}
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
>  
> -	/* Enqueue SIGUSR1 in pending signal queue of container */
> -	SAFE_KILL(NULL, cpid, SIGUSR1);
> +	TST_CHECKPOINT_WAIT(0);
>  
> -	tst_resm(TINFO, "parent: signalled SIGUSR1 to container");
> -	if (write(parent_cinit[1], "p:go", 5) != 5) {
> -		tst_brkm(TBROK | TERRNO, NULL, "write failed");
> -	}
> -
> -	/* collect exit status of child */
> -	SAFE_WAIT(NULL, &status);
> -
> -	if (WIFSIGNALED(status)) {
> -		if (WTERMSIG(status) == SIGUSR1)
> -			tst_resm(TFAIL,
> -				 "user function was not called inside cinit");
> -		else
> -			tst_resm(TBROK,
> -				 "cinit was terminated by %d",
> -				 WTERMSIG(status));
> -	}
> +	SAFE_KILL(ret, SIGUSR1);
>  
> -	/* Cleanup and exit */
> -	close(parent_cinit[1]);
> -	close(cinit_parent[0]);
> -	tst_exit();
> +	TST_CHECKPOINT_WAKE(0);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
