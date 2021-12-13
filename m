Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0CAC433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:31:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 988423C8BC0
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 17:31:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 839803C0B90
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:31:21 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 36CFA6002EA
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:31:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9FF66210F4;
 Mon, 13 Dec 2021 16:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639413078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XxMrLIsOY3pM8y/AWr1j4tPFlg5bVyG3YhXyWq1hec=;
 b=Dzptm5LpWNEkhsolRAzC5h5eLA24nrjFV1Fyyp4T398e4X9XaW2EAVfmhF0XSW+5TJZr44
 TNthcQPul0x+S62cZpEj0pCcCD3VhhkzGc9iqkTdGhxtN72yEvaqTTbxizK4vaBLFuFcKK
 zNxoxRttvTiNtLVyfvz2tSpwNvNlgko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639413078;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XxMrLIsOY3pM8y/AWr1j4tPFlg5bVyG3YhXyWq1hec=;
 b=H+Xk761z+wCSARkc3QcDhTYpyRWVvxMHTfHTbJeuDO/dzkPYjBeJiLr4IcsJ73ZAU7GVMH
 3+jXKqHx8YM3H1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F67B13E2B;
 Mon, 13 Dec 2021 16:31:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FO21HVZ1t2E3XwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Dec 2021 16:31:18 +0000
Date: Mon, 13 Dec 2021 17:32:43 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <Ybd1q80bXbPqzG4l@yuki>
References: <20211213034252.13698-1-sujiaxun@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213034252.13698-1-sujiaxun@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v1,
 1/2] syscalls/sched_get_priority_max01: Convert to new API
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
> +/*\
> + * [Description]
> + *
>   *	This is a Phase I test for the sched_get_priority_max(2) system call.
>   *	It is intended to provide a limited exposure of the system call.

Can we please get a better description than this?

Something along the lines that it gets max prio for different
schedulling policies and compares that with expected value?

>  #include <errno.h>
>  #include <sched.h>
> -#include "test.h"
> -
> -static void setup();
> -static void cleanup();
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"
> 
> -char *TCID = "sched_get_priority_max01";
> -
> -static struct test_case_t {
> +static struct test_case {
>  	char *desc;
>  	int policy;
>  	int retval;
> -} test_cases[] = {
> +} tcases[] = {
>  	{
>  	"Test for SCHED_OTHER", SCHED_OTHER, 0}, {
>  	"Test for SCHED_FIFO", SCHED_FIFO, 99}, {
>  	"Test for SCHED_RR", SCHED_RR, 99}

This formatting looks really strange, the opening and closing braces
should be on the same line as:

	{"foo", foo, 0},
	...

Also there is no point to repeat the "Test for" in each string, all that
needs to be stored in the desc is the name of the macro as a string.

>  };
> 
> -int TST_TOTAL = sizeof(test_cases) / sizeof(test_cases[0]);
> 
> -int main(int ac, char **av)
> +static void run_test(unsigned int nr)
>  {
> 
> -	int lc, ind;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> +	struct test_case *tc = &tcases[nr];
> 
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	TEST(tst_syscall(__NR_sched_get_priority_max, tc->policy));

Can we please switch to TST_EXP_POSITIVE() here?

This part should look like:

	TST_EXP_POSITIVE(...);

	if (!TST_PASS)
		return;

	if (TST_RET == tc->retval)
		tst_res(TPASS, ...);
	else
		tst_res(FAIL, ...);

> -		tst_count = 0;
> -
> -		for (ind = 0; ind < TST_TOTAL; ind++) {
> -			/*
> -			 * Call sched_get_priority_max(2)
> -			 */
> -			TEST(sched_get_priority_max(test_cases[ind].policy));
> -
> -			if (TEST_RETURN == test_cases[ind].retval) {
> -				tst_resm(TPASS, "%s Passed",
> -					 test_cases[ind].desc);
> -			} else {
> -				tst_resm(TFAIL | TTERRNO, "%s Failed, "
> -					 "sched_get_priority_max() returned %ld",
> -					 test_cases[ind].desc, TEST_RETURN);
> -			}
> -		}
> +	if (TST_RET == tc->retval) {
> +		tst_res(TPASS, "%s Passed",
> +			 tc->desc);
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "%s Failed, "
> +			 "sched_get_priority_max() returned %ld",
> +			 tc->desc, TST_RET);
>  	}
> 
> -	/* cleanup and exit */
> -	cleanup();
> -
> -	tst_exit();
> -
> -}
> -
> -/* setup() - performs all ONE TIME setup for this test */
> -void setup(void)
> -{
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
>  }
> 
> -/*
> - *cleanup() -  performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -}
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run_test,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
