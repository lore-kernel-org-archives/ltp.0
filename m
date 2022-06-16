Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF3BEC43334
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 07:45:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CB263C4BD0
	for <ltp@archiver.kernel.org>; Thu, 16 Jun 2022 09:45:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 699093C291F
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 09:45:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 963971000DF6
 for <ltp@lists.linux.it>; Thu, 16 Jun 2022 09:45:43 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C59D71F85D;
 Thu, 16 Jun 2022 07:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1655365542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdEPBbMHSxu+HTKceQInNXpaEk/DK+AEolOvipjyX/I=;
 b=hGxle7G0QSqH+7Ku51fF8Fa6KyU/NsauF5WqHwOh4xA+Ir24rqO7a6fnA6hi03+DdocmBs
 aJsvoD+Kfy2sKi338xVyg7jEjQ+KYsZum6eaOGQm7utWCSER1Kkhbh5VShsbnepnJmMMrA
 PnvASCizaV3pYkrGBSdlcb5EJrypnlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1655365542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wdEPBbMHSxu+HTKceQInNXpaEk/DK+AEolOvipjyX/I=;
 b=szz0sLnGPw7l2BJMG/J1tS7H++QdAXz5qXqR7G0KuKGM113nZFf5UazpYOudz/SlqyIwbS
 AivatRrJBLDteLDg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 751FF2C141;
 Thu, 16 Jun 2022 07:45:42 +0000 (UTC)
References: <20220615090648.405100-1-liwang@redhat.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Thu, 16 Jun 2022 08:21:11 +0100
In-reply-to: <20220615090648.405100-1-liwang@redhat.com>
Message-ID: <875yl1jbkq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] madvise06: shrink to 1 MADV_WILLNEED page to
 stabilize the test
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
Cc: Paul Bunyan <pbunyan@redhat.com>, Rafael Aquini <aquini@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Paul Bunyan reports that the madvise06 test fails intermittently with many
> LTS kernels, after checking with mm developer we prefer to think this is
> more like a test issue (but not kernel bug):
>
>    madvise06.c:231: TFAIL: 4 pages were faulted out of 2 max
>
> So this improvement is target to reduce the false positive happens from
> three points:
>
>   1. Adding the while-loop to give more chances for madvise_willneed()
>      reads memory asynchronously
>   2. Raise value of `loop` to let test waiting for more times if swapchache
>      haven't reached the expected
>   3. Shrink to only 1 page for MADV_WILLNEED verifying to make the system
>      easily takes effect on it
>
> From Rafael Aquini:
>
>   The problem here is that MADV_WILLNEED is an asynchronous non-blocking
>   hint, which will tell the kernel to start doing read-ahead work for the
>   hinted memory chunk, but will not wait up for the read-ahead to finish.
>   So, it is possible that when the dirty_pages() call start re-dirtying
>   the pages in that target area, is racing against a scheduled swap-in
>   read-ahead that hasn't yet finished. Expecting faulting only 2 pages
>   out of 102400 also seems too strict for a PASS threshold.
>
> Note:
>   As Rafael suggested, another possible approach to tackle this failure
>   is to tally up, and loosen the threshold to more than 2 major faults
>   after a call to madvise() with MADV_WILLNEED.
>   But from my test, seems the faulted-out page shows a significant
>   variance in different platforms, so I didn't take this way.
>
> Btw, this patch get passed on my two easy reproducible systems more than 1000 times
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Paul Bunyan <pbunyan@redhat.com>
> Cc: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  testcases/kernel/syscalls/madvise/madvise06.c | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
> index 6d218801c..bfca894f4 100644
> --- a/testcases/kernel/syscalls/madvise/madvise06.c
> +++ b/testcases/kernel/syscalls/madvise/madvise06.c
> @@ -164,7 +164,7 @@ static int get_page_fault_num(void)
>  
>  static void test_advice_willneed(void)
>  {
> -	int loops = 50, res;
> +	int loops = 100, res;
>  	char *target;
>  	long swapcached_start, swapcached;
>  	int page_fault_num_1, page_fault_num_2;
> @@ -202,23 +202,32 @@ static void test_advice_willneed(void)
>  		"%s than %ld Kb were moved to the swap cache",
>  		res ? "more" : "less", PASS_THRESHOLD_KB);
>  
> -
> -	TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));
> +	loops = 100;
> +	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld", &swapcached_start);
> +	TEST(madvise(target, pg_sz, MADV_WILLNEED));
>  	if (TST_RET == -1)
>  		tst_brk(TBROK | TTERRNO, "madvise failed");
> +	do {
> +		loops--;
> +		usleep(100000);
> +		if (stat_refresh_sup)
> +			SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
> +		SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
> +				&swapcached);
> +	} while (swapcached < swapcached_start + pg_sz/1024 && loops > 0);
>  
>  	page_fault_num_1 = get_page_fault_num();
>  	tst_res(TINFO, "PageFault(madvice / no mem access): %d",
>  			page_fault_num_1);
> -	dirty_pages(target, PASS_THRESHOLD);
> +	dirty_pages(target, pg_sz);

Adding the loop makes sense to me. However I don't understand why you
have also switched from PASS_THRESHOLD to only a single page?

I guess calling MADV_WILLNEED on a single page is the least realistic
scenario.

If there is an issue with PASS_THRESHOLD perhaps we could scale it based
on page size?

>  	page_fault_num_2 = get_page_fault_num();
>  	tst_res(TINFO, "PageFault(madvice / mem access): %d",
>  			page_fault_num_2);
>  	meminfo_diag("After page access");
>  
>  	res = page_fault_num_2 - page_fault_num_1;
> -	tst_res(res < 3 ? TPASS : TFAIL,
> -		"%d pages were faulted out of 2 max", res);
> +	tst_res(res == 0 ? TPASS : TFAIL,
> +		"%d pages were faulted out of 1 max", res);
>  
>  	SAFE_MUNMAP(target, CHUNK_SZ);
>  }


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
