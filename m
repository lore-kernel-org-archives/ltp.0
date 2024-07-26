Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CB1C3DA49
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 06:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721973908; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=nrFungvsnVSQl4FJpK6fOG1VAJULx1UParG7cuvA9Yk=;
 b=eIvIkYW1D4oIPrW2oELzCfXD4lmejn0P8Rv0t7w6zJ1dQgu7vZutJkVFuXCBbcTt93Eqv
 8FSnIqTodA+5EinppphE6KKKM339pEAJT4FxyGlQ0T83rUvRq3E7o4ZoX3wMSWJY+NukhBQ
 Z45/UER5b5+jLpMgJvzAU1cjNlfEKDU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4CAB3CF2B6
	for <ltp@archiver.kernel.org>; Fri, 26 Jul 2024 08:05:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E23303CF2B4
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 08:04:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 077B7600045
 for <ltp@lists.linux.it>; Fri, 26 Jul 2024 08:04:44 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5a10bb7bcd0so2180075a12.3
 for <ltp@lists.linux.it>; Thu, 25 Jul 2024 23:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1721973884; x=1722578684; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8z4Qs57lEnhGFKLybutF/+Jl4TWkuhd86yhca/QI+c=;
 b=U5M4y7t/jLqOe7x7pWZZl/HNZzDDzPy+tGJaGGX+f5lAouVKCAyjVlZ6vdfTSsDAWA
 VoaOoP9IxYE1mFV8IE26O82Ud1zpydXXetYejWU6+9Jz/hAMgn7mKD3CbSXxqWSXPe4P
 X0MTqJFQvU7P10vmdhDPt3+5iRZHf998NIleGlly4qMoYTubM7NStjOSC11EuWpVwpYx
 raaNPfXP7KM1+oJB7hdtUhy0kxEPtbCMkgD68Ztk3JMWykJbktgT1dmOfAFAD5NmQ+nn
 02IYQIk455PMordn4OJTMWAVYADnxtw113FTj7wZfNTPm0clxVL7zqVLvunqt8VSarBL
 58rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721973884; x=1722578684;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8z4Qs57lEnhGFKLybutF/+Jl4TWkuhd86yhca/QI+c=;
 b=RezYGsK4ZjkgNTMNha4pu719OZI3X4cH2vkR8/rDbPmMVwgsEPfD+RueIRlJ8676hZ
 YI9Anouo1aj7McLPeXF85FV+EYxMIPu4wJFkNLcvOA4qrR8hBVMoCKwmbXSE3Y+LetB1
 sL+Hli7FSiG9W5NgJJhIcxfKWD0ztn151K9UB2ckzgctjRRn3i49Vn+UIJ/3Cg6MBw8J
 cc1FOBEgK3bq2DXzrPBwkA0iCQHRoPpWC3jrHwuiEgy/vvjt5n59+gPkxjHdSWnEXzlh
 VQ6IHMklyX3XeBZPRlPEGAR1KeWyVI4XYVDDRzbf2usygW2f/O5gwdZ45JMqCrNVbuXT
 yP7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUud6FINl9m83b1gMm24TgohL1SIx4t3OYNS9thWHfPw8gfn2xvvc2LkfgCKLlN7gFP/b0E3siMs1A2uVeuuiflrno=
X-Gm-Message-State: AOJu0YyX3N6Eyqtyr8uf85UhxCEgMkDeyaEsT1VJzLf/43yF+BRwJ0UN
 hGyzn69aBGECKBmtazU8xTdlZ0+qsVd6LRska76yKn3+R8Ii6JmViByniPwjsJ8=
X-Google-Smtp-Source: AGHT+IG8lVWUKY9HlTEYVQXBE2/yC/8xv5WW9xyVSsa6BPdUiiqoSMtrJaai8l/Bub27MAemtsjnEg==
X-Received: by 2002:a17:906:7d7:b0:a77:e55a:9e87 with SMTP id
 a640c23a62f3a-a7ac503afd5mr271762366b.48.1721973884003; 
 Thu, 25 Jul 2024 23:04:44 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662?
 ([2a02:a31b:84a1:b780:b3c4:a558:3bdc:9662])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad92cd7sm140107866b.179.2024.07.25.23.04.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jul 2024 23:04:43 -0700 (PDT)
