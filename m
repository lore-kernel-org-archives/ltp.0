Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 311A6C43327
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 00:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782779414; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cxUSneijUIEql9TxYxxLszt4YLMD1krHGXGoL42Zjyc=;
 b=KfAGjhszLdQRuts1vd5fmn6E1YpBO7ylW6FuslTTjIMEN9uVk8+lhr+3VW5/Sxmmgr18F
 /Mcpf9NgWK7h+EmwxhxXG/qI7XoBZxJ8Qp8XSrFbxA7ewl7XlVleg/8H0U4bNwLXjUZ3sAi
 QtOVuiqbViJmhB/ssNyRoEPFu+pNOoY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C4933E52A5
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 02:30:14 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B67223E4EC3
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 02:29:53 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8FA031A00904
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 02:29:52 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4938d5f86f3so377265e9.1
 for <ltp@lists.linux.it>; Mon, 29 Jun 2026 17:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782779392; x=1783384192; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z+I1kOohjrIOdC138xUwgCk5Xuy0wdp7c546cTlJwSk=;
 b=CDLvJ9Zmlrrg0ao/zHBs1C2f4nBa+RqtGHejIzLpurmF4fDmVaexrcpyfRO25UUj51
 UhxEH8KHoPPcO6NpBQlhVwIOnDnJQH2DHRFtYzAVIjFxKfsYvEK0E8swhf33Ue1IH0bH
 tjV5ZMenClzRagBnMS7emRjHYmKHNlQ/NfkKhA6a7itVotg9e9K3GvvewAEUjnncYt6T
 ///yeofO+9IN/W2zSCdYWF1RiHtKrn5iTtFlL+i+/6kdOnyBZrK6ZokaXcbQAt4Otc7X
 k5U7ZcH//Wt9e85U4X9c+kMb7fRUE7PM9BjBSPSUXw7+e9pps+dB8cksa8cSsRDyXvdk
 iD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782779392; x=1783384192;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+I1kOohjrIOdC138xUwgCk5Xuy0wdp7c546cTlJwSk=;
 b=ryl3ai1vUHx+pmvYKt2I9OuTNLkiEz1w/nGkt/ZNtHVGlnwTZRwp+6a4TBFbEXElO2
 l8Qp7L8PnLU3ugsphh1QWN/FBPkckNSHHGtR4SeJaYO42jEX0O8pFgylFjf3CXuyt85A
 Qba70oUJTvHxh+9Wl77qaMx8U3KiWKBHVqdJ21bKp7gfOs7XvkGMLurr5mtHvVxJwLmA
 GeeNo1hUTrO8cPBnf9/MRmuFKA1TJuwhuIKZod1UDrm3gE9eu8mr032tt4MksdqTuPtb
 ff2kKJLunENySo1c4ti288yxU3Sv54+/yoiLQcEDq5eeZ3hkEXxFFKwX6k8YM+vrK5pi
 SbVg==
X-Gm-Message-State: AOJu0YxhGFc9EQhrux3s/lenMJRHl1r15f1I0HrckpYqXnGnsfOXMZAK
 H9+du0c2+pU9rB3pvfo6/790j1PPbzUMFsa2iI62tzgkN8nOefP0e+OaV5HSAgllkXU3HU7bExO
 lB8g=
X-Gm-Gg: AfdE7cnBY+m2LutHQw+69HjnfdpzDvOaqbhx8TBVUPPH7/AQL/30SCHrZtpIUPtxJZK
 CqHLsV5j+6rubJZKIKkE305Euo2SO3b6RrcfNcg4QAegFwKAUPV8EsxW0EHgCxnqaK8G+DimTVk
 VfX6+7wGh7HYdTHoDd1FvIQqqOPZwbajAJKJJNghzJaAedZC1HFlgukIEGgK8/P+sLWvT8Fps1A
 iUW8z1brMc4LHP2zB95ga1PGKzngEg9LGlF1TDotEd/5CU6EJPErMW0IZM4zyWRxmCbExgYRnE0
 y84rpoltGDViG6VsjwypxlSMa7FhpEvwV3vNwx7Ed83F1j4e2WYLRbIdPEGM51dhCeCXCYfVTYd
 5JpPAQIhXLnXClUxuTh0Q5l11l7hExCDDR6i5JX6Wuq9Np8SjpuTxX0H9s4AOGWjLOu/MQnASfV
 E1hIINd1xKgepmuP/ZOuVbHtt0SgPOig==
