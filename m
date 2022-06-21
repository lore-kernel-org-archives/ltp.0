Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2303AC43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 07:22:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAE8F3C942D
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:22:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D5D23C1BAD
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:22:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 79D561400985
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:22:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655796149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S1e0zMEngjHVZy6MaoGWtXgR2sQ0+nLoRJYMKHF4MS4=;
 b=HQQNjTAfUOkIJl6Vb+eposdvjUslpZE42wOefuccuB7eV9dHm9O/VaTAeGrhDHGYr170wJ
 zlAkhpr/uN7LFavNfwlYUdKvwMnM7k13tF2lMlKMJu+n9+xrwNKJdpma9g48AavTFEP8Lu
 zjJYQzYp+7YlZbJAaZ+PnqNsFLVvJ/A=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-517-606aMuq7Ml-5R7LAmmHrmQ-1; Tue, 21 Jun 2022 03:22:27 -0400
X-MC-Unique: 606aMuq7Ml-5R7LAmmHrmQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 b2-20020a0565120b8200b00477a4532448so6564503lfv.22
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 00:22:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S1e0zMEngjHVZy6MaoGWtXgR2sQ0+nLoRJYMKHF4MS4=;
 b=FpDHOI3RDVqrg15YVonU+7hoL5S6ViHZMBQPGDA82KZUDu5EdG45/Ul9gyUaAUT1qk
 ciX+aDKuwAzfTCMQgYlnm5zxHvSVxrVO+3rLe2RXb7uQYVMzwAGU4vNZx4ttbtI3lePe
 GluhL+yM/b679FHrJeSOPkQ2vIvNKVVfQQIz01RX6jLwXUtgTXYHQWHQWRsJRp1cG/OL
 wt7b7R1meaa5iyQ6pYmt9IePtIFIHam07qwszBVEZ3K328mBMHHxq57idwSPkgTov2jV
 WQBbqzCb2y52wyVJ15s30m+NJYz1KROPccguDJMystEfQp3DiddoQkFi35YTJSAaAh7K
 cBXA==
X-Gm-Message-State: AJIora/K06n8VR9x0viv2bu2KdhwurCAguKb89ttfqWuJbyF7viAcdtS
 rQRmy5borXtEqMD1u3hiMRMAeXrFRPo3+bwaOQGNkRNFrqrxqO3Ar4CHijnj5bytyj7wWAoVhAp
 AIoyUSZsVRXoThkKx92d7/ndgJZI=
X-Received: by 2002:a05:6512:22cf:b0:47f:7b38:73e7 with SMTP id
 g15-20020a05651222cf00b0047f7b3873e7mr1797037lfu.523.1655796144915; 
 Tue, 21 Jun 2022 00:22:24 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sy1DbPmiwhwftk2Vto6MftJXxX8NhxWgl1VnsT1bn/vV7kyFPLzaWJ2U621HOv1njNZRQjQraf4valDfb+zeg=
X-Received: by 2002:a05:6512:22cf:b0:47f:7b38:73e7 with SMTP id
 g15-20020a05651222cf00b0047f7b3873e7mr1797031lfu.523.1655796144729; Tue, 21
 Jun 2022 00:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
 <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
In-Reply-To: <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 21 Jun 2022 09:22:08 +0200
Message-ID: <CAASaF6wyH7YJtNaGfR9n-yhnHv9Pc7BvCMYe1EWvwnCMtNhfDQ@mail.gmail.com>
To: Joerg Vehlow <lkml@jv-coder.de>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [REGRESSION] lkft ltp for 6763a36
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 21, 2022 at 9:15 AM Joerg Vehlow <lkml@jv-coder.de> wrote:
>
> Hi,
>
> Am 6/17/2022 um 3:17 AM schrieb lkft@linaro.org:
> > ## Build
> > * kernel: 5.17.15
> > * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> > * git branch: linux-5.17.y
> > * git commit: eed68052d2016d9f96d6656435099762608120e3
> > * git describe: 6763a36
> > * test details: https://qa-reports.linaro.org/lkft/ltp/build/6763a36
> >
> > ## Test Regressions (compared to 20220527-48-g47ebb84)
> > * qemu_arm, ltp-syscalls-tests
> >   - accept02
> >
> >
> > ## Metric Regressions (compared to 20220527-48-g47ebb84)
> > No metric regressions found.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> >
> > ## Test Fixes (compared to 20220527-48-g47ebb84)
> > * qemu_arm, ltp-syscalls-tests
> >   - inotify12
> >
> > * qemu_arm64, ltp-crypto-tests
> >   - af_alg07
> @Martin
> This test is very unstable, can we do anything about it?
>
> >
> > * qemu_arm64, ltp-syscalls-tests
> >   - inotify12
> >
> > * qemu_i386, ltp-fs-tests
> >   - read_all_proc
> I've seen this test fail a lot, has anyone ever tried to analyze it? I
> was unable to reproduce the problem when running the test in isolation.

I see it hit timeouts too (read_all_sys as well). I think it needs
runtime restored to 5minutes as well, atm. it has 30s.

>
>
> >
> > * qemu_i386, ltp-syscalls-tests
> >   - inotify12
> >
> > * qemu_x86_64, ltp-syscalls-tests
> >   - inotify12
> >
>
> Joerg
>
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
