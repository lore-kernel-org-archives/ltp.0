Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661B0C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 09:00:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1847E3CEC3B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 11:00:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D438F3C840A
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:00:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E90710060A3
 for <ltp@lists.linux.it>; Wed, 25 Oct 2023 11:00:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 185B01FF39;
 Wed, 25 Oct 2023 09:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698224416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sXALUTd+dnBzEHkHpkc/V6eat3lRAGMOuQmdTB4GoOs=;
 b=kuGT0hIOFKi2zUQkTKY3Dv5GhFJ06OeWvlLQ6c9yfKR28DSa31bLK44y5BiBGmZG3ESlJf
 koCRlzrR8VzL+zaXx1NvFJODVcTAknrtMBjNuulBkrudUsyAxWP3v5X3sylNqS/Qw3PFP7
 kcxZPrLKjJI9t0ff2bN52haY3nqZkYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698224416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sXALUTd+dnBzEHkHpkc/V6eat3lRAGMOuQmdTB4GoOs=;
 b=dxFmzJByQ0bE4vE9EGDxJKvvjmEtpjRni5H0tZibYmqrZaCjBwVdqgrpAX9J/A+mkkwfI/
 zpbwsh0061nIeIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B11B913524;
 Wed, 25 Oct 2023 09:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7Y7HKh7ZOGXJDgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 25 Oct 2023 09:00:14 +0000
Date: Wed, 25 Oct 2023 11:00:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Marius Kittler <mkittler@suse.de>
Message-ID: <ZTjZHdNX6VHn42Ui@rei>
References: <20231023160242.3605-1-mkittler@suse.de>
 <20231023160242.3605-2-mkittler@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231023160242.3605-2-mkittler@suse.de>
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
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/5] Refactor ioctl02.c to use the new test API
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
> +	parentpid = getpid();
> +	childpid = SAFE_FORK();
> +	if (!childpid) {
> +		childfd = do_child_setup();
> +		if (childfd < 0)
> +			_exit(1);
> +		run_ctest();
> +		_exit(0);

This is stil mostly useless code, the do_child_setup() now uses safe
macros and as such cannot fail, the whole test will be aborted if any of
the SAFE_*() calls fails.

Hence there is no point in attempting to exit(1) because that is never
reached. The split of the child into two function does not make any
sense anymore. So this should really be:

	if (!childpid) {
		do_child();
		exit(0);
	}

>  	}
> -	cleanup();
>  
> -	tst_exit();
> -}
> +	TST_CHECKPOINT_WAIT(0);
>  
> -static void do_child(void)
> -{
> -	childfd = do_child_setup();
> -	if (childfd < 0)
> -		_exit(1);
> -	run_ctest();
> -	_exit(0);
> -}
> -
> -void do_child_uclinux(void)
> -{
> -	struct sigaction act;
> +	parentfd = SAFE_OPEN(parenttty, O_RDWR, 0777);
> +	/* flush tty queues to remove old output */
> +	SAFE_IOCTL(parentfd, TCFLSH, 2);
>  
> -	/* Set up the signal handlers again */
> -	act.sa_handler = (void *)sigterm_handler;
> -	act.sa_flags = 0;
> -	sigemptyset(&act.sa_mask);
> -	(void)sigaction(SIGTERM, &act, 0);
> +	/* run the parent test */
> +	run_ptest();
>  
> -	/* Run the normal child */
> -	do_child();
> +	TST_CHECKPOINT_WAKE(0);
>  }
>  
>  /*
>   * run_ptest() - setup the various termio structure values and issue
>   *		 the TCSETA ioctl call with the TEST macro.
>   */
> -static int run_ptest(void)
> +static void run_ptest(void)
>  {
> -	int i, rval;
> -
>  	/* Use "old" line discipline */
>  	termio.c_line = 0;
>  
> @@ -230,7 +93,7 @@ static int run_ptest(void)
>  	termio.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
>  
>  	/* Set control chars. */
> -	for (i = 0; i < NCC; i++) {
> +	for (int i = 0; i < NCC; i++) {
>  		if (i == VEOL2)
>  			continue;
>  		termio.c_cc[i] = CSTART;
> @@ -248,47 +111,26 @@ static int run_ptest(void)
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
> -	return chk_tty_parms();
> +	SAFE_IOCTL(parentfd, TCGETA, &termio);
> +	chk_tty_parms();
>  }
>  
> -static int run_ctest(void)
> +static void run_ctest(void)
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
> -	return 0;
> +	TST_CHECKPOINT_WAIT(0);
> +	tst_res(TINFO, "child: parent has finished testing");
> +	SAFE_CLOSE(childfd);
>  }
>  
> -static int chk_tty_parms(void)
> +static void chk_tty_parms(void)
>  {
>  	int i, flag = 0;
>  
>  	if (termio.c_line != 0) {
> -		tst_resm(TINFO, "line discipline has incorrect value %o",
> +		tst_res(TINFO, "line discipline has incorrect value %o",
>  			 termio.c_line);
>  		flag++;
>  	}
> @@ -301,7 +143,7 @@ static int chk_tty_parms(void)
>  	 */
>  #if 0
>  	if (termio.c_cflag != (B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL)) {
> -		tst_resm(TINFO, "cflag has incorrect value. %o",
> +		tst_res(TINFO, "cflag has incorrect value. %o",
>  			 termio.c_cflag);
>  		flag++;
>  	}
> @@ -309,19 +151,18 @@ static int chk_tty_parms(void)
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
> @@ -330,7 +171,7 @@ static int chk_tty_parms(void)
>  	if (!
>  	    (termio.c_lflag
>  	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
> -		tst_resm(TINFO, "lflag has incorrect value. %o",
> +		tst_res(TINFO, "lflag has incorrect value. %o",
>  			 termio.c_lflag);
>  		flag++;
>  	}
> @@ -339,130 +180,68 @@ static int chk_tty_parms(void)
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
> -	if (!flag)
> -		tst_resm(TINFO, "termio values are set as expected");
> -
> -	return flag;
> -}
> -
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
> +	if (flag != 0)
> +		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
> +				"%d %s", flag, flag > 1 ? "errors" : "error");
> +	else
> +		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");

I would prefer changing the TINFO statements above to TFAIL and simply
add:

	if (!flag)
		tst_res(TPASS, "TCGETA/TCSETA ioctl() flags are correct"


Since that actually makes it clear which part of the test failed.

Also you shouldn't add SUCCEEDED into the messages, the fact that the
test passed is printed by the test library already because of the TPASS
already.

>  }
>  
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
> +	TST_CHECKPOINT_WAKE(0);
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

This comment is no longer true.

> -	fd = SAFE_OPEN(NULL, devname, O_RDWR, 0777);
> +	int fd = SAFE_OPEN(device, O_RDWR, 0777);
>  
>  	/* Save the current device information - to be restored in cleanup() */
> -	SAFE_IOCTL(cleanup, fd, TCGETA, &save_io);
> +	SAFE_IOCTL(fd, TCGETA, &save_io);
>  
>  	/* Close the device */

And this comment is obvious. Generally the test is overcommented, I
would just remove most of the comments, since they are either obvious or
no longer true after the changes.

> -	SAFE_CLOSE(cleanup, fd);

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
