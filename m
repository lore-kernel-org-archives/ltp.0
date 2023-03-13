Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426D2C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 11:31:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E98643CD586
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 12:31:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 886E63C03AE
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 12:30:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 38D50200770
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 12:30:53 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7438A22A06;
 Mon, 13 Mar 2023 11:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1678707053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCzRYoQ4t106GFvWq2YZ5EZPEtkq9zqcaLTspu8EZJw=;
 b=CoVACIFEzgeDrionatpvpoXO03vG5426vOBNXxxt7Buzk8tu32WnLpyK1mgfyP8iS5nM4z
 vt4j/9gQ21mDDSa03Jx6XGGnehN9TLZz7tR3wcLXjIvWCC0r+4IBS395FsW2d3TR59jn3x
 BhLgSjaikp98LUU6OcUTZVY4268Ht6M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1678707053;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tCzRYoQ4t106GFvWq2YZ5EZPEtkq9zqcaLTspu8EZJw=;
 b=ay1LJ5rmdu72yZeK0UMCGbap898z1uQkvKFmenJ99UCASQtEYifnyLjQ5gGFqRh8rrVVfs
 Sc4whDW8fPYz2+CA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2DFEA2C141;
 Mon, 13 Mar 2023 11:30:53 +0000 (UTC)
References: <20230306235715.29868-1-wegao@suse.com>
 <20230307085139.3574-1-wegao@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Wei Gao <wegao@suse.com>
Date: Mon, 13 Mar 2023 10:45:12 +0000
Organization: Linux Private Site
In-reply-to: <20230307085139.3574-1-wegao@suse.com>
Message-ID: <87ttyo6g7o.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] kill01: New case cgroup kill
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
Cc: Li Wang <liwan@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Wei Gao via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_cgroup.c                             |   1 +
>  runtest/controllers                          |   1 +
>  testcases/kernel/controllers/kill/.gitignore |   1 +
>  testcases/kernel/controllers/kill/Makefile   |   6 +
>  testcases/kernel/controllers/kill/kill01.c   | 138 +++++++++++++++++++

nit: kill is not a controller, it is a core function. This should go in
controllers/cgroup.

>  5 files changed, 147 insertions(+)
>  create mode 100644 testcases/kernel/controllers/kill/.gitignore
>  create mode 100644 testcases/kernel/controllers/kill/Makefile
>  create mode 100644 testcases/kernel/controllers/kill/kill01.c
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 50699bc63..77575431d 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -166,6 +166,7 @@ static const struct cgroup_file cgroup_ctrl_files[] = {
>  	{ "cgroup.controllers", NULL, 0 },
>  	{ "cgroup.subtree_control", NULL, 0 },
>  	{ "cgroup.clone_children", "cgroup.clone_children", 0 },
> +	{ "cgroup.kill", NULL, 0 },
>  	{ }
>  };
>  
> diff --git a/runtest/controllers b/runtest/controllers
> index 8d1b936bf..2f69a8ec2 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -23,6 +23,7 @@ memcontrol01 memcontrol01
>  memcontrol02 memcontrol02
>  memcontrol03 memcontrol03
>  memcontrol04 memcontrol04
> +kill01 kill01
>  
>  cgroup_fj_function_debug cgroup_fj_function.sh debug
>  cgroup_fj_function_cpuset cgroup_fj_function.sh cpuset
> diff --git a/testcases/kernel/controllers/kill/.gitignore b/testcases/kernel/controllers/kill/.gitignore
> new file mode 100644
> index 000000000..4f9649e27
> --- /dev/null
> +++ b/testcases/kernel/controllers/kill/.gitignore
> @@ -0,0 +1 @@
> +/kill01
> diff --git a/testcases/kernel/controllers/kill/Makefile b/testcases/kernel/controllers/kill/Makefile
> new file mode 100644
> index 000000000..5ea7d67db
> --- /dev/null
> +++ b/testcases/kernel/controllers/kill/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/controllers/kill/kill01.c b/testcases/kernel/controllers/kill/kill01.c
> new file mode 100644
> index 000000000..432747e16
> --- /dev/null
> +++ b/testcases/kernel/controllers/kill/kill01.c
> @@ -0,0 +1,138 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic cgroup kill test.
> + *
> + */

