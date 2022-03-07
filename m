Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3ED8C43217
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 13:03:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5C783C1BD1
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 14:03:40 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85ACD3C1B99
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 14:03:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D53FD1400BD3
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 14:03:30 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 34DF7210F2
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646658210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcgJrU/If2rjvoDoAhUMHk104TpK2gMD3IzhC/veq38=;
 b=VY+GuFnlXNDMkU5r9u9+9Lxqi4HkjUa7yzYVSXSOWZ0SYf+Sbb4aZI0qykn+O6eY6WuW7m
 emOiNOivL1QiJ2lFcJciBUkXorYBwTJzOqRk4nYfLgyZDdUlDExxPtV4NJ8gDXi87NNtx9
 IIAL2mUPzn4L9vBYEJ4uHte/+kzRqwE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646658210;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PcgJrU/If2rjvoDoAhUMHk104TpK2gMD3IzhC/veq38=;
 b=dkF4Y8a/O2DHp0vQcW3bC/1K0mjlNm28kMjIzsVkd/jXC/deI/hgrBkr5hj2FJQKfZATWP
 v2yjh/Kd3NhnNiDQ==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F0BD0A3B83;
 Mon,  7 Mar 2022 13:03:29 +0000 (UTC)
References: <20220303145032.21493-1-chrubis@suse.cz>
 <20220303145032.21493-3-chrubis@suse.cz>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 07 Mar 2022 13:03:21 +0000
In-reply-to: <20220303145032.21493-3-chrubis@suse.cz>
Message-ID: <87a6e1ncda.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/7] mem/lib: Export group_check() as
 ksm_group_check()
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

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> This is preparing for the move of the code from library to the ksm06.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>

> ---
>  testcases/kernel/mem/include/mem.h |  2 ++
>  testcases/kernel/mem/lib/mem.c     | 22 +++++++++++-----------
>  2 files changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
> index f1cba5fcb..776809113 100644
> --- a/testcases/kernel/mem/include/mem.h
> +++ b/testcases/kernel/mem/include/mem.h
> @@ -50,6 +50,8 @@ void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
>  
>  void create_same_memory(int size, int num, int unit);
>  void test_ksm_merge_across_nodes(unsigned long nr_pages);
> +void ksm_group_check(int run, int pg_shared, int pg_sharing, int pg_volatile,
> +                     int pg_unshared, int sleep_msecs, int pages_to_scan);
>  
>  /* THP */
>  
> diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
> index ee9fc85b6..102fc5665 100644
> --- a/testcases/kernel/mem/lib/mem.c
> +++ b/testcases/kernel/mem/lib/mem.c
> @@ -271,9 +271,9 @@ static void final_group_check(int run, int pages_shared, int pages_sharing,
>  	check("pages_to_scan", pages_to_scan);
>  }
>  
> -static void group_check(int run, int pages_shared, int pages_sharing,
> -			int pages_volatile, int pages_unshared,
> -			int sleep_millisecs, int pages_to_scan)
> +void ksm_group_check(int run, int pages_shared, int pages_sharing,
> +		     int pages_volatile, int pages_unshared,
> +		     int sleep_millisecs, int pages_to_scan)
>  {
>  	if (run != 1) {
>  		tst_res(TFAIL, "group_check run is not 1, %d.", run);
> @@ -489,19 +489,19 @@ void create_same_memory(int size, int num, int unit)
>  
>  	resume_ksm_children(child, num);
>  	stop_ksm_children(child, num);
> -	group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
> +	ksm_group_check(1, 2, size * num * pages - 2, 0, 0, 0, size * pages * num);
>  
>  	resume_ksm_children(child, num);
>  	stop_ksm_children(child, num);
> -	group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
> +	ksm_group_check(1, 3, size * num * pages - 3, 0, 0, 0, size * pages * num);
>  
>  	resume_ksm_children(child, num);
>  	stop_ksm_children(child, num);
> -	group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
> +	ksm_group_check(1, 1, size * num * pages - 1, 0, 0, 0, size * pages * num);
>  
>  	resume_ksm_children(child, num);
>  	stop_ksm_children(child, num);
> -	group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
> +	ksm_group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
>  
>  	tst_res(TINFO, "KSM unmerging...");
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
> @@ -586,15 +586,15 @@ void test_ksm_merge_across_nodes(unsigned long nr_pages)
>  	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
>  	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
> -	group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
> -		    nr_pages * num_nodes);
> +	ksm_group_check(1, 1, nr_pages * num_nodes - 1, 0, 0, 0,
> +		        nr_pages * num_nodes);
>  
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
>  	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
>  	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
> -	group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
> -		    0, 0, 0, nr_pages * num_nodes);
> +	ksm_group_check(1, num_nodes, nr_pages * num_nodes - num_nodes,
> +		        0, 0, 0, nr_pages * num_nodes);
>  
>  	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
>  
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
