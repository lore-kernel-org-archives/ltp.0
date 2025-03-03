Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF1C282C5
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740998879; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=oWU3NcfbwBZjJI/lew3s+dvRFOq3AVfZgsDIlEX5MM0=;
 b=TeP8oE+YrT+HaIKcHYMH6UVbhvmgN+EAa9CfiCsWnQkMIODe6dMz/uUYIG21U+h0WPRjA
 vq9c/OzSYbD5EbvdQ+QUc897sL9d7A+K3gxCfOfhmGvv6yZG6sQWi+cGzz8WFDgJ0hj6eMP
 5qrYWrkoQHTWeAxvqoORSns853SXPdY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FB843C850E
	for <ltp@archiver.kernel.org>; Mon,  3 Mar 2025 11:47:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 37B813C7875
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 11:47:38 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4E68A142762D
 for <ltp@lists.linux.it>; Mon,  3 Mar 2025 11:47:36 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-390e3b3d432so2896316f8f.2
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 02:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740998855; x=1741603655; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e6+nDJEWwgRJmkKO0er9DUtXi4iO6JGJFoa7pVBmTRI=;
 b=F6dQN+OSdCARowXxmfBq58vEptEG4rGdkSeW57OjQau41INCqlecD1prjL79Zjq24M
 xY8rU1kwqF81v3gcRyMloobNeHbIKDGkoj0vHBfVjK0Of9+UWKn6S2Od7OuhDDxlxMEI
 JxS0l929OkLvszjzVNZoh90xAd7u9cSyvKHYVENWX56Om3jY1zWL8zWeP2DDhWnB1kz7
 JQD7gva4AoWt6erB+TNRlOSzwJjAYiuI8AuOzNrY2PY17p8XM7+tqLoAp8o30Wxt8+CW
 QwqvcC8JCmXQXFF2T4U43TU784A779JOG7XYXGtLFsGnJnbj6rXIY+0tRyYBiOczvghO
 XU9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998855; x=1741603655;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e6+nDJEWwgRJmkKO0er9DUtXi4iO6JGJFoa7pVBmTRI=;
 b=l9HGXG4PseuNgjkcPBuU4ucNPtRxYCYagSH4J2I9GPdhb+gY8xRCZscVsf8JRatCR2
 CRc+MtheOxKUrWTvLB0yBah5EGXgZwF6h8AaPIq1FSm/0CIKTRmo1xyMjjSH9kTacY/p
 XpRuca9ml1VEE7ShZFSJ/cRKbSUCrgYkynaJw7zl0o0ZQPgBW2k/lHfh3ERxG1Xu7OiR
 RrfYHf6ET92elxz+8BqLBQXbU/GNDJH6ymaf+Fo8qws89R2W2s2hYDxuTtpw016Sp9z2
 1OlS/VXDGm/rQhckYUZl997137TWExDKpXqzFkQytt3jVpQ9QTMQn3T9EenYWjiejgFP
 8/Kg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkFk/dg3sYFDpAey3MItUgZdhmtnyEbFNsF/Br0Sv3XKTP7H3keIJakwsU4AH18JGmX+4=@lists.linux.it
X-Gm-Message-State: AOJu0YwCihrtVx6pGeR9dUfrcHk8o29ndWn5Gws6OGlvrV5YSQlg7Zpx
 0ya8MhXUaYiYkk5faUACA24iH+YE+3rs3Fl563Kp0fcFTLG2Jj8BYINxIdwKsO0=
X-Gm-Gg: ASbGncshH27Z8On+evlZMJuV6K2ZurwwPBUSbCNDEXyuD08f8jdDRctFrVhQJxOMuYK
 XfeQvWfSmu6XaDMOnKPiViN21x03iN726LXLfvKB/MO9qVzKdouUizOn/rBHGnNolXtRv5Wk1lP
 M7n/uB5HQE8buJzTQ2gp6yDF3105a4VbNNv5rlEElyKXHTeLP6OpIEmeZe7zwGxlq6XgPB9bfJ9
 3MetBMvi9dVAHtx1LTtTdkfNootrq3D8ujyf9hYh01zzIgNxKlI/hx2AVZuPRU2RtaFic6fGBMi
 uBa8cCo1hPa8/iZNmif68MBg1Z+SqqD3zBT9ungFEPQxLUEOe/7kafI=
