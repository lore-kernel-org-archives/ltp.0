Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18B7C43458
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 14:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782483128; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=63j4hQKFatwyccoP8FO9yr04MUJw3bOoFcUJNNzTR64=;
 b=COVJG6WPnX7QRIFQLSCVegvmZTz5hm7BRlW0JTmxmf89JNxssr6TkyvcrGS/hqF4fwNN7
 og695TuzWnLR28ah+eU6mXrbFxp597FSLdKOx8SrUEZeBoe10dBTYDT0jayjAMoECOdNSKH
 CxHR09h10gQL7eWlKqB7aNkb1twzJfw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98CBE3E2F68
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 16:12:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A4913CA9FF
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 16:11:47 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2A0871000D91
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 16:11:41 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-46fe8fabdc0so20970f8f.0
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782483100; x=1783087900; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4xctNntPaD8E+bm7ayE9kfFCEAyVdOvNh/DMLdlN7Fo=;
 b=Vu06OaOeJY7PMuQ4GoMX0VKhKNypG+xX0Y3VNSlXa+LUv9J1lluED3Hl07lZY067QB
 UAxVhqMyYMgjozMkF5km8YbmsCR5uhOBPMeTC5jYwcoYJ2r4lwTcT9SdF2+nmxZ6h1ZH
 u2DQXWalbsGVAYJioaOmZ800PwEB09WQHzU9gmMN8wzpB+mE/D3P/mM/zyI4XR5y3q2q
 EfATIs2TfNqCIylvYMJmJ8XC7V0lBtc7zxs/uKILvHWeQSzo36QNvRtwkZNNtGP0q6OW
 Q0V8AKLh8NOusfv6xpAO8nF6MHrx2/Jv94lkMDmdOJT59iCAbXhcgDs/eMf6sXyAyEzE
 ji1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782483100; x=1783087900;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xctNntPaD8E+bm7ayE9kfFCEAyVdOvNh/DMLdlN7Fo=;
 b=sZY5k6LX8aKHOOQBzB2j+KbKHwM9aE86z2tGlCqAaxO8HEh60q35YSwFpQ0KeMQ/eg
 Z/jpx6cSjjY/m+p9UBcUpJxj4Er8klDiseKQtFGgmi1a6L85K7I/EKeWwuKJlbn9fq5D
 tn9hLvURCytv5u0QYhoo/hUpdvAhBtDy9Vzd5COO6EQIOxeD7C9DYnHY3pQGalwhkXay
 roDOMsuEZHJ4aBVJo1rAGufjdAZqjKsy4hD/LkQpeBHwFieBAp+I/UyNj/EW4WXdHi8q
 GprsyMx+edBhrMJSDkzWsdI0++QVNuLioVk3lJ5RCoYWfgkaoOgZavmAnsMDPaWcdNcm
 nRIQ==
X-Gm-Message-State: AOJu0YyPrHRrM1ySkGZkQJCH6n3qJUtraRWY6/2lTnrgXbHESzXSZQJS
 xZnd4odAEdrjO8bFnUXFuQgwYUXTIa7eDXXTcH2HUze07XVadJE/tp+ZshFKr/SgUIL3f6IVbUD
 Bbc0=
X-Gm-Gg: AfdE7ckKeovE+cs+SJi63U8dBpL2qRAaykzY8mW8bjnN5LiNCTjJlXqJJh98lg+/keu
 TErY4BZ/S1mdedjni8VUJCoVZmXrAzTVkuFB8ePXaQU8a/gsuaIGVg9xOAe4l3xATxA4/8Skxr6
 NwK4JmCCLcrlrUFBgpE2xIZm95av1Acuv3inhBeywCj/6Uznq0b5gbX6gTmsj2Ssx5t4kgp0HsZ
 /a9G+rgIJl8MnmFb4kv5UHUvcd1MOozghFq1+OjZnsxXfad9lyxb7GHWBAdAEUsEYVCYS0ISej8
 z+m+jn2CM8osLXx/9gJUTijfw22BzBSqK8Ulq4xzITDW6ZLjGNZ46ldITNOqOlWlq+Q224uryzh
 sO5WNSMwlr4W/uLdOt9AXlgKXC9dBiubiIPXgNTBcnvPGei4LAePzVuz/ietLdW+CkLL182W+5B
 +04xa/paIuSAfI2Xi156I0LaLZnxpusg==
