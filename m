Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4102C433F5
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 16:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC4D73C8CF4
	for <ltp@archiver.kernel.org>; Mon, 13 Dec 2021 17:04:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9CF33C89B1
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:04:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7B8B9601A18
 for <ltp@lists.linux.it>; Mon, 13 Dec 2021 17:04:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA34B210F9;
 Mon, 13 Dec 2021 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639411468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0IPLeTcWfRlUTatYAvLUaKzJclQ15QbCmqyeB9YcqsI=;
 b=H4DSQmKxAY0+AuQMbFgTyy5FEZaHfLQ/gze/ssL1JkitZWcDXfgWbYxlvyOPK2Yp6Q1m9v
 K+Vrrf6ip/4QDHSPGZK7Lnl6pwNd/ez08i7PHRXY0a0nVKGUQUY4btifS6XWKK1L9oVYrA
 GjSVjD2c5YfnFb6Xrss1+Kb7TPjAU1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639411468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0IPLeTcWfRlUTatYAvLUaKzJclQ15QbCmqyeB9YcqsI=;
 b=ZCxo0lCHM1RPgW79VqL1WCikoMmH7zs+mI2CbInhr3CwEkmtGJIscAnDaYoH379cPqNI7H
 5FGv63uw77Mf/gCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97F4113E3A;
 Mon, 13 Dec 2021 16:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 76IZJAxvt2FWVAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Dec 2021 16:04:28 +0000
Date: Mon, 13 Dec 2021 17:05:53 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: sujiaxun <sujiaxun@uniontech.com>
Message-ID: <YbdvYXQ1CwjzhjO6@yuki>
References: <20211213034213.10306-1-sujiaxun@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211213034213.10306-1-sujiaxun@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [v1] syscalls/symlinkat01: Convert to new API
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
> -static void mysymlinkat_test(struct test_struct *desc)
> +static void run_test(unsigned int nr)
>  {
>  	int fd;
> +	struct test_case *tc = &tcases[nr];
> +
> +	setup_every_copy();
> 
> -	TEST(mysymlinkat(desc->oldfn, *desc->newfd, desc->newfn));
> -
> -	/* check return code */
> -	if (TEST_ERRNO == desc->expected_errno) {
> -		if (TEST_RETURN == 0 && desc->referencefn1 != NULL) {
> +	TEST(tst_syscall(__NR_symlinkat, tc->oldfn, *tc->newfd, tc->newfn));
> +	if (TST_ERR == tc->expected_errno) {
> +		if (TST_RET == 0 && tc->referencefn1 != NULL) {
>  			int tnum = rand(), vnum = ~tnum;
> 
> -			fd = SAFE_OPEN(cleanup, desc->referencefn1, O_RDWR);
> -			SAFE_WRITE(cleanup, 1, fd, &tnum, sizeof(tnum));
> -			SAFE_CLOSE(cleanup, fd);
> +			fd = SAFE_OPEN(tc->referencefn1, O_RDWR);
> +			SAFE_WRITE(1, fd, &tnum, sizeof(tnum));
> +			SAFE_CLOSE(fd);
> 
> -			fd = SAFE_OPEN(cleanup, desc->referencefn2, O_RDONLY);
> -			SAFE_READ(cleanup, 1, fd, &vnum, sizeof(vnum));
> -			SAFE_CLOSE(cleanup, fd);
> +			fd = SAFE_OPEN(tc->referencefn2, O_RDONLY);
> +			SAFE_READ(1, fd, &vnum, sizeof(vnum));
> +			SAFE_CLOSE(fd);
> 
>  			if (tnum == vnum)
> -				tst_resm(TPASS, "Test passed");
> +				tst_res(TPASS, "Test passed");
>  			else
> -				tst_resm(TFAIL,
> +				tst_res(TFAIL,
>  					 "The link file's content isn't as same as the original file's "
>  					 "although symlinkat returned 0");
>  		} else {
> -			tst_resm(TPASS,
> +			tst_res(TPASS,
>  				 "symlinkat() returned the expected  errno %d: %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> +				 TST_ERR, strerror(TST_ERR));
>  		}

I think that the test would be much clearer to read if we split it into
two testcases, one that checks for successfull symlink creating and one
that checks for errors. Then we could easily use the TST_EXP_FAIL()
macros etc.

>  	} else {
> -		tst_resm(TFAIL,
> -			 TEST_RETURN ==
> +		tst_res(TFAIL,
> +			 TST_RET ==
>  			 0 ? "symlinkat() surprisingly succeeded" :
> -			 "symlinkat() Failed, errno=%d : %s", TEST_ERRNO,
> -			 strerror(TEST_ERRNO));
> +			 "symlinkat() Failed, errno=%d : %s", TST_ERR,
> +			 strerror(TST_ERR));
>  	}
>  }
> 
> @@ -214,27 +145,24 @@ static void setup(void)
>  {
>  	char *tmp;
>  	int fd;
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	tst_tmpdir();
> -
> -	SAFE_MKDIR(cleanup, TEST_DIR1, 0700);
> -	SAFE_MKDIR(cleanup, TEST_DIR3, 0700);
> -	olddirfd = SAFE_OPEN(cleanup, TEST_DIR1, O_DIRECTORY);
> -	deldirfd = SAFE_OPEN(cleanup, TEST_DIR3, O_DIRECTORY);
> -	SAFE_RMDIR(cleanup, TEST_DIR3);
> -	fd = SAFE_OPEN(cleanup, TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
> -	SAFE_CLOSE(cleanup, fd);
> +
> +	SAFE_MKDIR(TEST_DIR1, 0700);
> +	SAFE_MKDIR(TEST_DIR3, 0700);
> +	olddirfd = SAFE_OPEN(TEST_DIR1, O_DIRECTORY);
> +	deldirfd = SAFE_OPEN(TEST_DIR3, O_DIRECTORY);
> +	SAFE_RMDIR(TEST_DIR3);
> +	fd = SAFE_OPEN(TEST_DIR1 "/" TEST_FILE1, O_CREAT | O_EXCL, 0600);
> +	SAFE_CLOSE(fd);
> 
>  	/* gratuitous memory leak here */
>  	tmp = strdup(dpathname);
>  	snprintf(dpathname, sizeof(dpathname), tmp, get_current_dir_name());

Can we fix this mess as well? There is no point actually in having the
format in a variable like this we can easily instead do:

	char *pwd;

	pwd = get_current_dir_name();
	snprintf(dpathname, sizeof(dpahtname), "%s/" TESTDIR2 "/" TEST_FILE1, pwd);
	free(pwd);

And that fixes two memory leaks we had there.

> -
> -	TEST_PAUSE;
>  }
> 
> -static void cleanup(void)
> -{
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +    .min_kver = "2.6.16",
> +	.setup = setup,
> +    .tcnt = ARRAY_SIZE(tcases),
> +    .test = run_test,
> +    .needs_tmpdir = 1,
> +};

Other than that there are a few whitespaces wrong, see output of
'make check'

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
