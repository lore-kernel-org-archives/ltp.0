Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12F8EE14A0
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 15:45:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E7873CE9FF
	for <ltp@archiver.kernel.org>; Wed,  6 Sep 2023 17:45:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7C73C2755
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 17:45:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B8FB21400124
 for <ltp@lists.linux.it>; Wed,  6 Sep 2023 17:45:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8303A223AE;
 Wed,  6 Sep 2023 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694015140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RO4fP/rVEIMPBxbkBahjqahDQY76QYUAHqP4+xdzYg=;
 b=xL5Gr7su6eBTyP+Fllg29DDVJObf6cjKRqvkljjRq7Kt9PenD+aq+GbTVOOZQIF4uVYjPi
 G+HaVJ+PhJ8Lg05BjE97GiIg7YSXx2XjSxlvymdhI+QMgAc7i+RSL042VogpAXnYNtmFMV
 I25f6Xs3mlw33IMKXgt3ZYyLyKf76vY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694015140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4RO4fP/rVEIMPBxbkBahjqahDQY76QYUAHqP4+xdzYg=;
 b=NM7CvwdtSr41FCEVNN1lzjJSxu0bohYkkC10nSsuLxPOcB/KlRAraPb55XR7PB3JJkl5IG
 cQy6LFIOv3ZZovDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B6EC1333E;
 Wed,  6 Sep 2023 15:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HoZAGaSe+GQxawAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 06 Sep 2023 15:45:40 +0000
Message-ID: <a250c512-f989-18da-7fd5-3ea0923d4142@suse.cz>
Date: Wed, 6 Sep 2023 17:45:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
To: Marius Kittler <mkittler@suse.de>, ltp@lists.linux.it
References: <20230905115608.31192-1-mkittler@suse.de>
 <20230905115608.31192-2-mkittler@suse.de>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230905115608.31192-2-mkittler@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Refactor ioctl02.c to use the new test API
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 05. 09. 23 13:56, Marius Kittler wrote:
> This test code itself has been kept unchanged as much as possible
> (although it probably still has room for improvement).
> 
> See https://github.com/linux-test-project/ltp/issues/637 for related
> discussion.
> 
> Signed-off-by: Marius Kittler <mkittler@suse.de>
> ---
>   testcases/kernel/syscalls/ioctl/ioctl02.c | 221 +++++++++-------------
>   1 file changed, 92 insertions(+), 129 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
> index b4d4a3594..65a00821c 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl02.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
> @@ -1,6 +1,7 @@
>   /*
>    *   Copyright (c) International Business Machines  Corp., 2001
>    *   Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> + *   Copyright (c) 2023 Marius Kittler <mkittler@suse.de>
>    *
>    *   This program is free software;  you can redistribute it and/or modify
>    *   it under the terms of the GNU General Public License as published by

Let's start with header cleanup. The whole GPL license header should be 
replaced with SPDX string at the top of the file:

// SPDX-License-Identifier: GPL-2.0-or-later

 From the test info block, delete everything except the DESCRIPTION 
paragraph (without the header). The description comment block should 
start with /*\ instead of /* so that it gets picked up by our test 
metadata parser.

> @@ -64,15 +65,11 @@
>   #include <sys/types.h>
>   #include <sys/stat.h>
>   #include <termios.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -#include "lapi/ioctl.h"
> +#include "tst_test.h"
> +#include "tst_safe_macros.h"
>   
>   #define	CNUL	0
>   
> -char *TCID = "ioctl02";
> -int TST_TOTAL = 1;
> -
>   static struct termio termio, save_io;
>   
>   static char *parenttty, *childtty;

Initialize parentfd and childfd to -1 here, then the "closed" variable 
won't be needed.

> @@ -88,108 +85,72 @@ static int run_ctest(void);
>   static int chk_tty_parms();
>   static void setup(void);
>   static void cleanup(void);
> -static void help(void);
>   static void do_child(void);
>   void do_child_uclinux(void);
>   static void sigterm_handler(void);
>   
> -static int Devflag;
> -static char *devname;
> -
> -static option_t options[] = {
> -	{"D:", &Devflag, &devname},
> -	{NULL, NULL, NULL}
> -};
> +static char *device;
>   
> -int main(int ac, char **av)
> +static void verify_ioctl(void)
>   {
> -	int lc;
> -	int rval;
> -
> -	tst_parse_opts(ac, av, options, &help);
> +	parenttty = device;
> +	childtty = device;
>   
> +	parentpid = getpid();
> +	childpid = SAFE_FORK();
> +	if (childpid == 0) {	/* child */
>   #ifdef UCLINUX
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
> -
> -		childpid = FORK_OR_VFORK();
> -		if (childpid < 0)
> -			tst_brkm(TBROK, cleanup, "fork failed");
> -
> -		if (childpid == 0) {	/* child */
> -#ifdef UCLINUX
> -			if (self_exec(av[0], "dS", parentpid, childtty) < 0)
> -				tst_brkm(TBROK, cleanup, "self_exec failed");
> +		if (self_exec(av[0], "dS", parentpid, childtty) < 0)
> +			tst_brkm(TBROK, cleanup, "self_exec failed");
>   #else

We don't support uclibc anymore. The #ifdef should be removed along with 
self_exec(). Just call do_child() here.

> -			do_child();
> +		do_child();
>   #endif
> -		}
> -
> -		while (!sigusr1)
> -			sleep(1);
> -
> -		sigusr1 = 0;
> -
> -		parentfd = do_parent_setup();
> -		if (parentfd < 0) {
> -			kill(childpid, SIGTERM);
> -			waitpid(childpid, NULL, 0);
> -			cleanup();
> -		}
> +	}
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
> +	while (!sigusr1)
> +		sleep(1);

