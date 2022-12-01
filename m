Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A26C4321E
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:07:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 213453CC499
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 11:07:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB8713CC470
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:06:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1009C1A019AF
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:06:51 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 741541FD63;
 Thu,  1 Dec 2022 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669889211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAISaVwaUzlwiQbLVJwNW1WfR1FwDv3bKtYelKrUOiM=;
 b=Bua8WL9wcm1VDiaIyk1LTnaU0l0F0X+7c2SGKBUiRJ7woBisSG69dvzDg8wRnWE/CVjl06
 M3zLdMVYVcEsWY6YLFRgDU79sX+3Z3PqwI176axoVYw3ydEt0UZ5COxZqk2pLsU5KTelqK
 o0ugSSpSBjiyoq7K6StXc+38oAL8y6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669889211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WAISaVwaUzlwiQbLVJwNW1WfR1FwDv3bKtYelKrUOiM=;
 b=wkoNDe12whpXPEusJvqcyi2a+r2mIdVOUx3RuCvC4SQy9QzVlydYHvEAbSUsJfOwq9pJN+
 ZXkI8/SxlYged0DQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4C0412C141;
 Thu,  1 Dec 2022 10:06:51 +0000 (UTC)
References: <1669704060-5635-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1669704060-5635-2-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 01 Dec 2022 10:06:40 +0000
Organization: Linux Private Site
In-reply-to: <1669704060-5635-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87lenrigjp.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] include/lapi/sched.h: Move lapi/clone.h
 into here
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> Like namespaces_constants.h, kernel doesn't have
> clone.h header. We can also move it into here.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
> This patch has been verified on my ltp fork[1].
> [1]https://github.com/xuyang0410/ltp/actions/runs/3571298308/jobs/6003048080
>  include/lapi/clone.h                          | 56 -------------------
>  include/lapi/sched.h                          | 31 ++++++++++
>  lib/tst_clone.c                               |  2 +-
>  testcases/kernel/containers/pidns/pidns13.c   |  2 +-
>  testcases/kernel/containers/userns/userns08.c |  2 +-
>  testcases/kernel/syscalls/clone3/clone301.c   |  2 +-
>  testcases/kernel/syscalls/clone3/clone302.c   |  2 +-
>  .../syscalls/close_range/close_range01.c      |  2 +-
>  .../syscalls/close_range/close_range02.c      |  2 +-
>  9 files changed, 38 insertions(+), 63 deletions(-)
>  delete mode 100644 include/lapi/clone.h
>
> diff --git a/include/lapi/clone.h b/include/lapi/clone.h
> deleted file mode 100644
> index 437d1376f..000000000
> --- a/include/lapi/clone.h
> +++ /dev/null
> @@ -1,56 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * Copyright (c) 2020 Linaro Limited. All rights reserved.
> - * Author: Viresh Kumar <viresh.kumar@linaro.org>
> - */
> -
> -#ifndef LAPI_CLONE_H__
> -#define LAPI_CLONE_H__
> -
> -#include <sys/syscall.h>
> -#include <linux/types.h>
> -#include <sched.h>
> -#include <stdint.h>
> -
> -#include "config.h"
> -#include "lapi/syscalls.h"
> -
> -#ifndef HAVE_CLONE3
> -struct clone_args {
> -	uint64_t __attribute__((aligned(8))) flags;
> -	uint64_t __attribute__((aligned(8))) pidfd;
> -	uint64_t __attribute__((aligned(8))) child_tid;
> -	uint64_t __attribute__((aligned(8))) parent_tid;
> -	uint64_t __attribute__((aligned(8))) exit_signal;
> -	uint64_t __attribute__((aligned(8))) stack;
> -	uint64_t __attribute__((aligned(8))) stack_size;
> -	uint64_t __attribute__((aligned(8))) tls;
> -};
> -
> -static inline int clone3(struct clone_args *args, size_t size)
> -{
> -	return tst_syscall(__NR_clone3, args, size);
> -}
> -#endif
> -
> -#ifndef CLONE_PIDFD
> -#define CLONE_PIDFD	0x00001000	/* set if a pidfd should be placed in parent */
> -#endif
> -
> -#ifndef CLONE_NEWUSER
> -# define CLONE_NEWUSER	0x10000000
> -#endif
> -
> -static inline void clone3_supported_by_kernel(void)
> -{
> -	long ret;
> -
> -	if ((tst_kvercmp(5, 3, 0)) < 0) {
> -		/* Check if the syscall is backported on an older kernel */
> -		ret = syscall(__NR_clone3, NULL, 0);
> -		if (ret == -1 && errno == ENOSYS)
> -			tst_brk(TCONF, "Test not supported on kernel version < v5.3");
> -	}
> -}
> -
> -#endif /* LAPI_CLONE_H__ */
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 3b0b4be31..1d22a9d7e 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -11,6 +11,7 @@
>  #include <unistd.h>
>  #include <stdint.h>
>  #include <inttypes.h>
> +#include "config.h"
>  #include "lapi/syscalls.h"
>  
>  struct sched_attr {
> @@ -43,6 +44,32 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
>  	return syscall(__NR_sched_getattr, pid, attr, size, flags);
>  }
>  
> +#ifndef HAVE_CLONE3
> +struct clone_args {
> +	uint64_t __attribute__((aligned(8))) flags;
> +	uint64_t __attribute__((aligned(8))) pidfd;
> +	uint64_t __attribute__((aligned(8))) child_tid;
> +	uint64_t __attribute__((aligned(8))) parent_tid;
> +	uint64_t __attribute__((aligned(8))) exit_signal;
> +	uint64_t __attribute__((aligned(8))) stack;
> +	uint64_t __attribute__((aligned(8))) stack_size;
> +	uint64_t __attribute__((aligned(8))) tls;
> +};
> +
> +static inline int clone3(struct clone_args *args, size_t size)
> +{
> +	return tst_syscall(__NR_clone3, args, size);
> +}
> +#endif
> +
> +static inline void clone3_supported_by_kernel(void)
> +{
> +	if ((tst_kvercmp(5, 3, 0)) < 0) {
> +		/* Check if the syscall is backported on an older kernel */
> +		tst_syscall(__NR_clone3, NULL, 0);
> +	}
> +}
> +
>  #ifndef SCHED_DEADLINE
>  # define SCHED_DEADLINE	6
>  #endif
> @@ -55,6 +82,10 @@ static inline int sched_getattr(pid_t pid, struct sched_attr *attr,
>  # define CLONE_FS	0x00000200
>  #endif
>  
> +#ifndef CLONE_PIDFD
> +# define CLONE_PIDFD	0x00001000
> +#endif
> +
>  #ifndef CLONE_NEWNS
>  # define CLONE_NEWNS	0x00020000
>  #endif
> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index 07e7f0767..ecc84408c 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -8,7 +8,7 @@
>  #include <stddef.h>
>  
>  #include "tst_test.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  
>  pid_t tst_clone(const struct tst_clone_args *tst_args)
>  {
> diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
> index 39fd6df7f..6a155027c 100644
> --- a/testcases/kernel/containers/pidns/pidns13.c
> +++ b/testcases/kernel/containers/pidns/pidns13.c
> @@ -31,7 +31,7 @@
>  
>  #include "tst_test.h"
>  #include "tst_clone.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  
>  static int pipe_fd[2];
>  
> diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
> index afdad6cad..2697d874b 100644
> --- a/testcases/kernel/containers/userns/userns08.c
> +++ b/testcases/kernel/containers/userns/userns08.c
> @@ -25,7 +25,7 @@
>  
>  #include "tst_test.h"
>  #include "tst_clone.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  #include "tst_safe_file_at.h"
>  
>  static pid_t clone_newuser(void)
> diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
> index f7ef0b2d7..d0fadbc5d 100644
> --- a/testcases/kernel/syscalls/clone3/clone301.c
> +++ b/testcases/kernel/syscalls/clone3/clone301.c
> @@ -15,7 +15,7 @@
>  #include <sys/wait.h>
>  
>  #include "tst_test.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  #include "lapi/pidfd.h"
>  
>  #define CHILD_SIGNAL	SIGUSR1
> diff --git a/testcases/kernel/syscalls/clone3/clone302.c b/testcases/kernel/syscalls/clone3/clone302.c
> index 08d6417ce..b1b4ccebb 100644
> --- a/testcases/kernel/syscalls/clone3/clone302.c
> +++ b/testcases/kernel/syscalls/clone3/clone302.c
> @@ -14,7 +14,7 @@
>  #include <stdlib.h>
>  
>  #include "tst_test.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  
>  static struct clone_args *valid_args, *invalid_args;
>  unsigned long stack;
> diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
> index 5e2de4d1e..30bb600b6 100644
> --- a/testcases/kernel/syscalls/close_range/close_range01.c
> +++ b/testcases/kernel/syscalls/close_range/close_range01.c
> @@ -28,7 +28,7 @@
>  #include "tst_test.h"
>  #include "tst_clone.h"
>  
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  #include "lapi/close_range.h"
>  
>  static int fd[3];
> diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
> index bd46936bb..aec899261 100644
> --- a/testcases/kernel/syscalls/close_range/close_range02.c
> +++ b/testcases/kernel/syscalls/close_range/close_range02.c
> @@ -18,7 +18,7 @@
>  #include "tst_clone.h"
>  #include "lapi/fcntl.h"
>  #include "lapi/close_range.h"
> -#include "lapi/clone.h"
> +#include "lapi/sched.h"
>  
>  static int try_close_range(int fd, int flags)
>  {
> -- 
> 2.23.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
