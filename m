Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2CCC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 12:18:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF8C83CA3B8
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 14:18:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0C743C9E2C
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 14:18:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4F8CB600546
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 14:18:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5557A1F380;
 Tue, 26 Apr 2022 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650975509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7e0NouWxrEjwv2mURwz3auiXd/E9N/0J0IRalJo+8so=;
 b=g9vnjZlE/i61J5QtdUvLOdpcCJ89gvmy5KqS5o2DvsaJXg41qyVVAv0xHhStK8YnE7pk4O
 DsucS/qC18EZXvqf4QxdbrmESyR3PK4MOohNEC6g8R0h+XKJAHYlS98HlibzvgT51NyJpP
 qTRUe3qZv/4FI00dCQcUto0/UqDja6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650975509;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7e0NouWxrEjwv2mURwz3auiXd/E9N/0J0IRalJo+8so=;
 b=WxU+cIznGpyJQiIcKjjb+YR4tZyYcYlmau7qh01jqAMKu0m38PZBMjpfONg9Oj5dyrZR3y
 tcmK2GfkUT1o0HAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C82713223;
 Tue, 26 Apr 2022 12:18:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HN9OCRXjZ2JjDAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Apr 2022 12:18:29 +0000
Date: Tue, 26 Apr 2022 14:20:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Ymfjm0mdVKacvDnq@yuki>
References: <20220425133816.720-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425133816.720-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/signal.h: rm references to _SC_SIGRT_* and
 __SIGRT*
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
> The old API's tst_sig.c uses_SC_SIGRT_MIN/MAX are not extant and a
> quick internet search does not reveal much. It's assumed they meant
> the same thing as tst_sigrt{min,max}_kern.
> 
> The fallback using __SIGRT{MIN,MAX} is also replaced with
> tst_signal_is_reserved_rt. It says sigrtmin on HPPA is 37. However in
> the kernel all arches have it set to 32.
> 
> In all cases __SIGRT{MIN,MAX} is replaces with constants we define as
> we can not use __ variables. Two functions are introduced to make the
> meaning clear when using these constants to check if a signal is
> reserved and/or realtime.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Suggested-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/lapi/signal.h                         | 36 ++++++-------
>  lib/tst_sig.c                                 | 51 +------------------
>  testcases/kernel/syscalls/ptrace/ptrace05.c   |  2 +-
>  .../syscalls/rt_sigsuspend/rt_sigsuspend01.c  |  2 +-
>  testcases/kernel/syscalls/sighold/sighold02.c |  4 +-
>  5 files changed, 23 insertions(+), 72 deletions(-)
> 
> diff --git a/include/lapi/signal.h b/include/lapi/signal.h
> index 6f4a76881..aa185a5a6 100644
> --- a/include/lapi/signal.h
> +++ b/include/lapi/signal.h
> @@ -1,24 +1,24 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> +/* SPDX-License-Identifier: GPL-2.0-or-later */

The style with "//" seems to be more common in LTP. If we want to unify
on the latter it should be done for all files and in a separate patch.

>  /*
> - * Copyright (c) 2019 Linaro Limited. All rights reserved.
> - * Author: Daniel D??az <daniel.diaz@linaro.org>
> + * Copyright (c) 2022 SUSE LLC
>   */
> -
> -#ifndef LAPI_SIGNAL_H__
> -#define LAPI_SIGNAL_H__

Why have you deleted the guards?

>  #include <signal.h>
>  
> -/*
> - * Some libc implementations might differ in the definitions they include. This
> - * covers those differences for all tests to successfully build.
> - */
> +const int tst_sigrtmin_kern = 32;
> +const int tst_sigrtmax_kern = 64;

I would go for macros here but I guess that either one works.

