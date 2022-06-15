Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33364C43334
	for <ltp@archiver.kernel.org>; Wed, 15 Jun 2022 11:49:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E11783C254D
	for <ltp@archiver.kernel.org>; Wed, 15 Jun 2022 13:49:28 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EB383C0775
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 13:49:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9D759600131
 for <ltp@lists.linux.it>; Wed, 15 Jun 2022 13:49:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8647B21B33;
 Wed, 15 Jun 2022 11:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655293754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BM3W49noCr8GPYw9Pbh6kI2bYRDdAz3yrMSNrXlr7Kk=;
 b=1R8GGjbU5hss18XtO5AK8un4YayO6wfOnyZ8bNKTN1CUsh5tSnwsGJgVmVRzgsk7G5svKe
 Qbq3/IG4PX3UgOCoFjZoOfQ6+0B7ixpJhJP3QR2S+sKxrZivDhNwJvbhXQMdLS8Vfvyc4Q
 0QPrzbYc2f5WTIqMFAa5ftrYQ8Oa/n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655293754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BM3W49noCr8GPYw9Pbh6kI2bYRDdAz3yrMSNrXlr7Kk=;
 b=AdNfdbYVyKyeJAW4hjNEjLczcZ7u12N6lAnmSexZ20NW1MSypiATlML5v2y9EJvhZUkgRp
 cXnCp9JMce+nfeBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72057139F3;
 Wed, 15 Jun 2022 11:49:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id g5HCGjrHqWJzegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Jun 2022 11:49:14 +0000
Date: Wed, 15 Jun 2022 13:51:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YqnHuR6nK4jALxQy@yuki>
References: <20220613203333.24839-1-andrea.cervesato@suse.de>
 <20220613203333.24839-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613203333.24839-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/6] Rewrite mqns_01 test using new LTP API
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
> -mqns_01 mqns_01
> -mqns_01_clone mqns_01 -clone
> +mqns_01_none mqns_01 -m none
> +mqns_01_clone mqns_01 -m clone
> +mqns_01_unshare mqns_01 -m unshare
>  mqns_02 mqns_02
>  mqns_02_clone mqns_02 -clone
>  mqns_03 mqns_03
> diff --git a/testcases/kernel/containers/mqns/common.h b/testcases/kernel/containers/mqns/common.h
> new file mode 100644
> index 000000000..2e0a0a402
> --- /dev/null
> +++ b/testcases/kernel/containers/mqns/common.h
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef __MQNS_H
> +#define __MQNS_H

Any identifier that starts with underscore is reserved for libc and
compiler implementation, please make sure not to use such names.

Also the file is called common.h so probably this should be something
as MQNS_COMMON_H instead.

