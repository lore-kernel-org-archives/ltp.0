Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35411C43217
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 12:09:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 353413CC65A
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 13:09:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F07413C714A
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 13:09:13 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 590F11400242
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 13:09:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6043F1F74A;
 Mon, 28 Nov 2022 12:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669637350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mXtCDrgJfAxsdGU4rlJNk/nyvlPwgv3PEp+4Id3ix9w=;
 b=zT6o3exQvrVB8KeFbxp5slu52wmOtU2bVKea/I2qz94dNYX41etUdfcHhBzXifzgjB2v3t
 vfg2hM+gE+1hlcFzKclmMsbg07gA9LiXogOQvmZICpdeRdCvPaSTw33M+bwqjLgAc6bI4g
 zBsTJ1qjBvZg0onl8KTcvffC3rme+rk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669637350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mXtCDrgJfAxsdGU4rlJNk/nyvlPwgv3PEp+4Id3ix9w=;
 b=zE9dp8XYm8SMQYdSx/j/dy03tNOmScnod9H7hlGRTI/46tfUMH8cWl+sNGRxUbDh73AY19
 I969W/KKnHhQIiDQ==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 2DC932C141;
 Mon, 28 Nov 2022 12:09:10 +0000 (UTC)
References: <20221031132658.26233-1-andrea.cervesato@suse.com>
 <20221031132658.26233-3-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Mon, 28 Nov 2022 11:56:06 +0000
