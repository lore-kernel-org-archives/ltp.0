Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229F0C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 19:56:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 739893CA0B5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 20:56:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27EB03C9564
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 20:56:23 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7769C1401702
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 20:56:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7571D1F37D;
 Thu, 17 Feb 2022 19:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645127782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ladF0XlBJpMkk9obs0oNSAf0mqcIWBG87mFKzfdXeec=;
 b=0c/c5UcOgT5D6BKgST4T2PIv1YJU8sh9cGW3BlsYguGR+Rg7OqCGRA/mkOGQuGHhQgYf93
 TsS4421IC4iUaDoZ+FiVFUiTFEn62Es1vk6Cv6y42E2gE8PE+b3bEFnOIkk4l/7OaXtkma
 Q2Ynlr4GZoFlBPakzLQVDefEZ21CY5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645127782;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ladF0XlBJpMkk9obs0oNSAf0mqcIWBG87mFKzfdXeec=;
 b=p4kE1SaIQ/vrhwcqyiQ7DYWnp0aIUjhtvPOt6gzxa9nVgjZFLovy6e4cdd+dcSboy8fj6V
 ZggHsIuOb7nER+DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3274013476;
 Thu, 17 Feb 2022 19:56:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4QV8CGaoDmIMVwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Feb 2022 19:56:22 +0000
Date: Thu, 17 Feb 2022 20:56:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Yg6oZLaYz6Dj1FY4@pevik>
References: <1645005868-2373-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1645005868-2373-5-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] syscalls/pidfd_getfd02: add basic error test
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

Hi Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks! Few comments below, can be fixed before merge.

> +++ b/testcases/kernel/syscalls/pidfd_getfd/.gitignore
> @@ -1 +1,2 @@
>  pidfd_getfd01
> +pidfd_getfd02
Again /pidfd_getfd02

> diff --git a/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c b/testcases/kernel/syscalls/pidfd_getfd/pidfd_getfd02.c
...
> +/*\
> + * [Description]
> + *
> + * Tests basic error handling of the pidfd_open syscall.
> + *
> + * - EBADF pidfd is not a valid PID file descriptor
> + * - EBADF targetfd is not an open file descriptor in the process referred
> + *   to by pidfd
> + * - EINVAL flags is not 0
> + * - ESRCH the process referred to by pidfd does not exist(it has terminated and
> + *   been waited on))

nit: add space and remove redundant bracket
 * - ESRCH the process referred to by pidfd does not exist (it has terminated and
 *   been waited on)

> + * - EPERM the calling process doesn't have PTRACE_MODE_ATTACH_REALCREDS permissions
> + *   over the process referred to by pidfd

+1 (only ENFILE "The system-wide limit on the total number of open files has been
reached." which is probably not worth of implementing).
...

> +static void setup(void)
> +{
> +	struct passwd *pw;
> +
> +	pw = SAFE_GETPWNAM("nobody");
> +	uid = pw->pw_uid;
> +
> +	pidfd_open_supported();
> +	pidfd_getfd_supported();
nit: I'd put these before SAFE_GETPWNAM().

> +
> +	TST_EXP_FD_SILENT(pidfd_open(getpid(), 0), "pidfd_open");
If you wait for Cyril's patch adding auto stringification
https://lore.kernel.org/ltp/20220217142730.19726-1-chrubis@suse.cz/

you can use just:
TST_EXP_FD_SILENT(pidfd_open(getpid(), 0));

and get more info.

> +	if (!TST_PASS)
> +		tst_brk(TFAIL | TTERRNO, "pidfd_open failed");

@Cyril: would it be possible to to allow using also tst_brk() in macros in
tst_test_macros.h?

Having TST_*_BRK() (i.e. TST_EXP_FD_SILENT_BRK()) looks too complicated

> +	valid_pidfd = TST_RET;
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int pid;
> +
> +	switch (tc->exp_errno) {
> +	case EPERM:
> +		pid = SAFE_FORK();
SAFE_FORK() can be before switch.

> +		if (!pid) {
> +			SAFE_SETUID(uid);
> +			TST_EXP_FAIL2(pidfd_getfd(valid_pidfd, tc->targetfd, tc->flags),
> +				tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
> +				valid_pidfd, tc->targetfd, tc->flags, tc->name);
> +			TST_CHECKPOINT_WAKE(0);
> +			exit(0);
> +		}
> +		TST_CHECKPOINT_WAIT(0);
> +		SAFE_WAIT(NULL);
> +		return;
> +	break;
> +	case ESRCH:
> +		pid = SAFE_FORK();
> +		if (!pid) {
> +			TST_CHECKPOINT_WAIT(0);
> +			exit(0);
> +		}
> +		TST_EXP_FD_SILENT(pidfd_open(pid, 0), "pidfd_open");
> +		*tc->pidfd = TST_RET;
> +		TST_CHECKPOINT_WAKE(0);
> +		SAFE_WAIT(NULL);
> +	break;
> +	default:
> +	break;
> +	};

IMHO more readable would be instead of switch use if/else if or 2 functions.


Kind regards,
Petr

> +
> +	TST_EXP_FAIL2(pidfd_getfd(*tc->pidfd, tc->targetfd, tc->flags),
> +		tc->exp_errno, "pidfd_getfd(%d, %d, %d) with %s",
> +		*tc->pidfd, tc->targetfd, tc->flags, tc->name);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
