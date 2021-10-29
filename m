Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B899C433EF
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 07:50:04 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3D660234
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 07:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A3D660234
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE5BE3C6E45
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 09:50:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DE813C0E9B
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 09:49:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A9F11610496
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 09:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635493788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDLUcq1w5o4AdujHmp6KP5dD+la3Yr7gNWSp6DA+yFY=;
 b=eLKRcSib5eTXBKNSIhPdlI/oeC5EGTkbyhD8qiis7RiV+++p1aKOp4H/Qu2/t0dkHn43uo
 SzQbd10h8w9/u4wpSnUIrbBziwpu2D9Xtj8iHRIiT4XYxGbY3at/mvgKLxdd4DhT8rGG0/
 CCoR0OZGWQW80vnKerTnjOZkJy3xsDc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-tmPUBuQXORaS8Cy-wJ36VA-1; Fri, 29 Oct 2021 03:49:44 -0400
X-MC-Unique: tmPUBuQXORaS8Cy-wJ36VA-1
Received: by mail-oi1-f199.google.com with SMTP id
 w26-20020a056808019a00b00298e7b4523cso4591116oic.9
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 00:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lDLUcq1w5o4AdujHmp6KP5dD+la3Yr7gNWSp6DA+yFY=;
 b=NPoAayjo7vik2HFPDCTxIBkOP67EfhPGgWzbcpUmyA8JsG131x+pYLOOeHRIsm4qq5
 MDjHABZEoKytOQ4EC6ZxwdCfrrfXCqPkXgyvQzDA6sAlJInMd2WUFDjlIyrRDaFAWe1a
 MWdiFqTNJThhwc2zBMn9uBh9TdmLY8waqcYGUfXCeVzFXTQsRsrsgNbznoCEs7k+Aks9
 9HFC8bchVZQFt+Al3iir73n95rQiCcZ0yTRyMjJji0aLRfSiCtc67YrU55S0h979l9Ff
 uYYX6C3/4+CRsFjaDQ53abQvRJ4X/eURWuqDm4T5iIoz6yvUHMq8Zd8uAWLiazEdPxIN
 ctjA==
X-Gm-Message-State: AOAM5320TkrpbDIFQwsAdbfmBAXRDXeLLs21Bv3cUf7nwBtFCL6aVmDc
 3NFKzRs6REmtOTIg3VmEoycJoigZEZJo7ZPqoeSn9/pA0Ta5gmCpCMGxvKuTEUh3ZBir5G9wdZ1
 loDL4ieXZBlwwgAWARVQZAM16J5I=
X-Received: by 2002:a9d:1b31:: with SMTP id l46mr7383654otl.57.1635493783799; 
 Fri, 29 Oct 2021 00:49:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFB1CbGqypZs1++5ghRjeKLLZy8fbENo+FfZ5cdy3RRYWgD6e3xDSDtbVGZ8UXJOjMsGKds2rRq+u0B2P6duI=
X-Received: by 2002:a9d:1b31:: with SMTP id l46mr7383641otl.57.1635493783535; 
 Fri, 29 Oct 2021 00:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20211028031422.208689-1-zhaogongyi@huawei.com>
In-Reply-To: <20211028031422.208689-1-zhaogongyi@huawei.com>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 29 Oct 2021 09:49:28 +0200
Message-ID: <CAASaF6zDyWnkrNGdWAHqgrwQWk3n8cu0DhU3B5-ip0_ka5K5xA@mail.gmail.com>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/epoll_create: Replace syscall to libc
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

On Thu, Oct 28, 2021 at 5:13 AM Zhao Gongyi <zhaogongyi@huawei.com> wrote:
>
> For epoll_create01.c/epoll_create02.c, we should replace syscall to libc
> or the testcase will fail because of Syscall epoll_create is not support
> in some arches.
>
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>

Acked-by: Jan Stancek <jstancek@redhat.com>

> ---
>  testcases/kernel/syscalls/epoll_create/epoll_create01.c | 2 +-
>  testcases/kernel/syscalls/epoll_create/epoll_create02.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> index 3ef5b5cac..b6ebe9ad7 100644
> --- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> @@ -24,7 +24,7 @@ static int tc[] = {1, INT_MAX};
>
>  static void run(unsigned int n)
>  {
> -       TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);
> +       TST_EXP_FD(epoll_create(tc[n]), "epoll_create(%d)", tc[n]);
>
>         if (!TST_PASS)
>                 return;
> diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> index c59ea7944..e96228983 100644
> --- a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> @@ -27,7 +27,7 @@ static struct test_case_t {
>
>  static void run(unsigned int n)
>  {
> -       TST_EXP_FAIL(tst_syscall(__NR_epoll_create, tc[n].size),
> +       TST_EXP_FAIL(epoll_create(tc[n].size),
>                      tc[n].exp_err, "create(%d)", tc[n].size);
>  }
>
> --
> 2.17.1
>
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
