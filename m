Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C344FC021AA
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739977951; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=rYYQAr3B6Y5ZJstbelIyJl0YnUEBR6eWkDQdfjwlBcI=;
 b=a/FttJvJI6cWBzsYr9sQne8mTp0E8btWD+G6qX0kZuz4sA7jSfcl3TxIRl6q9/AH/HJT8
 Hfq4ngmtKQFqNpFkWGiMPpSpDsgtwkSXfhYCaHHKJuGtzbsnr2wkwd/DYz8LzaP60k5dxd9
 3AnFXIBsnx/TL45bUc5zJvd8hbTpOXM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C40F23C30BC
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 16:12:31 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 567D93C0722
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 16:12:10 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 62E06611192
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 16:12:09 +0100 (CET)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5e0813bd105so2982738a12.1
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 07:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739977929; x=1740582729; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sBL6wzSYj+eEyU05vNNf3FkRBja1d3Lf/UjJSbLl+Wg=;
 b=JSTfj8cmFfADlDsXLoi+KXZDRO53UfhweH5N1vjYZoS2osneTka6jx1kfgf25KTqOO
 4dNPPJzxDGfPqU5i4UIaXlDy2Vo9alC8/5o+Q9HXZ183BrNSuoKec6uCpVf1Z2Lzmdd5
 3wLQ0xrBtROf76MaO42xk+ojM7DqQzJkaFQt8/MUumJuuQ+vBagE+Nby697ydjA9sKgc
 gMSnNvVzdGHU9HdsYAD5vLOfHqr3lmjLgaR1WSQayZk3m7Ph0xffVGFMyCov1JryT8zM
 zrDY0WvDmSCw9rakccx36QWURHXuUOvzbFv3rJIb966A0Z53/z1oYNgJmTiNfKi9kswJ
 12yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739977929; x=1740582729;
 h=in-reply-to:from:content-language:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sBL6wzSYj+eEyU05vNNf3FkRBja1d3Lf/UjJSbLl+Wg=;
 b=EDwSazhw2cZ4OeCckmZ9mdk2o1nWj5lZ8zWwSPKxzWyyBztHzFRL+27LJMi/ibVybS
 H6us+9LYb7faYhlaR6g4DHhlmFYyjaqekurtwZS5gjVcWpk+jOqj5rWdzmlYmfrrbn9f
 mk58wiH1jDB87BV6bf8wVxE+FkjzTNiv2qxxr7JA04BIztreX7wNTnXn0AVuf9vKxa5u
 tzHxg/DmU4skGzt+9h1R5QV2Sywei6mUM+GeOFrtPKNIgsREJvva+7qVPzRR3ZZ4YmNq
 6LT//aL1a9XJszotNNNSEO7Vajg4EehRFy5xoEG/9epZl8DXBEAZ3/cUS/XexvSz4uik
 HjeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnb6ekzyrVPTNHnWJox19BDyQPO1wgiiQ4zqjo+udpkf/3V+JKCB7zE0pZTd3SFiXAhYs=@lists.linux.it
X-Gm-Message-State: AOJu0YyvVdIQgezi0AVdN6rUlvpV7RI4mpM7cDP4Ohw8hUSvygg5b0Wj
 BbyinH4nCvlaqk6YR+rQDljgcTVT8w/5GoFmY3c3dH74+se+vNgPN2n2DtH2WLo=
X-Gm-Gg: ASbGncsdQSoEV6PSQbjXxbqOPM2F588x+HuICNvotoX/gK8ztag8H76fqVCjdecOBO1
 PpiMgsV69r1cYjP4HC9I9ziLnllqvPF310wTAbW/QglBS/WWu6b9aIziMqyt+6N0UESuwgAKDLB
 pEY7510/IUt8My7aiyzZbFK1UIuyB8l1F47lWRqJw77wKhwBB1+ohrpg2qvwBjY7876fD1m5h7Z
 MZSIR9Pew2CIf5AEFX8cBEFixw5mCzzJ1P140INzRFvsAs8wnRqBHg4KUcC0QdhNcV0X3W5mID+
 A22orAogz4xZdE2Eyb8A5QPUpNWVuH0xIw1DAzGJ0bVuwF+eT5umwI9tHdDku6wDTV4uy9vq4af
 tkURR+9GjGPaZurRlBxo9R+hVcCX6kR+ZOcbEM1hDh3VaEqSg6Pc=
