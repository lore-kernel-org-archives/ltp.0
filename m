Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B96C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:53:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 444B93CBE55
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:53:48 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A20F23CBE07
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:53:39 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AA68D60068E
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:53:38 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DF93337DC;
 Mon, 12 Dec 2022 15:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670860418; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mICcLB1JVj9DZAJjXlOpSX/82b/4cA/rnYzYmqd+Cdg=;
 b=TpDKhoXdxlFHZ2WPUP4wC/OtKwb5jbFo/Nod+qrez+Km5Oy5uLWwguNYFgYWyv6rvzZIk4
 YWrwU8gviTQYRD/R38eXvG9ju147yvQGfuvCh2YlT8cB7/IT2tT28VUSreNBPpYSqap7jq
 0tdJW+C0E4upzClY1wF+Jrjr7cSTxvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670860418;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mICcLB1JVj9DZAJjXlOpSX/82b/4cA/rnYzYmqd+Cdg=;
 b=zQ/0LQgOIBtEbFQgoE8F0NtVMdBEySguoh3oeMg/kMz97/ik8vLo+NWxdzUNjQl27kryPI
 A1UL5vgiJ1cPlyBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0842E138F3;
 Mon, 12 Dec 2022 15:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2Y9dAIJOl2PmcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Dec 2022 15:53:38 +0000
Date: Mon, 12 Dec 2022 16:53:25 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y5dOdWVLPXfgGKGg@rei>
References: <20221206165840.12107-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221206165840.12107-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getcpu01: Reinstate node_id test
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
> Presently the node_id is only checked on i386 and it is broken. The
> sched_getcpu call was substituted for getcpu when
> available. sched_getcpu does not have the node_id parameter and does
> not even call SYS_getcpu if it can be completed by vDSO.
> 
> Also we can at least check the node_id on x86_64 as well.

I suppose that the getcpu manual page is a bit confusing, the function
is implemented on most of the major achitectures and as VDSO on most of
them too. It was only added first to x86 architectures.

> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/syscalls/getcpu/getcpu01.c | 22 +++++++++------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
> index fcc273e29..21c67f412 100644
> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c
> @@ -15,20 +15,16 @@
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <sys/types.h>
> +#include "tst_test.h"
>  #include "lapi/syscalls.h"
>  #include "lapi/cpuset.h"
> -#include "tst_test.h"
>  #include "config.h"
>  
>  static inline int get_cpu(unsigned *cpu_id,
> -			  unsigned *node_id LTP_ATTRIBUTE_UNUSED,
> -			  void *cache_struct LTP_ATTRIBUTE_UNUSED)
> +			  unsigned *node_id)
>  {
> -#ifndef HAVE_SCHED_GETCPU
> -	return tst_syscall(__NR_getcpu, cpu_id, node_id, cache_struct);
> -#else
> -	*cpu_id = sched_getcpu();
> -#endif
> +	return tst_syscall(__NR_getcpu, cpu_id, node_id, NULL);

The call is mostly implemneted as VDSO so it would make much more sense
to test the libc function instead and test the implementation that is
actually used in production.

>  	return 0;
>  }
>  
> @@ -78,7 +74,7 @@ realloc:
>  	return cpu_max;
>  }
>  
> -#ifdef __i386__
> +#if  defined(__i386__) || defined(__x86_64__)
>  static unsigned int get_nodeid(unsigned int cpu_id)
>  {
>  	DIR *directory_parent, *directory_node;
> @@ -125,22 +121,22 @@ static void run(void)
>  {
>  	unsigned int cpu_id, node_id = 0;
>  	unsigned int cpu_set;


The get_nodeid() just parses sysfs, that should be portable, can't we
just get rid of the ifdefs completely instead?

> -#ifdef __i386__
> +#if defined(__i386__) || defined(__x86_64__)
>  	unsigned int node_set;
>  #endif
>  
>  	cpu_set = set_cpu_affinity();
> -#ifdef __i386__
> +#if defined(__i386__) || defined(__x86_64__)
>  	node_set = get_nodeid(cpu_set);
>  #endif
>  
> -	TEST(get_cpu(&cpu_id, &node_id, NULL));
> +	TEST(get_cpu(&cpu_id, &node_id));
>  	if (TST_RET == 0) {
>  		if (cpu_id != cpu_set)
>  			tst_res(TFAIL, "getcpu() returned wrong value"
>  				" expected cpuid:%d, returned value cpuid: %d",
>  				cpu_set, cpu_id);
> -#ifdef __i386__
> +#if defined(__i386__) || defined(__x86_64__)
>  		else if (node_id != node_set)
>  			tst_res(TFAIL, "getcpu() returned wrong value"
>  				" expected  node id:%d returned  node id:%d",
> -- 
> 2.38.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
