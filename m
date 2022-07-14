Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE90C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 06:59:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 612F23C91EE
	for <ltp@archiver.kernel.org>; Thu, 14 Jul 2022 08:59:05 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A22353C089F
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 08:58:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E7A031000D20
 for <ltp@lists.linux.it>; Thu, 14 Jul 2022 08:58:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657781932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9AEE+tBqtDenxiY7hJHkdHzuJVubO2NYuShMhaYv98c=;
 b=HEVetGrWawOUjulZKDxpLIZ0VSPM1dEOYI4UR1v/y/l4AQzDHIB1kj86JZ2yhlfySPY1KQ
 YM8MKAQbFkm8TW/mKLy/i/pZTREqF4l0d41Ofvzl5h12AsnvIFUlrSfx7nVhvG1DKQNFZ5
 k5nkSIrLopAnRKQcrD0HLDI1p9/IucE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-3lJTQ6Z4NIupJblKpSg6dQ-1; Thu, 14 Jul 2022 02:58:50 -0400
X-MC-Unique: 3lJTQ6Z4NIupJblKpSg6dQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 b7-20020a0565120b8700b004890b28f7c8so409944lfv.7
 for <ltp@lists.linux.it>; Wed, 13 Jul 2022 23:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9AEE+tBqtDenxiY7hJHkdHzuJVubO2NYuShMhaYv98c=;
 b=TLopd0jtYHATWEfmNo1axczp7/m+4PiDUdxgBw5k3Lmm/HsHrfTqGYXi6Nkgxi73Hl
 i4YzGUIhZ6IFfSF3PdJhI1vM8C+IXujyhpfQlWoJEGguGKh3YwmowCvFH7aPIRJwSeEY
 aH6AfjqFai4CXoC+xn1rmrd52ZA+gThKHVpuN3LCkWLkQYRB32dFICyTtYpkKo128a35
 TYCfUKVJznjkmOq/inK3QvJSu1YYlpgC5wVynQI1/2yD1cfU2AbRFvxRAL1RtY7mEGEa
 hnPITDCFwUvGkfweISbtOMnTwtDsx0iSV4LX2OWWeZ3VSnJlTBMS+xQRFXxRUk69JZYt
 3N6w==
X-Gm-Message-State: AJIora8mWO3LXUDPlW5ubCvH9k1MA7BOFzAPgvTIScfH4RnHZnJWUo0M
 UFVv7DVJun6lbO8zulyDFcVAZTuEZNnFEwrUQBKLPwL9V6GcZcHxZLyQsCXGbZb5UjpgnfrpZBM
 Yl6SYm+eTA8Q1yWBeevhuFbIk57E=
X-Received: by 2002:a05:6512:104b:b0:489:e6ad:8412 with SMTP id
 c11-20020a056512104b00b00489e6ad8412mr4444492lfb.197.1657781929344; 
 Wed, 13 Jul 2022 23:58:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1shkTmzshQ6YscWlC5/U1vliMPN4EO7KaRqfqcpL5BeQFRpNhVrgn4FKAsXGPRcxMdInhHY8zt0rixE6pM3CbQ=
X-Received: by 2002:a05:6512:104b:b0:489:e6ad:8412 with SMTP id
 c11-20020a056512104b00b00489e6ad8412mr4444484lfb.197.1657781929089; Wed, 13
 Jul 2022 23:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220712124617.23139-1-rpalethorpe@suse.com>
In-Reply-To: <20220712124617.23139-1-rpalethorpe@suse.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 14 Jul 2022 08:58:30 +0200
Message-ID: <CAASaF6xwEpong-apUxxZxQB47cw-2yaBEpn+AjjogU3qxHag1g@mail.gmail.com>
To: Richard Palethorpe <rpalethorpe@suse.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] read_all: Add worker timeout
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jul 12, 2022 at 2:46 PM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> Kill and restart workers that take too long to read a file. The
> default being one second. A custom time can be set with the new -t
> option.
>
> This is to prevent a worker from blocking forever in a read. Currently
> when this happens the whole test times out and any remaining files in
> the worker's queue are not tested.
>
> As a side effect we can now also set the timeout very low to cause
> partial reads.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Cc: Joerg Vehlow <lkml@jv-coder.de>
> Cc: Li Wang <liwang@redhat.com>
> ---
>  testcases/kernel/fs/read_all/read_all.c | 83 ++++++++++++++++++++++++-
>  1 file changed, 82 insertions(+), 1 deletion(-)

>
> +static void restart_worker(struct worker *const worker)
> +{
> +       int wstatus, ret, i, q_len;
> +       struct timespec now;
> +
> +       kill(worker->pid, SIGKILL);
> +       ret = waitpid(worker->pid, &wstatus, 0);

Is there a chance we could get stuck in uninterruptible read? I think I saw some
in past, but those may be blacklisted already, so this may only be something
to watch for if we still get test timeouts in future.

> +
> +       if (ret != worker->pid) {
> +               tst_brk(TBROK | TERRNO, "waitpid(%d, ...) = %d",
> +                       worker->pid, ret);
> +       }
> +
> +       /* Make sure the queue length and semaphore match. Threre is a
> +        * race in qeuue_pop where the semaphore can be decremented
^^ typo in queue_pop above

> +        * then the worker killed before updating q->front
> +        */
> +       q_len = 0;
> +       i = worker->q->front;
> +       while (i != worker->q->back) {
> +               if (!worker->q->data[i])
> +                       q_len++;
> +
> +               i = (i + 1) % QUEUE_SIZE;
> +       }
> +
> +       ret = sem_destroy(&worker->q->sem);
> +       if (ret == -1)
> +               tst_brk(TBROK | TERRNO, "sem_destroy");
> +       ret = sem_init(&worker->q->sem, 1, q_len);
> +       if (ret == -1)
> +               tst_brk(TBROK | TERRNO, "sem_init");
> +
> +       tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
> +       worker->last_seen = tst_timespec_to_ms(now);
> +       worker->pid = SAFE_FORK();
> +
> +       if (!worker->pid)
> +               exit(worker_run(worker));
> +}
> +
>  static void work_push_retry(int worker, const char *buf)
>  {
>         int i, ret, worker_min, worker_max, usleep_time = 100;
> +       struct timespec now;
> +       int elapsed;
>
>         if (worker < 0) {
>                 /* pick any, try -worker first */
> @@ -299,10 +357,25 @@ static void work_push_retry(int worker, const char *buf)
>         i = worker_min;
>
>         for (;;) {
> -               ret = queue_push(workers[i].q, buf);
> +               struct worker *const w = workers + i;
> +
> +               ret = queue_push(w->q, buf);
>                 if (ret == 1)
>                         break;
>
> +               tst_clock_gettime(CLOCK_MONOTONIC_RAW, &now);
> +               elapsed =
> +                       tst_timespec_to_ms(now) - tst_atomic_load(&w->last_seen);
> +
> +               if (elapsed > worker_timeout) {
> +                       if (!quiet) {
> +                               tst_res(TINFO,
> +                                       "Worker %d (%d) stuck for %dms, restarting it",
> +                                       i, w->pid, elapsed);

Can we also print file worker is stuck on?
And as Li pointed out, I'd also extend max_runtime to 60 seconds.

Acked-by: Jan Stancek <jstancek@redhat.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
