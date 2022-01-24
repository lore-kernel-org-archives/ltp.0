Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCDEC433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 15:14:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D9EF43C909D
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 16:14:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B14693C21D9
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:14:32 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2C6E51400059
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 16:14:31 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 684B11F38B;
 Mon, 24 Jan 2022 15:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643037271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ecqFVxyAFBBVb/wW4bh/kT+2hCkdBjogQQTzLHsiqUE=;
 b=pUcTjJLVHX7yfyYkWBYw8pSCC+unbTJG9pTkajKWPIJCOMfRRMaaHfbhJ0wviAw4K9okf0
 KQChZsLpmGN8xET2j8XFbTIuKZ04MWNsp+heU6I1h8G6HxyzxvVRc/ftKNLgZNJUk7Ehuy
 H7eXg51SYvQ0yGwOiO7A/WxfDVIpjc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643037271;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ecqFVxyAFBBVb/wW4bh/kT+2hCkdBjogQQTzLHsiqUE=;
 b=2H6FUh0nzusJIrqTgGCrKZzCbNT3gIOMGuqoWuJrzgNcnAFXU0VGZH4miKNMg45VIOosT0
 GocJpH9RRjD4KACw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 45D7813C1B;
 Mon, 24 Jan 2022 15:14:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id irWyEFfC7mHRFAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jan 2022 15:14:31 +0000
Date: Mon, 24 Jan 2022 16:16:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ye7CwmegfyHXgN2N@yuki>
References: <20211208082625.26324-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211208082625.26324-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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
> diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
> index 5d729a33d..580df00a3 100644
> --- a/m4/ltp-eventfd.m4
> +++ b/m4/ltp-eventfd.m4
> @@ -12,12 +12,10 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
>  		AC_SUBST(AIO_LIBS, "-laio")
>  
>  		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
> -		AC_TRY_LINK([#include <stdio.h>
> +		AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdio.h>
>                               #include <libaio.h>
> -		            ],
> -		            [io_set_eventfd(NULL, 0); return 0;],
> +		            ]], [[io_set_eventfd(NULL, 0); return 0;]])],
>  		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
> -						AC_MSG_RESULT(yes)],
> -		            [AC_MSG_RESULT(no)])
> +						AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])

Shouldn't we convert this bit into AC_CHECK_FUNCS() (in a separte patch)?

