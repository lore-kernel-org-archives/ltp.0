Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305A1C433F5
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 08:33:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52BE73CA510
	for <ltp@archiver.kernel.org>; Mon, 11 Apr 2022 10:33:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B451F3C02B1
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 10:33:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A078E1A006E1
 for <ltp@lists.linux.it>; Mon, 11 Apr 2022 10:33:23 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 251891F37D;
 Mon, 11 Apr 2022 08:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1649666002;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uZslm2j0ysTgyR9Vuosagb25ErdptkNmWBW36snehk=;
 b=XUFVV8yFhNqnBOZLGEhDX669CtrVkMK+ZKnPkQkMsMkW786dqeOCIO9ATr0RxXgUOLaWJ2
 kuyOo+pFildj5vpEkYOYaDaZeFEqSVDtaGffR4xAtaZG764eq4+Sm1rYLZIGLK11sPMauv
 /YYVU1F54jmL7IjuWE+yI67jHQ4FAP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1649666002;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uZslm2j0ysTgyR9Vuosagb25ErdptkNmWBW36snehk=;
 b=qpoQsx9yBCr35Y8pRrY/c5cM9BkqMih59rQ6JigCet3T08BHkiPpH8lmBhFu1keblEnNFv
 YWx3x2DFbbtFu6CQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id B7D51A3B88;
 Mon, 11 Apr 2022 08:33:21 +0000 (UTC)
References: <20220405170607.3596657-1-edliaw@google.com>
 <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 11 Apr 2022 08:51:43 +0100
In-reply-to: <CAEemH2dZiWZjHWMzrRuuiar5YQHF741TMu4p=uMtWgTPG4Oh+w@mail.gmail.com>
Message-ID: <87sfqkggtq.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fzsync: break inf loop with flag vs
 pthread_cancel
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
Cc: kernel-team <kernel-team@android.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li and Edward,

Sorry for slow response I was AFK.

Li Wang <liwang@redhat.com> writes:

> Hi Edward,
>
> On Wed, Apr 6, 2022 at 1:06 AM Edward Liaw via ltp <ltp@lists.linux.it> wrote:
>
>  Hi, I'm working to get fzsync working with the Android kernel, which
>  does not have pthread_cancel available.
>
>  In the absence of pthread_cancel, when thread A exits due to a break,
>  thread B will get stuck in an infinite loop while waiting for thread A
>  to progress.
>
>  Instead of cancelling thread B, we can use the exit flag to break out of
>  thread B's loop.  This should also remove the need for the wrapper
>  around the thread.
>
> This method is more graceful, but involves a new potential issue.
>
> Looking at tst_fzsync_run_a, if anything goes wrong in other places
> (thread_b) and break with setting 'pair->exit' to 1 to end the looping. 
> It doesn't work for thread_a because tst_atomic_store(exit, &pair->exit)
> will reset it back to 0 (int exit = 0).

I don't think we have ever handled thread B breaking gracefully?

If B breaks and it calls tst_fzsync_pair_cleanup then it will try to
join to itself and we will probably get EDEADLK.

In most cases though thread B is very simple and doesn't even use SAFE_
functions.

>
> Another suggestion is to distinguish the abnormal invoke for
> tst_fzsync_pair_cleanup, because that is rarely a situation we
> encounter, no need to reset pair->exit over again.
>
> So better to have this improvement:
>
> --- a/include/tst_fuzzy_sync.h
> +++ b/include/tst_fuzzy_sync.h
> @@ -232,7 +232,11 @@ static inline void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
>  static inline void tst_fzsync_pair_cleanup(struct tst_fzsync_pair *pair)
>  {
>         if (pair->thread_b) {
> -               tst_atomic_store(1, &pair->exit);
> +               /* Terminate thread B if parent hits accidental break */
> +               if (!pair->exit) {
> +                       tst_atomic_store(1, &pair->exit);
> +                       usleep(100000);

Why do we need usleep?

> +               }
>                 SAFE_PTHREAD_JOIN(pair->thread_b, NULL);
>                 pair->thread_b = 0;
>         }
> @@ -642,7 +646,6 @@ static inline void tst_fzsync_wait_b(struct tst_fzsync_pair *pair)
>   */
>  static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>  {
> -       int exit = 0;
>         float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
>  
>         if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
> @@ -657,19 +660,18 @@ static inline int tst_fzsync_run_a(struct tst_fzsync_pair *pair)
>         if (pair->exec_time_p < rem_p) {
>                 tst_res(TINFO,
>                         "Exceeded execution time, requesting exit");
> -               exit = 1;
> +               tst_atomic_store(1, &pair->exit);
>         }
>  
>         if (++pair->exec_loop > pair->exec_loops) {
>                 tst_res(TINFO,
>                         "Exceeded execution loops, requesting exit");
> -               exit = 1;
> +               tst_atomic_store(1, &pair->exit);
>         }
>  
> -       tst_atomic_store(exit, &pair->exit);
>         tst_fzsync_wait_a(pair);
>  
> -       if (exit) {
> +       if (pair->exit) {
>                 tst_fzsync_pair_cleanup(pair);
>                 return 0;
>         }

I think this part is reasonable however. Even if we don't handle B
breaking fully gracefully it is better to avoid setting exit back to
zero unecessarily and risking deadlock.

>
> -- 
> Regards,
> Li Wang


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
