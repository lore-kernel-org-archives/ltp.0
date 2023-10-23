Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46BAC001E0
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 13:17:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE17A3CD958
	for <ltp@archiver.kernel.org>; Mon, 23 Oct 2023 15:17:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EC463C821F
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:17:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2B788200DCB
 for <ltp@lists.linux.it>; Mon, 23 Oct 2023 15:17:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8026E1FE18;
 Mon, 23 Oct 2023 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698067040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH37BvsTLn9joKcizX/dK+1RW71Vj6/ssaVaozBVeQE=;
 b=UjFgoUewxbDdqjnL+mfE/AxSkWCOBKNYmMlYBVDYWe8E6ZD0xEiqjH2LYTCd9H/AI7LMsN
 xutt6YFqVPm9y+vD/RYOZgtjoJ0wWOViIMmkxOEpHrJ7PbKi5lAZygl/VttQyb9q7ccU4C
 LT8JxRcHZraewtDbwOLE6JGmGA2hbdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698067040;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QH37BvsTLn9joKcizX/dK+1RW71Vj6/ssaVaozBVeQE=;
 b=kCvbRSmS8ngzEJcgJCMHMVjKZZ7XLGxgzOlLxRgrFj3r2NRXJsBmgT+wJX7VGlP3ytlxEc
 g4MI3VDGhzoCdSDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67654132FD;
 Mon, 23 Oct 2023 13:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QhNTGWByNmU0SAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 23 Oct 2023 13:17:20 +0000
Date: Mon, 23 Oct 2023 15:17:51 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZTZyfzX4VDoEpARm@yuki>
References: <20230919110951.31500-1-mkittler@suse.de>
 <20230919110951.31500-2-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230919110951.31500-2-mkittler@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.60 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/4] Refactor ioctl02.c to use the new test API
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
> +static const int checkpoint_child_ready = 1;
> +static const int checkpoint_parent_done_testing = 2;

1. It's more customary to make constants like this macros.
2. The names are overly too long
3. You can actually use single checkpoint

> -int main(int ac, char **av)
> +static void verify_ioctl(void)
>  {
> -	int lc;
> -	int rval;
> -
> -	tst_parse_opts(ac, av, options, &help);
> -
> -#ifdef UCLINUX
> -	maybe_run_child(&do_child_uclinux, "dS", &parentpid, &childtty);
> -#endif
> -
> -	if (!Devflag)
> -		tst_brkm(TBROK, NULL, "You must specify a tty device with "
> -			 "the -D option.");
> -
> -	tst_require_root();
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		parenttty = devname;
> -		childtty = devname;
> -
> -		parentpid = getpid();
> +	parenttty = device;
> +	childtty = device;
>  
> -		childpid = FORK_OR_VFORK();
> -		if (childpid < 0)
> -			tst_brkm(TBROK, cleanup, "fork failed");
> +	parentpid = getpid();
> +	childpid = SAFE_FORK();
> +	if (childpid == 0)
> +		do_child();
>  
> -		if (childpid == 0) {	/* child */
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "dS", parentpid, childtty) < 0)
> -				tst_brkm(TBROK, cleanup, "self_exec failed");
> -#else
> -			do_child();
> -#endif
> -		}
> -
> -		while (!sigusr1)
> -			sleep(1);
> +	TST_CHECKPOINT_WAIT2(checkpoint_child_ready, 5000);

Why TST_CHECKPOINT_WAIT2(), why do you need to set the timeout?