I guess this is copied from the self tests and you can mention that in
the description and link to the original.

> +
> +#include <errno.h>
> +#include <linux/limits.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/types.h>
> +#include <unistd.h>
> +#include <sys/wait.h>
> +
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"
> +
> +#define MAX_PID_NUM 100
> +#define pid_num MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
> +#define buf_len (20 * pid_num)
> +
> +static char *buf;
> +static struct tst_cg_group *cg_child_test_simple;
> +
> +static int wait_for_pid(pid_t pid)
> +{
> +	int status, ret;
> +
> +again:
> +	ret = waitpid(pid, &status, 0);
> +	if (ret == -1) {
> +		if (errno == EINTR)
> +			goto again;
> +
> +		return -1;
> +	}
> +
> +	if (!WIFEXITED(status))
> +		return -1;
> +
> +	return WEXITSTATUS(status);
> +}

We have tst_reap_children for this, but this just appears to be wrong
for this test.

> +
> +/*
> + * A simple process running in a sleep loop until being
> + * re-parented.
> + */
> +static void child_fn(void)
> +{
> +	int ppid = getppid();
> +
> +	while (getppid() == ppid)
> +		usleep(1000);
> +
> +}
> +
> +static int cg_run_nowait(const struct tst_cg_group *const cg,
> +		  void (*fn)(void))

Why keep this function?

If you want to convert tests to LTP, then don't do the minimum possible
to use the LTP API. Use as much of it as possible otherwise we are just
importing brittle self tests.

> +{
> +	int pid;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
> +		fn();
> +	}
> +
> +	return pid;
> +}
> +
> +static int cg_wait_for_proc_count(const struct tst_cg_group *cg, int count)
> +{
> +	int attempts;
> +	char *ptr;
> +
> +	for (attempts = 100; attempts >= 0; attempts--) {
> +		int nr = 0;
> +
> +		SAFE_CG_READ(cg, "cgroup.procs", buf, buf_len);
> +
> +		for (ptr = buf; *ptr; ptr++)
> +			if (*ptr == '\n')
> +				nr++;
> +
> +		if (nr >= count)
> +			return 0;
> +
> +		usleep(100000);

It's best to avoid arbitrary sleep values and attempts. You could use
TST_CHECKPOINT* or increment a counter in some shared memory with
SAFE_MMAP and tst_atomic_inc.

> +	}
> +
> +	return -1;
> +}
> +
> +static void run(void)
> +{
> +	pid_t pids[MAX_PID_NUM];
> +	int i;
> +
> +	cg_child_test_simple = tst_cg_group_mk(tst_cg,
> "cg_test_simple");
> +
> +	memset(buf, 0, buf_len);

IIRC guarded buffers are zeroed already.

> +
> +	for (i = 0; i < pid_num; i++)
> +		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);

If the parent is killed and the children are moved then they will return
and cause a fork bomb.

This is not obvious because of the unecessary indirection (function
pointer and functions).

> +
> +	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple,
> pid_num));

If this fails then there will be little information to debug it. This is
a common issue with the self tests which we will be importing into the LTP.

> +	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
> +
> +	for (i = 0; i < pid_num; i++) {
> +		/* wait_for_pid(pids[i]); */
> +		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]) == SIGKILL);

It seems wait_for_pid will never == SIGKILL. The function does not
inspect the signal a process was killed with at all.

The test passes becaues this is not the correct use of TST_EXP_PASS*.

> +	}
> +
> +	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
> +}
> +
> +static void setup(void)
> +{
> +	buf = tst_alloc(buf_len);

Simple allocations like this can be done in the test struct.

> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.forks_child = 1,
> +	.max_runtime = 15,
> +	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },

Why do we need the memory controller?

If it is just to make the LTP library happy, then you can change the
library instead (e.g. add a "cgroup" pseudo controller if we didn't do
that already).

> +	.needs_cgroup_ver = TST_CG_V2,
> +};
> -- 
> 2.35.3

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
