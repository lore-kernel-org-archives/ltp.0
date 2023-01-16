Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1784C54EBE
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 10:59:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 758833CC8F3
	for <ltp@archiver.kernel.org>; Mon, 16 Jan 2023 11:59:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98FDC3CC904
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 11:59:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CDB0020075A
 for <ltp@lists.linux.it>; Mon, 16 Jan 2023 11:59:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 239E9676D0;
 Mon, 16 Jan 2023 10:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1673866781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dkTtyC/QPFkeA39ccr4MXK2PgahhQXGf0q0vPBbYlE=;
 b=nobP6DmLHXJ+pVCvYNZLeCa+brQC27x2BiTsxeoMEpIbQwZIeDWStiJ+p4+OZ9HpxMZW4L
 jdFq7ygr8xzfXYpdJNNOxvXqYRP4ZXrsnAIcoIoLbqdnHlmtZ/r580x9Tlm/6nTYyJpal3
 01y7U4BgIf5Sw00QU8VrK396Yhd1zR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1673866781;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9dkTtyC/QPFkeA39ccr4MXK2PgahhQXGf0q0vPBbYlE=;
 b=2yYy2fL6LfVAnhDnYTAxOMo2Tzw5vkeH9hN89Cm6CPRLVGrET3errgEfT7bgvtTWB5fjkr
 eBFdb/s6YS+0w5CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id E28A82C149;
 Mon, 16 Jan 2023 10:59:40 +0000 (UTC)
References: <20230111091341.13346-1-pvorel@suse.cz>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 16 Jan 2023 10:53:07 +0000
Organization: Linux Private Site
In-reply-to: <20230111091341.13346-1-pvorel@suse.cz>
Message-ID: <87o7qywxr7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/1] aio-stress.c: Remove useless iteration
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

I have merged this and my/Petr's aiocp patches.

Petr I'm not sure what motivated some of these changes? Although clearly
the code was incorrect, I don't see the test failures in OpenQA?

Petr Vorel <pvorel@suse.cz> writes:

> local iteration variable in worker() was probably left over from
> previous version before rewrite because clang correctly reported also on
> this old version:
>
>     aio-stress.c:1049:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
>     int iteration = 0;
>
> NOTE: restart label was considered to be removed, but in the end kept.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Changes v2->v3:
> * Keep restart label (remove only the variable)
>
>  testcases/kernel/io/ltp-aiodio/aio-stress.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> index d84d5a0741..5c3a0a3a49 100644
> --- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
> +++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
> @@ -1039,7 +1039,6 @@ static int *worker(struct thread_info *t)
>  	char *this_stage = NULL;
>  	struct timeval stage_time;
>  	int status = 0;
> -	int iteration = 0;
>  	int cnt;
>  
>  	aio_setup(&t->io_ctx, 512);
> @@ -1116,10 +1115,8 @@ restart:
>  	}
>  
>  	/* someone got restarted, go back to the beginning */
> -	if (t->active_opers && cnt < iterations) {
> -		iteration++;
> +	if (t->active_opers && cnt < iterations)
>  		goto restart;
> -	}
>  
>  	/* finally, free all the ram */
>  	while (t->finished_opers) {


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
