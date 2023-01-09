Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74000C54EBD
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 14:39:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DE813CCBB1
	for <ltp@archiver.kernel.org>; Mon,  9 Jan 2023 15:39:02 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29E153C5802
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 15:38:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 360B360010F
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 15:38:50 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id BF07737FB9
 for <ltp@lists.linux.it>; Mon,  9 Jan 2023 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673275129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lSBSwdQn5a4OBNYsr/wyAxUDEISIbqOu6nammY0VpU=;
 b=e41L2MJX9FXntjSRDeZsX7jHAJ73eh4VuqBfg3FUxY83loP9fIovFNAVnz1uwjGO/uAlYX
 QF9KP1GeqZEDb2YU4gEzoJ9v1gn8wha7Ve+4wMNj1DtnBPZrKY9B0kln6drJ8Pl6X+6pMa
 WlUk9+jUhbF0PRYlDPam1taQG1Lm7sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673275129;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9lSBSwdQn5a4OBNYsr/wyAxUDEISIbqOu6nammY0VpU=;
 b=lwaIv6qCJJ1N9TpZkYzV3x7Crckx0X5a7wxYn2cCgWBuZM7B7T+ZfkTbAlQ6Fz1GwFxujg
 mI+wFjpf6g80XVAA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9749D2C141;
 Mon,  9 Jan 2023 14:38:49 +0000 (UTC)
References: <20221223183325.10814-1-pvorel@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 09 Jan 2023 14:11:01 +0000
Organization: Linux Private Site
In-reply-to: <20221223183325.10814-1-pvorel@suse.cz>
Message-ID: <87tu0zixhk.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] aio-stress.c: Remove useless iteration
 variable
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

Petr Vorel <pvorel@suse.cz> writes:

> local iteration variable in worker() was probably left over from
> previous version before rewrite because clang correctly reported also on
> this old version:
>
>     aio-stress.c:1049:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
>     int iteration = 0;
>
> Whole restart label was not used.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v1->v2:
> * remove whole restart label.
>
>  testcases/kernel/io/ltp-aiodio/aio-stress.c | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> index 2fdbb84e87..2946ac1f47 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -1039,12 +1039,10 @@ static int *worker(struct thread_info *t)
>  	char *this_stage = NULL;
>  	struct timeval stage_time;
>  	int status = 0;
> -	int iteration = 0;
>  	int cnt;
>  
>  	aio_setup(&t->io_ctx, 512);
>  
> -restart:
>  	if (num_threads > 1) {
>  		if (pthread_barrier_wait(&worker_barrier))
>  			gettimeofday(&global_stage_start_time, NULL);
> @@ -1115,12 +1113,6 @@ restart:
>  			global_thread_throughput(t, this_stage);
>  	}
>  
> -	/* someone got restarted, go back to the beginning */
> -	if (t->active_opers && cnt < iterations) {

In this case, shouldn't we remove all the restart code? It seems
active_opers can be added to and cnt could be less than iterations. So
the label could be used.

I think you are safe to remove only the iteration variable.

Personally I would not touch this code except to fix a major issue or
rewrite it altogether.

> -		iteration++;
> -		goto restart;
> -	}
> -
>  	/* finally, free all the ram */
>  	while (t->finished_opers) {
>  		oper = t->finished_opers;
> -- 
> 2.39.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
