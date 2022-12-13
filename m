Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A53C4332F
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 09:53:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D92A3CBDB0
	for <ltp@archiver.kernel.org>; Tue, 13 Dec 2022 10:53:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 499E33C32DD
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 10:53:04 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 839061A00163
 for <ltp@lists.linux.it>; Tue, 13 Dec 2022 10:53:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A289A22E12;
 Tue, 13 Dec 2022 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670925182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=So5/zpQNWIGX6ncWVB1qK4Zw2HcXuiAHatom5+jq6HQ=;
 b=OfHTleNll7oh+xUm8hJYYcYW0voqhrcR0ov+P+YqkHT3EFjcITdDda/SAoqqTRAPgMbpL/
 4UVonh9vW2GCMq8PHc+hbObjsgUHCWfOv3BqflQIxCyHzR1u9jjQqKYwF204q+Ro9yE97y
 HPH5QO/GF1MwjINd3JDMPyaGT3WVm8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670925182;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=So5/zpQNWIGX6ncWVB1qK4Zw2HcXuiAHatom5+jq6HQ=;
 b=atKgorKo2WreOfacLWuXpjJkoeH7RoIGgeIxwP7uwGAUGaFu44oLuu1HQdedZQ1IC/cbnj
 RK/sAD9pfFa61NCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 772F2138F9;
 Tue, 13 Dec 2022 09:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id t83PGH5LmGOwTwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Dec 2022 09:53:02 +0000
Date: Tue, 13 Dec 2022 10:53:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y5hLfAN7NCvsKmNk@pevik>
References: <20221213094427.32743-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221213094427.32743-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcpu01: Reinstate node_id test
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

> Presently the node_id is only checked on i386 and it is broken. The
> sched_getcpu call was substituted for getcpu when
> available. sched_getcpu does not have the node_id parameter, it's not
> the same thing as getcpu.

> Also we can check the node_id on any platform which has NUMA. Which
> includes more than just x86.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Cyril Hrubis <chrubis@suse.cz>
> ---

> V2:
> * Removed all the ifdefs
> * Use libc getcpu when available
> * Remove kernel version check

>  configure.ac                                |  1 +
>  include/lapi/sched.h                        |  7 +++++
>  testcases/kernel/syscalls/getcpu/getcpu01.c | 35 ++-------------------
>  3 files changed, 11 insertions(+), 32 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index e9b15c7f7..1ab7cc60d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -101,6 +101,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      fstatat \
>      getauxval \
>      getcontext \
> +    getcpu \
>      getdents \
>      getdents64 \
>      io_pgetevents \
> diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> index 1d22a9d7e..1065665d1 100644
> --- a/include/lapi/sched.h
> +++ b/include/lapi/sched.h
> @@ -70,6 +70,13 @@ static inline void clone3_supported_by_kernel(void)
>  	}
>  }

> +#ifndef HAVE_GETCPU
> +static inline int getcpu(unsigned *cpu, unsigned *node)
> +{
> +	return tst_syscall(__NR_getcpu, cpu, node, NULL);
> +}
> +#endif
> +
>  #ifndef SCHED_DEADLINE
>  # define SCHED_DEADLINE	6
>  #endif
> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
> index fcc273e29..f6fcc4fc1 100644
> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
> @@ -11,26 +11,12 @@
>  #define _GNU_SOURCE
>  #include <dirent.h>
>  #include <errno.h>
> -#include <sched.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/types.h>
> -#include "lapi/syscalls.h"
> -#include "lapi/cpuset.h"
>  #include "tst_test.h"
> -#include "config.h"
> -
> -static inline int get_cpu(unsigned *cpu_id,
> -			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
> -			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
> -{
> -#ifndef HAVE_SCHED_GETCPU
> -	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> -#else
> -	*cpu_id = sched_getcpu();
> -#endif
> -	return 0;
> -}
> +#include "lapi/cpuset.h"
> +#include "lapi/sched.h"

>  static unsigned int max_cpuid(size_t size, cpu_set_t * set)
>  {
> @@ -78,7 +64,6 @@ realloc:
>  	return cpu_max;
>  }

> -#ifdef __i386__
>  static unsigned int get_nodeid(unsigned int cpu_id)
>  {
>  	DIR *directory_parent, *directory_node;
> @@ -119,33 +104,26 @@ static unsigned int get_nodeid(unsigned int cpu_id)
>  	}
>  	return node_id;
>  }
> -#endif

>  static void run(void)
>  {
>  	unsigned int cpu_id, node_id = 0;
>  	unsigned int cpu_set;
> -#ifdef __i386__
>  	unsigned int node_set;
> -#endif

>  	cpu_set = set_cpu_affinity();
> -#ifdef __i386__
>  	node_set = get_nodeid(cpu_set);
> -#endif

> -	TEST(get_cpu(&cpu_id, &node_id, NULL));
> +	TEST(getcpu(&cpu_id, &node_id));
>  	if (TST_RET == 0) {
>  		if (cpu_id != cpu_set)
>  			tst_res(TFAIL, "getcpu() returned wrong value"
>  				" expected cpuid:%d, returned value cpuid: %d",
>  				cpu_set, cpu_id);
> -#ifdef __i386__
>  		else if (node_id != node_set)
>  			tst_res(TFAIL, "getcpu() returned wrong value"
>  				" expected  node id:%d returned  node id:%d",
>  				node_set, node_id);
> -#endif
>  		else
>  			tst_res(TPASS, "getcpu() returned proper"
>  				" cpuid:%d, node id:%d", cpu_id,
> @@ -156,13 +134,6 @@ static void run(void)
>  	}
>  }

FYI Richie is touching the same code, one of you will need to rebase.
IMHO it's better to remove this in dedicated patchset (i.e. in Xu).

Kind regards,
Petr

> -static void setup(void)
> -{
> -	if (tst_kvercmp(2, 6, 20) < 0)
> -		tst_brk(TCONF, "kernel >= 2.6.20 required");
> -}
> -
>  static struct tst_test test = {
>  	.test_all = run,
> -	.setup = setup,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
