Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D4DC6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 10:32:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C20C3CE2D7
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 11:32:29 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 869013CA59A
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 11:32:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 19DEA1400E72
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 11:32:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2A011FD91;
 Thu, 23 Mar 2023 10:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679567534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWaD4Pgm1C/XnKRNgQi3sCx/IQsPqo/Y/qVRRafpxJI=;
 b=CrCcyidzZ+bZVDnh3vAF7d/C9tXDdqgoHWHIHtzAXAdcff0KjGPzVZRuoDv39GvzDdtjr4
 tHlvYYDwVSPNlKnU2AHJJmKFctdtuwgol5PYWPyVw3OVP4taAboh/syIOwJirEf8Zc0t2x
 6DdXQEaS2+ovVoZDVzrj8HKSpW+QJ+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679567534;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dWaD4Pgm1C/XnKRNgQi3sCx/IQsPqo/Y/qVRRafpxJI=;
 b=iOmcXRAWKyC4ooTm4nN7p0ktpLkHzigrqq+fVCEGTrZ+gDpEU046eOr8Lh+m28VxVwM7xt
 UUlu11TrnqzQznBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3FE54132C2;
 Thu, 23 Mar 2023 10:32:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OHDZCa4qHGSrbAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 23 Mar 2023 10:32:14 +0000
Date: Thu, 23 Mar 2023 11:32:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20230323103207.GG405493@pevik>
References: <20230307124708.27280-1-andrea.cervesato@suse.de>
 <20230307124708.27280-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230307124708.27280-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/6] Refactor mqns_01 using new LTP API
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

Hi Andrea,

> diff --git a/runtest/containers b/runtest/containers
> index 23f394579..5e1b53bfa 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -16,7 +16,8 @@ pidns31 pidns31
>  pidns32 pidns32

>  mqns_01 mqns_01
> -mqns_01_clone mqns_01 -clone
> +mqns_01_clone mqns_01 -m clone
I'd be for renaming these testcases to rename the underscore (e.g. from
mqns_01.c to mqns01.c). But this can be done any time later.

> +mqns_01_unshare mqns_01 -m unshare
>  mqns_02 mqns_02
>  mqns_02_clone mqns_02 -clone
>  mqns_03 mqns_03

> diff --git a/testcases/kernel/containers/mqns/mqns_01.c b/testcases/kernel/containers/mqns/mqns_01.c
> index 1d109e020..61e586c14 100644
> --- a/testcases/kernel/containers/mqns/mqns_01.c
> +++ b/testcases/kernel/containers/mqns/mqns_01.c
> @@ -1,148 +1,82 @@
> +// SPDX-License-Identifier: GPL-2.0
It should be GPL-2.0-or-later

I'm going to fix it before merge.

>  /*
> -* Copyright (c) International Business Machines Corp., 2009
> -* Copyright (c) Nadia Derbey, 2009
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.
> -*
> -* Check mqns isolation: father mqns cannot be accessed from newinstance
> -*
> -* Mount mqueue fs
> -* Create a posix mq -->mq1
> -* unshare
> -* In unshared process:
> -*    Mount newinstance mqueuefs
> -*    Check that mq1 is not readable from new ns
> + * Copyright (c) International Business Machines Corp., 2009
> + * Copyright (c) Nadia Derbey, 2009 <Nadia.Derbey@bull.net>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */

> -***************************************************************************/
> +/*\
> + * [Description]
> + *
> + * Create a mqueue inside the parent and check if it can be accessed from
maybe:
Create a mqueue inside the parent and verify it cannot be accessed from
the child namespace.

> + * the child namespace.
> + */

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
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +#include "tst_safe_posix_ipc.h"

> -char *TCID = "posixmq_namespace_01";
> -int TST_TOTAL = 1;
> +#define MQNAME "/MQ1"

> -int p1[2];
> -int p2[2];
> +static mqd_t mqd;
> +static char *str_op;

> -int check_mqueue(void *vtest)
> +static void run(void)
>  {
> -	char buf[30];
> -	mqd_t mqd;
> +	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };

> -	(void) vtest;
> +	tst_res(TINFO, "Checking namespaces isolation from parent to child");

> -	close(p1[1]);
> -	close(p2[0]);
> +	if (str_op && !strcmp(str_op, "clone")) {
> +		tst_res(TINFO, "Spawning isolated process");

> -	if (read(p1[0], buf, strlen("go") + 1) < 0) {
> -		printf("read(p1[0], ...) failed: %s\n", strerror(errno));
> -		exit(1);
> -	}
> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDONLY);
> -	if (mqd == -1) {
> -		if (write(p2[1], "notfnd", strlen("notfnd") + 1) < 0) {
> -			perror("write(p2[1], ...) failed");
> -			exit(1);
> +		if (!SAFE_CLONE(&clone_args)) {
> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
> +			return;
> +		}
> +	} else if (str_op && !strcmp(str_op, "unshare")) {
> +		tst_res(TINFO, "Spawning unshared process");
> +
> +		if (!SAFE_FORK()) {
> +			SAFE_UNSHARE(CLONE_NEWIPC);
> +			TST_EXP_FAIL(mq_open(MQNAME, O_RDONLY), ENOENT);
> +			return;
>  		}
>  	} else {
> -		if (write(p2[1], "exists", strlen("exists") + 1) < 0) {
> -			perror("write(p2[1], \"exists\", 7) failed");
> -			exit(1);
> -		} else if (mq_close(mqd) < 0) {
> -			perror("mq_close(mqd) failed");
> -			exit(1);
> +		tst_res(TINFO, "Spawning plain process");
> +
> +		if (!SAFE_FORK()) {
> +			TST_EXP_POSITIVE(mq_open(MQNAME, O_RDONLY));
> +			return;
>  		}
>  	}
> -
> -	exit(0);
>  }

>  static void setup(void)
>  {
> -	tst_require_root();
> -	check_mqns();
> +	mqd = SAFE_MQ_OPEN(MQNAME, O_RDWR | O_CREAT | O_EXCL, 0777, NULL);
>  }

> -int main(int argc, char *argv[])
> +static void cleanup(void)
>  {
> -	int r;
> -	mqd_t mqd;
> -	char buf[30];
> -	int use_clone = T_UNSHARE;
> -
> -	setup();
> -
> -	if (argc == 2 && strcmp(argv[1], "-clone") == 0) {
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
> -
> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
> -		0777, NULL);
> -	if (mqd == -1) {
> -		perror("mq_open");
> -		tst_brkm(TFAIL, NULL, "mq_open failed");
> +	if (mqd != -1) {
> +		SAFE_MQ_CLOSE(mqd);
> +		SAFE_MQ_UNLINK(MQNAME);
>  	}
> -
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

The old version actually communicate between parent and child proces over pipe
(p1, p2 arrays). Is it all of these useless? I wonder myself what have POSIX
message queues together with pipes.

I'm sorry if I overlook discussion about it in the past (looked at various
versions; it'd be worth to mention changes like this in the commit message).

Kind regards,
Petr

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
> -
> -	/* destroy the mqueue */
> -	if (mq_close(mqd) == -1) {
> -		tst_brkm(TBROK | TERRNO, NULL, "mq_close failed");
> -	}
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
> +	.options = (struct tst_option[]) {
> +		{ "m:", &str_op, "Child process isolation <clone|unshare>" },
> +		{},
> +	},
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_USER_NS",
> +		NULL
> +	},
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