Message-ID: <b8c4a02f-d108-42d0-8da1-aa4000f789bd@suse.com>
Date: Fri, 26 Jul 2024 08:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>, ltp@lists.linux.it
References: <20240726024447.134802-1-liwang@redhat.com>
Content-Language: en-US
In-Reply-To: <20240726024447.134802-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cachestat: remove .min_kver from cachestat tests
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 7/26/24 04:44, Li Wang wrote:
> Removing the kernel version check (.min_kver) from the cachestat
> tests to allow the test to run on distributions that backport the
> cachestat syscall.
>
> With no support just skip as TCONF:
>    ../../../../include/lapi/mman.h:40: TCONF: syscall(451) __NR_cachestat not supported on your arch

It's ok for me.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

> Suggested-by: Stephen Bertram <sbertram@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>   testcases/kernel/syscalls/cachestat/cachestat01.c | 1 -
>   testcases/kernel/syscalls/cachestat/cachestat02.c | 1 -
>   testcases/kernel/syscalls/cachestat/cachestat03.c | 1 -
>   testcases/kernel/syscalls/cachestat/cachestat04.c | 1 -
>   4 files changed, 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/cachestat/cachestat01.c b/testcases/kernel/syscalls/cachestat/cachestat01.c
> index f3730d773..19ae9655e 100644
> --- a/testcases/kernel/syscalls/cachestat/cachestat01.c
> +++ b/testcases/kernel/syscalls/cachestat/cachestat01.c
> @@ -90,7 +90,6 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.needs_tmpdir = 1,
> -	.min_kver = "6.5",
>   	.mount_device = 1,
>   	.mntpoint = MNTPOINT,
>   	.all_filesystems = 1,
> diff --git a/testcases/kernel/syscalls/cachestat/cachestat02.c b/testcases/kernel/syscalls/cachestat/cachestat02.c
> index 2bb94f133..e168de5a5 100644
> --- a/testcases/kernel/syscalls/cachestat/cachestat02.c
> +++ b/testcases/kernel/syscalls/cachestat/cachestat02.c
> @@ -82,7 +82,6 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.needs_tmpdir = 1,
> -	.min_kver = "6.5",
>   	.bufs = (struct tst_buffers []) {
>   		{&cs, .size = sizeof(struct cachestat)},
>   		{&cs_range, .size = sizeof(struct cachestat_range)},
> diff --git a/testcases/kernel/syscalls/cachestat/cachestat03.c b/testcases/kernel/syscalls/cachestat/cachestat03.c
> index 35f6bdfb3..139745c34 100644
> --- a/testcases/kernel/syscalls/cachestat/cachestat03.c
> +++ b/testcases/kernel/syscalls/cachestat/cachestat03.c
> @@ -70,7 +70,6 @@ static struct tst_test test = {
>   	.needs_hugetlbfs = 1,
>   	.hugepages = {1, TST_NEEDS},
>   	.tcnt = ARRAY_SIZE(tcases),
> -	.min_kver = "6.5",
>   	.needs_tmpdir = 1,
>   	.bufs = (struct tst_buffers []) {
>   		{&cs, .size = sizeof(struct cachestat)},
> diff --git a/testcases/kernel/syscalls/cachestat/cachestat04.c b/testcases/kernel/syscalls/cachestat/cachestat04.c
> index a389c203c..a59494451 100644
> --- a/testcases/kernel/syscalls/cachestat/cachestat04.c
> +++ b/testcases/kernel/syscalls/cachestat/cachestat04.c
> @@ -48,7 +48,6 @@ static void run(void)
>   
>   static struct tst_test test = {
>   	.test_all = run,
> -	.min_kver = "6.5",
>   	.mount_device = 1,
>   	.mntpoint = MNTPOINT,
>   	.bufs = (struct tst_buffers []) {

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
