Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF68EC021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 08:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741077088; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=qEoXTTQeNZe9hp/3rnf2pbwVw4HtOoH1OQ7VYco2IMQ=;
 b=p4EnvmrHkh88fJSz/2QQpSfsh3kBfrooWndPaQizz/9uaq/fGUx58yFEoVP/Klc9faUbm
 yAMUwIG2gHDyWqeiVN/LpMCfYxg1taR6/k/ockKsLBQlRUpJfk+R8q7vShSa9l1E9WFreM6
 mwwYLsr+NZdamsCJ3h3Jt8mdG/tTyTk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC3023C9D2C
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 09:31:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD9A73C845A
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 09:31:06 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 593B16017C4
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 09:31:05 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bcc02ca41so3426895e9.0
 for <ltp@lists.linux.it>; Tue, 04 Mar 2025 00:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741077065; x=1741681865; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=flQq801mx/mxLIV7r4gOb4jQHUYfodErvaUEPuyxth8=;
 b=hFHk0xB1zg83MOj6UhjgErZEwwZj566tR7E99hldv+hCRBIAyaeBYuOaOLb2RxB8by
 8i6Hjjc6IpC9hiwKOvu79jFlwsDD06Rn7XpifBml0hNqYIZvBq7/RmMv57mx5xeN57Yb
 5YIhQ7XeRPPBsI0zGKMV2EIVA8Tn+igJIUyZdRcUDZg6okYsjIRpmL5awVZqFZtS4AuQ
 31cUm+6xA7b8GB1qqHXokOBPN6kOEaZOtQf5h1xZNdTc4f9GK2iHH9aHsZ26HBimrCZb
 ueGE3zKWYKp1weN+OXVCMa2F+cM3cYT8RREbqMTGvln11o4d/lKu0CaYKGhPuNH52Njl
 vs7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741077065; x=1741681865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flQq801mx/mxLIV7r4gOb4jQHUYfodErvaUEPuyxth8=;
 b=JE9owkm0JiHxQy3ai5e2+ifBJd1u6gVQwk6ya9jxehff0Slsv9vYUi1P9b5G7op7GG
 iJ61vfXIPOwJiN9NZlqC8vxDY9BfJ5yZ8Onwg0ywP66eAT5VgnujPa4C0tDy+qzP/xul
 0Um136Z1Hh7ODq+UrkAkS9knnovTd5AzcZ7/EMXG0uPXhTt52PT8Tf2f9/Pq826XTZdG
 rZ3Osb3LnLfMemNBF9DwofwHg3Vy4pp0RFR3wrWSlhOZNpEF9HPHmABZr1CKZzXU+TqV
 9D9zHxvZZaHChfxSyafaGWyvBD4aMwAzgIa0AjAmcPlA2zTNxOQNDyFTVh6p4tyCU54Q
 KViw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkOkiKhs/FoTch109HvuoArvmUgDcYSbtrCzn5Yx1ZTumr2VlpA6Ss6f+n3KXvFtR3L4c=@lists.linux.it
X-Gm-Message-State: AOJu0YxJKhTtfAERBcuPW4cOv6qj6kpD8Z0NPFvzdq3A+BLrtQ5SzKHW
 Ofg2A4mjI+yyUWqj3Rdru6+WnmBMZcx2XleAZJ/+nldOzCblQ+L+aPeFQUHmGg7FaEOn0rItwSo
 Ha8k=
X-Gm-Gg: ASbGnctBHBD5VbhrhrotsZVRq01U2RLLnNxYjveE66iBOgBz5hgARyc8Bc/F/snlecS
 rAgXmC7i2N3IEbhgAcz5ImzPvSSqAAnR29ojd3IT6rt7MMAdov+Ekd3JbxDruChBuKtNHFn9z6q
 sD60S6RE3dPk3OOuiULxerNPUrLnHDt9bcYz4MFNSszmkjPRYHiVHpBr5mrXAvUuJON5TVlYlr4
 LhFxQ0ubY3RHLYMi0ST34fHgt+H7NDnyChgbxr2Kb1vKbSWvw5XXOXyxp7wB4M3x1oydDKgjJzb
 IdiZ8FttMb5WoUowzZfxK0FXSuLxnUq27zUe/TrevF2PuwGf3fttDXAKR5MfWeRdyfTZAMVMorT
 yU2AUiOkhhXtOVCNFGQmZvA3njr5Sj+BUtMETgUN0uGtXhjhSH6MVIO34omnEC6Etuh/6UO8lTk
 IS9Iz1