X-Google-Smtp-Source: AGHT+IFW3PRyxYuAq5EQVxura4oyUdhN4xxaXko7fjm+k8wHtuECZgSCbTw76K5KKTAkyvr0HOSb0g==
X-Received: by 2002:a5d:6da3:0:b0:38f:34a7:ebfb with SMTP id
 ffacd0b85a97d-390eca61f54mr11397748f8f.55.1740998855531; 
 Mon, 03 Mar 2025 02:47:35 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b6cd8sm13905541f8f.44.2025.03.03.02.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 02:47:35 -0800 (PST)
Message-ID: <5a4dc2a7-dbfd-4927-ad85-7c3e0d8a00ee@suse.com>
Date: Mon, 3 Mar 2025 11:47:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20241219081951.8340-1-wegao@suse.com>
 <20250303094243.5782-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250303094243.5782-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] unshare03.c: Add test coverage for dup_fd()
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

On 3/3/25 10:42, Wei Gao via ltp wrote:
> This is new test case adapted from the kernel self test unshare_test.c.
> It verifies that the kernel correctly handles the EMFILE error condition
> during file descriptor table unsharing, specifically when the parent
> process modifies the file descriptor limits and the child process attempts
> to unshare(CLONE_FILES).
Add a test case based on kernel self-test unshare_test.c to check that 
the kernel handles the EMFILE error when a parent process changes file 
descriptor limits and the child process tries to unshare (CLONE_FILES).

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   runtest/syscalls                              |  1 +
>   testcases/kernel/syscalls/unshare/.gitignore  |  1 +
>   testcases/kernel/syscalls/unshare/unshare03.c | 75 +++++++++++++++++++
>   3 files changed, 77 insertions(+)
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
> index 000000000..c8baecc10
> --- /dev/null
> +++ b/testcases/kernel/syscalls/unshare/unshare03.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Al Viro <viro@zeniv.linux.org.uk>
> + * Copyright (C) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * The test is verifying whether unshare() raises EMFILE error when we
> + * attempt to release the file descriptor table shared with the parent
> + * process, after opening a new file descriptor in the parent and modifying
> + * the maximum number of file descriptors in the child.
Probably we can use the commit message here :-)
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
> +	pid_t pid;
> +	struct tst_clone_args args = {
> +		.flags = CLONE_FILES,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
Here we can print the number of open file descriptors, using tst_res(), 
to help debugging.
> +
> +	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);

In the previous version I made a mistake in the review. The original 
test is using /proc/sys/fs/nr_open to set limits first, then it reads 
back them from the same file in order to have a starting limit. This is 
probably needed due to the kernel configurations. So please bring back 
the SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit); line I asked to remove. 
Sorry for that.

Also, if we are going to use new increments, we need to update the next 
increments as well according to the previous ones. So feel free to leave 
it as it was before.

I must have been distracted that day :-)

> +
> +	rlimit.rlim_cur = nr_open + 16;
> +	rlimit.rlim_max = nr_open + 16;
> +
> +	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rlimit);
Here we can print the new limits after updating it, using tst_res(), to 
help debugging.
> +
> +	SAFE_DUP2(2, nr_open + 8);
> +
> +	if (!SAFE_CLONE(&args)) {
> +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> +		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> +		TST_CHECKPOINT_WAKE(0);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +	tst_res(TPASS, "Verify EMFILE error pass");
We don't need this since we already have TST_EXP_FAIL inside the child 
process.
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
> +TST_TEST_TCONF("unshare is undefined.");
unshare syscall is undefined.
> +#endif

The rest looks ok.

Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
