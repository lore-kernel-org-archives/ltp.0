Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A889C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 14:03:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F5CD3CBE4E
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:03:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48A843CBE07
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:02:55 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B1027600681
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 15:02:54 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id B81D033764;
 Mon, 12 Dec 2022 14:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670853773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGPa0whbkt7aTGg5fl65m2JLnO30NN9xmqQQl7MwGFo=;
 b=YqwF/R5MYJqqJHdN0PWA9lVMhVL0r7PKawbyZsvDu1G9aiOYXTGY7cwm36aMk2PU1WrVSU
 B/O6qJn82ypvbLwiZ2OWkqmHwGvPwnPHPHbzMg49w+6N48/qPNue7rnDerF7ShJ4Dg3Ch5
 BvMKmEC7cVfVRPf9w7MkQHuXzHTP/aM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670853773;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hGPa0whbkt7aTGg5fl65m2JLnO30NN9xmqQQl7MwGFo=;
 b=uWqXv7Vxgx/6gT87CXBHADmtekKCBE+67A0EqeaaUaGk4aUejHJAe2NzDELyfXanZrK3Cz
 e7Lw3qjlBH+nk/Bg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8C5792C141;
 Mon, 12 Dec 2022 14:02:53 +0000 (UTC)
References: <20221206165840.12107-1-rpalethorpe@suse.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 12 Dec 2022 14:01:23 +0000
Organization: Linux Private Site
In-reply-to: <20221206165840.12107-1-rpalethorpe@suse.com>
Message-ID: <87fsdkvhx0.fsf@suse.de>
MIME-Version: 1.0
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Ping! I will merge soon if there are no comments.

Richard Palethorpe via ltp <ltp@lists.linux.it> writes:

> Presently the node_id is only checked on i386 and it is broken. The
> sched_getcpu call was substituted for getcpu when
> available. sched_getcpu does not have the node_id parameter and does
> not even call SYS_getcpu if it can be completed by vDSO.
>
> Also we can at least check the node_id on x86_64 as well.
>
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
> +
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


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