> -#ifndef __SIGRTMIN
> -# define __SIGRTMIN 32
> -#endif
> -#ifndef __SIGRTMAX
> -# define __SIGRTMAX (_NSIG - 1)
> -#endif
> +/* Indicates that libc has reserved a RT signal for use by the system
> + * libraries. Usually threading, but could be anything. */
> +__attribute__((warn_unused_result))
> +static inline int tst_signal_is_reserved_rt(const int sig)
> +{
> +	return 	sig >= tst_sigrtmin_kern && sig < SIGRTMIN;
              ^
	      Should be single space.
> +}
>  
> -#endif /* LAPI_SIGNAL_H__ */
> +/* Indicates that a signal is in the kernel's realtime set. This
> + * includes signals reserved by libc. */
> +__attribute__((const, warn_unused_result))
> +static inline int tst_signal_is_kern_rt(const int sig)
> +{
> +	return 	sig >= tst_sigrtmin_kern && sig < tst_sigrtmax_kern;
              ^
	      Here as well.
> +}
> diff --git a/lib/tst_sig.c b/lib/tst_sig.c
> index 6d77aeafd..2db3561f5 100644
> --- a/lib/tst_sig.c
> +++ b/lib/tst_sig.c
> @@ -69,7 +69,6 @@
>  
>  #include <errno.h>
>  #include <string.h>
> -#include <signal.h>
>  #include <unistd.h>
>  #include "test.h"
>  #include "lapi/signal.h"
> @@ -93,9 +92,6 @@ static void (*tst_setup_signal(int, void (*)(int))) (int);
>  void tst_sig(int fork_flag, void (*handler) (), void (*cleanup) ())
>  {
>  	int sig;
> -#ifdef _SC_SIGRT_MIN
> -	long sigrtmin, sigrtmax;
> -#endif
>  
>  	/*
>  	 * save T_cleanup and handler function pointers
> @@ -106,10 +102,6 @@ void tst_sig(int fork_flag, void (*handler) (), void (*cleanup) ())
>  		/* use default handler */
>  		handler = def_handler;
>  	}
> -#ifdef _SC_SIGRT_MIN
> -	sigrtmin = sysconf(_SC_SIGRT_MIN);
> -	sigrtmax = sysconf(_SC_SIGRT_MAX);
> -#endif
>  
>  	/*
>  	 * now loop through all signals and set the handlers
> @@ -123,54 +115,13 @@ void tst_sig(int fork_flag, void (*handler) (), void (*cleanup) ())
>  		 * SIGINFO is used for file quotas and should be expected
>  		 */
>  
> -#ifdef _SC_SIGRT_MIN
> -		if (sig >= sigrtmin && sig <= sigrtmax)
> +		if (tst_signal_is_kern_rt(sig))
>  			continue;
> -#endif
>  
>  		switch (sig) {
>  		case SIGKILL:
>  		case SIGSTOP:
>  		case SIGCONT:
> -#if !defined(_SC_SIGRT_MIN) && defined(__SIGRTMIN) && defined(__SIGRTMAX)
> -			/* Ignore all real-time signals */
> -		case __SIGRTMIN:
> -		case __SIGRTMIN + 1:
> -		case __SIGRTMIN + 2:
> -		case __SIGRTMIN + 3:
> -		case __SIGRTMIN + 4:
> -		case __SIGRTMIN + 5:
> -		case __SIGRTMIN + 6:
> -		case __SIGRTMIN + 7:
> -		case __SIGRTMIN + 8:
> -		case __SIGRTMIN + 9:
> -		case __SIGRTMIN + 10:
> -		case __SIGRTMIN + 11:
> -		case __SIGRTMIN + 12:
> -		case __SIGRTMIN + 13:
> -		case __SIGRTMIN + 14:
> -		case __SIGRTMIN + 15:
> -/* __SIGRTMIN is 37 on HPPA rather than 32 *
> - * as on i386, etc.                        */
> -#if !defined(__hppa__)
> -		case __SIGRTMAX - 15:
> -		case __SIGRTMAX - 14:
> -		case __SIGRTMAX - 13:
> -		case __SIGRTMAX - 12:
> -		case __SIGRTMAX - 11:
> -#endif
> -		case __SIGRTMAX - 10:
> -		case __SIGRTMAX - 9:
> -		case __SIGRTMAX - 8:
> -		case __SIGRTMAX - 7:
> -		case __SIGRTMAX - 6:
> -		case __SIGRTMAX - 5:
> -		case __SIGRTMAX - 4:
> -		case __SIGRTMAX - 3:
> -		case __SIGRTMAX - 2:
> -		case __SIGRTMAX - 1:
> -		case __SIGRTMAX:
> -#endif
>  #ifdef SIGSWAP
>  		case SIGSWAP:
>  #endif /* SIGSWAP */
> diff --git a/testcases/kernel/syscalls/ptrace/ptrace05.c b/testcases/kernel/syscalls/ptrace/ptrace05.c
> index 54cfa4d7b..1c1911877 100644
> --- a/testcases/kernel/syscalls/ptrace/ptrace05.c
> +++ b/testcases/kernel/syscalls/ptrace/ptrace05.c
> @@ -72,7 +72,7 @@ int main(int argc, char **argv)
>  
>  	for (signum = start_signum; signum <= end_signum; signum++) {
>  
> -		if (signum >= __SIGRTMIN && signum < SIGRTMIN)
> +		if (tst_signal_is_kern_rt(signum))

This should be tst_signal_is_reserve_rt() right?

>  			continue;
>  
>  		switch (child = fork()) {
> diff --git a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> index 511d5fcb2..5fbfad04e 100644
> --- a/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> +++ b/testcases/kernel/syscalls/rt_sigsuspend/rt_sigsuspend01.c
> @@ -50,7 +50,7 @@ static void verify_rt_sigsuspend(void)
>  
>  	SAFE_RT_SIGPROCMASK(0, NULL, &set2, SIGSETSIZE);
>  	for (i = 1; i < SIGRTMAX; i++) {
> -		if (i >= __SIGRTMIN && i < SIGRTMIN)
> +		if (tst_signal_is_reserved_rt(i))
>  			continue;
>  		if (sigismember(&set1, i) != sigismember(&set2, i))
>  			tst_brk(TFAIL, "signal mask not preserved");
> diff --git a/testcases/kernel/syscalls/sighold/sighold02.c b/testcases/kernel/syscalls/sighold/sighold02.c
> index 1cfb7688b..cfa4a4765 100644
> --- a/testcases/kernel/syscalls/sighold/sighold02.c
> +++ b/testcases/kernel/syscalls/sighold/sighold02.c
> @@ -17,7 +17,7 @@
>   */
>  
>  #define _XOPEN_SOURCE 600
> -#include <signal.h>
> +#include "lapi/signal.h"
>  #include "tst_test.h"
>  
>  #ifndef NSIG
> @@ -33,7 +33,7 @@ static int sigs_map[NUMSIGS];
>  
>  static int skip_sig(int sig)
>  {
> -	if (sig >= 32 && sig < SIGRTMIN)
> +	if (tst_signal_is_reserved_rt(sig))
>  		return 1;
>  
>  	switch (sig) {
> -- 
> 2.35.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