X-Received: by 2002:a05:600c:8519:b0:493:a43d:6a2e with SMTP id
 5b1f17b1804b1-493b8cd7cd4mr14133045e9.8.1782779391945; 
 Mon, 29 Jun 2026 17:29:51 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493b8d0afacsm30292565e9.12.2026.06.29.17.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 17:29:51 -0700 (PDT)
Date: Tue, 30 Jun 2026 00:29:50 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <akMN_kOtke47w0-v@autotest-wegao.qe.prg2.suse.org>
References: <20260629-invalid_syscalls-v1-1-6276034a35c5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260629-invalid_syscalls-v1-1-6276034a35c5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall02: add invalid syscall number test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 29, 2026 at 04:03:09PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Add a test verifying that syscall() returns ENOSYS when called with
> unimplemented syscall numbers. The chosen numbers stay above the syscall
> table and below the architecture-specific private ranges, so they are
> reliably invalid on every supported architecture.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/syscall/.gitignore  |  1 +
>  testcases/kernel/syscalls/syscall/syscall02.c | 47 +++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a021c79da49d4157c33187caed2dd3f0483759e0..8a777e61da1af59ba694e0bc5b5d92bb1d63754a 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1678,6 +1678,7 @@ sync_file_range01 sync_file_range01
>  sync_file_range02 sync_file_range02
>  
>  syscall01 syscall01
> +syscall02 syscall02
>  
>  sysconf01 sysconf01
>  
> diff --git a/testcases/kernel/syscalls/syscall/.gitignore b/testcases/kernel/syscalls/syscall/.gitignore
> index 74a081e40cb564e874e0f81478d3d1a0e95b6df4..fed1d81079450a7442023447285cd112924f7a10 100644
> --- a/testcases/kernel/syscalls/syscall/.gitignore
> +++ b/testcases/kernel/syscalls/syscall/.gitignore
> @@ -1 +1,2 @@
>  /syscall01
> +/syscall02
> diff --git a/testcases/kernel/syscalls/syscall/syscall02.c b/testcases/kernel/syscalls/syscall/syscall02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..3bd9fa8cdcca257e03b358749ee7a2b676d8720d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/syscall/syscall02.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Verify that :manpage:`syscall(2)` fails with ENOSYS when invoked with
> + * invalid syscall numbers.
> + *
> + * The syscall number is dispatched as an unsigned value on Linux. A value is
> + * reliably unimplemented on every supported architecture when it is:
> + *
> + * - above the syscall table
> + * - below the architecture-specific private syscall ranges (e.g. ARM's
> + *   0x0f0000 base)
> + * - without the x32 ABI bit (0x40000000) set
> + *
> + * Such a number is routed to sys_ni_syscall and returns ENOSYS.
> + */
> +
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +
> +#include "tst_test.h"
> +
> +#define TC(x) {.scno = (long)(x), .desc = #x}
> +
> +static struct tcase {
> +	long scno;
> +	const char *desc;
> +} tcases[] = {
> +	TC(0x8000),
> +	TC(0xf000),
> +	TC(0xfffe),
> +};

I suggest add two more cases check:
1) -1
2) __NR_syscalls +1 (Base arch/powerpc/kernel/syscall.c)

> +
> +static void verify_syscall(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +
> +	TST_EXP_FAIL2(syscall(tc->scno), ENOSYS, "syscall(%s)", tc->desc);
> +}
> +
> +static struct tst_test test = {
> +	.test = verify_syscall,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> 
> ---
> base-commit: ad68429b9cfd55b233733e45e600ffafa1458ac5
> change-id: 20260629-invalid_syscalls-0476c52d7d0c
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
