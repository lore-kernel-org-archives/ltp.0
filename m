Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD20C64ED6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 10:17:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 18D3F3CCE34
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 11:17:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B2D53CBA10
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 11:16:55 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 621D910005E3
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 11:16:54 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9B5141FDC1;
 Tue, 28 Feb 2023 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677579413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWTw47escqF1YwJ9bNbBTmUbmoCliVCHNgr7viMBPSc=;
 b=EFIvH8NGzGPw/flVyo+a2iH6GxkQ4P4Xan+q9e9oHarDnOxBy/aQVn/nq7kOzggd9Ad6gm
 sfEpMCAsSm2oQ6hJjoLhwmwGhLxFaqwl7kxzyGn65hS+3FXpDpTWD7xQXcSfzzulmYxPWM
 Pq6h14FPZS5bOP6QiB18hpDDtif6uUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677579413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LWTw47escqF1YwJ9bNbBTmUbmoCliVCHNgr7viMBPSc=;
 b=MTQXUQEU/TjFFzTvftHHoDNSfzOpjLmTicj/bt6DClmUlVrd3wkCUjVma9WispQKBHldQG
 Ai4nACVjuNCFsMBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6CBBF2C141;
 Tue, 28 Feb 2023 10:16:53 +0000 (UTC)
References: <20230215055727.20793-1-xiaoshoukui@gmail.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: xiaoshoukui <xiaoshoukui@gmail.com>
Date: Tue, 28 Feb 2023 10:06:54 +0000
Organization: Linux Private Site
In-reply-to: <20230215055727.20793-1-xiaoshoukui@gmail.com>
Message-ID: <875ybmumb0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add ioctl_loop08 test for LOOP_GET_STATUS lock
 imbalance
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

xiaoshoukui <xiaoshoukui@gmail.com> writes:

> ---
>  .../kernel/syscalls/ioctl/ioctl_loop08.c      | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/ioctl/ioctl_loop08.c
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop08.c b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
> new file mode 100644
> index 000000000..047273576
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop08.c
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 xiaoshoukui <xiaoshoukui@ruijie.com.cn>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This is a basic ioctl test about loopdevice LOOP_GET_STATUS
> + * and LOOP_GET_STATUS64.
> + * Commit 2d1d4c1e591f made loop_get_status() drop lo_ctx_mutex before
> + * returning, but the loop_get_status_old(), loop_get_status64(), and
> + * loop_get_status_compat() wrappers don't call loop_get_status() if the
> + * passed argument is NULL. The callers expect that the lock is dropped, so
> + * make sure we drop it in that case, too.
> + *
> + * Fixed by commit:
> + *
> + *  commit bdac616db9bbadb90b7d6a406144571015e138f7
> + *  Author: Omar Sandoval <osandov@fb.com>
> + *  Date:   Fri Apr 06 09:57:03 2018 -0700
> + *
> + *    loop: fix LOOP_GET_STATUS lock imbalance
> + */
> +
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <stdlib.h>
> +#include "lapi/loop.h"
> +#include "tst_test.h"
> +
> +#define MAX_MSGSIZE 4096
> +
> +static const char lock_imbalance[] = "lock held when returning to user space";
> +
> +static struct tcase {
> +	int ioctl_flag;
> +	char *message;
> +} tcases[] = {
> +	{ LOOP_GET_STATUS,
> +	 "Testing LOOP_GET_STATUS lock imbalance" },
> +
> +	{ LOOP_GET_STATUS64,
> +	 "Testing LOOP_GET_STATUS64 lock imbalance" },
> +};
> +
> +static int find_kmsg(const char *text_to_find)
> +{
> +	int f, msg_found = 0;
> +	char msg[MAX_MSGSIZE + 1];
> +
> +	f = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
> +
> +	while (1) {
> +		TEST(read(f, msg, MAX_MSGSIZE));
> +		if (TST_RET < 0) {
> +			if (TST_ERR == EAGAIN)
> +				/* there are no more messages */
> +				break;
> +			else if (TST_ERR == EPIPE)
> +				/* current message was overwritten */
> +				continue;
> +			else
> +				tst_brk(TBROK | TTERRNO,
> +					"err reading /dev/kmsg");
> +		} else {
> +			/* lines from kmsg are not NULL terminated */
> +			msg[TST_RET] = '\0';
> +			if (strstr(msg, text_to_find) != NULL) {
> +				msg_found = 1;
> +				break;
> +			}
> +		}
> +	}
> +	SAFE_CLOSE(f);
> +
> +	if (msg_found)
> +		return 0;
> +	else
> +		return -1;
> +}
> +
> +static void do_child(void)
> +{
> +	char dev_path[1024];
> +	int dev_num, dev_fd;
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++) {
> +		tst_res(TINFO, "%s", tcases[i].message);
> +		dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
> +
> +		if (dev_num < 0)
> +			tst_brk(TBROK, "Failed to find free loop device");
> +
> +		dev_fd = SAFE_OPEN(dev_path, O_RDWR);
> +
> +		if (tcases[i].ioctl_flag == LOOP_GET_STATUS)
> +			ioctl(dev_fd, LOOP_GET_STATUS, NULL);
> +		else
> +			ioctl(dev_fd, LOOP_GET_STATUS64, NULL);
> +
> +		if (dev_fd > 0)
> +			SAFE_CLOSE(dev_fd);
> +
> +	}
> +
> +	exit(0);
> +
> +}
> +
> +static void verify_ioctl_loop(void)
> +{
> +	int ret, pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		do_child();
> +
> +	ret = TST_PROCESS_STATE_WAIT(pid, 'D', 5000);
> +
> +	if (!ret && !find_kmsg(lock_imbalance))
> +		tst_res(TFAIL, "Trigger ioctl loop lock imbalance");
> +	else
> +		tst_res(TPASS, "Nothing bad happened, probably");
> +
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_ioctl_loop,
> +	.needs_root = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_LOCKDEP=y",

We don't want to rely on a debugging feature unless necessary. Often
testing is done on production kernels.

If the test is run on a buggy kernel without lockdep then might we get a
deadlock?

So I think it would be best to run the test, but skip the kmsg check if
lockdep is not enabled (using tst_kconfig_get).

> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "bdac616db9bb "},
> +		{}
> +	},
> +	.needs_drivers = (const char *const[]) {
> +		"loop",
> +		NULL
> +	},
> +	.forks_child = 1,
> +	.timeout = 60,
> +};
> -- 
> 2.20.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
