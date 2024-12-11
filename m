Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75AEE7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733910163; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=3EO09/6XNxHDxoB3clHV31OwSVs1QD6HJspYE28pkUs=;
 b=hTwPxH59nXTxV8Th1YATW4ODeAjC9nOSKe6Gw7iQ/4Gt8KTN/LwsQTlZBlCpgSCIwyC2Y
 viPJWK2ygXfbaNZhCMWg1ZNVl8GH8qeiYzockv1MmHXNJSyLi5VJxjAE0SaMkIyt/Jyx52f
 +FIeQc0st2S3zT1huONnZF5Fve/phDM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A674A3E7CFD
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:42:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3B4E3C279D
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:42:22 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8955B100F6F8
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 10:42:21 +0100 (CET)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434f80457a4so2585195e9.0
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 01:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733910141; x=1734514941; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fnASpvkAOLI9b0WRR7pB54cICSJl+Hts+UtSGRNRy/M=;
 b=S+9ith7uKOsi2upXKtFdYHQMFcetJxpzVnNliYuTg0dt8RYngO1dF/MXrQR/CYpyxg
 aPqfnZbmPvZlxvXAcaUj6bFBTWgTkKh6Dm7Eu/udG6Kk3DJmMK9Qwigr3hPc70ZSX4/m
 q4WAFEfnIknz1pD9qPLWBsO7FRe07c5djXnqlaRMpfP2/nwfW5D0ffRq2JFsKQd5ZDGQ
 TlmRgXQrhbRnMF7G09OIdgsDd47X6NKlCRgxpJVqk/t252REoKapUx3Ofd7mYNl20AD/
 mn3EZQGLlgpF0r9WVBuR76F42aTYBeAz7JSAOiSO2t1d5l3eTSDI+nUhfutUtRfBXJ7B
 omPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733910141; x=1734514941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fnASpvkAOLI9b0WRR7pB54cICSJl+Hts+UtSGRNRy/M=;
 b=hFjLF/BDbgDFkbNu4R+3Je89pQ5WmrhPvg09ihLQFutEZDL5kAi7dP4VxpB1w+mGtb
 /WMUk1MKk/z8Uyn6XLT6WLOgJLOLB9lmVTmu8lbzYdtQ56QlZdcptpSEBXuwOTcknDEi
 F4og63SNxJYQTF1KKoMzm+mfdT54TNk0827Sa7O9xunc9chvDOFuKlgBLwybmYoEmBGh
 1w2RZ/thz7dscnn/Sc4xqGt+mT6ouzjPf+njToIFM/5tgp6k+QOZZV97+q8IxtIAgNcA
 0BykdwFeo658gXXD+/8CP4WfRaOI8UU5VCbKRPWalFGnFpcBZe/eOVfq0AMN2AzT88Bb
 06Hg==
X-Gm-Message-State: AOJu0YytEy06VNoqutaklPvVdhcdQF9nN9qhnYrhFwowB4f/sbl2N8sB
 JqP1jqDnwnRbHIBdkMKNKTP6mmkCexzVFCEsrjvBsNxPyYMooX48kmPRfpiAqmIj2ox9QE/7tGp
 WKzA=
X-Gm-Gg: ASbGncslDa/atKAfsun8MZFqXUF2eDCIRyhAlD8lAlCaC3DqOELNw2SchpmjqAOKWh8
 812yOfphjTYgHdb6AvUj4aZwPU2+yym6Tgvsp5pHrg48dVzjTP0k8RZarwFER86VIK5m/a9elx/
 GrdPdbCBu41EeqdnCQg4JfGJpmlSV1a4FHLwD6+sYQMEbTl8Y0K+cnqfCAw75sU61xqAwJDAxJ6
 PT4cJYxKMKgGAFqGqAMmDC0YiFY1f3COz4sjOSoSHRf+jIqBP1Yhahmjh9ibV+Ezg==
X-Google-Smtp-Source: AGHT+IGsXKsuLeoAwt42lGX0q4ZndXt9cmiXKACMUzq7rybIMxHLiHsvTkSu102ryEbJyA+gvU8Gyg==
X-Received: by 2002:a5d:59af:0:b0:386:37bb:ddf8 with SMTP id
 ffacd0b85a97d-3864de8f134mr1219512f8f.6.1733910140651; 
 Wed, 11 Dec 2024 01:42:20 -0800 (PST)
Received: from [192.168.42.37] ([193.86.92.181])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725df830510sm6550046b3a.29.2024.12.11.01.42.18
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 01:42:20 -0800 (PST)
Message-ID: <d1c3fef0-108e-4136-bfa1-660245158521@suse.com>
Date: Wed, 11 Dec 2024 10:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CA+G9fYvcBvbabg+m7brKfpGCGZUcK+KHHTFX7hFvW6GmN2XF0g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] selftests: core: unshare_test: WARNING: at mm/util.c:671
 __kvmalloc_node_noprof
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

why we are discussing kselftests in the LTP mailing list? Delivery 
error? :-)

