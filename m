Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93501C43217
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 10:33:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 367AE3CC49C
	for <ltp@archiver.kernel.org>; Thu,  1 Dec 2022 11:33:24 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 487CB3CC470
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:33:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B52BB1001952
 for <ltp@lists.linux.it>; Thu,  1 Dec 2022 11:33:13 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C2ED31FD6B;
 Thu,  1 Dec 2022 10:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669890792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PrFIdcQQ4Rvdsr9De5kplGPAU6WfggeFwgcCCGYno+Y=;
 b=rb3wJHhxJWEWc3xderKHqJvLrna5JVjNb/qAGT73INGkCPKXvhzINF+4wL+nrYyFsB5Rhs
 ppDIj/CxbWH9DEu4F8bLmuhoQNY7hT4Y0ML9ocxZOkAUuO69H8SL2ESPAmro/ZPZtsOYZU
 efT7OoXsJULbhw/xFy4GZLtVjf5ew1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669890792;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PrFIdcQQ4Rvdsr9De5kplGPAU6WfggeFwgcCCGYno+Y=;
 b=mrvtXkbhIAdYiZFnkBc8pGPaJPNKbMFccnAfJx2r28ZDBpiTz5SjdhqbXxIqxJcbGlxi7t
 LBy6w5dPx1N/2mCg==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A073C2C141;
 Thu,  1 Dec 2022 10:33:12 +0000 (UTC)
References: <20221130135451.28399-1-andrea.cervesato@suse.com>
 <20221130135451.28399-2-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Thu, 01 Dec 2022 10:29:28 +0000
Organization: Linux Private Site
In-reply-to: <20221130135451.28399-2-andrea.cervesato@suse.com>
Message-ID: <87h6yfifbr.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 1/2] Rewrite aio-stress test using LTP API
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

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>  	}
>  }
>  
> @@ -1111,7 +1040,7 @@ void global_thread_throughput(struct thread_info *t, char *this_stage)
>   * various timings are printed in between the stages, along with
>   * thread synchronization if there are more than one threads.
>   */
> -int worker(struct thread_info *t)
> +static int *worker(struct thread_info *t)
>  {
>  	struct io_oper *oper;
>  	char *this_stage = NULL;
> @@ -1126,15 +1055,18 @@ restart:

There is a useless variable below this line reported by clang

aio-stress.c:1049:6: warning: variable 'iteration' set but not used [-Wunused-but-set-variable]
        int iteration = 0;

It's incremented, but never read from. This seems to have always been
the case and it should be removed.

With that

Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
