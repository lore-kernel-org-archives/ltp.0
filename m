Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76A94C433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 09:16:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 267433C9B10
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 10:16:45 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBEE63C07BD
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:16:35 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B13BA140021A
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 10:16:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644225393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLmX5S/LNNxm9ZzbzEooCGz3Yu+5pNttWWK5wvTUn/E=;
 b=BnnTaZ4m/bC8hc5d+TPB3YgIOJUvwkwnEN+ICfizE+vdES+RzWsskgKKNINsCqi+1p4upT
 vokSel7XJpWoX2hP5TrFp7lPbO5/xw/L50gI+A8MtWAeIZYWD24Var7qiqmwSYcwkSOsrB
 gNhA0Swdca77I0x+8fYMqQcdLvOkcZQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-177-6_rDQlSBPjWWoyKRzdAAGg-1; Mon, 07 Feb 2022 04:16:30 -0500
X-MC-Unique: 6_rDQlSBPjWWoyKRzdAAGg-1
Received: by mail-ot1-f72.google.com with SMTP id
 l1-20020a9d7341000000b0059c2046f9edso5691567otk.3
 for <ltp@lists.linux.it>; Mon, 07 Feb 2022 01:16:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZLmX5S/LNNxm9ZzbzEooCGz3Yu+5pNttWWK5wvTUn/E=;
 b=yYi38mIbYTMkLZ+bvFryarBT2CqcY5di4rlV1PIDxxVRtlggOZkaRn3GJp3Z3FfvqQ
 9JsQc8achvACzw4H0xmk0gy5VA2BcVQPDnH4J5r6eKF2PnveP6Ia1uZuXtu17VXy4NER
 g3f5oAtaujwMJdfwelbFSDMRkdYiwkCT77a1KSABdAYHv6pMy/XmHO4k4XudVI7X8e7T
 vnO5p0xYv70TH/dCgHpcyO6HQG5RXATOvEhemYQAP5NUohBDVWFNegUtHSVQWzsVXqdC
 //UcBP2FMDFD3PJzgJJNg28ad4fviPqWFY+hP4sNq+8IYFBFED0sxSlU/QtCGa3gdS27
 TOFQ==
X-Gm-Message-State: AOAM533+EtH5BosMkDv4BfdDGWLnJydi2tRakXC7Rvvzm4OGNRsCWOVP
 HV5DodMgORZfMfNuCIJ/aUl89wfimOEGiTmcXeTxFQHYKSmUPTYYfRoyC0Ox3PNO3MzKgd/qd+u
 MVH4CqSnpe0LnqihEkyRV42Q2H/o=
X-Received: by 2002:a4a:e705:: with SMTP id y5mr3320021oou.21.1644225389710;
 Mon, 07 Feb 2022 01:16:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwwY8enHi1vXSJ7ODiaPB6zd8CG9B55bqSKyKS3xj3erPad10Pez9kkKy5PdThRqXGfAHsIrWR7ko6EcEfUULw=
X-Received: by 2002:a4a:e705:: with SMTP id y5mr3320012oou.21.1644225389381;
 Mon, 07 Feb 2022 01:16:29 -0800 (PST)
MIME-Version: 1.0
References: <20220207040447.2803113-1-liwang@redhat.com>
In-Reply-To: <20220207040447.2803113-1-liwang@redhat.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 7 Feb 2022 10:16:10 +0100
Message-ID: <CAASaF6ytd7ROq_S48NnYWY4-VU+nGjX7NTcgM5aGQG6G0rh_OQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: skip on small RAM system
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

On Mon, Feb 7, 2022 at 5:05 AM Li Wang <liwang@redhat.com> wrote:
>
> It is easy to get VmSwap increase with a small system, here is
> run with a 1G RAM kvm guest and TBROK:
>
>     7   tst_test.c:1365: TINFO: Timeout per run is 0h 05m 00s
>     8   getrusage03.c:43: TPASS: initial.self ~= child.self
>     9   getrusage03.c:57: TPASS: initial.children ~= 100MB
>     10  getrusage03.c:66: TPASS: child.children == 0
>     11  getrusage03.c:84: TPASS: child.children ~= 300MB
>     12  getrusage03.c:104: TPASS: initial.children ~= pre_wait.children
>     13  getrusage03.c:112: TPASS: post_wait.children ~= 400MB
>     14  getrusage03.h:25: TBROK: VmSwap is not zero
>     15  getrusage03.c:133: TPASS: initial.children ~= after_zombie.children
>     16  getrusage03.h:25: TBROK: VmSwap is not zero
>     17  getrusage03_child.c:57: TPASS: initial.self ~= exec.self
>     18  getrusage03_child.c:62: TPASS: initial.children ~= exec.children
>
> Signed-off-by: Li Wang <liwang@redhat.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

This should fix the immediate failure, just wondering,
would there be any downside of replacing that TBROK with TCONF?

> ---
>
> Notes:
>     Ps. I also think we might need .min_mem_[avai|total] field but
>         not sure if it is really necessary to add that.
>
>  testcases/kernel/syscalls/getrusage/getrusage03.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/getrusage/getrusage03.c b/testcases/kernel/syscalls/getrusage/getrusage03.c
> index bf5127483..5aa0b2326 100644
> --- a/testcases/kernel/syscalls/getrusage/getrusage03.c
> +++ b/testcases/kernel/syscalls/getrusage/getrusage03.c
> @@ -173,6 +173,14 @@ static void run(unsigned int i)
>         }
>  }
>
> +static void setup(void)
> +{
> +       long long mem_avail = tst_available_mem();
> +
> +       if (mem_avail < 512L*1024)
> +               tst_brk(TCONF, "Needed > 512MB availabe, only have: %ld kB", mem_avail);
> +}
> +
>  static struct tst_test test = {
>         .forks_child = 1,
>         .child_needs_reinit = 1,
> @@ -182,6 +190,7 @@ static struct tst_test test = {
>                 {"linux-git", "1f10206cf8e9"},
>                 {}
>         },
> +       .setup = setup,
>         .test = run,
>         .tcnt = ARRAY_SIZE(testfunc_list),
>  };
> --
> 2.31.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