X-Google-Smtp-Source: AGHT+IHgLYjViASHgVhLfDLv7jXBJzHReRl1kSGI+GKGFb3XJwU4oHEnZiCRj0qhg1SFMl98rAIfTg==
X-Received: by 2002:a05:6402:26ca:b0:5db:731d:4456 with SMTP id
 4fb4d7f45d1cf-5e0361f2985mr20616188a12.28.1739977928475; 
 Wed, 19 Feb 2025 07:12:08 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece288e2dsm10623763a12.80.2025.02.19.07.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Feb 2025 07:12:07 -0800 (PST)
Message-ID: <a0fe27a5-69eb-4974-af58-ad18805f6bcb@suse.com>
Date: Wed, 19 Feb 2025 16:12:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20241219081951.8340-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20241219081951.8340-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] unshare03.c: Add test coverage for dup_fd()
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

Hi!

On 12/19/24 09:19, Wei Gao via ltp wrote:
> Signed-off-by: Wei Gao<wegao@suse.com>
Missing an explanation of the commit.
> ---
>   runtest/syscalls                              |  1 +
>   testcases/kernel/syscalls/unshare/.gitignore  |  1 +
>   testcases/kernel/syscalls/unshare/unshare03.c | 91 +++++++++++++++++++
>   3 files changed, 93 insertions(+)
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
> index 000000000..0ff40b242
> --- /dev/null
> +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Al Viro<viro@zeniv.linux.org.uk>
> + * Copyright (C) 2024 Wei Gao<wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
No needed anymore.
> + *
> + * Test case is adapted from the kernel self test unshare_test.c.
> + * Test coverage for dup_fd() failure handling in unshare_fd()
The test is verifying whether unshare() raises EMFILE error when we 
attempt to release the file descriptor table shared with the parent 
process, after opening a new file descriptor in the parent and modifying 
the maximum number of file descriptors in the child.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <sys/wait.h>
> +#include <sys/types.h>
> +#include <sys/param.h>
> +#include <sys/syscall.h>
> +#include <sched.h>
> +#include <limits.h>
> +#include <unistd.h>
All these imports are not needed.
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
> +	pid_t pid;
> +	struct clone_args args = {
> +		.flags = CLONE_FILES,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> +
> +	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
> +
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit);

I don't get the point of this call, even in the kselftests. The limits 
are overridden in the next 2 lines..

> +
> +	rlimit.rlim_cur = nr_open + 1024;
> +	rlimit.rlim_max = nr_open + 1024;
> +
> +	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
> +
> +	SAFE_DUP2(2, nr_open + 64);
We have the control over file descriptors in this process, so I don't 
see why adding such a big number of file descriptors, but I guess 
nothing happens if we are adding high numbers. Maybe 
rlimit.rlim_cur/rlim_max + 16 would be enough. And then here we can use 
nr_open + 8 ...
> +
> +	pid = clone3(&args, sizeof(args));
> +
> +	if (pid < 0) {
We can use SAFE_CLONE() here
> +		tst_res(TFAIL | TTERRNO, "clone3() failed");
> +		return;
> +	}
> +
> +	if (!pid) {
> +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> +		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, NULL, 0);
No need for this, tst_reap_children() is running automatically at the 
end of run().
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +}
> +
> +static struct tst_test test = {
> +	.forks_child = 1,
> +	.needs_tmpdir = 1,
Temporary folder is not used.
> +	.needs_root = 1,
> +	.test_all = run,
> +	.setup = setup,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{FS_NR_OPEN, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +};
> +
> +#else
> +TST_TEST_TCONF("unshare is undefined.");
> +#endif
>
Kind regards,
Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
