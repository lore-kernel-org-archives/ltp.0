Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B72C3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1722851587; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=VWeoabq1FTuXV3eHYjtYeciCxTMNHPU4v0Ah7zFMcJE=;
 b=qWA75UGsICyLgoxgbMTXzY6wuq1fE8iDtXTx8FX0gU/uXrKTBQooXk8z04H0NHO7zo5kF
 SreiSm6HZt88bSaF9OL1YkQLjKs+QdqYppd2Ea0vZHHunDD4i5GqPVVfzkb8mTIxbVDdXJr
 IKwGpcC9NHa2Y2yYZQaRYHV0z8t0fT8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5F933D1FC5
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 11:53:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CCA63D1E18
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 11:52:44 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 65C481A010CF
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 11:52:44 +0200 (CEST)
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52efbb55d24so15864544e87.1
 for <ltp@lists.linux.it>; Mon, 05 Aug 2024 02:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1722851563; x=1723456363; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oD3/vIx2NzFNOfWGjhX8ujIu76w14yyLj5E0x1oWQ58=;
 b=gIxh46SKfrni55fR9XPBgGcTlsu4Je6+lkEwKS5mi6VMp/BFYj9UiD+IyYfCx4Scn/
 NR/uY+KkrvsWROGpz/4jilm1Ycf0JYmjZSge3erdlBcXJYcxZCbSqm2RI+6D4jhiWlIo
 9iKgqKEMeQfjsQOP0huJnuILqqtW/22omws4m3CXsxyEYcqXp+JrGg4vCyNQLgNZQ2G3
 SznfBWUciMbCL7qKMzCaBxMBXBGkqYn+A39VELVCH7s3y9+j5+ylM0HW6TGclvlpva00
 WPTUVkM6jnPrCBifpyt10HlIJBHqgoTdLH80Osc+d+GtWMsQw0dqyg/m0fU91ANvZxUL
 IU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722851563; x=1723456363;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oD3/vIx2NzFNOfWGjhX8ujIu76w14yyLj5E0x1oWQ58=;
 b=a2F8oBlz0S+ggEHwiKsIWDzG+s8YGNFDSG0WzZcUoZkQiUibL0u66Uh/r06hr0Vygb
 qwiMHgg+y5kQ8qImkN4aTkTxuF7jxfm3CF+RTVU7NVIMJvNj0n3Uxaq2wUt46I2Ygele
 DgMwbz6mfnDztcFYQL/EsAucNhLMo8F5U8YlreyC0pITJXmfwamhGnUBZuZfT0ZLj9sS
 SwCOr0fwRBi4bTPTpWaFoQRYgK5e84ZUtZTPKxhS6En5vk9Op0cEbIAx8yhO+Oh+td/k
 40dlfMsPYGTQLA8l1F2T4LKpUJ7/8oZ45lissHBeaz29N5p/G+AZafVr2pfZsxeJEBjV
 E09g==
X-Gm-Message-State: AOJu0YzDllqy01I7F4xekI4zQJVPwHai7HVuIw7Nt/DsVcXdomPVXPkI
 Bnn+ruV9Xf8UqPybU77QaJhjTj3lwpEbHWEiFSyUWExxXXKion/Uoj66d4oMIDf21fMKc9Pps6e
 fh0Q=
X-Google-Smtp-Source: AGHT+IECWP8hqXHNEoIFF0yN9mgcWjBGuXD+L/+BeZrk4BEOGQM+9m8Pjl13kiORN/hoGwbD1MjCYg==
X-Received: by 2002:a05:6512:b08:b0:52c:83c7:936a with SMTP id
 2adb3069b0e04-530bb3b464amr10257931e87.42.1722851562175; 
 Mon, 05 Aug 2024 02:52:42 -0700 (PDT)
Received: from [192.168.1.59] ([151.51.15.217])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4294fsm430119366b.103.2024.08.05.02.52.41
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 02:52:41 -0700 (PDT)
Message-ID: <2d414c20-ab82-41d5-8490-335dd0134755@suse.com>
Date: Mon, 5 Aug 2024 11:52:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240805092219.2659302-1-maxj.fnst@fujitsu.com>
Content-Language: en-US
In-Reply-To: <20240805092219.2659302-1-maxj.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getcpu: Add testcase for EFAULT
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

Hi!

On 8/5/24 11:22, Ma Xinjian via ltp wrote:
> Add a testcase with the arguments point to an invalid address.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> ---
>   runtest/syscalls                            |  1 +
>   testcases/kernel/syscalls/getcpu/getcpu02.c | 97 +++++++++++++++++++++
>   2 files changed, 98 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b8728c1c5..1537b5022 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -448,6 +448,7 @@ futimesat01 futimesat01
>   getcontext01 getcontext01
>   
>   getcpu01 getcpu01
> +getcpu02 getcpu02
>   
>   getcwd01 getcwd01
>   getcwd02 getcwd02
> diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
> new file mode 100644
> index 000000000..f32660ef9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> + * Copyright (c) Linux Test Project, 2024
> + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
> + *
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that getcpu(2) fails with
> + *
> + * - EFAULT arguments point outside the calling process's address
> + *          space.
We can squeeze the description in one single line since EFAULT is the 
only one we are gonna test.
> + */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <sys/resource.h>
> +#include <sys/time.h>
> +#include <sys/wait.h>
> +#include <stdlib.h>
tst_test.h is importing these already.
> +
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +
> +static void *bad_addr;
> +
> +static void setup(void)
> +{
> +	bad_addr = tst_get_bad_addr(NULL);
> +}
> +
> +static void check_bad_cpu_id(void *bad_addr, unsigned int *node_id)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		TST_EXP_FAIL(getcpu(bad_addr, node_id), EFAULT);
> +
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "getcpu() caused SIGSEGV");
> +		return;
> +	}
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> +		return;
> +
> +	tst_res(TFAIL, "child %s", tst_strstatus(status));
> +}
> +
> +static void check_bad_node_id(unsigned int *cpu_id, void *bad_addr)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		TST_EXP_FAIL(getcpu(cpu_id, bad_addr), EFAULT);
> +
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> +		tst_res(TPASS, "getcpu() caused SIGSEGV");
> +		return;
> +	}
> +
> +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> +		return;
> +
> +	tst_res(TFAIL, "child %s", tst_strstatus(status));
> +}
> +
> +static void run_test(void)
> +{
> +	unsigned int cpu_id, node_id = 0;
> +
> +	check_bad_cpu_id(bad_addr, &node_id);
> +	check_bad_node_id(&cpu_id, bad_addr);
Here we can use .test/.tcnt , defining 2 testcases with different 
getcpu() input values.
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run_test,
> +	.forks_child = 1,
> +};

Best regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