The signal sending and catching should probably be replaced with 
TST_CHECKPOINT_WAIT()/_WAKE().

>   
> -		if (rval != 0)
> -			tst_resm(TFAIL, "TCGETA/TCSETA tests FAILED with "
> -				 "%d %s", rval, rval > 1 ? "errors" : "error");
> -		else
> -			tst_resm(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
> +	sigusr1 = 0;
>   
> -		/* FIXME: check return codes. */
> -		(void)kill(childpid, SIGTERM);
> -		(void)waitpid(childpid, NULL, 0);
> +	parentfd = do_parent_setup();
> +	if (parentfd < 0) {

This error handling branch will never be used. SAFE_OPEN() and 
SAFE_IOCTL() in do_parent_setup() will automatically terminate the test 
on error.

You could also remove do_parent_setup() entirely and just call the 
SAFE_OPEN() and SAFE_IOCTL() here directly.

> +		kill(childpid, SIGTERM);
> +		waitpid(childpid, NULL, 0);
> +		cleanup();

Never call cleanup() directly!

> +	}
>   
> +	/* run the parent test */
> +	int rval = run_ptest();
> +	if (rval == -1) {
>   		/*
> -		 * Clean up things from the parent by restoring the
> -		 * tty device information that was saved in setup()
> -		 * and closing the tty file descriptor.
> +		 * Parent cannot set/get ioctl parameters.
> +		 * SIGTERM the child and cleanup.
>   		 */
> -		if (ioctl(parentfd, TCSETA, &save_io) == -1)
> -			tst_resm(TINFO, "ioctl restore failed in main");
> -		SAFE_CLOSE(cleanup, parentfd);
> -
> -		closed = 1;
> +		kill(childpid, SIGTERM);
> +		waitpid(childpid, NULL, 0);
> +		cleanup();
>   	}
> -	cleanup();
>   
> -	tst_exit();
> +	if (rval != 0)
> +		tst_res(TFAIL, "TCGETA/TCSETA tests FAILED with "
> +				"%d %s", rval, rval > 1 ? "errors" : "error");
> +	else
> +		tst_res(TPASS, "TCGETA/TCSETA tests SUCCEEDED");
> +
> +	/* FIXME: check return codes. */
> +	(void)kill(childpid, SIGTERM);
> +	(void)waitpid(childpid, NULL, 0);

kill() should be replaced with checkpoints. waitpid() will be done 
automatically by LTP library. The ioctl() and SAFE_CLOSE() below should 
be done in cleanup().

> +
> +	/*
> +	 * Clean up things from the parent by restoring the
> +	 * tty device information that was saved in setup()
> +	 * and closing the tty file descriptor.
> +	 */
> +	if (ioctl(parentfd, TCSETA, &save_io) == -1)
> +		tst_res(TINFO, "ioctl restore failed in main");
> +	SAFE_CLOSE(parentfd);
> +
> +	closed = 1;
>   }
>   
>   static void do_child(void)
> @@ -221,8 +182,6 @@ void do_child_uclinux(void)
>    */
>   static int run_ptest(void)
>   {
> -	int i, rval;
> -
>   	/* Use "old" line discipline */
>   	termio.c_line = 0;
>   
> @@ -230,7 +189,7 @@ static int run_ptest(void)
>   	termio.c_cflag = B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL;
>   
>   	/* Set control chars. */
> -	for (i = 0; i < NCC; i++) {
> +	for (int i = 0; i < NCC; i++) {
>   		if (i == VEOL2)
>   			continue;
>   		termio.c_cc[i] = CSTART;
> @@ -250,16 +209,10 @@ static int run_ptest(void)
>   
>   	TEST(ioctl(parentfd, TCSETA, &termio));

TEST(ioctl()) above should be changed to SAFE_IOCTL().

>   
> -	if (TEST_RETURN < 0) {
> -		tst_resm(TFAIL, "ioctl TCSETA failed : "
> -			 "errno = %d", TEST_ERRNO);
> -		return -1;
> -	}
> -
>   	/* Get termio and see if all parameters actually got set */
> -	rval = ioctl(parentfd, TCGETA, &termio);
> +	int rval = ioctl(parentfd, TCGETA, &termio);

Also change this to SAFE_IOCTL() and remove the error handling below.

>   	if (rval < 0) {
> -		tst_resm(TFAIL, "ioctl TCGETA failed.  Ending test.");
> +		tst_res(TFAIL, "ioctl TCGETA failed.  Ending test.");
>   		return -1;
>   	}
>   
> @@ -276,10 +229,10 @@ static int run_ctest(void)
>   

Replace signals with checkpoints here.

>   	sigterm = 0;
>   
> -	tst_resm(TINFO, "child: Got SIGTERM from parent.");
> +	tst_res(TINFO, "child: Got SIGTERM from parent.");
>   
>   	if (close(childfd) == -1)
> -		tst_resm(TINFO, "close() in run_ctest() failed");
> +		tst_res(TINFO, "close() in run_ctest() failed");
>   	return 0;
>   }
>   
> @@ -288,7 +241,7 @@ static int chk_tty_parms(void)
>   	int i, flag = 0;
>   
>   	if (termio.c_line != 0) {
> -		tst_resm(TINFO, "line discipline has incorrect value %o",
> +		tst_res(TINFO, "line discipline has incorrect value %o",
>   			 termio.c_line);
>   		flag++;
>   	}
> @@ -301,7 +254,7 @@ static int chk_tty_parms(void)
>   	 */
>   #if 0
>   	if (termio.c_cflag != (B50 | CS7 | CREAD | PARENB | PARODD | CLOCAL)) {
> -		tst_resm(TINFO, "cflag has incorrect value. %o",
> +		tst_res(TINFO, "cflag has incorrect value. %o",
>   			 termio.c_cflag);
>   		flag++;
>   	}
> @@ -312,7 +265,7 @@ static int chk_tty_parms(void)
>   			if (termio.c_cc[VEOL2] == CNUL) {
>   				continue;
>   			} else {
> -				tst_resm(TINFO, "control char %d has "
> +				tst_res(TINFO, "control char %d has "
>   					 "incorrect value %d %d", i,
>   					 termio.c_cc[i], CNUL);
>   				flag++;
> @@ -321,7 +274,7 @@ static int chk_tty_parms(void)
>   		}
>   
>   		if (termio.c_cc[i] != CSTART) {
> -			tst_resm(TINFO, "control char %d has incorrect "
> +			tst_res(TINFO, "control char %d has incorrect "
>   				 "value %d.", i, termio.c_cc[i]);
>   			flag++;
>   		}
> @@ -330,7 +283,7 @@ static int chk_tty_parms(void)
>   	if (!
>   	    (termio.c_lflag
>   	     && (ISIG | ICANON | XCASE | ECHO | ECHOE | NOFLSH))) {
> -		tst_resm(TINFO, "lflag has incorrect value. %o",
> +		tst_res(TINFO, "lflag has incorrect value. %o",
>   			 termio.c_lflag);
>   		flag++;
>   	}
> @@ -339,34 +292,32 @@ static int chk_tty_parms(void)
>   	    (termio.c_iflag
>   	     && (BRKINT | IGNPAR | INPCK | ISTRIP | ICRNL | IUCLC | IXON | IXANY
>   		 | IXOFF))) {
> -		tst_resm(TINFO, "iflag has incorrect value. %o",
> +		tst_res(TINFO, "iflag has incorrect value. %o",
>   			 termio.c_iflag);
>   		flag++;
>   	}
>   
>   	if (!(termio.c_oflag && (OPOST | OLCUC | ONLCR | ONOCR))) {
> -		tst_resm(TINFO, "oflag has incorrect value. %o",
> +		tst_res(TINFO, "oflag has incorrect value. %o",
>   			 termio.c_oflag);
>   		flag++;
>   	}
>   
>   	if (!flag)
> -		tst_resm(TINFO, "termio values are set as expected");
> +		tst_res(TINFO, "termio values are set as expected");
>   
>   	return flag;
>   }
>   
>   static int do_parent_setup(void)
>   {
> -	int pfd;
> -
> -	pfd = SAFE_OPEN(cleanup, parenttty, O_RDWR, 0777);
> +	int pfd = SAFE_OPEN(parenttty, O_RDWR, 0777);

Assign the file descriptor directly to parentfd so that it can be closed 
in cleanup() if SAFE_IOCTL() below fails.

>   
>   	/* unset the closed flag */
>   	closed = 0;
>   
>   	/* flush tty queues to remove old output */
> -	SAFE_IOCTL(cleanup, pfd, TCFLSH, 2);
> +	SAFE_IOCTL(pfd, TCFLSH, 2);
>   	return pfd;
>   }
>   
> @@ -376,7 +327,7 @@ static int do_child_setup(void)
>   
>   	cfd = open(childtty, O_RDWR, 0777);

Use SAFE_OPEN() here and remove the error handling below.

>   	if (cfd < 0) {
> -		tst_resm(TINFO, "Could not open %s in do_child_setup(), errno "
> +		tst_res(TINFO, "Could not open %s in do_child_setup(), errno "
>   			 "= %d", childtty, errno);
>   		/* signal the parent so we don't hang the test */
>   		kill(parentpid, SIGUSR1);
> @@ -385,7 +336,7 @@ static int do_child_setup(void)
>   
>   	/* flush tty queues to remove old output */
>   	if (ioctl(cfd, TCFLSH, 2) < 0) {

SAFE_IOCTL() here and then use checkpoints.

> -		tst_resm(TINFO, "ioctl TCFLSH failed. : errno = %d", errno);
> +		tst_res(TINFO, "ioctl TCFLSH failed. : errno = %d", errno);
>   		/* signal the parent so we don't hang the test */
>   		kill(parentpid, SIGUSR1);
>   		return -1;
> @@ -415,24 +366,26 @@ static void sigusr2_handler(void)
>   	sigusr2 = 1;
>   }
>   
> -static void help(void)
> -{
> -	printf("  -D <tty device> : for example, /dev/tty[0-9]\n");
> -}
> -
>   static void setup(void)
>   {
> +#ifdef UCLINUX
> +	do_child_uclinux();
> +#endif

We don't support uclibc anymore.

> +
> +	if (!device)
> +		tst_brk(TBROK, "You must specify a tty device with -D option");
> +
>   	int fd;
>   	struct sigaction act;
>   
>   	/* XXX: TERRNO required all over the place */
> -	fd = SAFE_OPEN(NULL, devname, O_RDWR, 0777);
> +	fd = SAFE_OPEN(device, O_RDWR, 0777);
>   
>   	/* Save the current device information - to be restored in cleanup() */
> -	SAFE_IOCTL(cleanup, fd, TCGETA, &save_io);
> +	SAFE_IOCTL(fd, TCGETA, &save_io);
>   
>   	/* Close the device */
> -	SAFE_CLOSE(cleanup, fd);
> +	SAFE_CLOSE(fd);
>   
>   	/* Set up the signal handlers */
>   	act.sa_handler = (void *)sigterm_handler;
> @@ -453,16 +406,26 @@ static void setup(void)
>   	(void)sigaction(SIGTTOU, &act, 0);
>   
>   	sigterm = sigusr1 = sigusr2 = 0;
> -
> -	TEST_PAUSE;
>   }
>   
>   static void cleanup(void)
>   {

Check whether parentfd >= 0 instead and use SAFE_IOCTL()/SAFE_CLOSE().

>   	if (!closed) {
>   		if (ioctl(parentfd, TCSETA, &save_io) == -1)
> -			tst_resm(TINFO, "ioctl restore failed in cleanup()");
> +			tst_res(TINFO, "ioctl restore failed in cleanup()");
>   		if (close(parentfd) == -1)
> -			tst_resm(TINFO, "close() failed in cleanup()");
> +			tst_res(TINFO, "close() failed in cleanup()");
>   	}
>   }
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
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

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