> +#include <stdlib.h>
> +#include <mqueue.h>
> +#include "lapi/namespaces_constants.h"
> +#include "tst_test.h"
> +
> +enum {
> +	T_CLONE,
> +	T_UNSHARE,
> +	T_NONE,
> +};
> +
> +static int dummy_child1(void *v)
> +{
> +	(void)v;
> +	return 0;
> +}
> +
> +static void check_newipc(void)
> +{
> +	int pid, status;
> +
> +	pid = ltp_clone_quick(CLONE_NEWIPC | SIGCHLD, dummy_child1, NULL);
> +	if (pid < 0)
> +		tst_brk(TCONF | TERRNO, "CLONE_NEWIPC not supported");
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +}
> +
> +static inline int get_clone_unshare_enum(const char* str_op)
> +{
> +	int use_clone;
> +
> +	use_clone = T_NONE;

I do not think that we have to initialize the variable, we either set it
or exit. Is this code here to silence a warning?

maybe it would be better to use return instead of variable as:


	if (foo)
		return BAR;
	else if (bar)
		return FOO;
	...


	return 0;


This piece of code has dummy return at the end but is a bit more clear.

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
> +static void clone_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
> +{
> +	int pid;
> +
> +	pid = ltp_clone_quick(clone_flags | SIGCHLD, fn1, arg1);
> +	if (pid < 0)
> +		tst_brk(TBROK | TERRNO, "ltp_clone_quick error");
> +}
> +
> +static void unshare_test(unsigned long clone_flags, int (*fn1)(void *arg), void *arg1)
> +{
> +	int pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		SAFE_UNSHARE(clone_flags);
> +
> +		fn1(arg1);
> +		exit(0);
> +	}
> +}
> +
> +static void plain_test(int (*fn1)(void *arg), void *arg1)
> +{
> +	int pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		fn1(arg1);
> +		exit(0);
> +	}
> +}
> +
> +static void clone_unshare_test(int use_clone, unsigned long clone_flags,
> +			       int (*fn1)(void *arg), void *arg1)
> +{
> +	switch (use_clone) {
> +	case T_NONE:
> +		plain_test(fn1, arg1);
> +	break;
> +	case T_CLONE:
> +		clone_test(clone_flags, fn1, arg1);
> +	break;
> +	case T_UNSHARE:
> +		unshare_test(clone_flags, fn1, arg1);
> +	break;
> +	default:
> +		tst_brk(TBROK, "%s: bad use_clone option: %d", __FUNCTION__, use_clone);
> +	break;
> +	}
> +}
> +
> +#endif /* __MQNS_H */
> diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
> index 1d109e020..e6ebe0ea8 100644
> --- a/testcases/kernel/containers/mqns/mqns_01.c
> +++ b/testcases/kernel/containers/mqns/mqns_01.c
> @@ -1,148 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> -* Copyright (c) International Business Machines Corp., 2009
> -* Copyright (c) Nadia Derbey, 2009
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.
> -*
> -* This program is distributed in the hope that it will be useful,
> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> -* the GNU General Public License for more details.
> -* You should have received a copy of the GNU General Public License
> -* along with this program; if not, write to the Free Software
> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -*
> -* Author: Nadia Derbey <Nadia.Derbey@bull.net>
> -*
> -* Check mqns isolation: father mqns cannot be accessed from newinstance
> -*
> -* Mount mqueue fs
> -* Create a posix mq -->mq1
> -* unshare
> -* In unshared process:
> -*    Mount newinstance mqueuefs
> -*    Check that mq1 is not readable from new ns
> -
> -***************************************************************************/
> -
> -#ifndef _GNU_SOURCE
> -#define _GNU_SOURCE
> -#endif
> -#include <sys/wait.h>
> -#include <errno.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <string.h>
> -#include <unistd.h>
> -#include "mqns.h"
> -#include "mqns_helper.h"
> -
> -char *TCID = "posixmq_namespace_01";
> -int TST_TOTAL = 1;
> -
> -int p1[2];
> -int p2[2];
> -
> -int check_mqueue(void *vtest)
> + * Copyright (c) International Business Machines Corp., 2009
> + * Copyright (c) Nadia Derbey, 2009 <Nadia.Derbey@bull.net>
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Create a mqueue inside the father and check if it can be accessed from
                                    ^
				 parent

The most usual wording is parent/child process, they don't have a gender
after all.