Organization: Linux Private Site
In-reply-to: <20221031132658.26233-3-andrea.cervesato@suse.com>
Message-ID: <87tu2juvq4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Rewrite utsname testing suite
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

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Deleted utstest.c and created the following new tests:
> - utsname01
> - utsname02
> - utsname03
> - utsname04
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Usage of HOST_NAME_MAX
>
>  runtest/containers                            |   7 +
>  .../kernel/containers/utsname/.gitignore      |   5 +-
>  testcases/kernel/containers/utsname/Makefile  |  23 +-
>  .../containers/utsname/runutstests_noltp.sh   |  41 --
>  testcases/kernel/containers/utsname/utsname.h | 116 ++++++
>  .../kernel/containers/utsname/utsname01.c     |  72 ++++
>  .../kernel/containers/utsname/utsname02.c     |  96 +++++
>  .../kernel/containers/utsname/utsname03.c     | 110 ++++++
>  .../kernel/containers/utsname/utsname04.c     |  66 ++++
>  testcases/kernel/containers/utsname/utstest.c | 356 ------------------
>  10 files changed, 474 insertions(+), 418 deletions(-)
>  delete mode 100755 testcases/kernel/containers/utsname/runutstests_noltp.sh
>  create mode 100644 testcases/kernel/containers/utsname/utsname.h
>  create mode 100644 testcases/kernel/containers/utsname/utsname01.c
>  create mode 100644 testcases/kernel/containers/utsname/utsname02.c
>  create mode 100644 testcases/kernel/containers/utsname/utsname03.c
>  create mode 100644 testcases/kernel/containers/utsname/utsname04.c
>  delete mode 100644 testcases/kernel/containers/utsname/utstest.c
>
> diff --git a/runtest/containers b/runtest/containers
> index 2637b62fe..36d9378af 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -73,6 +73,13 @@ utstest_clone_3 utstest clone 3
>  utstest_clone_4 utstest clone 4
>  utstest_clone_5 utstest clone 5
>  
> +utsname01 utsname01
> +utsname02 utsname02
> +utsname03_clone utsname03 -m clone
> +utsname03_unshare utsname03 -m unshare
> +utsname04_clone utsname04 -m clone
> +utsname04_unshare utsname04 -m unshare
> +
>  mountns01 mountns01
>  mountns02 mountns02
>  mountns03 mountns03
> diff --git a/testcases/kernel/containers/utsname/.gitignore b/testcases/kernel/containers/utsname/.gitignore
> index 0e1f41dc8..945ed280e 100644
> --- a/testcases/kernel/containers/utsname/.gitignore
> +++ b/testcases/kernel/containers/utsname/.gitignore
> @@ -1 +1,4 @@
> -/utstest
> +/utsname01
> +/utsname02
> +/utsname03
> +/utsname04
> diff --git a/testcases/kernel/containers/utsname/Makefile b/testcases/kernel/containers/utsname/Makefile
> index 5efcbf648..9c0158c01 100644
> --- a/testcases/kernel/containers/utsname/Makefile
> +++ b/testcases/kernel/containers/utsname/Makefile
> @@ -1,28 +1,11 @@
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) International Business Machines  Corp., 2007                 ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -################################################################################
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>  
>  top_srcdir		?= ../../../..
>  
>  include $(top_srcdir)/include/mk/testcases.mk
>  include $(abs_srcdir)/../Makefile.inc
>  
> -LDLIBS			:= -lclone -lpthread -lrt $(LDLIBS)
> +LDLIBS			:= -lclone $(LDLIBS)
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/containers/utsname/runutstests_noltp.sh b/testcases/kernel/containers/utsname/runutstests_noltp.sh
> deleted file mode 100755
> index 43cb7e26b..000000000
> --- a/testcases/kernel/containers/utsname/runutstests_noltp.sh
> +++ /dev/null
> @@ -1,41 +0,0 @@
> -#!/bin/sh
> -################################################################################
> -##                                                                            ##
> -## Copyright (c) International Business Machines  Corp., 2007                 ##
> -##                                                                            ##
> -## This program is free software;  you can redistribute it and#or modify      ##
> -## it under the terms of the GNU General Public License as published by       ##
> -## the Free Software Foundation; either version 2 of the License, or          ##
> -## (at your option) any later version.                                        ##
> -##                                                                            ##
> -## This program is distributed in the hope that it will be useful, but        ##
> -## WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY ##
> -## or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License   ##
> -## for more details.                                                          ##
> -##                                                                            ##
> -## You should have received a copy of the GNU General Public License          ##
> -## along with this program;  if not, write to the Free Software               ##
> -## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
> -##                                                                            ##
> -################################################################################
> -
> -oldhostname=`hostname`
> -exit_code=0
> -echo "unshare tests"
> -for i in `seq 1 5`; do
> -	echo "test $i (unshare)"
> -	./utstest_noltp unshare $i
> -	if [ $? -ne 0 ]; then
> -		exit_code=$?
> -	fi
> -done
> -echo "clone tests"
> -for i in `seq 1 5`; do
> -	echo "test $i (clone)"
> -	./utstest_noltp clone $i
> -	if [ $? -ne 0 ]; then
> -		exit_code=$?
> -	fi
> -done
> -hostname "$oldhostname"
> -exit $exit_code
> diff --git a/testcases/kernel/containers/utsname/utsname.h b/testcases/kernel/containers/utsname/utsname.h
> new file mode 100644
> index 000000000..4a88e2c91
> --- /dev/null
> +++ b/testcases/kernel/containers/utsname/utsname.h
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef UTSTEST_H
> +#define UTSTEST_H
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/namespaces_constants.h"
> +
> +enum {
> +	T_CLONE,
> +	T_UNSHARE,
> +	T_NONE,
> +};
> +
> +static int dummy_child(LTP_ATTRIBUTE_UNUSED void *v)
> +{
> +	return 0;
> +}
> +
> +static inline void check_newuts(void)
> +{
> +	int pid, status;
> +
> +	pid = ltp_clone_quick(CLONE_NEWUTS | SIGCHLD, dummy_child, NULL);
> +	if (pid < 0)
> +		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +}
> +
> +static inline int get_clone_unshare_enum(const char *str_op)
> +{
> +	int use_clone;
> +
> +	use_clone = T_NONE;
> +
> +	if (!str_op || !strcmp(str_op, "none"))
> +		use_clone = T_NONE;
> +	else if (!strcmp(str_op, "clone"))
> +		use_clone = T_CLONE;
> +	else if (!strcmp(str_op, "unshare"))
> +		use_clone = T_UNSHARE;
> +	else
> +		tst_brk(TBROK, "Test execution mode <clone|unshare|none>");
> +
> +	return use_clone;
> +}
> +
> +static inline pid_t clone_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
> +{
> +	pid_t pid;
> +
> +	pid = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
> +	if (pid < 0)
> +		tst_brk(TBROK | TERRNO, "ltp_clone_quick error");
> +
> +	return pid;
> +}
> +
> +static inline pid_t unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
> +{
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_UNSHARE(clone_flags);
> +
> +		fn1(arg1);
> +		exit(0);
> +	}
> +
> +	return pid;
> +}
> +
> +static inline pid_t plain_test(int (*fn1)(void *arg), void *arg1)
> +{
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		fn1(arg1);
> +		exit(0);
> +	}
> +
> +	return pid;
> +}
> +
> +static inline pid_t clone_unshare_test(int use_clone, unsigned long clone_flags,
> +			       int (*fn1)(void *arg), void *arg1)
> +{
> +	pid_t pid = -1;
> +
> +	switch (use_clone) {
> +	case T_NONE:
> +		pid = plain_test(fn1, arg1);
> +	break;
> +	case T_CLONE:
> +		pid = clone_test(clone_flags, fn1, arg1);
> +	break;
> +	case T_UNSHARE:
> +		pid = unshare_test(clone_flags, fn1, arg1);
> +	break;
> +	default:
> +		tst_brk(TBROK, "%s: bad use_clone option: %d", __func__, use_clone);
> +	break;
> +	}
> +
> +	return pid;
> +}
> +
> +#endif
> diff --git a/testcases/kernel/containers/utsname/utsname01.c b/testcases/kernel/containers/utsname/utsname01.c
> new file mode 100644
> index 000000000..077019abc
> --- /dev/null
> +++ b/testcases/kernel/containers/utsname/utsname01.c
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone two plain processes and check if both read the same hostname.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "utsname.h"
> +
> +static char *hostname1;
> +static char *hostname2;
> +
> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
> +{
> +	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
> +
> +	return 0;
> +}
> +
> +static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
> +{
> +	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
> +
> +	return 0;
> +}
> +
> +static void run(void)
> +{
> +	int status1, status2;
> +	pid_t pid1, pid2;
> +
> +	memset(hostname1, 0, HOST_NAME_MAX);
> +	memset(hostname2, 0, HOST_NAME_MAX);
> +
> +	pid1 = clone_unshare_test(T_NONE, 0, child1_run, NULL);
> +	pid2 = clone_unshare_test(T_NONE, 0, child2_run, NULL);
> +
> +	SAFE_WAITPID(pid1, &status1, 0);
> +	SAFE_WAITPID(pid2, &status2, 0);
> +
> +	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
> +		return;
> +
> +	TST_EXP_PASS(strcmp(hostname1, hostname2));
> +}
> +
> +static void setup(void)
> +{
> +	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
> +	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,

Minor point, but we don't need root for this.

> +	.forks_child = 1,
> +};
> diff --git a/testcases/kernel/containers/utsname/utsname02.c b/testcases/kernel/containers/utsname/utsname02.c
> new file mode 100644
> index 000000000..5f8bbe836
> --- /dev/null
> +++ b/testcases/kernel/containers/utsname/utsname02.c
> @@ -0,0 +1,96 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone two plain processes, change hostname in the first one then check if
> + * hostaname has changed inside the second one as well.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "utsname.h"
> +
> +#define HOSTNAME "LTP_HOSTNAME"
> +
> +static char *hostname1;
> +static char *hostname2;
> +static char originalhost[HOST_NAME_MAX];
> +
> +static void reset_hostname(void)
> +{
> +	SAFE_SETHOSTNAME(originalhost, strlen(originalhost));
> +}
> +
> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
> +{
> +	SAFE_SETHOSTNAME(HOSTNAME, strlen(HOSTNAME));
> +	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	return 0;
> +}
> +
> +static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
> +{
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
> +
> +	return 0;
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid1, pid2;
> +	int status1, status2;
> +
> +	memset(hostname1, 0, HOST_NAME_MAX);
> +	memset(hostname2, 0, HOST_NAME_MAX);
> +
> +	pid1 = clone_unshare_test(T_NONE, 0, child1_run, NULL);
> +	pid2 = clone_unshare_test(T_NONE, 0, child2_run, NULL);

FYI ltp_clone_quick leaks memory because it allocates the stack, but
nothing frees it.

In the future we could use protected buffers for that. It's not a big
deal for this test.

> +
> +	SAFE_WAITPID(pid1, &status1, 0);
> +	SAFE_WAITPID(pid2, &status2, 0);
> +
> +	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
> +		return;
> +
> +	TST_EXP_PASS(strcmp(hostname1, HOSTNAME));
> +	TST_EXP_PASS(strcmp(hostname2, HOSTNAME));
> +
> +	reset_hostname();
> +}
> +
> +static void setup(void)
> +{
> +	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	memset(originalhost, 0, HOST_NAME_MAX);
> +
> +	SAFE_GETHOSTNAME(originalhost, HOST_NAME_MAX);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
> +	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
> +
> +	reset_hostname();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> diff --git a/testcases/kernel/containers/utsname/utsname03.c b/testcases/kernel/containers/utsname/utsname03.c
> new file mode 100644
> index 000000000..b6579c11b
> --- /dev/null
> +++ b/testcases/kernel/containers/utsname/utsname03.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines Corp., 2007
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone two processes using CLONE_NEWUTS, change hostname from the first
> + * container and check if hostname didn't change inside the second one.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "utsname.h"
> +
> +#define HOSTNAME "LTP_HOSTNAME"
> +
> +static char *str_op = "clone";

Specifying the -m option causes a warning to be printed. IIUC you can't
set a default value here. get_clone_unshare_enum should return a default
value.

> +static int use_clone;
> +static char *hostname1;
> +static char *hostname2;
> +static char originalhost[HOST_NAME_MAX];
> +
> +static void reset_hostname(void)
> +{
> +	SAFE_SETHOSTNAME(originalhost, strlen(originalhost));
> +}
> +
> +static int child1_run(LTP_ATTRIBUTE_UNUSED void *vtest)
> +{
> +	SAFE_SETHOSTNAME(HOSTNAME, strlen(HOSTNAME));
> +	SAFE_GETHOSTNAME(hostname1, HOST_NAME_MAX);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	return 0;
> +}
> +
> +static int child2_run(LTP_ATTRIBUTE_UNUSED void *vtest)
> +{
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	SAFE_GETHOSTNAME(hostname2, HOST_NAME_MAX);
> +
> +	return 0;
> +}
> +
> +static void run(void)
> +{
> +	pid_t pid1, pid2;
> +	int status1, status2;
> +
> +	memset(hostname1, 0, HOST_NAME_MAX);
> +	memset(hostname2, 0, HOST_NAME_MAX);
> +
> +	pid1 = clone_unshare_test(use_clone, CLONE_NEWUTS, child1_run, NULL);
> +	pid2 = clone_unshare_test(use_clone, CLONE_NEWUTS, child2_run, NULL);
> +
> +	SAFE_WAITPID(pid1, &status1, 0);
> +	SAFE_WAITPID(pid2, &status2, 0);
> +
> +	if (WIFSIGNALED(status1) || WIFSIGNALED(status2))
> +		return;
> +
> +	TST_EXP_PASS(strcmp(hostname1, HOSTNAME));
> +	TST_EXP_PASS(strcmp(hostname2, originalhost));
> +
> +	reset_hostname();
> +}
> +
> +static void setup(void)
> +{
> +	use_clone = get_clone_unshare_enum(str_op);
> +
> +	if (use_clone != T_CLONE && use_clone != T_UNSHARE)
> +		tst_brk(TCONF, "Only clone and unshare clone are supported");
> +
> +	check_newuts();
> +
> +	hostname1 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +	hostname2 = SAFE_MMAP(NULL, sizeof(char) * HOST_NAME_MAX, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	memset(originalhost, 0, HOST_NAME_MAX);
> +
> +	SAFE_GETHOSTNAME(originalhost, HOST_NAME_MAX);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_MUNMAP(hostname1, HOST_NAME_MAX);
> +	SAFE_MUNMAP(hostname2, HOST_NAME_MAX);
> +
> +	reset_hostname();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,

Just FYI, but this is probaby not true. We do have the ability to
request and drop individual capabilities as well.

However the thing that stops me from merging this is the warning
produced by -m.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