Andrea Cervesato

On 8/26/24 15:20, Naresh Kamboju wrote:
> The following kernel warning is noticed on all arch and all devices while
> running selftests: core: unshare_test on Linux next-20240823 and next-20240826.
>
> First seen on next-20240823.
>    Good: next-20240822
>    BAD:  next-20240823 and next-20240826
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Crash log:
> --------
> # selftests: core: unshare_test
> <4>[   61.084149] ------------[ cut here ]------------
> <4>[ 61.085175] WARNING: CPU: 0 PID: 477 at mm/util.c:671
> __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[   61.088958] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
> sha512_ce sha512_arm64 drm fuse backlight dm_mod ip_tables x_tables
> <4>[   61.093141] CPU: 0 UID: 0 PID: 477 Comm: unshare_test Not
> tainted 6.11.0-rc5-next-20240826 #1
> <4>[   61.094558] Hardware name: linux,dummy-virt (DT)
> <4>[   61.096763] pstate: 23400009 (nzCv daif +PAN -UAO +TCO +DIT
> -SSBS BTYPE=--)
> <4>[ 61.097841] pc : __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[ 61.099701] lr : __kvmalloc_node_noprof (mm/util.c:661)
> <4>[   61.100448] sp : ffff800080abbce0
> <4>[   61.100819] x29: ffff800080abbcf0 x28: fff0000004549280 x27:
> 0000000000000000
> <4>[   61.101744] x26: 0000000000000000 x25: 0000000000000000 x24:
> fff0000003615e40
> <4>[   61.102512] x23: fff0000003615ec0 x22: bfafa45863b285c8 x21:
> 0000000200002000
> <4>[   61.103232] x20: 00000000ffffffff x19: 0000000000400cc0 x18:
> 0000000000000000
> <4>[   61.104053] x17: 0000000000000000 x16: 0000000000000000 x15:
> 0000000000000000
> <4>[   61.104927] x14: 0000000000000000 x13: 0000000000000000 x12:
> 0000000000000000
> <4>[   61.105752] x11: 0000000000000000 x10: 0000000000000000 x9 :
> 0000000000000000
> <4>[   61.106606] x8 : 0000000000000001 x7 : 0000000000000001 x6 :
> 0000000000000005
> <4>[   61.107377] x5 : 0000000000000000 x4 : fff0000004549280 x3 :
> 0000000000000000
> <4>[   61.108207] x2 : 0000000000000000 x1 : 000000007fffffff x0 :
> 0000000000000000
> <4>[   61.109262] Call trace:
> <4>[ 61.109619] __kvmalloc_node_noprof (mm/util.c:671 (discriminator 1))
> <4>[ 61.110248] alloc_fdtable (fs/file.c:133)
> <4>[ 61.110751] expand_files
> (include/linux/atomic/atomic-arch-fallback.h:457
> include/linux/atomic/atomic-instrumented.h:33 fs/file.c:177
> fs/file.c:238)
> <4>[ 61.111171] ksys_dup3 (fs/file.c:1337)
> <4>[ 61.111596] __arm64_sys_dup3 (fs/file.c:1355)
> <4>[ 61.112006] invoke_syscall (arch/arm64/include/asm/current.h:19
> arch/arm64/kernel/syscall.c:54)
> <4>[ 61.112480] el0_svc_common.constprop.0
> (include/linux/thread_info.h:127 (discriminator 2)
> arch/arm64/kernel/syscall.c:140 (discriminator 2))
> <4>[ 61.112955] do_el0_svc (arch/arm64/kernel/syscall.c:152)
> <4>[ 61.113384] el0_svc (arch/arm64/include/asm/irqflags.h:55
> arch/arm64/include/asm/irqflags.h:76
> arch/arm64/kernel/entry-common.c:165
> arch/arm64/kernel/entry-common.c:178
> arch/arm64/kernel/entry-common.c:713)
> <4>[ 61.113742] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
> <4>[ 61.115181] el0t_64_sync (arch/arm64/kernel/entry.S:598)
> <4>[   61.115709] ---[ end trace 0000000000000000 ]---
>
>
> Crash Log links,
> --------
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/log
>
> Crash failed comparison:
> ----------
>   - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24953436/suite/log-parser-test/test/check-kernel-exception-warning-cpu-pid-at-mmutilc-__kvmalloc_node_noprof/history/
>
> metadata:
> ----
>    git describe: next-20240823 and next-20240826
>    git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>    git sha: c79c85875f1af04040fe4492ed94ce37ad729c4d
>    kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/config
>    artifact location:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/
>    build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2l2pZRzhgRkPgXIKLJCI7vwVd6t/
>    toolchain: clang-18 and gcc-13
>
> Steps to reproduce:
> ---------
>   - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l2paZVYTloIDBYnua1s12DeIic/reproducer
>   - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2l2paZVYTloIDBYnua1s12DeIic/tux_plan
>
> Please let me know if you need more information.
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