> -		sigusr1 = 0;
> -
> -		parentfd = do_parent_setup();
> -		if (parentfd < 0) {
> -			kill(childpid, SIGTERM);
> -			waitpid(childpid, NULL, 0);
> -			cleanup();
> -		}
> +	parentfd = SAFE_OPEN(parenttty, O_RDWR, 0777);
> +	/* flush tty queues to remove old output */
> +	SAFE_IOCTL(parentfd, TCFLSH, 2);
>  
> -		/* run the parent test */
> -		rval = run_ptest();
> -		if (rval == -1) {
> -			/*
> -			 * Parent cannot set/get ioctl parameters.
> -			 * SIGTERM the child and cleanup.
> -			 */
> -			kill(childpid, SIGTERM);
> -			waitpid(childpid, NULL, 0);
> -			cleanup();
> -		}
> +	/* run the parent test */
> +	int rval = run_ptest();
>  
> -		if (rval != 0)
> -			tst_resm(TFAIL, "TCGETA/TCSETA tests FAILED with "
> -				 "%d %s", rval, rval > 1 ? "errors" : "error");
> -		else
> -			tst_resm(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
> -
> -		/* FIXME: check return codes. */
> -		(void)kill(childpid, SIGTERM);
> -		(void)waitpid(childpid, NULL, 0);
> -
> -		/*
> -		 * Clean up things from the parent by restoring the
> -		 * tty device information that was saved in setup()
> -		 * and closing the tty file descriptor.
> -		 */
> -		if (ioctl(parentfd, TCSETA, &save_io) == -1)
> -			tst_resm(TINFO, "ioctl restore failed in main");
> -		SAFE_CLOSE(cleanup, parentfd);
> -
> -		closed = 1;
> -	}
> -	cleanup();
> +	if (rval != 0)
> +		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
> +				"%d %s", rval, rval > 1 ? "errors" : "error");
> +	else
> +		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");

Please no test result propagation like this. The TPASS/TFAIL should be
reported in the check_tty_params() directly. All that needs to be done
is to change the TINFO there to TPASS and TFAIL as needed and we can get
rid of this result propagation.

> -	tst_exit();
> +	TST_CHECKPOINT_WAKE(checkpoint_parent_done_testing);
>  }
>  
>  static void do_child(void)
> @@ -201,28 +94,12 @@ static void do_child(void)
>  	_exit(0);
>  }

This function is a bit useless now and all the indirection is making
things less readable. All we actually need to is to open the file
descriptor and wait on a checkpoint, I would just put all the code
directly in the if (!childpid) branch into the verify_ioctl() instead.

