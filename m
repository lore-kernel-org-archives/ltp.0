Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349C0C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 08:44:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 616463C958C
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 10:44:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DAC13C60C2
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 10:43:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE0361A01DF4
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 10:43:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 84D1534AE2;
 Tue, 19 Jul 2022 08:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658220228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8mpLH1QUxIVI894JrPut6xaCut6Mm5H7HYbg2LGD1eI=;
 b=AqC8LCChM2V3XBxIk4X7G9Jtm0eXAT0xVua1aHyFIXPEvnXLTZEKLF2ZFhCLwwZUtUYicI
 XKPCidmSG/9e/NV3jml7yCZNjUAqxlWxCa3CAxSReY46fpvCM1O5oaUMrB3V3h7xwV5jCf
 Z0p5IgLPpZkAPZlXtIwxFdaoKkICQg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658220228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8mpLH1QUxIVI894JrPut6xaCut6Mm5H7HYbg2LGD1eI=;
 b=DakTIjSAxzBgcOAdTAU/sAG/VxMVuvelOisF4UKfGHcnT4WWTlvCffdgulFlQHK9JAFFkB
 ZG56gzzjvxiS4ACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6749813A72;
 Tue, 19 Jul 2022 08:43:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id z4OeF8Ru1mJNUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 19 Jul 2022 08:43:48 +0000
Date: Tue, 19 Jul 2022 10:45:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Message-ID: <YtZvDr3vb51AfUQc@rei>
References: <1658198910-21458-1-git-send-email-zhanghongchen@loongson.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1658198910-21458-1-git-send-email-zhanghongchen@loongson.cn>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syslog11: convert to new LTP API
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
> convert to use new LTP API for syslog11.

You should at least mention here that the printk file is now saved and
restored since that is a functional change.

Or even better do the functional change that saves and restores the file
in a separate patch.

> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
>  testcases/kernel/syscalls/syslog/syslog11.c | 231 +++++-----------------------
>  1 file changed, 42 insertions(+), 189 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
> index b9540ef..b6fb4a8 100644
> --- a/testcases/kernel/syscalls/syslog/syslog11.c
> +++ b/testcases/kernel/syscalls/syslog/syslog11.c
> @@ -1,212 +1,65 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

The original lincense is GPL-2.0-only we can't change the license to
or-later here.

