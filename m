Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECFEC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 12:31:13 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7815160EBD
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 12:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7815160EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D597F3C67FA
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:31:09 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C9883C673A
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 14:30:58 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 51131601CDD
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 14:30:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635251456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wvGjwceAz7S9Sb3UnDkjoDuh6PyYieNGzTWPjs6icCw=;
 b=ZT0dESLZO3/8Cbr1sIJXrYakARQinAF0zLoViFTKlrzDT0X0LzJJQP2QY8e4TqG3N0CVmf
 xkyZxGi8gdf+0p8aNMa3SpWrQCXX+qOXlUCxnL8Z+3omDlJ+7K0yI+qSUha9ss3S6H4wqK
 U5JmPlMI8q5tUhnAsQrLm89rl7ixrz0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-IwxWoBqwPAWr_mPpGaKs9g-1; Tue, 26 Oct 2021 08:30:54 -0400
X-MC-Unique: IwxWoBqwPAWr_mPpGaKs9g-1
Received: by mail-oi1-f199.google.com with SMTP id
 t185-20020aca5fc2000000b0029a210e5f5fso635524oib.4
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 05:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wvGjwceAz7S9Sb3UnDkjoDuh6PyYieNGzTWPjs6icCw=;
 b=gKHGcLLhqRRpmin6onU/PzOYK/ttiTseaLTsBtuDagFiglMJLk4LFb6JEj5V9/Vi2R
 +6slHvMzxZwjnuu6gjNBbKKTJnNW8Lk0JDsRYsRrBUI4/d2EgYyggwtT4v17BBk/wHsu
 u8Fjg5329tOvdsmq2pKHidegy6VNNlDlYzr2Qc1P1TF16kESQ74JaMcwl2cdRwVc2LVU
 9eDIyJ3Z3sPGE6xipqqebfeZHsN9DToWK7s0nQ5/KcxcNYRv6FKeEqTbaAOpcRlZUJpr
 B2XUWVtaphU1bvwes54MP9LWDDHBUZS79KCF3cpXQ0szzmDbfnRbgL+wl9tIJits1+yH
 sbMw==
X-Gm-Message-State: AOAM533Y7mJJLyosSI+Tx2sfcpV1O8iQ3+4lQrR/0hwfDvruCGCXaPvB
 EPURyoWPv6GSH4BT+Stpjts6De57X3/tgjqcWn8XwV0pOZ5BDnp8i2YE9XjT4mMnTIrxhiUxCgf
 mNbf+b60ik6FFIUK7J0bDKEIDch4=
X-Received: by 2002:a4a:3859:: with SMTP id o25mr16824325oof.10.1635251453597; 
 Tue, 26 Oct 2021 05:30:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+U1Faq172APClYRv0VJqKaWdUVMuAaTOexMZAluRxyiBJthQMSXY89SsJ1jQvOJWZEiqOuk1d4wlSFB2XDqo=
X-Received: by 2002:a4a:3859:: with SMTP id o25mr16824313oof.10.1635251453423; 
 Tue, 26 Oct 2021 05:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20211026075025.29117-1-zhaogongyi@huawei.com>
In-Reply-To: <20211026075025.29117-1-zhaogongyi@huawei.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 26 Oct 2021 14:30:37 +0200
Message-ID: <CAASaF6yWxgM5M0L23k64GkDLBoahxi8-4-zao+yJD0NjtMn9HA@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/syscalls: Add epoll_create for aarch64.in
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

On Tue, Oct 26, 2021 at 9:49 AM Zhao Gongyi <zhaogongyi@huawei.com> wrote:
>
> Add epoll_create for aarch64.in and modify the value of epoll_ctl
> for aarch64.in. Otherwise, the testcase epoll_create01/epoll_create02 will
> fail.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  include/lapi/syscalls/aarch64.in | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/lapi/syscalls/aarch64.in b/include/lapi/syscalls/aarch64.in
> index a47185954..e9023a1d0 100644
> --- a/include/lapi/syscalls/aarch64.in
> +++ b/include/lapi/syscalls/aarch64.in
> @@ -19,7 +19,6 @@ getcwd 17
>  lookup_dcookie 18
>  eventfd2 19
>  epoll_create1 20
> -epoll_ctl 21
>  epoll_pwait 22
>  dup 23
>  dup3 24
> @@ -243,6 +242,8 @@ rt_tgsigqueueinfo 240
>  perf_event_open 241
>  accept4 242
>  recvmmsg 243
> +epoll_create 250
> +epoll_ctl 251

These values are for 32 bit only syscalls. Won't this break 64 bit?

>  wait4 260
>  prlimit64 261
>  fanotify_init 262
> --
> 2.17.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
