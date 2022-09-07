Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1490C38145
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 07:18:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F40AB3CA97F
	for <ltp@archiver.kernel.org>; Wed,  7 Sep 2022 09:18:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71EBF3CA8F5
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 09:17:56 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7C4391000B52
 for <ltp@lists.linux.it>; Wed,  7 Sep 2022 09:17:55 +0200 (CEST)
Received: by mail-qk1-x733.google.com with SMTP id w18so9855689qki.8
 for <ltp@lists.linux.it>; Wed, 07 Sep 2022 00:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=+H9/81xqq9ukWv90rh1THYxj3WBOFtyxQWRIev+F02c=;
 b=SzbjM0JDHCbCBNGQwN2vjoasU+L43MeZZV0UmuGBZu66ap16f1DSqh4FgMDdhczR2C
 18PzyjS+uo09rg/4Fado/4ap1itM0+cCPzZ9OwbLlLaFPtesc990hL0MyNc1fg5GzMrv
 KuhCbOMXjal2tSfBZe4vDQOrNMtoCtsldzFOv9aYVNqOCo8mwSt5wCJcvUfwvIvvpaOn
 v+epH2X12NDqWZxnmsnxD4UiMcJh4DUMLxDvwK/AbbLrbyXT8t/EoNenj7H7WzmKoVo4
 z2A5dhQG8yGM9AZxcSMfNWp95acwDxCXd85dMn/uKBwyw/VRZqh9kt3+PdlAA3ejtADT
 WrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=+H9/81xqq9ukWv90rh1THYxj3WBOFtyxQWRIev+F02c=;
 b=YjYq3CKCf2xe0lU2LqWw/4QHg1gAn+qw4oFPRmFFT0IYvdKscUbdFFk9Y/bX6uXvf/
 6QWC7Xkb1InfbWUkZPkFoqQR3ssyPcJTPrrVhqjrmhttjx3pZKTjj0ysM4t9JMeYo7OD
 3ElGkUgZF7RjMIfh1m3CaTI5ynT0yTKAGwRGwfdgKGYMU5GbfFj8iznlt166BaLudIsW
 rhRtWEGHusiJG1d85uaZA45IpPDhBPSsgdBkmBLjUelYj9/2XZuu6RZqkhj5aybAe8Kh
 6X/vJ7wj3mBQo1A1QXoEHG26vSfEXcjJTKpWYo3pQ/9VqJOzIN8UG0WokLvDdD1D4DnV
 rruQ==
X-Gm-Message-State: ACgBeo0CAPn0x0kKrcnNZEN2rlG+fVshbZ3YumL8xDEBxyIS78H/c/ch
 ILbpucNvKZxl87veWZNxUZ3zihJvP2Oegg==
X-Google-Smtp-Source: AA6agR4++zk0dtpmyLmcbv20XyDrwZq/nY/xvAfrRd70kULiJPuPsxE1uzfJJH8KZwh0M6h8DdmSKw==
X-Received: by 2002:a37:912:0:b0:6bc:8244:b073 with SMTP id
 18-20020a370912000000b006bc8244b073mr1683648qkj.37.1662535074113; 
 Wed, 07 Sep 2022 00:17:54 -0700 (PDT)
Received: from google.com (123.178.145.34.bc.googleusercontent.com.
 [34.145.178.123]) by smtp.gmail.com with ESMTPSA id
 k6-20020a05620a414600b006bb78d095c5sm13983076qko.79.2022.09.07.00.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 00:17:53 -0700 (PDT)
Date: Wed, 7 Sep 2022 07:17:50 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YxhFnmERyC1V381+@google.com>
References: <20220906092615.15116-1-pvorel@suse.cz>
 <20220906092615.15116-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220906092615.15116-4-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fanotify14: Use TST_EXP_FD_ERRNO()
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 06, 2022 at 11:26:15AM +0200, Petr Vorel wrote:
> That greatly simplifies the code.