>  	fi
>  ])
> diff --git a/m4/ltp-kernel_devel.m4 b/m4/ltp-kernel_devel.m4
> index 8a0598e5a..d46d54775 100644
> --- a/m4/ltp-kernel_devel.m4
> +++ b/m4/ltp-kernel_devel.m4
> @@ -9,7 +9,7 @@ AC_DEFUN([LTP_CHECK_KERNEL_DEVEL],[
>  AC_MSG_CHECKING([for kernel-devel])
>  AC_ARG_WITH(
>  	[linux-version],
> -	[AC_HELP_STRING([--with-linux-version=VERSION],
> +	[AS_HELP_STRING([--with-linux-version=VERSION],
>  			[specify the Linux version to build modules for])],
>  	[LINUX_VERSION="${withval}"],
>  	AS_IF([test "$cross_compiling" = "no"],
> @@ -18,7 +18,7 @@ AC_ARG_WITH(
>  AC_SUBST(LINUX_VERSION)
>  
>  AC_ARG_WITH([linux-dir],
> -	[AC_HELP_STRING([--with-linux-dir=DIR],
> +	[AS_HELP_STRING([--with-linux-dir=DIR],
>  			[specify path to kernel-devel directory])],
>  	[LINUX_DIR="${withval}"],
>  	AS_IF([test -n "$LINUX_VERSION"],
> @@ -44,7 +44,7 @@ AC_MSG_RESULT([$WITH_MODULES])
>  
>  AC_ARG_WITH(
>  	[modules],
> -	[AC_HELP_STRING([--without-modules],
> +	[AS_HELP_STRING([--without-modules],
>  			[disable auto-building kernel modules])],
>  			[WITH_MODULES="no"],
>  			[])
> diff --git a/m4/ltp-mremap_fixed.m4 b/m4/ltp-mremap_fixed.m4
> index 66548b82b..ff2696909 100644
> --- a/m4/ltp-mremap_fixed.m4
> +++ b/m4/ltp-mremap_fixed.m4
> @@ -6,7 +6,7 @@ AC_DEFUN([LTP_CHECK_MREMAP_FIXED],[
>  AH_TEMPLATE(HAVE_MREMAP_FIXED,
>  [Define to 1 if you have MREMAP_FIXED in <sys/mman.h>.])
>  AC_MSG_CHECKING([for MREMAP_FIXED in <sys/mman.h>])
> -AC_TRY_COMPILE([#define _GNU_SOURCE
> -                #include <sys/mman.h>], [int flags = MREMAP_FIXED;],
> -               AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
> +                #include <sys/mman.h>]], [[int flags = MREMAP_FIXED;]])],
> +                [AC_DEFINE(HAVE_MREMAP_FIXED) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>  ])
> diff --git a/m4/ltp-perf_event_open.m4 b/m4/ltp-perf_event_open.m4
> index 6966cf270..4a488ffa3 100644
> --- a/m4/ltp-perf_event_open.m4
> +++ b/m4/ltp-perf_event_open.m4
> @@ -7,10 +7,8 @@ AC_DEFUN([LTP_CHECK_SYSCALL_PERF_EVENT_OPEN],[
>  AH_TEMPLATE(HAVE_PERF_EVENT_ATTR,
>  [Define to 1 if you have struct perf_event_attr])
>  AC_MSG_CHECKING([for perf_event_attr in linux/perf_event.h])
> -AC_TRY_COMPILE([#include <unistd.h>
> -		#include <linux/perf_event.h>],
> -		[
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <unistd.h>
> +		#include <linux/perf_event.h>]], [[
>  			struct perf_event_attr pe;
> -		],
> -		AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +		]])],[AC_DEFINE(HAVE_PERF_EVENT_ATTR) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])

And this one with AC_CHECK_TYPES()?

>  ])
> diff --git a/testcases/realtime/m4/check.m4 b/testcases/realtime/m4/check.m4
> index e60ae1928..d04a2cc73 100644
> --- a/testcases/realtime/m4/check.m4
> +++ b/testcases/realtime/m4/check.m4
> @@ -1,10 +1,10 @@
>  AC_DEFUN([REALTIME_CHECK_PRIO_INHERIT],[
>  AC_MSG_CHECKING([for PTHREAD_PRIO_INHERIT])
> -AC_TRY_COMPILE([
> -#include <pthread.h>],[int main(void) {
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
> +#include <pthread.h>]], [[int main(void) {
>  	pthread_mutexattr_t attr;
>  	return pthread_mutexattr_setprotocol(&attr, PTHREAD_PRIO_INHERIT);
> -}],[has_priority_inherit="yes"],[])
> +}]])],[has_priority_inherit="yes"],[])
>  if test "x$has_priority_inherit" = "xyes" ; then
>  	AC_DEFINE(HAS_PRIORITY_INHERIT,1,[Define to 1 if you have PTHREAD_PRIO_INHERIT])
>  	AC_MSG_RESULT(yes)
> diff --git a/testcases/realtime/m4/ltp-exp10.m4 b/testcases/realtime/m4/ltp-exp10.m4
> index 3d2320a20..625175c31 100644
> --- a/testcases/realtime/m4/ltp-exp10.m4
> +++ b/testcases/realtime/m4/ltp-exp10.m4
> @@ -26,12 +26,10 @@ AH_TEMPLATE(HAVE_EXP10,
>  AC_MSG_CHECKING([for exp10])
>  backup_ldlibs="$LIBS"
>  LIBS+=" -lm"
> -AC_TRY_LINK([#define _GNU_SOURCE
> -             #include <math.h>],
> -            [
> +AC_LINK_IFELSE([AC_LANG_PROGRAM([[#define _GNU_SOURCE
> +             #include <math.h>]], [[
>               volatile float val;
>               exp10(val);
> -            ],
> -             AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes), AC_MSG_RESULT(no))
> +            ]])],[AC_DEFINE(HAVE_EXP10) AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])
>  LIBS="$backup_ldlibs"
>  ])

Similarily here AC_CHECK_FUNCS()?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
