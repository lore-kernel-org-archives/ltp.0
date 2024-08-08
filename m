Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FA3C3DA4A
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 09:17:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0761D3D205D
	for <ltp@archiver.kernel.org>; Thu,  8 Aug 2024 11:17:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F2D63D1CA3
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 11:17:03 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 50F5A1001596
 for <ltp@lists.linux.it>; Thu,  8 Aug 2024 11:17:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33CD01FCE0;
 Thu,  8 Aug 2024 09:16:59 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06C2013876;
 Thu,  8 Aug 2024 09:16:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oqzSAAuNtGaHIAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Aug 2024 09:16:59 +0000
Date: Thu, 8 Aug 2024 11:16:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <20240808091657.GA313341@pevik>
References: <20240807113601.3882356-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240807113601.3882356-1-maxj.fnst@fujitsu.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 33CD01FCE0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] getcpu: Add testcase for EFAULT
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ma,

> Add a testcase with the arguments point to an invalid address.

Generally LGTM, I have few comments, but I'll fix them before merge.

> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.de>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>

@Andrea, Cyril, feel free to have final look during today (otherwise I'll merge
later today).

@Ma The test has changed 3 times quite significantly. IMHO it's better not to
add Reviewed-by: unless you change just either simple thing or did changes you
were explicitly asked to do. Better is to --cc all people who did the review
when generating patches with 'git format-patch'.

(It's good to add Reviewed-by: if your patchset has more commits and some of
them were previously reviewed and they are unchanged in the following version.)

> ---

