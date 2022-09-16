Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D6DC54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 08:39:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 485253CAC69
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 10:38:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E14033CAC3A
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:38:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2EF002013DB
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:38:46 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D94921FDD6;
 Fri, 16 Sep 2022 08:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663317525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUrf5ETYVEWy8jMieFEH9FByfKcrEqe/1iDLsDsq3QM=;
 b=y2EN6ryCtZNmESsNBzptVaTQDiQYRa88kNIBWmnZS5dIhCawxjSKzbvZYXOElQ9VUnmOVM
 odaZ3BJ3B+WcdvvTW/lJuKRceasiqxsIph0TGz090LBfbNBB1KEtv8kE+Xo3JHe/tKUQsg
 wrll6pgOmSHqhscJrWdHHqO8RB5Lhi4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663317525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eUrf5ETYVEWy8jMieFEH9FByfKcrEqe/1iDLsDsq3QM=;
 b=AkvXfxk5jbFRlgZ1DIDSwNnyEEEsKkyBf9rHGWqvBwQCNdpvnGMiWictS+7piBPJtgYGqB
 UtBo9M1ZYJoyeGCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9B451346B;
 Fri, 16 Sep 2022 08:38:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nBIyLBU2JGOiRgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 08:38:45 +0000
Date: Fri, 16 Sep 2022 10:40:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyQ2i0t6JEL0ksib@yuki>
References: <20220915160343.21773-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915160343.21773-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ksm: Add max_runtime to tests
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
> ksm02, ksm04 and ksm05 take 10+ seconds to finish. Set max_runtime to avoid
> random timeout issues.

The patch looks good. I guess that the ksm05 in the description is a
leftover and should be removed before applying, right?

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Changes since v1:
> - Increased max_runtime from 20s to 32s
> - Added dynamic runtime calculation for non-default memsize
> 
> After some experiments it turns out that the total amount of RAM doesn't
> matter, ksmd will scan only pages marked with MADV_MERGEABLE. So unless
> another process interferes with the test, we can calculate max_runtime
> from the memory size parameter.
> 
> The create_same_memory() function will run 4 ksm scan on each call which
> takes about 2 seconds with the default memory size. Both ksm02 and ksm04
> call it twice which means 16 seconds of runtime by default. Let's raise it
> to 32 for some safety margin on slower systems.
> 
>  testcases/kernel/mem/ksm/ksm02.c      | 4 ++++
>  testcases/kernel/mem/ksm/ksm04.c      | 4 ++++
>  testcases/kernel/mem/ksm/ksm_common.h | 4 +++-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
> index 1cb7d8e73..4183108d5 100644
> --- a/testcases/kernel/mem/ksm/ksm02.c
> +++ b/testcases/kernel/mem/ksm/ksm02.c
> @@ -85,6 +85,9 @@ static void verify_ksm(void)
>  static void setup(void)
>  {
>  	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
> +
> +	if (opt_sizestr && size > DEFAULT_MEMSIZE)
> +		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
>  }
>  
>  static struct tst_test test = {
> @@ -110,6 +113,7 @@ static struct tst_test test = {
>  	},
>  	.test_all = verify_ksm,
>  	.min_kver = "2.6.32",
> +	.max_runtime = 32,
>  	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
>  };
>  
> diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
> index 39c741876..9fe9d6dd5 100644
> --- a/testcases/kernel/mem/ksm/ksm04.c
> +++ b/testcases/kernel/mem/ksm/ksm04.c
> @@ -87,6 +87,9 @@ static void setup(void)
>  	parse_ksm_options(opt_sizestr, &size, opt_numstr, &num, opt_unitstr, &unit);
>  
>  	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
> +
> +	if (opt_sizestr && size > DEFAULT_MEMSIZE)
> +		tst_set_max_runtime(32 * (size / DEFAULT_MEMSIZE));
>  }
>  
>  static struct tst_test test = {
> @@ -112,6 +115,7 @@ static struct tst_test test = {
>  	},
>  	.test_all = verify_ksm,
>  	.min_kver = "2.6.32",
> +	.max_runtime = 32,
>  	.needs_cgroup_ctrls = (const char *const []){
>  		"memory", "cpuset", NULL
>  	},
> diff --git a/testcases/kernel/mem/ksm/ksm_common.h b/testcases/kernel/mem/ksm/ksm_common.h
> index 56faf01e4..a582891c6 100644
> --- a/testcases/kernel/mem/ksm/ksm_common.h
> +++ b/testcases/kernel/mem/ksm/ksm_common.h
> @@ -9,7 +9,9 @@
>  
>  #include "tst_test.h"
>  
> -int size = 128, num = 3, unit = 1;
> +#define DEFAULT_MEMSIZE 128
> +
> +int size = DEFAULT_MEMSIZE, num = 3, unit = 1;
>  char *opt_sizestr, *opt_numstr, *opt_unitstr;
>  
>  static inline void parse_ksm_options(char *str_size, int *size,
> -- 
> 2.37.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
