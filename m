Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E550C25B10
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 15:31:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9946D3CE49E
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 17:31:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 145593CAEB6
 for <ltp@lists.linux.it>; Fri, 10 May 2024 17:31:08 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E9D9C603EB8
 for <ltp@lists.linux.it>; Fri, 10 May 2024 17:31:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 526893F2B5;
 Fri, 10 May 2024 15:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715355065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qndJEoyCiR2pUjAeIUau0dN4DFLqfvCq/7fr/oeyfEw=;
 b=p3sr2bSZHJEvz0Q7mNvXgbDVPBRI+Ca6bDC9pClgCV+5qysYThaVNm+ke434molTF9t5zl
 QsAVID9chj3F2rCKpG1cssS9LgJ2a1Qmfp6m5jyKLNWiU9ce9PsVZU/ov2wXWZmG4/ft8f
 6L5K8Q1JPcdq+H/zDji8NvopZNQHxZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715355065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qndJEoyCiR2pUjAeIUau0dN4DFLqfvCq/7fr/oeyfEw=;
 b=n9/DEE968zpW9b0L6LYNE/VLNYaAt2lhBUCkFPu4/Kj6uoMJ6q5qD0PHWE2mGDGg6dLskK
 e3eTsjQFWPGlC7CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=p3sr2bSZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="n9/DEE96"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715355065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qndJEoyCiR2pUjAeIUau0dN4DFLqfvCq/7fr/oeyfEw=;
 b=p3sr2bSZHJEvz0Q7mNvXgbDVPBRI+Ca6bDC9pClgCV+5qysYThaVNm+ke434molTF9t5zl
 QsAVID9chj3F2rCKpG1cssS9LgJ2a1Qmfp6m5jyKLNWiU9ce9PsVZU/ov2wXWZmG4/ft8f
 6L5K8Q1JPcdq+H/zDji8NvopZNQHxZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715355065;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qndJEoyCiR2pUjAeIUau0dN4DFLqfvCq/7fr/oeyfEw=;
 b=n9/DEE968zpW9b0L6LYNE/VLNYaAt2lhBUCkFPu4/Kj6uoMJ6q5qD0PHWE2mGDGg6dLskK
 e3eTsjQFWPGlC7CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11928139AA;
 Fri, 10 May 2024 15:31:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eIpgArk9PmZhLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 10 May 2024 15:31:05 +0000
Date: Fri, 10 May 2024 17:31:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Hui Min Mina Chou <minachou@andestech.com>
Message-ID: <20240510153103.GA448405@pevik>
References: <20240328083344.277502-1-minachou@andestech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240328083344.277502-1-minachou@andestech.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_FIVE(0.00)[5]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 526893F2B5
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setitimer: Pass the kernel-defined
 struct __kernel_old_itimerval to sys_setitimer().
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
Cc: tim609@andestech.com, cynthia@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> +++ b/configure.ac
> @@ -219,7 +219,8 @@ AC_CHECK_TYPES([struct xt_entry_match, struct xt_entry_target],,,[
>  ])

>  AC_CHECK_TYPES([struct __kernel_old_timeval, struct __kernel_old_timespec, struct __kernel_timespec,
> -                struct __kernel_old_itimerspec, struct __kernel_itimerspec],,,[#include <sys/socket.h>])
> +                struct __kernel_old_itimerspec, struct __kernel_itimerspec,
> +                struct __kernel_old_itimerval],,,[#include <sys/socket.h>])

@Hui following is unrelated to your patchset (we can sort it later, it should
not block your effort).

@Cyril the original code prior this patchset in 203ee275c ("Fix struct
__kernel_old_timeval redefinition on 64bit sparc") did not include
<linux/time_types.h> for some reason IMHO fallbacks were always used.
I wonder why and whether we still don't want to use <linux/time_types.h>.

Then Fabrice's fix in 12986b755 ("include/tst_timer.h: avoid redefinition of
kernel structures") add autotools check just for uncommon toolchain (sh4 from
Texas Instruments). It's somehow hidden (due missing comment it looks like we
mostly get the definitions from header, but obviously not when we include
<sys/socket.h>.

>  AC_CHECK_TYPES([struct futex_waitv],,,[#include <linux/futex.h>])
>  AC_CHECK_TYPES([struct mount_attr],,,[
> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index 703f03294eae..6fb9400206b8 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -135,6 +135,13 @@ struct __kernel_itimerspec {
>  	struct __kernel_timespec it_value;       /* timer expiration */
>  };
>  #endif
> +
> +#ifndef HAVE_STRUCT___KERNEL_OLD_ITIMERVAL
> +struct __kernel_old_itimerval {
> +	struct __kernel_old_timeval it_interval;	/* timer interval */
> +	struct __kernel_old_timeval it_value;		/* current value */
> +};
> +#endif
>  #endif

>  enum tst_ts_type {
> @@ -370,6 +377,11 @@ static inline int sys_timerfd_settime64(int fd, int flags, void *its,
>  	return tst_syscall(__NR_timerfd_settime64, fd, flags, its, old_its);
>  }

> +static inline int sys_setitimer(int which, void *new_value, void *old_value)
> +{
> +	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> +}

+1 adding function to the common place.

IMHO we slightly prefer to add C functions to C file (e.g. lib/tst_timer.c,
there are other functions) + adding signature to tst_timer.h.

With that:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
>  /*
>   * Returns tst_ts seconds.
>   */
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer01.c b/testcases/kernel/syscalls/setitimer/setitimer01.c
> index d12abe904f1c..94ee51c6a667 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer01.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer01.c
> @@ -20,9 +20,10 @@
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
>  #include "tst_safe_clocks.h"
> +#include "tst_timer.h"

>  static struct timeval tv;
> -static struct itimerval *value, *ovalue;
> +static struct __kernel_old_itimerval *value, *ovalue;
>  static volatile unsigned long sigcnt;
>  static long time_step;
>  static long time_sec;
> @@ -38,11 +39,6 @@ static struct tcase {
>  	{ITIMER_PROF,    "ITIMER_PROF",    SIGPROF},
>  };

> -static int sys_setitimer(int which, void *new_value, void *old_value)
> -{
> -	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> -}
> -
>  static void sig_routine(int signo LTP_ATTRIBUTE_UNUSED)
>  {
>  	sigcnt++;
> diff --git a/testcases/kernel/syscalls/setitimer/setitimer02.c b/testcases/kernel/syscalls/setitimer/setitimer02.c
> index b012d71fa7bd..c545f6288bbb 100644
> --- a/testcases/kernel/syscalls/setitimer/setitimer02.c
> +++ b/testcases/kernel/syscalls/setitimer/setitimer02.c
> @@ -19,13 +19,9 @@
>  #include <stdlib.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "tst_timer.h"

> -static struct itimerval *value, *ovalue;
> -
> -static int sys_setitimer(int which, void *new_value, void *old_value)
> -{
> -	return tst_syscall(__NR_setitimer, which, new_value, old_value);
> -}
> +static struct __kernel_old_itimerval *value, *ovalue;

>  static void verify_setitimer(unsigned int i)
>  {
> @@ -55,8 +51,8 @@ static struct tst_test test = {
>  	.test = verify_setitimer,
>  	.setup = setup,
>  	.bufs = (struct tst_buffers[]) {
> -		{&value,  .size = sizeof(struct itimerval)},
> -		{&ovalue, .size = sizeof(struct itimerval)},
> +		{&value,  .size = sizeof(struct __kernel_old_itimerval)},
> +		{&ovalue, .size = sizeof(struct __kernel_old_itimerval)},
>  		{}
>  	}
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