Also, not needed, but it helps, if you wrote some changes to the previous
version after these '---' (it will not be part of the git commit message when
other developers apply your patch with 'git am'.

>  runtest/syscalls                            |  1 +
>  testcases/kernel/syscalls/getcpu/getcpu02.c | 71 +++++++++++++++++++++
>  2 files changed, 72 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c

> diff --git a/runtest/syscalls b/runtest/syscalls
> index b8728c1c5..1537b5022 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -448,6 +448,7 @@ futimesat01 futimesat01
>  getcontext01 getcontext01

>  getcpu01 getcpu01
> +getcpu02 getcpu02

You miss adding "/getcpu02" into testcases/kernel/syscalls/getcpu/.gitignore.
I'll do that before merge.

>  getcwd01 getcwd01
>  getcwd02 getcwd02


> diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
> new file mode 100644
> index 000000000..859cb0d3e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
> @@ -0,0 +1,71 @@
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
> + * Verify that getcpu(2) fails with EFAULT:
> + *
> + * 1) cpu_id points outside the calling process's address space.
> + * 2) node_id points outside the calling process's address space.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +
> +static unsigned int cpu_id, node_id;
> +
> +static struct tcase {
> +	unsigned int *cpu_id;
> +	unsigned int *node_id;
> +} tcases[] = {
> +	{NULL, &node_id},
> +	{&cpu_id, NULL}
I meant to add char *desc here instead of tst_res(TINFO later in check_getcpu()
> +};
> +
> +static void check_getcpu(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int status;
> +	pid_t pid;
> +
> +	if (n == 0) {
It might be better to check this as:
if (!tc->cpu_id)
(set cpu_id only if not set.

> +		tst_res(TINFO, "Make cpu_id point outside the calling process's address space.");
> +		tc->cpu_id = tst_get_bad_addr(NULL);
> +	} else if (n == 1) {
and here either if (!tc->node_id) or simple else.
> +		tst_res(TINFO, "Make node_id point outside the calling process's address space.");
> +		tc->node_id = tst_get_bad_addr(NULL);

Also, we usually try to set values which does not change in the setup function
(because one can run test more times, e.g. 1000x with :/getcpu02 -i1000. Thus
things which don't have to be repeated go to the setup function.

But when I tried that, even without setup function, using this pointer always
causes SIGSEGV (test passes). And I use direct static values it does *not* cause
SIGSEGV (test fails):

static unsigned int cpu_id, node_id;
static unsigned int *p_cpu_id = &cpu_id, *p_node_id = &node_id;

static struct tcase {
	unsigned int **cpu_id;
	unsigned int **node_id;
	char *desc;
} tcases[] = {
	{NULL, NULL, "none"},
	{NULL, &p_node_id, "cpu_id"},
	{&p_cpu_id, NULL, "node_id"},
};

static void check_getcpu(unsigned int n)
{
	struct tcase *tc = &tcases[n];
	int status;
	pid_t pid;

	tst_res(TINFO, "Test %s outside process's address space", tc->desc);

	pid = SAFE_FORK();
	if (!pid) {
		TST_EXP_FAIL(getcpu(p_cpu_id, p_node_id), EFAULT); // this would always pass
		TST_EXP_FAIL(getcpu(*tc->cpu_id, *tc->node_id), EFAULT); // this always fail, even for none

		exit(0);
	}

I guess I miss something obvious. Therefore I suggest to merge (or see the diff
below).

Kind regards,
Petr

static struct tcase {
	unsigned int *cpu_id;
	unsigned int *node_id;
	char *desc;
} tcases[] = {
	{NULL, &node_id, "cpu_id"},
	{&cpu_id, NULL, "node_id"},
};

static void check_getcpu(unsigned int n)
{
	struct tcase *tc = &tcases[n];
	int status;
	pid_t pid;

	tst_res(TINFO, "Test %s outside process's address space", tc->desc);

	if (!tc->cpu_id)
		tc->cpu_id = tst_get_bad_addr(NULL);

	if (!tc->node_id)
		tc->node_id = tst_get_bad_addr(NULL);

	pid = SAFE_FORK();
	if (!pid) {
		TST_EXP_FAIL(getcpu(tc->cpu_id, tc->node_id), EFAULT);

		exit(0);
	}

	SAFE_WAITPID(pid, &status, 0);

	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
		tst_res(TPASS, "getcpu() caused SIGSEGV");
		return;
	}

	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
		return;

	tst_res(TFAIL, "child %s", tst_strstatus(status));
}

diff --git testcases/kernel/syscalls/getcpu/.gitignore testcases/kernel/syscalls/getcpu/.gitignore
index 31fec5d35e..cd3022bbb1 100644
--- testcases/kernel/syscalls/getcpu/.gitignore
+++ testcases/kernel/syscalls/getcpu/.gitignore
@@ -1 +1,2 @@
 /getcpu01
+/getcpu02
diff --git testcases/kernel/syscalls/getcpu/getcpu02.c testcases/kernel/syscalls/getcpu/getcpu02.c
index 859cb0d3eb..83d236a78c 100644
--- testcases/kernel/syscalls/getcpu/getcpu02.c
+++ testcases/kernel/syscalls/getcpu/getcpu02.c
@@ -9,7 +9,7 @@
 /*\
  * [Description]
  *
- * Verify that getcpu(2) fails with EFAULT:
+ * Verify that getcpu(2) fails with EFAULT if:
  *
  * 1) cpu_id points outside the calling process's address space.
  * 2) node_id points outside the calling process's address space.
@@ -25,9 +25,10 @@ static unsigned int cpu_id, node_id;
 static struct tcase {
 	unsigned int *cpu_id;
 	unsigned int *node_id;
+	char *desc;
 } tcases[] = {
-	{NULL, &node_id},
-	{&cpu_id, NULL}
+	{NULL, &node_id, "cpu_id"},
+	{&cpu_id, NULL, "node_id"},
 };
 
 static void check_getcpu(unsigned int n)
@@ -36,13 +37,13 @@ static void check_getcpu(unsigned int n)
 	int status;
 	pid_t pid;
 
-	if (n == 0) {
-		tst_res(TINFO, "Make cpu_id point outside the calling process's address space.");
+	tst_res(TINFO, "Test %s outside process's address space", tc->desc);
+
+	if (!tc->cpu_id)
 		tc->cpu_id = tst_get_bad_addr(NULL);
-	} else if (n == 1) {
-		tst_res(TINFO, "Make node_id point outside the calling process's address space.");
+
+	if (!tc->node_id)
 		tc->node_id = tst_get_bad_addr(NULL);
-	}
 
 	pid = SAFE_FORK();
 	if (!pid) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
