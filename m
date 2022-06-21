Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74966C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 07:15:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06ED13C9478
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 09:15:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 457DB3C641F
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:15:03 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4DF0F600794
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 09:15:02 +0200 (CEST)
Received: from [10.40.94.3] (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id F1D789FF90;
 Tue, 21 Jun 2022 07:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1655795702; bh=8is5e4HeWTKSfAcRFe42UYd1GyP95OxM8tu4woxWGqU=;
 h=Message-ID:Date:MIME-Version:Subject:To:From;
 b=jNsEzhnDhBeuewaQ6u3iVOJbRLM/zVyy1sc85P0H1CvVg894lenvesXdIp5Bc7cdY
 Balgc5lR2YX71ANBz6HZMjIrUROeu+I5TYl0G5fmZ/m1T7bBaDvhHf7Lm/2sUmiA1N
 ls6XOVbhQWC38/jse6JaTbVSX3h2vJj6n48aNJTQ=
Message-ID: <11d7d8a6-c062-03aa-7e7c-f7d3c3c2f095@jv-coder.de>
Date: Tue, 21 Jun 2022 09:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: ltp@lists.linux.it, Martin Doucha <mdoucha@suse.cz>,
 Richard Palethorpe <rpalethorpe@suse.com>
References: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
From: Joerg Vehlow <lkml@jv-coder.de>
In-Reply-To: <010001816f3c352e-f5ee78c6-1425-42f5-b673-409a0a92ef74-000000@email.amazonses.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Am 6/17/2022 um 3:17 AM schrieb lkft@linaro.org:
> ## Build
> * kernel: 5.17.15
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-5.17.y
> * git commit: eed68052d2016d9f96d6656435099762608120e3
> * git describe: 6763a36
> * test details: https://qa-reports.linaro.org/lkft/ltp/build/6763a36
> 
> ## Test Regressions (compared to 20220527-48-g47ebb84)
> * qemu_arm, ltp-syscalls-tests
>   - accept02
> 
> 
> ## Metric Regressions (compared to 20220527-48-g47ebb84)
> No metric regressions found.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 
> ## Test Fixes (compared to 20220527-48-g47ebb84)
> * qemu_arm, ltp-syscalls-tests
>   - inotify12
> 
> * qemu_arm64, ltp-crypto-tests
>   - af_alg07
@Martin
This test is very unstable, can we do anything about it?

> 
> * qemu_arm64, ltp-syscalls-tests
>   - inotify12
> 
> * qemu_i386, ltp-fs-tests
>   - read_all_proc
I've seen this test fail a lot, has anyone ever tried to analyze it? I
was unable to reproduce the problem when running the test in isolation.


> 
> * qemu_i386, ltp-syscalls-tests
>   - inotify12
> 
> * qemu_x86_64, ltp-syscalls-tests
>   - inotify12
> 

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