X-Google-Smtp-Source: AGHT+IFx5NXb9M8/D5hYl5Uheh0KFdL/zhRJE16pEBVpAB6pFQAgfsjNYm1lxl9GzX3grTG1fiQbFg==
X-Received: by 2002:a05:600c:a03:b0:439:967b:46fc with SMTP id
 5b1f17b1804b1-43ba67036bfmr138931035e9.8.1741077064595; 
 Tue, 04 Mar 2025 00:31:04 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba5393e5sm215718665e9.20.2025.03.04.00.31.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 00:31:04 -0800 (PST)
Message-ID: <361f2b39-3deb-462d-90fe-4f2ee2de9b60@suse.com>
Date: Tue, 4 Mar 2025 09:31:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250304034348.23389-1-wegao@suse.com>
 <20250304040601.23920-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250304040601.23920-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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

thanks for editing the last version. A couple of comments below.

On 3/4/25 05:06, Wei Gao via ltp wrote:
> Add a test case based on kernel self-test unshare_test.c to check that
> the kernel handles the EMFILE error when a parent process changes file
> descriptor limits and the child process tries to unshare (CLONE_FILES).
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   runtest/syscalls                              |  1 +
>   testcases/kernel/syscalls/unshare/.gitignore  |  1 +
>   testcases/kernel/syscalls/unshare/unshare03.c | 77 +++++++++++++++++++
>   3 files changed, 79 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/unshare/unshare03.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index ded035ee8..10800c1a3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1715,6 +1715,7 @@ unlinkat01 unlinkat01
>   
>   unshare01 unshare01
>   unshare02 unshare02
> +unshare03 unshare03
>   
>   #
>   # These tests require an unmounted block device
> diff --git a/testcases/kernel/syscalls/unshare/.gitignore b/testcases/kernel/syscalls/unshare/.gitignore
> index 855ffd055..e5b5c261d 100644
> --- a/testcases/kernel/syscalls/unshare/.gitignore
> +++ b/testcases/kernel/syscalls/unshare/.gitignore
> @@ -1,2 +1,3 @@
>   /unshare01
>   /unshare02
> +/unshare03
> diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
> new file mode 100644
> index 000000000..c1f13bcd5
> --- /dev/null
> +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Al Viro <viro@zeniv.linux.org.uk>
> + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * This test case based on kernel self-test unshare_test.c to check that
> + * the kernel handles the EMFILE error when a parent process changes file
> + * descriptor limits and the child process tries to unshare (CLONE_FILES).
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "config.h"
> +#include "lapi/sched.h"
> +
> +#define FS_NR_OPEN "/proc/sys/fs/nr_open"
> +
> +#ifdef HAVE_UNSHARE
> +
> +static void run(void)
> +{
> +	int nr_open;
> +	struct rlimit rlimit;
> +	struct tst_clone_args args = {
> +		.flags = CLONE_FILES,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> +	tst_res(TDEBUG, "Maximum number of file descriptors: %d", nr_open);
> +
> +	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
> +
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);
> +
> +	rlimit.rlim_cur = nr_open + 1024;
> +	rlimit.rlim_max = nr_open + 1024;
> +
> +	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
> +	tst_res(TDEBUG, "Set new maximum number of file descriptors to : %d",
> +		nr_open + 1024);
> +
> +	SAFE_DUP2(2, nr_open + 64);
> +
> +	if (!SAFE_CLONE(&args)) {
> +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> +		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> +		TST_CHECKPOINT_WAKE(0);
There's no need to use synchronization mechanisms because at the end of 
the test we call tst_reap_children() waiting for all the children to be 
completed.
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_root = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_checkpoints = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{FS_NR_OPEN, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +};
> +
> +#else
> +TST_TEST_TCONF("unshare syscall is undefined.");
> +#endif

The rest looks good. If you want I can edit the checkpoint thing and 
merge this patch.

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
