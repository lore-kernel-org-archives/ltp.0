Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0114CC77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 13:10:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E29F73CBB4F
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 15:10:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 215AF3CAA20
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 15:10:15 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A77761400B9E
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 15:10:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55B9B1FDCD;
 Wed, 26 Apr 2023 13:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682514612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8HFArCcfcfm6JKUb7G8O/077sG0Ys2NRwTj48mFuDY=;
 b=zmNt+8i3GDwRjt9Bv+pDERnaHk9KWZ25SNEOI4+4JfObK94q8wMeGG8Iu3GyI/51nx9Yta
 Ko9KALVioWSTRFTqdwyDSOv7VLO3JMRojzetoDkXsSlL/dF6aLpUlIkE0V9k2JIDhyW8DU
 mYbnPJ1+TFUs6Y/qUYQZzWiEg4xiEJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682514612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F8HFArCcfcfm6JKUb7G8O/077sG0Ys2NRwTj48mFuDY=;
 b=gUT88IajXgG5BCm+kr5gKRPy8UXu/eHScBJ9gyYQ8mDlpcsSaYGudBKJF6gThWUclrW4x9
 t1sS7LaTBXzOVBAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 34974138F0;
 Wed, 26 Apr 2023 13:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GaL8C7QiSWSONQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 13:10:12 +0000
Date: Wed, 26 Apr 2023 15:11:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZEki8+W/YpkWd9vc@yuki>
References: <20230421012642.16625-1-wegao@suse.com>
 <20230422135337.12087-1-wegao@suse.com>
 <20230422135337.12087-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230422135337.12087-2-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] kill01: New case cgroup kill
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
> ---
>  lib/tst_cgroup.c                              |   1 +
>  runtest/controllers                           |   1 +
>  .../kernel/controllers/cgroup/.gitignore      |   1 +
>  .../kernel/controllers/cgroup/cgroup_core03.c | 144 ++++++++++++++++++
>  4 files changed, 147 insertions(+)
>  create mode 100644 testcases/kernel/controllers/cgroup/cgroup_core03.c
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
> index 8d1b936bf..93c52c439 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -1,6 +1,7 @@
>  #DESCRIPTION:Resource Management testing
>  cgroup_core01	cgroup_core01
>  cgroup_core02	cgroup_core02
> +cgroup_core03	cgroup_core03
>  cgroup		cgroup_regression_test.sh
>  memcg_regression	memcg_regression_test.sh
>  memcg_test_3	memcg_test_3
> diff --git a/testcases/kernel/controllers/cgroup/.gitignore b/testcases/kernel/controllers/cgroup/.gitignore
> index 8deae77da..9f1d1ada9 100644
> --- a/testcases/kernel/controllers/cgroup/.gitignore
> +++ b/testcases/kernel/controllers/cgroup/.gitignore
> @@ -2,3 +2,4 @@
>  /cgroup_regression_getdelays
>  /cgroup_core01
>  /cgroup_core02
> +/cgroup_core03
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core03.c b/testcases/kernel/controllers/cgroup/cgroup_core03.c
> new file mode 100644
> index 000000000..2a6941c44
> --- /dev/null
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core03.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2012 Christian Brauner <brauner-AT-kernel.org>
> + * Copyright (c) 2023 SUSE LLC <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test is copied from kselftest
> + * tools/testing/selftests/cgroup/test_kill.c
> + * Only simple test implemented within current case, the other cases such
> + * as test_cgkill_tree and test_cgkill_forkbomb can be created later.
> + *
> + */
> +
> +#include <sys/wait.h>
> +
> +#include "lapi/syscalls.h"
> +#include "tst_test.h"
> +
> +#define MAX_PID_NUM 100
> +#define PID_NUM MIN(MAX_PID_NUM, (tst_ncpus_available() + 1))
> +#define BUF_LEN (20 * PID_NUM)
> +
> +static int *data_ptr;
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
> +	if (WIFSIGNALED(status))
> +		return 0;
> +
> +	return -1;
> +}
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

