Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E9EC433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 13:23:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 578773C9CB0
	for <ltp@archiver.kernel.org>; Wed,  9 Feb 2022 14:23:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E2B23C013D
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 14:23:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D6A1E1A01126
 for <ltp@lists.linux.it>; Wed,  9 Feb 2022 14:23:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 090811F383;
 Wed,  9 Feb 2022 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644413022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ivtq47mv+13xPERBP4wQJuCQjU7gibb31MiZLPg6zTk=;
 b=17kVwgwYL6mZeCyhuVKsLSsDtdusHfDF3URN4JZXaZljOf2f+rz8oUQ9L+7xrcKH/RCipt
 r8gEdcF/J0KInwvEBd8j+X/UG4AtG7zxSlGqhCR4uv7ZGaFEfN5WRj0HdW6pn7AN41T2H6
 /Q/oamJ8emarb9oz0Ccyff/pFoG8y/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644413022;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ivtq47mv+13xPERBP4wQJuCQjU7gibb31MiZLPg6zTk=;
 b=X1/O+yha5L7LWBvQUHQ8giFxtyeTbiwAiZ5P6gsov94Q28yb1EU4/iaGzgh6Akfub5rGjo
 m+2Hb12HkFDqkcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBB6113D2D;
 Wed,  9 Feb 2022 13:23:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ooYvNF3AA2KbRQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 09 Feb 2022 13:23:41 +0000
Date: Wed, 9 Feb 2022 14:23:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YgPAV7iqkneCIgbX@rei>
References: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1644399738-2155-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/pidfd_open: Simplify code
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
> diff --git a/include/lapi/pidfd_open.h b/include/lapi/pidfd_open.h
> index 9806c73d4..5cf10933e 100644
> --- a/include/lapi/pidfd_open.h
> +++ b/include/lapi/pidfd_open.h
> @@ -9,11 +9,15 @@
>  
>  #include <sys/syscall.h>
>  #include <sys/types.h>
> -
>  #include "lapi/syscalls.h"
> -
>  #include "config.h"
>  
> +static inline void pidfd_open_supported(void)
> +{
> +	/* allow the tests to fail early */
> +	tst_syscall(__NR_pidfd_open);
> +}
> +
>  #ifndef HAVE_PIDFD_OPEN
>  static inline int pidfd_open(pid_t pid, unsigned int flags)
>  {
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> index f40e9b624..ed9b82637 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> @@ -1,11 +1,15 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * Description:
>   * Basic pidfd_open() test:
> - * 1) Fetch the PID of the current process and try to get its file descriptor.
> - * 2) Check that the close-on-exec flag is set on the file descriptor.
> + *
> + * - Fetch the PID of the current process and try to get its file descriptor.
> + * - Check that the close-on-exec flag is set on the file descriptor.
>   */
>  
>  #include <unistd.h>
> @@ -17,10 +21,7 @@ static void run(void)
>  {
>  	int flag;
>  
> -	TEST(pidfd_open(getpid(), 0));
> -
> -	if (TST_RET == -1)
> -		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
> +	TST_EXP_PID_SILENT(pidfd_open(getpid(), 0), "pidfd_open(getpid(), 0)");

Techincally the return value is a fd so this should be
TST_EXP_FD_SILENT().

>  	flag = fcntl(TST_RET, F_GETFD);
>  
> @@ -35,7 +36,12 @@ static void run(void)
>  	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
>  }
>  
> +static void setup(void)
> +{
> +	pidfd_open_supported();
> +}
> +
>  static struct tst_test test = {
> -	.min_kver = "5.3",
> +	.setup = setup,
>  	.test_all = run,
>  };
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> index dc86cae7a..93a61a51d 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open02.c
> @@ -1,14 +1,21 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the pidfd_open syscall.
>   *
> - * Description:
> - * Basic pidfd_open() test to test invalid arguments.
> + * - ESRCH the process specified by pid does not exist
> + * - EINVAL pid is not valid
> + * - EINVAL flags is not valid
>   */
>  #include "tst_test.h"
>  #include "lapi/pidfd_open.h"
>  
> -pid_t expired_pid, my_pid, invalid_pid = -1;
> +static pid_t expired_pid, my_pid, invalid_pid = -1;
>  
>  static struct tcase {
>  	char *name;
> @@ -23,6 +30,7 @@ static struct tcase {
>  
>  static void setup(void)
>  {
> +	pidfd_open_supported();
>  	expired_pid = tst_get_unused_pid();
>  	my_pid = getpid();
>  }
> @@ -31,27 +39,11 @@ static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  
> -	TEST(pidfd_open(*tc->pid, tc->flags));
> -
> -	if (TST_RET != -1) {
> -		SAFE_CLOSE(TST_RET);
> -		tst_res(TFAIL, "%s: pidfd_open succeeded unexpectedly (index: %d)",
> -			tc->name, n);
> -		return;
> -	}
> -
> -	if (tc->exp_errno != TST_ERR) {
> -		tst_res(TFAIL | TTERRNO, "%s: pidfd_open() should fail with %s",
> -			tc->name, tst_strerrno(tc->exp_errno));
> -		return;
> -	}
> -
> -	tst_res(TPASS | TTERRNO, "%s: pidfd_open() failed as expected",
> -		tc->name);
> +	TST_EXP_FAIL2(pidfd_open(*tc->pid, tc->flags), tc->exp_errno,
> +			"pidfd_open with %s", tc->name);
>  }
>  
>  static struct tst_test test = {
> -	.min_kver = "5.3",
>  	.tcnt = ARRAY_SIZE(tcases),
>  	.test = run,
>  	.setup = setup,
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> index 48470e5e1..f41afa2fc 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
> @@ -1,8 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * Description:
>   * This program opens the PID file descriptor of the child process created with
>   * fork(). It then uses poll to monitor the file descriptor for process exit, as
>   * indicated by an EPOLLIN event.
> @@ -27,11 +30,9 @@ static void run(void)
>  		exit(EXIT_SUCCESS);
>  	}
>  
> -	TEST(pidfd_open(pid, 0));
> +	TST_EXP_PID_SILENT(pidfd_open(pid, 0), "pidfd_open(%d, 0)", pid);

Here as well.

Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
