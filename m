Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29721C433EF
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 10:37:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9D6D3C9582
	for <ltp@archiver.kernel.org>; Mon, 18 Jul 2022 12:37:48 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C4F73C90A6
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 12:37:37 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CE535600494
 for <ltp@lists.linux.it>; Mon, 18 Jul 2022 12:37:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2EEC533895;
 Mon, 18 Jul 2022 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658140656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ad2o1ZN0l95751BxxMU7SvYqdoQ/7wSF2+HTpfZjbQ=;
 b=XBSQGZ63zH8iIrkDyUkzPbJwrfUyVpGewkKZeMn1PdbRvBxD0NDeGLDmZbTztJOrpCyR0g
 6CE2J6wTtSrTNwP6Iar/LfllT3XmWlONTElmvwE9c+CXDW70JMe1Om8jfGWfFl5fNuqIWr
 udeO5dtGFmYRqI9aqSiTLAVPpPXTVUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658140656;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/ad2o1ZN0l95751BxxMU7SvYqdoQ/7wSF2+HTpfZjbQ=;
 b=2tYDT6UZz4Io+VBS29ebNdpjgji3iUzLfVk+UeECLcXVA8XtswyFI0+IpPvdcHnJ3Ciy9B
 pR3eGhnUHWz20mCQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D16072C141;
 Mon, 18 Jul 2022 10:37:35 +0000 (UTC)
References: <20220712124617.23139-1-rpalethorpe@suse.com>
 <CAEemH2e=-8rt+N=VdiA27xO=-Z5zE4RPu+MCf2NDCuOTq6xcAw@mail.gmail.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Mon, 18 Jul 2022 11:09:21 +0100
In-reply-to: <CAEemH2e=-8rt+N=VdiA27xO=-Z5zE4RPu+MCf2NDCuOTq6xcAw@mail.gmail.com>
Message-ID: <87pmi2iu4w.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Reply-To: rpalethorpe@suse.de
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> On Tue, Jul 12, 2022 at 8:46 PM Richard Palethorpe <rpalethorpe@suse.com> wrote:
>
>  Kill and restart workers that take too long to read a file. The
>  default being one second. A custom time can be set with the new -t
>  option.
>
>  This is to prevent a worker from blocking forever in a read. Currently
>  when this happens the whole test times out and any remaining files in
>  the worker's queue are not tested.
>
>  As a side effect we can now also set the timeout very low to cause
>  partial reads.
>
> To restart workers which are blocked from reading files is a practical way.
> My only concern is that restarted-worker is also slower reading on some
> specific files so it will still be timed out again. Then the rest will fall into 
> restart cycles. Here I'd suggest loosening the worker_timeout to 3000 ms
> to accommodate systems of different IO speeds.

I didn't observe any issues setting the timeout very low
(<100ms). Worker's remove an item from the queue before trying to read
it, so they shouldn't get stuck in a restart cycle on the same file (if
thats what you meant).

>
> Though each worker at most takes 3secs, the max time would not
> be overdue 45s (3 sec * max_works), unless tested sequentially
> in the worst case. So bumping up max_runtime maybe also helpful.
>
> Anyway, I'd be happy to apply your patch first to see how things going.
> Reviewed-by: Li Wang <liwang@redhat.com>
>
> --- a/testcases/kernel/fs/read_all/read_all.c
> +++ b/testcases/kernel/fs/read_all/read_all.c
> @@ -64,7 +64,7 @@ struct queue {
>  struct worker {
>         pid_t pid;
>         struct queue *q;
> -       int last_seen;
> +       unsigned long long last_seen;
>  };
>  
>  enum dent_action {
> @@ -86,7 +86,7 @@ static long max_workers = 15;
>  static struct worker *workers;
>  static char *drop_privs;
>  static char *str_worker_timeout;
> -static int worker_timeout = 1000;
> +static int worker_timeout = 3000;
>  
>  static char *blacklist[] = {
>         NULL, /* reserved for -e parameter */
> @@ -552,5 +552,6 @@ static struct tst_test test = {
>         .cleanup = cleanup,
>         .test_all = run,
>         .forks_child = 1,
> +       .max_runtime = 60,
>  };

I'm not sure if this is better or worse. In my sys folder there are
approx 35K files. Obviously a timeout of even 1s is far too long to read
all of them if they all timeout. In fact if we set the timeout as 100ms
then they would still require about 58 mins.

Of course most of them take a very short time on most systems. I guess
that ideally the timeout needs to be adapted as the test runs so that
all remaining files can be read. The issue with that though is that kill+wait+fork
takes more time than most reads. Although that can be measured as
well....

This issue is quite a lot like the issues we have with fuzzy sync. I
think it's maybe time to start dynamically adapting to system
performance. That's probably best left to another patch series though.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