X-Received: by 2002:a05:6000:4901:b0:46d:2c51:63d4 with SMTP id
 ffacd0b85a97d-46dc398a28dmr11896251f8f.41.1782483100393; 
 Fri, 26 Jun 2026 07:11:40 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee01d46sm23390719f8f.13.2026.06.26.07.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 07:11:39 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:11:38 +0000
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <aj6Iml1fSH2IwjqN@autotest-wegao.qe.prg2.suse.org>
References: <6a3e42d0.2cf1dda8.3b5368.08d7@mx.google.com>
 <20260626135347.48218-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260626135347.48218-1-avinesh.kumar@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] set_mempolicy: require CONFIG_NUMA
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jun 26, 2026 at 03:53:46PM +0200, Avinesh Kumar via ltp wrote:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
> 
> On kernels without CONFIG_NUMA=y set_mempolicy() returns ENOSYS,
> which the test misreports as TFAIL.
> 
> set_mempolicy05 -
> 
> set_mempolicy05.c:105: TFAIL: set_mempolicy should fail with EFAULT or EINVAL, instead returned 38
> 
> remaining of these tests (set_mempolicy[01-04]) checks for minimum two
> NUMA nodes and reports TCONF, but those also should exit on CONFIG_NUMA
> check.
> 
> tse_numa.c:200: TINFO: Found 1 NUMA memory nodes
> tse_numa.c:141: TINFO: File '/sys/devices/system/node/node0/meminfo' does not exist! NUMA not enabled?
> get_mempolicy02.c:60: TCONF: test requires at least one NUMA memory node
> 
> Add .needs_kconfigs with CONFIG_NUMA=y
> 
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
> ---
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c | 4 ++++
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c | 4 ++++
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c | 4 ++++
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c | 4 ++++
>  testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c | 4 ++++
>  5 files changed, 20 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> index a85a56332..07836cc69 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy01.c
> @@ -120,6 +120,10 @@ static struct tst_test test = {
>  	.forks_child = 1,
>  	.needs_checkpoints = 1,
>  	.timeout = 600,
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_NUMA=y",
> +		NULL
> +	}
>  };
I suppose we do not need "#ifdef HAVE_NUMA_V2" anymore in the code.
Same for set_mempolicy02 etc
>  
>  #else
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
> index 94d8aa336..d98f81545 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy02.c
> @@ -109,6 +109,10 @@ static struct tst_test test = {
>  	.tcnt = 2,
>  	.forks_child = 1,
>  	.needs_checkpoints = 1,
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_NUMA=y",
> +		NULL
> +	}
>  };
>  
>  #else
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> index bc5e03217..43e0439d4 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy03.c
> @@ -103,6 +103,10 @@ static struct tst_test test = {
>  	.mntpoint = MNTPOINT,
>  	.forks_child = 1,
>  	.needs_checkpoints = 1,
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_NUMA=y",
> +		NULL
> +	}
>  };
>  
>  #else
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> index 672232c84..fa88385ce 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy04.c
> @@ -134,6 +134,10 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.mntpoint = MNTPOINT,
>  	.needs_checkpoints = 1,
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_NUMA=y",
> +		NULL
> +	}
>  };
>  
>  #else
> diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
> index 7481dcd8d..fb118c4ac 100644
> --- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
> +++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
> @@ -115,6 +115,10 @@ static struct tst_test test = {
>  		"ppc",
>  		NULL
>  	},
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_NUMA=y",
> +		NULL
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "cf01fb9985e8"},
>  		{"CVE", "2017-7616"},
> -- 
> 2.54.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