What's the reason we are waiting for reparenting here? Aren't these
processes killed anyways? I suppose that we can just call pause() here
instead.

> +}
> +
> +static int cg_run_nowait(const struct tst_cg_group *const cg,
> +		  void (*fn)(void))
> +{
> +	int pid;
> +
> +	pid = SAFE_FORK();
> +	if (pid == 0) {
> +		SAFE_CG_PRINTF(cg, "cgroup.procs", "%d", getpid());
> +		tst_atomic_inc(data_ptr);
> +		if (tst_atomic_load(data_ptr) == PID_NUM)
> +			TST_CHECKPOINT_WAKE(0);

I do not think that this is 100% correct, as it is we may end up calling
the TST_CHECKOPOINT_WAKE(0) more than once here, since there is a race
between increment and load. An if that happens only one of the calls to
TST_CHECKPOINT_WAKE(0) will succeeds, while the rest would fail and
break the test.

First of all the tst_atomic_inc() returns the value after the increment,
so that we can actually get the counter value without a race.

Secondly I think that we can get rid of the atomic operations
completely, we just have to loop N times over the TST_CHECKPOINT_WAIT()
in the run() function and call TST_CHECKPOINT_WAKE() in each child
instance. We can also add TST_CHECKPOINT_WAIT_NR() to the test library
that would also take a number of wait calls passed as a parameter.

> +		fn();
> +	}
> +
> +	return pid;
> +}
> +
> +static int cg_wait_for_proc_count(const struct tst_cg_group *cg, int count)

The function does not wait for anything, so it should be called
cg_count_procs() or similar.

> +{
> +	char *ptr;
> +
> +	int nr = 0;
> +
> +	SAFE_CG_READ(cg, "cgroup.procs", buf, BUF_LEN);
> +
> +	for (ptr = buf; *ptr; ptr++)
> +		if (*ptr == '\n')
> +			nr++;
> +
> +	if (nr >= count)
> +		return 0;
> +
> +	tst_res(TINFO, "Expect process num is %d but get %d", count, nr);
> +
> +	return -1;
> +}
> +
> +static void run(void)
> +{
> +	pid_t pids[MAX_PID_NUM];
> +	int i;
> +	*data_ptr = 0;
> +
> +	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
> +
> +	memset(buf, 0, BUF_LEN);
> +
> +	for (i = 0; i < PID_NUM; i++)
> +		pids[i] = cg_run_nowait(cg_child_test_simple, child_fn);
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	TST_EXP_PASS(cg_wait_for_proc_count(cg_child_test_simple, PID_NUM));

This is very minor, but I would make the function return the number of
pids found in the cgroup and called it as:

	TST_EXP_VAL(cg_count_procs(cg_child_test_simple), pid_num);

> +	SAFE_CG_PRINTF(cg_child_test_simple, "cgroup.kill", "%d", 1);
> +
> +	for (i = 0; i < PID_NUM; i++)
> +		TST_EXP_PASS_SILENT(wait_for_pid(pids[i]));

Then we can do here:

	TST_EXP_VAL(cg_count_procs(cg_child_test_simple), 0);

> +	cg_child_test_simple = tst_cg_group_rm(cg_child_test_simple);
> +}
> +
> +static void setup(void)
> +{
> +	buf = tst_alloc(BUF_LEN);
> +	data_ptr = SAFE_MMAP(NULL, sizeof(uintptr_t), PROT_READ | PROT_WRITE,
> +						 MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (data_ptr)
> +		SAFE_MUNMAP(data_ptr, sizeof(uintptr_t));
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.forks_child = 1,
> +	.max_runtime = 20,
> +	.needs_cgroup_ctrls = (const char *const []){ "pseudo", NULL },
> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_checkpoints = 1,
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
