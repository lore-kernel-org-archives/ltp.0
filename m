Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87254C77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 13:28:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8DE3CBEC9
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 15:28:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CF893CBEAA
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:28:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C64B81400C67
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 15:28:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BA47B219E7;
 Fri, 21 Apr 2023 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682083690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrG0QKau6gMPUcVhbKurzs14olRNY7rFhNPCNM1ReZo=;
 b=CYWMpkH7PSZUPLihOuT9TAf5kfHTcueK+viekvoTCCFddtBEJ2U/7ZlN9WDJRLU0wyK82d
 5qpOh7areV6wOsaHyfXxLg9CI3ntifzhDFysW7WnrE2GWKAEhnnhGgMrlMSN9CWz7pEesj
 2RElGGE0hl0wQyY8iy68Qy7HYWY4WzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682083690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrG0QKau6gMPUcVhbKurzs14olRNY7rFhNPCNM1ReZo=;
 b=LFf99CEyYKIYqxqhTNvc+9A5T9vwLAYcttbYvOfcjqpzFXfnpDxPwtrRk9mrQzMYQvluyy
 K3ODzTrhFvawLkDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6D0313456;
 Fri, 21 Apr 2023 13:28:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pNVwJ2qPQmQiWQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Apr 2023 13:28:10 +0000
Date: Fri, 21 Apr 2023 15:29:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZEKPq8eFUAuXOGD0@yuki>
References: <20230226003526.8733-1-wegao@suse.com>
 <20230421123855.13427-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230421123855.13427-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] clone3: Add clone3's clone_args cgroup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone303.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test case check clone3 CLONE_INTO_CGROUP flag
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/wait.h>
> +
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +#include "lapi/pidfd.h"
> +
> +#define BUF_LEN 20
> +#define CLONE_INTO_CGROUP 0x200000000ULL

This should be added as a fallback definition into lapi/sched.h

> +static struct tst_cg_group *cg_child_test_simple;
> +static struct clone_args *args;
> +
> +static pid_t clone_into_cgroup(int cgroup_fd)
> +{
> +	pid_t pid;
> +
> +	args->flags = CLONE_INTO_CGROUP;
> +	args->exit_signal = SIGCHLD;
> +	args->cgroup = cgroup_fd;
> +
> +	pid = clone3(args, sizeof(*args));
> +
> +	if (pid < 0)
> +		tst_res(TFAIL | TTERRNO, "clone3() failed !");
> +
> +	return pid;
> +}
> +
> +static void run(void)
> +{
> +	char path[100];
> +	int fd;
> +	pid_t pid;
> +
> +	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
> +	sprintf(path, "/sys/fs/cgroup/ltp/%s/%s", tst_cg_group_name(tst_cg), tst_cg_group_name(cg_child_test_simple));

There is no guarantee that the cgroup is mounted in this hardcoded path
and that the top level directory for LTP tests is called ltp.

Moreover we already do have a file descriptor pointing to the directory
for cgroup v2 opened in the cgroup library. All we need is a function in
the library that would find the take the tst_cg_group and find the right
cgroup_dir in the dirs[] array.

> +	tst_res(TINFO, "cgroup path is %s", path);
> +	fd = SAFE_OPEN(path, O_DIRECTORY | O_CLOEXEC | O_NOFOLLOW | O_PATH);
> +
> +	pid = clone_into_cgroup(fd);
> +
> +	if (!pid) {
> +		TST_CHECKPOINT_WAIT(0);

Just add reutrn; here and drop the else below.

> +	} else {
> +
> +		char buf[BUF_LEN];
> +
> +		SAFE_CG_READ(cg_child_test_simple, "cgroup.procs", buf, BUF_LEN);
                                                                          ^
									  sizeof(buf);
> +
> +		int x = atoi(buf);
> +
> +		if (x == pid)
> +			tst_res(TPASS, "clone3 case pass!");
> +		else
> +			tst_brk(TFAIL | TTERRNO, "clone3() failed !");
> +
> +		TST_CHECKPOINT_WAKE(0);
> +
> +		SAFE_WAITPID(pid, NULL, 0);
> +
> +		cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.max_runtime = 20,
> +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_checkpoints = 1,
> +	.min_kver = "5.7",
> +	.bufs = (struct tst_buffers []) {
> +		{&args, .size = sizeof(*args)},
> +		{},
> +	}
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
