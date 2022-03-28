Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C898EC433FE
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 08:56:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC36D3C14BC
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 10:56:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 224533C14BC
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 10:55:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7EEB0200933
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 10:55:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC10E210E3;
 Mon, 28 Mar 2022 08:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648457755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sxSQ0W+9YJAUNT19tChsAhb0xGed7Lta5g8kPJneAO0=;
 b=jQbY+ZGuxTtTfR/lTQQ7/L37SFQnNJeJaoaiiVU2zwGwba8GScOi5jZGlAiSC51/jr4g7D
 8qGcsFxbcoEBZpxc4tevLkpZquF+sqBAJnCjOrEh+5/mZbQ3/w2yaLoI2lPFHK670Jf43T
 FMVzR4ppSTluPxhyMshWhOCgDU3qU98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648457755;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sxSQ0W+9YJAUNT19tChsAhb0xGed7Lta5g8kPJneAO0=;
 b=Y1WABzRUqLGaXBqAhfF6uHbgIXeJeZM6MQn4mD8T32fDoG9R7pL66hNrp+QJTxa/ik3bNK
 zjtIyiP4+gK2pkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9968713215;
 Mon, 28 Mar 2022 08:55:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id peQVJBt4QWKAGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 28 Mar 2022 08:55:55 +0000
Date: Mon, 28 Mar 2022 10:58:13 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YkF4pVQXMqEO32r2@yuki>
References: <20220325040057.544211-1-liwang@redhat.com> <Yj2V2fu/3Zzio3TZ@yuki>
 <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fVf8tMbY4R_O-BrSy7vtmyGgNq3NbYF=LfjyHDbDgkBg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime04: set threshold based on the clock
 tick rate
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Eirik Fuller <efuller@redhat.com>,
 Waiman Long <llong@redhat.com>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >         clock_getres(CLOCK_REALTIME_COARSE, &res);
> >
> >         delta = 5 + (res.tv_nsec / 1000000) * 5;
> >
> 
> Sounds reasonable.
> 
> But I don't understand why you multiply 5 for the resolution
> (in milliseconds) here. Or, a wiser choice is to get the real
> resolution for each clockid? i.e.

I did multiply it with 5 just to add some error margin. I guess that we
can as well multiply it with 2 if that works well enough.

I do not think that we should get resolution for each clock, the COARSE
clock should have the worst resolution of all clocks.

> --- a/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime04.c
> @@ -92,23 +92,27 @@ static struct time64_variants variants[] = {
> 
>  static void setup(void)
>  {
> -       delta = 1000/sysconf(_SC_CLK_TCK) + 5;
> -       if (tst_is_virt(VIRT_ANY)) {
> -               tst_res(TINFO, "Running in a virtual machine, multiply the
> delta by 10.");
> -               delta *= 10;
> -       }
> -
>         find_clock_gettime_vdso(&ptr_vdso_gettime, &ptr_vdso_gettime64);
>  }
> 
>  static void run(unsigned int i)
>  {
>         struct tst_ts ts;
> +       struct timespec res;
>         long long start, end = 0, diff, slack;
>         struct time64_variants *tv;
>         int count = 10000, ret;
>         unsigned int j;
> 
> +       clock_getres(clks[i], &res);
> +       tst_res(TINFO, "%s: resolution is %ldns", tst_clock_name(clks[i]),
> res.tv_nsec);
> +
> +       delta = 5 + res.tv_nsec/1000000;
> +       if (tst_is_virt(VIRT_ANY)) {
> +               delta *= 10;
> +               tst_res(TINFO, "Multiply the delta by 10 in virtual
> machine: %lld", delta);
> +       }
> +
>         do {
>                 for (j = 0; j < ARRAY_SIZE(variants); j++) {
>                         /* Refresh time in start */
> 
> -- 
> Regards,
> Li Wang

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
