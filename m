Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WjpzS-0003qi-FK
	for ltp-list@lists.sourceforge.net; Mon, 12 May 2014 13:09:58 +0000
Date: Mon, 12 May 2014 15:08:56 +0200
From: chrubis@suse.cz
Message-ID: <20140512130856.GB4741@rei>
References: <1399540004-14742-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<1399540004-14742-5-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399540004-14742-5-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] [PATCH 4/4] rt_sigaction*, rt_sigprocmask01,
 rt_sigsuspend01: SPARC support
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> Added SPARC support for tests:
>  * rt_sigaction01, rt_sigaction02, rt_sigaction03
>  * rt_sigprocmask01
>  * rt_sigsuspend01
> 
> Author: Jose E. Marchesi <jose.marchesi@oracle.com>
> Co-author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  include/ltp_signal.h                               |   39 +++++++++++++++++++-
>  .../kernel/syscalls/rt_sigaction/rt_sigaction01.c  |   32 ++++++++++++++---
>  .../kernel/syscalls/rt_sigaction/rt_sigaction02.c  |   13 ++++++-
>  .../kernel/syscalls/rt_sigaction/rt_sigaction03.c  |   28 ++++++++++++++
>  .../syscalls/rt_sigprocmask/rt_sigprocmask01.c     |   24 +++++++++++-
>  .../syscalls/rt_sigsuspend/rt_sigsuspend01.c       |   24 ++++++++++--
>  6 files changed, 147 insertions(+), 13 deletions(-)
> 
> diff --git a/include/ltp_signal.h b/include/ltp_signal.h
> index e6fb2e0..c050894 100644
> --- a/include/ltp_signal.h
> +++ b/include/ltp_signal.h
> @@ -1,6 +1,7 @@
>  /*
>   * Copyright (c) 2009 Cisco Systems, Inc.  All Rights Reserved.
>   * Copyright (c) 2009 FUJITSU LIMITED.  All Rights Reserved.
> + * Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of version 2 of the GNU General Public License as
> @@ -77,6 +78,42 @@
>  #define HAVE_SA_RESTORER
>  #define SA_RESTORER	0x04000000
>  
> +#endif /* __x86_64__ */
> +
> +#ifdef __sparc__
> +#if defined __arch64__ || defined __sparcv9
> +
> +/*
> + * From glibc/sysdeps/unix/sysv/linux/sparc/sparc64/sigaction.c
> + */
> +
> +static void __rt_sigreturn_stub(void)
> +{
> +	__asm__ ("mov %0, %%g1\n\t"
> +		"ta  0x6d\n\t"
> +		: /* no outputs */
> +		: "i" (__NR_rt_sigreturn));
> +}
> +
> +#else /* sparc32 */
> +
> +/*
> + * From glibc/sysdeps/unix/sysv/linux/sparc/sparc32/sigaction.c
> + */
> +
> +static void __sigreturn_stub(void)
> +{
> +	__asm__ ("mov %0, %%g1\n\t"
> +		"ta  0x10\n\t"
> +		: /* no outputs */
> +		: "i" (__NR_sigreturn));
> +}
> +
> +#endif
> +#endif /* __sparc__ */

Do you care to elaborate what are these used for? I can see that you
pass and addres to them to the sparc variant of the rt_sigaction
syscalls below however a line or two about why we do this in the commit
message wouldn't hurt.

> +#if defined __x86_64__ || defined __sparc__
> +
>  struct kernel_sigaction {
>  	__sighandler_t k_sa_handler;
>  	unsigned long sa_flags;
> @@ -118,7 +155,7 @@ static inline int sig_initial(int sig)
>  
>  }
>  
> -#endif /* __x86_64__ */
> +#endif /* __x86_64__ || __sparc__*/
>  
>  #endif /* LTP_RT_SIG_TEST */
>  
> diff --git a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> index 8f18394..2f8020e 100644
> --- a/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> +++ b/testcases/kernel/syscalls/rt_sigaction/rt_sigaction01.c
> @@ -1,5 +1,6 @@
>  /******************************************************************************/
>  /* Copyright (c) Crackerjack Project., 2007                                   */
> +/* Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.      */
>  /*                                                                            */
>  /* This program is free software;  you can redistribute it and/or modify      */
>  /* it under the terms of the GNU General Public License as published by       */
> @@ -127,21 +128,42 @@ void handler(int sig)
>  
>  int set_handler(int sig, int sig_to_mask, int mask_flags)
>  {
> -#ifdef __x86_64__
> +#ifdef __sparc__
> +	struct sigaction sa;
> +	struct kernel_sigaction kact, koact;
> +# ifdef __arch64__
> +	unsigned long stub = ((unsigned long) &__rt_sigreturn_stub) - 8;
> +# else
> +	unsigned long stub = ((unsigned long) &__sigreturn_stub) - 8;
> +# endif

These ifdefs are repeated in the lines below over and over, can we put
them in a common header instead?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