> + * the isolated/forked child namespace.
> + */
> +
> +#include <mqueue.h>
> +#include "common.h"
> +
> +#define MQNAME "/MQ1"
> +
> +static mqd_t mqd;
> +static char *str_op;
> +static int use_clone;
> +
> +static int check_mqueue(LTP_ATTRIBUTE_UNUSED void *vtest)
>  {
> -	char buf[30];
> -	mqd_t mqd;
> +	mqd_t mqd1;
>  
> -	(void) vtest;
> +	mqd1 = mq_open(MQNAME, O_RDONLY);
>  
> -	close(p1[1]);
> -	close(p2[0]);
> +	if (use_clone == T_NONE) {
> +		if (mqd1 == -1)
> +			tst_res(TFAIL, "Queue has been accessed form plain cloned process");
> +		else
> +			tst_res(TPASS, "Can't access to queue from plain cloned process");
>  
> -	if (read(p1[0], buf, strlen("go") + 1) < 0) {
> -		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
> -		exit(1);
> -	}
> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
> -	if (mqd == -1) {
> -		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
> -			perror("write(p2[1], ...) failed");
> -			exit(1);
> -		}
> -	} else {
> -		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
> -			perror("write(p2[1], \"exists\", 7) failed");
> -			exit(1);
> -		} else if (mq_close(mqd) < 0) {
> -			perror("mq_close(mqd) failed");
> -			exit(1);
> -		}
> +		return 0;
>  	}
>  
> -	exit(0);
> +	if (mqd1 == -1)
> +		tst_res(TPASS, "Can't access to queue from isolated process");
> +	else
> +		tst_res(TFAIL, "Queue has been accessed from isolated process");
> +
> +	return 0;
>  }
>  
> -static void setup(void)
> +static void run(void)
>  {
> -	tst_require_root();
> -	check_mqns();
> +	tst_res(TINFO, "Checking namespaces isolation from parent to child");
> +
> +	clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
>  }
>  
> -int main(int argc, char *argv[])
> +static void setup(void)
>  {
> -	int r;
> -	mqd_t mqd;
> -	char buf[30];
> -	int use_clone = T_UNSHARE;
> -
> -	setup();
> -
> -	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
> +
> -		tst_resm(TINFO,
> -			 "Testing posix mq namespaces through clone(2).");
> -		use_clone = T_CLONE;
> -	} else
> -		tst_resm(TINFO,
> -			 "Testing posix mq namespaces through unshare(2).");
> -
> -	if (pipe(p1) == -1 || pipe(p2) == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
> -	}
> +	use_clone = get_clone_unshare_enum(str_op);
>  
> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
> -		0777, NULL);
> -	if (mqd == -1) {
> -		perror("mq_open");
> -		tst_brkm(TFAIL, NULL, "mq_open failed");
> -	}
> +	if (use_clone != T_NONE)
> +		check_newipc();
>  
> -	tst_resm(TINFO, "Checking namespaces isolation from parent to child");
> -	/* fire off the test */
> -	r = do_clone_unshare_test(use_clone, CLONE_NEWIPC, check_mqueue, NULL);
> -	if (r < 0) {
> -		tst_resm(TFAIL, "failed clone/unshare");
> -		mq_close(mqd);
> -		tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
> -		tst_exit();
> -	}
> -
> -	close(p1[0]);
> -	close(p2[1]);
> -	if (write(p1[1], "go", strlen("go") + 1) < 0)
> -		tst_resm(TBROK | TERRNO, "write(p1[1], \"go\", ...) failed");
> -	else if (read(p2[0], buf, 7) < 0)
> -		tst_resm(TBROK | TERRNO, "read(p2[0], buf, ...) failed");
> -	else {
> -		if (!strcmp(buf, "exists")) {
> -			tst_resm(TFAIL, "child process found mqueue");
> -		} else if (!strcmp(buf, "notfnd")) {
> -			tst_resm(TPASS, "child process didn't find mqueue");
> -		} else {
> -			tst_resm(TFAIL, "UNKNOWN RESULT");
> -		}
> -	}
> +	mqd = mq_open(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
> +	if (mqd == -1)
> +		tst_brk(TBROK | TERRNO, "mq_open failed");

We do have SAFE_MQ_OPEN() in tst_safe_posix_ipc.h

> +}
>  
> -	/* destroy the mqueue */
> -	if (mq_close(mqd) == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
> +static void cleanup(void)
> +{
> +	if (mqd != -1) {
> +		mq_close(mqd);
> +		mq_unlink(MQNAME);

And these two should be added to the tst_safe_posix_ipc.h as well and
used here.

>  	}
> -	tst_syscall(__NR_mq_unlink, NOSLASH_MQ1);
> -
> -	tst_exit();
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.min_kver = "2.6.30",
> +	.options = (struct tst_option[]) {
> +		{ "m:", &str_op, "Test execution mode <clone|unshare|none>" },
> +		{},
> +	},
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
