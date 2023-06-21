Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92664EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 08:35:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BDE03CA013
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 10:35:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C09B53C9B8C
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 10:35:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C7A12200398
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 10:35:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B07171F8C3;
 Wed, 21 Jun 2023 08:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687336507;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eq/OYUU60C6J+XWJPiEPgRUysU/sopeWfet77PNqqBo=;
 b=0+y8nGs7WSS2HKKJyqadSPCqKUXy+o9/brzICJWuqM+p4gYqd0zx5QshDNONtGCes6XrME
 g9ECO4FR8VLlyTRiaa+qpwaGKHoxBsDsgIW0yazFhxa2rBnKd2yiw04C6tAvgqePAAPGrA
 gOXIEleeGdpwwK+CBqITwspjrKcKkss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687336507;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eq/OYUU60C6J+XWJPiEPgRUysU/sopeWfet77PNqqBo=;
 b=WG0ydFYb1o7Y6p5M92m4iteYsaAFpRA0qPgMG401B7CljYjE9pLzDoI8ENCcZ8miCnLhzo
 jgROgI80sjVneeAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92EE4134B1;
 Wed, 21 Jun 2023 08:35:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 012RIju2kmTuVgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 08:35:07 +0000
Date: Wed, 21 Jun 2023 10:35:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230621083506.GC361973@pevik>
References: <20230601105127.55155-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230601105127.55155-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mem: make use of save_restore to simplify code
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

Hi Li,

very nice cleanup, thanks!

...
> +++ b/testcases/kernel/mem/tunable/overcommit_memory.c
> @@ -70,7 +70,6 @@
>  #define EXPECT_FAIL		1

>  static char *R_opt;
> -static long old_overcommit_memory = -1;
>  static long old_overcommit_ratio = -1;
>  static long overcommit_ratio;
>  static long sum_total;
> @@ -90,16 +89,11 @@ static void setup(void)
>  	long mem_total, swap_total;
>  	struct rlimit lim;

> -	if (access(PATH_SYSVM "overcommit_memory", F_OK) == -1 ||
> -	    access(PATH_SYSVM "overcommit_ratio", F_OK) == -1)
> -		tst_brk(TCONF, "system doesn't support overcommit_memory");
Here is used TCONF instead of TBROK.
> -
>  	if (R_opt)
>  		overcommit_ratio = SAFE_STRTOL(R_opt, 0, LONG_MAX);
>  	else
>  		overcommit_ratio = DEFAULT_OVER_RATIO;

> -	old_overcommit_memory = get_sys_tune("overcommit_memory");
>  	old_overcommit_ratio = get_sys_tune("overcommit_ratio");

>  	mem_total = SAFE_READ_MEMINFO("MemTotal:");
> @@ -128,14 +122,6 @@ static void setup(void)
>  	tst_res(TINFO, "TotalBatchSize is %ld kB", total_batch_size);
>  }

> -static void cleanup(void)
> -{
> -	if (old_overcommit_memory != -1)
> -		set_sys_tune("overcommit_memory", old_overcommit_memory, 0);
Also third parameter of set_sys_tune() (check) is 0.

> -	if (old_overcommit_ratio != -1)
> -		set_sys_tune("overcommit_ratio", old_overcommit_ratio, 0);
> -}
> -
>  static void overcommit_memory_test(void)
>  {

> @@ -269,6 +255,10 @@ static struct tst_test test = {
>  		{}
>  	},
>  	.setup = setup,
> -	.cleanup = cleanup,
>  	.test_all = overcommit_memory_test,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{"/proc/sys/vm/overcommit_memory", NULL, TST_SR_TBROK},
> +		{"/proc/sys/vm/overcommit_ratio", NULL, TST_SR_TBROK},
=> shouldn't be here TST_SR_TCONF instead of TST_SR_TBROK?

I also wonder if testcases/kernel/mem/tunable/max_map_count.c
can replace old_max_map_count with .save_restore (with TST_SR_TCONF).

Also testcases/kernel/mem/tunable/min_free_kbytes.c could use
.save_restore on panic_on_oom and min_free_kbytes, right?

But these two can be done as a separate effort.

Otherwise LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