> -void do_child_uclinux(void)
> -{
> -	struct sigaction act;
> -
> -	/* Set up the signal handlers again */
> -	act.sa_handler = (void *)sigterm_handler;
> -	act.sa_flags = 0;
> -	sigemptyset(&act.sa_mask);
> -	(void)sigaction(SIGTERM, &act, 0);
> -
> -	/* Run the normal child */
> -	do_child();
> -}
> -
>  /*
>   * run_ptest() - setup the various termio structure values and issue
>   *		 the TCSETA ioctl call with the TEST macro.
>   */
>  static int run_ptest(void)
>  {
> -	int i, rval;
> -
>  	/* Use "old" line discipline */
>  	termio.c_line = 0;
>  
> @@ -230,7 +107,7 @@ static int run_ptest(void)
>  	termio.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
>  
>  	/* Set control chars. */
> -	for (i = 0; i < NCC; i++) {
> +	for (int i = 0; i < NCC; i++) {
>  		if (i == VEOL2)
>  			continue;
>  		termio.c_cc[i] = CSTART;
> @@ -248,38 +125,18 @@ static int run_ptest(void)
>  	/* Set output modes. */
>  	termio.c_oflag = OPOST | OLCUC | ONLCR | ONOCR;
>  
> -	TEST(ioctl(parentfd, TCSETA, &termio));
> -
> -	if (TEST_RETURN < 0) {
> -		tst_resm(TFAIL, "ioctl TCSETA failed : "
> -			 "errno = %d", TEST_ERRNO);
> -		return -1;
> -	}
> +	SAFE_IOCTL(parentfd, TCSETA, &termio);
>  
>  	/* Get termio and see if all parameters actually got set */
> -	rval = ioctl(parentfd, TCGETA, &termio);
> -	if (rval < 0) {
> -		tst_resm(TFAIL, "ioctl TCGETA failed.  Ending test.");
> -		return -1;
> -	}
> -
> +	SAFE_IOCTL(parentfd, TCGETA, &termio);
>  	return chk_tty_parms();
>  }
>  
>  static int run_ctest(void)
>  {
> -	/*
> -	 * Wait till the parent has finished testing.
> -	 */
> -	while (!sigterm)
> -		sleep(1);
> -
> -	sigterm = 0;
> -
> -	tst_resm(TINFO, "child: Got SIGTERM from parent.");
> -
> -	if (close(childfd) == -1)
> -		tst_resm(TINFO, "close() in run_ctest() failed");
> +	TST_CHECKPOINT_WAIT(checkpoint_parent_done_testing);
> +	tst_res(TINFO, "child: parent has finished testing");
> +	SAFE_CLOSE(childfd);
>  	return 0;
>
>  }
>  
> @@ -288,7 +145,7 @@ static int chk_tty_parms(void)
>  	int i, flag = 0;
>  
>  	if (termio.c_line != 0) {
> -		tst_resm(TINFO, "line discipline has incorrect value %o",
> +		tst_res(TINFO, "line discipline has incorrect value %o",
>  			 termio.c_line);
>  		flag++;
>  	}
> @@ -301,7 +158,7 @@ static int chk_tty_parms(void)
>  	 */
>  #if 0
>  	if (termio.c_cflag != (B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL)) {
> -		tst_resm(TINFO, "cflag has incorrect value. %o",
> +		tst_res(TINFO, "cflag has incorrect value. %o",
>  			 termio.c_cflag);
>  		flag++;
>  	}
> @@ -309,19 +166,18 @@ static int chk_tty_parms(void)
>  
>  	for (i = 0; i < NCC; i++) {
>  		if (i == VEOL2) {
> -			if (termio.c_cc[VEOL2] == CNUL) {
> +			if (!termio.c_cc[i]) {
>  				continue;
>  			} else {
> -				tst_resm(TINFO, "control char %d has "
> -					 "incorrect value %d %d", i,
> -					 termio.c_cc[i], CNUL);
> +				tst_res(TINFO, "control char %d has "
> +					 "incorrect value %d", i, termio.c_cc[i]);
>  				flag++;
>  				continue;
>  			}
>  		}
>  
>  		if (termio.c_cc[i] != CSTART) {
> -			tst_resm(TINFO, "control char %d has incorrect "
> +			tst_res(TINFO, "control char %d has incorrect "
>  				 "value %d.", i, termio.c_cc[i]);
>  			flag++;
>  		}
> @@ -330,7 +186,7 @@ static int chk_tty_parms(void)
>  	if (!
>  	    (termio.c_lflag
>  	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
> -		tst_resm(TINFO, "lflag has incorrect value. %o",
> +		tst_res(TINFO, "lflag has incorrect value. %o",
>  			 termio.c_lflag);
>  		flag++;
>  	}
> @@ -339,130 +195,67 @@ static int chk_tty_parms(void)
>  	    (termio.c_iflag
>  	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
>  		 | IXOFF))) {
> -		tst_resm(TINFO, "iflag has incorrect value. %o",
> +		tst_res(TINFO, "iflag has incorrect value. %o",
>  			 termio.c_iflag);
>  		flag++;
>  	}
>  
>  	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
> -		tst_resm(TINFO, "oflag has incorrect value. %o",
> +		tst_res(TINFO, "oflag has incorrect value. %o",
>  			 termio.c_oflag);
>  		flag++;
>  	}
>  
>  	if (!flag)
> -		tst_resm(TINFO, "termio values are set as expected");
> +		tst_res(TINFO, "termio values are set as expected");
>  
>  	return flag;
>  }
>  
> -static int do_parent_setup(void)
> -{
> -	int pfd;
> -
> -	pfd = SAFE_OPEN(cleanup, parenttty, O_RDWR, 0777);
> -
> -	/* unset the closed flag */
> -	closed = 0;
> -
> -	/* flush tty queues to remove old output */
> -	SAFE_IOCTL(cleanup, pfd, TCFLSH, 2);
> -	return pfd;
> -}
> -
>  static int do_child_setup(void)
>  {
> -	int cfd;
> -
> -	cfd = open(childtty, O_RDWR, 0777);
> -	if (cfd < 0) {
> -		tst_resm(TINFO, "Could not open %s in do_child_setup(), errno "
> -			 "= %d", childtty, errno);
> -		/* signal the parent so we don't hang the test */
> -		kill(parentpid, SIGUSR1);
> -		return -1;
> -	}
> +	int cfd = SAFE_OPEN(childtty, O_RDWR, 0777);
>  
>  	/* flush tty queues to remove old output */
> -	if (ioctl(cfd, TCFLSH, 2) < 0) {
> -		tst_resm(TINFO, "ioctl TCFLSH failed. : errno = %d", errno);
> -		/* signal the parent so we don't hang the test */
> -		kill(parentpid, SIGUSR1);
> -		return -1;
> -	}
> +	SAFE_IOCTL(cfd, TCFLSH, 2);
>  
>  	/* tell the parent that we're done */
> -	kill(parentpid, SIGUSR1);
> -
> +	TST_CHECKPOINT_WAKE(checkpoint_child_ready);
>  	return cfd;
>  }
>  
> -/*
> - * Define the signals handlers here.
> - */
> -static void sigterm_handler(void)
> -{
> -	sigterm = 1;
> -}
> -
> -static void sigusr1_handler(void)
> -{
> -	sigusr1 = 1;
> -}
> -
> -static void sigusr2_handler(void)
> -{
> -	sigusr2 = 1;
> -}
> -
> -static void help(void)
> -{
> -	printf("  -D <tty device> : for example, /dev/tty[0-9]\n");
> -}
> -
>  static void setup(void)
>  {
> -	int fd;
> -	struct sigaction act;
> +	if (!device)
> +		tst_brk(TBROK, "You must specify a tty device with -D option");
>  
>  	/* XXX: TERRNO required all over the place */
> -	fd = SAFE_OPEN(NULL, devname, O_RDWR, 0777);
> +	int fd = SAFE_OPEN(device, O_RDWR, 0777);
>  
>  	/* Save the current device information - to be restored in cleanup() */
> -	SAFE_IOCTL(cleanup, fd, TCGETA, &save_io);
> +	SAFE_IOCTL(fd, TCGETA, &save_io);
>  
>  	/* Close the device */
> -	SAFE_CLOSE(cleanup, fd);
> -
> -	/* Set up the signal handlers */
> -	act.sa_handler = (void *)sigterm_handler;
> -	act.sa_flags = 0;
> -	sigemptyset(&act.sa_mask);
> -	(void)sigaction(SIGTERM, &act, 0);
> -
> -	act.sa_handler = (void *)sigusr1_handler;
> -	act.sa_flags = 0;
> -	(void)sigaction(SIGUSR1, &act, 0);
> -
> -	act.sa_handler = (void *)sigusr2_handler;
> -	act.sa_flags = 0;
> -	(void)sigaction(SIGUSR2, &act, 0);
> -
> -	act.sa_handler = SIG_IGN;
> -	act.sa_flags = 0;
> -	(void)sigaction(SIGTTOU, &act, 0);
> -
> -	sigterm = sigusr1 = sigusr2 = 0;
> -
> -	TEST_PAUSE;
> +	SAFE_CLOSE(fd);
>  }
>  
>  static void cleanup(void)
>  {
> -	if (!closed) {
> -		if (ioctl(parentfd, TCSETA, &save_io) == -1)
> -			tst_resm(TINFO, "ioctl restore failed in cleanup()");
> -		if (close(parentfd) == -1)
> -			tst_resm(TINFO, "close() failed in cleanup()");
> +	if (parentfd >= 0) {
> +		SAFE_IOCTL(parentfd, TCSETA, &save_io);
> +		SAFE_CLOSE(parentfd);
>  	}
>  }
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.needs_checkpoints = 1,
> +	.forks_child = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = verify_ioctl,
> +	.options = (struct tst_option[]) {
> +		{"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
> +		{}
> +	}
> +};
> \ No newline at end of file
> -- 
> 2.42.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