This looks OK to me, nice work!

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  .../kernel/syscalls/fanotify/fanotify14.c     | 118 +++++-------------
>  1 file changed, 33 insertions(+), 85 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify14.c b/testcases/kernel/syscalls/fanotify/fanotify14.c
> index aa4db586e..47d013c9f 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify14.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify14.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2018 Matthew Bobrowski. All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2020-2022
>   *
>   * Started by Matthew Bobrowski <mbobrowski@mbobrowski.org>
>   */
> @@ -48,6 +49,7 @@ static int fan_report_target_fid_unsupported;
>  static struct test_case_t {
>  	unsigned int init_flags;
>  	unsigned int mark_flags;
> +	/* zero mask expects to fail on fanotify_init() */
>  	unsigned long long mask;
>  	int expected_errno;
>  } test_cases[] = {
> @@ -111,7 +113,6 @@ static struct test_case_t {
>  
>  static void do_test(unsigned int number)
>  {
> -	int ret;
>  	struct test_case_t *tc = &test_cases[number];
>  
>  	if (fan_report_target_fid_unsupported && tc->init_flags & FAN_REPORT_TARGET_FID) {
> @@ -120,101 +121,48 @@ static void do_test(unsigned int number)
>  		return;
>  	}
>  
> -	fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY);
> -	if (fanotify_fd < 0) {
> -		if (errno == tc->expected_errno) {
> -			tst_res(TPASS,
> -				"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) "
> -				"failed with error %d as expected",
> -				fanotify_fd,
> -				tc->init_flags, tc->expected_errno);
> -			return;
> -		}
> -		tst_brk(TBROK | TERRNO,
> -			"fanotify_fd=%d, fanotify_init(%x, O_RDONLY) failed",
> -			fanotify_fd,
> -			tc->init_flags);
> -	}
> +	TST_EXP_FD_ERRNO(fanotify_fd = fanotify_init(tc->init_flags, O_RDONLY),
> +			 !tc->mask && tc->expected_errno ? tc->expected_errno : 0);
>  
> -	/*
> -	 * A test case with a mask set to zero indicate that they've been
> -	 * specifically designed to test and fail on the fanotify_init()
> -	 * system call.
> -	 */
> -	if (tc->mask == 0) {
> -		tst_res(TFAIL,
> -			"fanotify_fd=%d fanotify_init(%x, O_RDONLY) "
> -			"unexpectedly succeeded when tests with mask 0 are "
> -			"expected to fail when calling fanotify_init()",
> -			fanotify_fd,
> -			tc->init_flags);
> +	if (fanotify_fd < 0)
> +		return;
> +
> +	if (!tc->mask)
>  		goto out;
> -	}
>  
>  	/* Set mark on non-dir only when expecting error ENOTDIR */
>  	const char *path = tc->expected_errno == ENOTDIR ? FILE1 : MNTPOINT;
>  
> -	ret = fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
> -				tc->mask, AT_FDCWD, path);
> -	if (ret < 0) {
> -		if (errno == tc->expected_errno) {
> -			tst_res(TPASS,
> -				"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, "
> -				"%llx, AT_FDCWD, %s) failed with error %d "
> -				"as expected",
> -				ret,
> -				fanotify_fd,
> -				tc->mark_flags,
> -				tc->mask,
> -				path, tc->expected_errno);
> -			/*
> -			 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
> -			 * Try to set an inode mark on a directory and it should succeed.
> -			 * Try to set directory events in filesystem mark mask on non-dir
> -			 * and it should succeed.
> -			 */
> -			if (tc->expected_errno == ENOTDIR) {
> -				SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
> -						   tc->mask, AT_FDCWD, MNTPOINT);
> -				tst_res(TPASS,
> -					"Adding an inode mark on directory did not fail with "
> -					"ENOTDIR error as on non-dir inode");
> -			}
> -			if (tc->expected_errno == ENOTDIR &&
> -			    !(tc->mark_flags & FAN_MARK_ONLYDIR)) {
> -				SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags |
> -						   FAN_MARK_FILESYSTEM, tc->mask,
> -						   AT_FDCWD, FILE1);
> -				tst_res(TPASS,
> -					"Adding a filesystem mark on non-dir did not fail with "
> -					"ENOTDIR error as with an inode mark");
> -			}
> +	TST_EXP_FD_ERRNO(fanotify_mark(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
> +								   tc->mask, AT_FDCWD, path),
> +					 tc->expected_errno);
>  
> -			goto out;
> +	/*
> +	 * ENOTDIR are errors for events/flags not allowed on a non-dir inode.
> +	 * Try to set an inode mark on a directory and it should succeed.
> +	 * Try to set directory events in filesystem mark mask on non-dir
> +	 * and it should succeed.
> +	 */
> +	if (TST_PASS && tc->expected_errno == ENOTDIR) {
> +		SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags,
> +				   tc->mask, AT_FDCWD, MNTPOINT);
> +		tst_res(TPASS,
> +			"Adding an inode mark on directory did not fail with "
> +			"ENOTDIR error as on non-dir inode");
> +
> +		if (!(tc->mark_flags & FAN_MARK_ONLYDIR)) {
> +			SAFE_FANOTIFY_MARK(fanotify_fd, FAN_MARK_ADD | tc->mark_flags |
> +					   FAN_MARK_FILESYSTEM, tc->mask,
> +					   AT_FDCWD, FILE1);
> +			tst_res(TPASS,
> +				"Adding a filesystem mark on non-dir did not fail with "
> +				"ENOTDIR error as with an inode mark");
>  		}
> -		tst_brk(TBROK | TERRNO,
> -			"ret=%d, fanotify_mark(%d, FAN_MARK_ADD | %x, %llx, "
> -			"AT_FDCWD, %s) failed",
> -			ret,
> -			fanotify_fd,
> -			tc->mark_flags,
> -			tc->mask,
> -			FILE1);
>  	}
>  
> -	tst_res(TFAIL,
> -		"fanotify_fd=%d, ret=%d, fanotify_init(%x, O_RDONLY) and "
> -		"fanotify_mark(%d, FAN_MARK_ADD | %x, %llx, AT_FDCWD, %s) did "
> -		"not return any errors as expected",
> -		fanotify_fd,
> -		ret,
> -		tc->init_flags,
> -		fanotify_fd,
> -		tc->mark_flags,
> -		tc->mask,
> -		FILE1);
>  out:
> -	SAFE_CLOSE(fanotify_fd);
> +	if (fanotify_fd > 0)
> +		SAFE_CLOSE(fanotify_fd);
>  }
>  
>  static void do_setup(void)
> -- 
> 2.37.3
> 
/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