>  /*
> - * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + * Author: Madhu T L <madhu.tarikere@wipro.com>
>   */
> -/**********************************************************
> - *
> - *    TEST IDENTIFIER   : syslog11
> - *
> - *    EXECUTED BY       : root / superuser
> - *
> - *    TEST TITLE        : Basic tests for syslog(2)
> - *
> - *    TEST CASE TOTAL   : 11
> - *
> - *    AUTHOR            : Madhu T L <madhu.tarikere@wipro.com>
> - *
> - *    SIGNALS
> - *      Uses SIGUSR1 to pause before test if option set.
> - *      (See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	Verify that, syslog(2) is successful for type ranging from 1 to 8
> - *
> - *	Setup:
> - *	  Setup signal handling.
> - *	  Test caller is superuser
> - *	  Check existence of user nobody
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - *	Test:
> - *	 Loop if the proper options are given.
> - *	  Execute system call
> - *	  Check return value, if not successful,
> - *		 Issue FAIL message
> - *	  Otherwise,
> - *		Issue PASS message
> - *
> - *	Cleanup:
> - *	  Print errno log and/or timing stats if options given
> - *
> - * USAGE:  <for command-line>
> - *  syslog11 [-c n] [-e] [-f] [-h] [-i n] [-I x] [-p] [-P x] [-t]
> - *		where,  -c n : Run n copies concurrently.
> - *			-e   : Turn on errno logging.
> - *			-f   : Turn off functional testing
> - *			-h   : Show help screen
> - *			-i n : Execute test n times.
> - *			-I x : Execute test for x seconds.
> - *			-p   : Pause for SIGUSR1 before starting
> - *			-P x : Pause for x seconds between iterations.
> - *			-t   : Turn on syscall timing.
> +
> +/*
> + * [Description]
> + * Verify that, syslog(2) is successful for type ranging from 1 to 8
>   *
> - ****************************************************************/
> + */
>  
>  #include <errno.h>
> -#include <pwd.h>
> -#include <sys/types.h>
> -#include <unistd.h>
> -#include <linux/unistd.h>
> -#include <sys/syscall.h>
> -#include "test.h"
> -#include "safe_macros.h"
>  
> -#define UNEXP_RET_VAL	-1
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "tst_safe_macros.h"
>  
> -struct test_case_t {		/* test case structure */
> +struct tcase {		/* test case structure */
>  	int type;		/* 1st arg. */
>  	char *buf;		/* 2nd arg. */
>  	int len;		/* 3rd arg. */
> -	int (*setup) (void);	/* Individual setup routine */
> -	void (*cleanup) (void);	/* Individual cleanup routine */
>  	char *desc;		/* Test description */
>  };

I would have removed these comments as well, there is no point in
commenting the obvious here.

> -char *TCID = "syslog11";
> -static int testno;
>  static char buf;
> -static struct passwd *ltpuser;
> -
> -static void setup(void);
> -static void cleanup(void);
> -static int setup1(void);
> -static void cleanup1(void);
>  
> -#define syslog(arg1, arg2, arg3) syscall(__NR_syslog, arg1, arg2, arg3)
> +#define syslog(arg1, arg2, arg3) tst_syscall(__NR_syslog, arg1, arg2, arg3)
>  
> -static struct test_case_t tdat[] = {
> +static struct tcase tcases[] = {
>  	/* Type 0 and 1 are currently not implemented, always returns success */
> -	{0, &buf, 0, NULL, NULL, "type 0/Close the log"},
> -	{1, &buf, 0, NULL, NULL, "type 1/Open the log"},
> -	{2, &buf, 0, NULL, NULL, "type 2/Read from the log"},
> -	{3, &buf, 0, NULL, NULL, "type 3/Read ring buffer"},
> -	{3, &buf, 0, setup1, cleanup1, "type 3/Read ring buffer for non-root "
> -	 "user"},

Looking at the syslog12.c the non-root user read with EPERM is covered
there, so it's fine to drop it from this test. But please mention that
in the commit message as well.

> -	/* Next two lines will clear dmesg. Uncomment if that is okay. -Robbie Williamson */
> -	/*    { 4, &buf, 0, NULL, NULL, "type 4/Read and clear ring buffer" },            */
> -	/*    { 5, &buf, 0, NULL, NULL, "type 5/Clear ring buffer" },                     */
> -
> -	{8, NULL, 1, NULL, NULL, "type 8/Set log level to 1"},
> -	{8, NULL, 7, NULL, NULL, "type 8/Set log level to 7(default)"},
> -	{6, NULL, 0, NULL, NULL, "type 6/Disable printk's to console"},
> -	{7, NULL, 0, NULL, NULL, "type 7/Enable printk's to console"},
> +	{0, &buf, 0, "type 0/Close the log"},
> +	{1, &buf, 0, "type 1/Open the log"},
> +	{2, &buf, 0, "type 2/Read from the log"},
> +	{3, &buf, 0, "type 3/Read ring buffer"},
> +	/*
> +	 * Next two lines will clear dmesg.
> +	 * Uncomment if that is okay. -Robbie Williamson
> +	 */
> +	/*
> +	 * { 4, &buf, 0, "type 4/Read and clear ring buffer" },
> +	 * { 5, &buf, 0, "type 5/Clear ring buffer" },
> +	 */
> +	{8, NULL, 1, "type 8/Set log level to 1"},
> +	{8, NULL, 7, "type 8/Set log level to 7(default)"},
> +	{6, NULL, 0, "type 6/Disable printk's to console"},
> +	{7, NULL, 0, "type 7/Enable printk's to console"},
>  };
>  
> -int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);
> -
> -int main(int argc, char **argv)
> +static void run(unsigned int n)
>  {
> -	int lc;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		/* reset tst_count in case we are looping */
> -		tst_count = 0;
> -
> -		for (testno = 0; testno < TST_TOTAL; ++testno) {
> +	struct tcase *tc = &tcases[n];
>  
> -			if (tdat[testno].setup && tdat[testno].setup()) {
> -				/* Setup failed, skip this testcase */
> -				continue;
> -			}
> -
> -			TEST(syslog(tdat[testno].type, tdat[testno].buf,
> -				    tdat[testno].len));
> -
> -			if (TEST_RETURN == UNEXP_RET_VAL) {
> -				if (TEST_ERRNO == EPERM && geteuid() != 0) {
> -					tst_resm(TPASS,
> -						 "syslog() passed for %s (non-root EPERM is OK)",
> -						 tdat[testno].desc);
> -				} else {
> -					tst_resm(TFAIL,
> -						 "syslog() failed for %s: errno "
> -						 "%d (%s)", tdat[testno].desc,
> -						 TEST_ERRNO, strerror(errno));
> -				}
> -			} else {
> -				tst_resm(TPASS, "syslog() successful for %s",
> -					 tdat[testno].desc);
> -			}
> -
> -			if (tdat[testno].cleanup) {
> -				tdat[testno].cleanup();
> -			}
> -		}
> -	}
> -	cleanup();
> -
> -	tst_exit();
> -}
> -
> -int setup1(void)
> -{
> -	/* Change effective user id to nodody */
> -	if (seteuid(ltpuser->pw_uid) == -1) {
> -		tst_resm(TBROK, "seteuid failed to set the effective"
> -			 " uid to %d", ltpuser->pw_uid);
> -		return 1;
> -	}
> -	return 0;
> +	TST_EXP_PASS(syslog(tc->type, tc->buf, tc->len),
> +			"syslog() with %s", tc->desc);
>  }
>  
> -void cleanup1(void)
> -{
> -	/* Change effective user id to root */
> -	SAFE_SETEUID(NULL, 0);
> -}
> -
> -/*
> - * setup()
> - *	performs all ONE TIME setup for this test
> - */
> -void setup(void)
> -{
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	/* Check for nobody_uid user id */
> -	if ((ltpuser = getpwnam("nobody")) == NULL) {
> -		tst_brkm(TBROK, NULL, "nobody user id doesn't exist");
> -	}
> -
> -	/* Pause if that option was specified
> -	 * TEST_PAUSE contains the code to fork the test with the -c option.
> -	 */
> -	TEST_PAUSE;
> -}
> -
> -/*
> - * cleanup()
> - *	performs all ONE TIME cleanup for this test at
> - *	completion or premature exit
> - */
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.test = run,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"!/proc/sys/kernel/printk", NULL},
> +		{NULL, NULL}
> +	},
> +	.needs_root = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
