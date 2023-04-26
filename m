Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E80C7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 13:46:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA7C93CBB58
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 15:46:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E73DC3CA6A7
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 15:45:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EED74140012E
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 15:45:48 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C755F1FDCF;
 Wed, 26 Apr 2023 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682516747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TK5yenh2OUW/wY+5lSVvOiCjxhJv60jQ9JAvWYjcbko=;
 b=Mb2whdJeuFtk1xlwQfxIGL7cPXxy+0n8FRajMEpi2sBt5AQdMlAUXyLkyVprK+nOB57eyb
 3qL4AB6u8p+2lYhWXl5ZFCelYsbe/NrJpT8zMK/zcUk41AW+ymrpOXdPnrrk5rwP+b6oE/
 Xw1KcRO5T/MFphH4G1NTWtQEIjO0RfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682516747;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TK5yenh2OUW/wY+5lSVvOiCjxhJv60jQ9JAvWYjcbko=;
 b=69JD1FkDlnXgTUVuvNpQbPYYESzkVY9GgQ55a4GOnsMxatuyAbl5XsK7vVO1fSEzALLTq1
 ZuuhVsxyxTfzAKAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AD889138F0;
 Wed, 26 Apr 2023 13:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3RV5KAsrSWRBSAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 13:45:47 +0000
Date: Wed, 26 Apr 2023 15:44:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZEkqoZKbORCnRlT5@rei>
References: <20230421123855.13427-1-wegao@suse.com>
 <20230422014216.26294-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230422014216.26294-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] clone3: Add clone3's clone_args cgroup
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
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index 2826ddad1..d8e621962 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -157,6 +157,9 @@ const char *
>  tst_cg_group_name(const struct tst_cg_group *const cg)
>  		      __attribute__ ((nonnull, warn_unused_result));
>  
> +int tst_cg_group_dir_fd(const struct tst_cg_group *const cg)
> +		      __attribute__ ((nonnull, warn_unused_result));
> +
>  /* Remove a descendant CGroup */
>  struct tst_cg_group *
>  tst_cg_group_rm(struct tst_cg_group *const cg)
> diff --git a/include/tst_clone.h b/include/tst_clone.h
> index 9ffdc68d1..7b278dfa7 100644
> --- a/include/tst_clone.h
> +++ b/include/tst_clone.h
> @@ -11,6 +11,7 @@
>  struct tst_clone_args {
>  	uint64_t flags;
>  	uint64_t exit_signal;
> +	uint64_t cgroup;
>  };
>  
>  /* clone3 with fallbacks to clone when possible. Be aware that it
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 50699bc63..c63d04c67 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -166,6 +166,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
>  	{ "cgroup.controllers", NULL, 0 },
>  	{ "cgroup.subtree_control", NULL, 0 },
>  	{ "cgroup.clone_children", "cgroup.clone_children", 0 },
> +	{ "cgroup.kill", NULL, 0 },
>  	{ }
>  };

This seems to be unrelated change.

> @@ -1093,6 +1094,11 @@ const char *tst_cg_group_name(const struct tst_cg_group *const cg)
>  	return cg->group_name;
>  }
>  
> +int tst_cg_group_dir_fd(const struct tst_cg_group *const cg)
> +{
> +	return cg->dirs[0]->dir_fd;

Does this actually work in the case of mixed cgroup v1 and v2 setup?
Even if so I would just make sure that this call returns a fd pointing
to a v2 directory. Also the function should include "unified" in the
name so that it's clear that it returns fd to the v2 "unified"
hierarchy. I guess that tst_cg_group_unified_dir_fd() would be fitting
name.

To implement that we have to loop over dirs[] array and check which one
of them is v2, which should be reachable via the root pointer in the dir.

> +}
> +
>  struct tst_cg_group *tst_cg_group_rm(struct tst_cg_group *const cg)
>  {
>  	struct cgroup_dir **dir;
> diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> index ecc84408c..2aa00beb1 100644
> --- a/lib/tst_clone.c
> +++ b/lib/tst_clone.c
> @@ -15,6 +15,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
>  	struct clone_args args = {
>  		.flags = tst_args->flags,
>  		.exit_signal = tst_args->exit_signal,
> +		.cgroup = tst_args->cgroup,
>  	};
>  	int flags;
>  	pid_t pid = -1;
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 9c23a4248..0b6adfd7f 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -117,6 +117,7 @@ clone09 clone09
>  
>  clone301 clone301
>  clone302 clone302
> +clone303 clone303
>  
>  close01 close01
>  close02 close02
> diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
> index 604cb903e..10369954b 100644
> --- a/testcases/kernel/syscalls/clone3/.gitignore
> +++ b/testcases/kernel/syscalls/clone3/.gitignore
> @@ -1,2 +1,3 @@
>  clone301
>  clone302
> +clone303
> diff --git a/testcases/kernel/syscalls/clone3/clone303.c b/testcases/kernel/syscalls/clone3/clone303.c
> new file mode 100644
> index 000000000..e35cc8def
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clone3/clone303.c
> @@ -0,0 +1,94 @@
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
> +
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
> +	int fd;
> +	pid_t pid;
> +
> +	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
> +	fd = tst_cg_group_dir_fd(cg_child_test_simple);

I suppoose that this can be done once in the test setup.

> +	pid = clone_into_cgroup(fd);
> +
> +	if (!pid) {
> +		TST_CHECKPOINT_WAIT(0);
> +		return;
> +	}
> +
> +	char buf[BUF_LEN];
> +
> +	SAFE_CG_READ(cg_child_test_simple, "cgroup.procs", buf, BUF_LEN);
> +
> +	int x = atoi(buf);
> +
> +	if (x == pid)
> +		tst_res(TPASS, "clone3 case pass!");
> +	else
> +		tst_brk(TFAIL | TTERRNO, "clone3() failed !");
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);

And this could be done in the test cleanup.

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
