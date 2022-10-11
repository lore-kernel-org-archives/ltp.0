Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 504B8C433FE
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 09:59:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A07763CAE93
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 11:59:46 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 33C9A3CAE86
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:59:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8DE371400BF6
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 11:59:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 08FBA222E4;
 Tue, 11 Oct 2022 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665482375;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPlRxij0aINnX+M6lQob3YvxpJ7gEtlJxdbblg6bvJ8=;
 b=blXq2sYIC19skcuUUJvwigjeKU+N7zzekmwIBoPEpQTEg6734flBppBSimrduKCN8erHKS
 LMgVyfBZtk1u9fKMeHsT0jBmdxPwA2+0rNAtBsHbx09sUqcJBZw6xVPszWTSd7qabjSvY5
 ZcElg23fcRB9wqHX83ewnv/A49SVblU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665482375;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UPlRxij0aINnX+M6lQob3YvxpJ7gEtlJxdbblg6bvJ8=;
 b=3Wzqujko555ZItKWQdI3P0uBS4CEjovu/2KUQfc1ba0XAdpiPeiJ48UwhASD5Qy40sT6Iq
 8jQ3VQgT+X1IpyCQ==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 83DCF2C141;
 Tue, 11 Oct 2022 09:59:34 +0000 (UTC)
References: <20220805094619.663-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 11 Oct 2022 10:59:21 +0100
In-reply-to: <20220805094619.663-1-andrea.cervesato@suse.com>
Message-ID: <87v8oq7kak.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns10 test using new LTP API
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


Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/pidns/pidns10.c | 133 ++++++--------------
>  1 file changed, 38 insertions(+), 95 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns10.c b/testcases/kernel/containers/pidns/pidns10.c
> index b38b9fd18..cbc9d3585 100644
> --- a/testcases/kernel/containers/pidns/pidns10.c
> +++ b/testcases/kernel/containers/pidns/pidns10.c
> @@ -1,112 +1,55 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
> -* Copyright (c) International Business Machines Corp., 2007
> -* This program is free software; you can redistribute it and/or modify
> -* it under the terms of the GNU General Public License as published by
> -* the Free Software Foundation; either version 2 of the License, or
> -* (at your option) any later version.
> -* This program is distributed in the hope that it will be useful,
> -* but WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See
> -* the GNU General Public License for more details.
> -* You should have received a copy of the GNU General Public License
> -* along with this program; if not, write to the Free Software
> -* Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> -*
> -***************************************************************************
> -* File: pidns10.c
> -* *
> -* * Description:
> -* *  The pidns10.c testcase verifies inside the container, if kill(-1, signal)
> -* *  fails with ESRCH when there are no processes in container.
> -* *
> -* * Test Assertion & Strategy:
> -* *  Create a PID namespace container.
> -* *  Invoke kill(-1, SIGUSR1) inside container and check return code and error.
> -* *  kill() should have failed;except swapper & init, no process is inside.
> -* *
> -* * Usage: <for command-line>
> -* *  pidns10
> -* *
> -* * History:
> -* *  DATE      NAME                             DESCRIPTION
> -* *  13/11/08  Gowrishankar M 			Creation of this test.
> -* *            <gowrishankar.m@in.ibm.com>
> -*
> -******************************************************************************/
> -#define _GNU_SOURCE 1
> -#include <sys/wait.h>
> -#include <sys/types.h>
> -#include <string.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include "pidns_helper.h"
> -#include "test.h"
> -
> -char *TCID = "pidns10";
> -int TST_TOTAL = 1;
> + * Copyright (C) International Business Machines Corp., 2008
> + *               13/11/08  Gowrishankar M <gowrishankar.m@in.ibm.com>
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
>  
> -int child_fn(void *);
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag and check if kill(-1, signal) fails
> + * with ESRCH when there are no process in the container.
> + */
>  
> -#define CHILD_PID       1
> -#define PARENT_PID      0
> +#include "tst_test.h"
> +#include "lapi/namespaces_constants.h"
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *arg)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> -	int exit_val, ret;
> -	pid_t pid, ppid;
> +	pid_t cpid, ppid;
> +	int ret;
>  
> -	/* Set process id and parent pid */
> -	pid = getpid();
> +	cpid = getpid();
>  	ppid = getppid();
> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
> -		printf("cinit: pidns was not created.\n");
> +
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
>  		return 1;
>  	}
>  
> -	if ((ret = kill(-1, SIGUSR1)) == -1 && errno == ESRCH) {
> -		printf("cinit: kill(-1, sig) failed with -1 / ESRCH as "
> -		       "expected\n");
> -		exit_val = 0;
> -	} else {
> -		printf("cinit: kill(-1, sig) didn't fail with -1 / ESRCH "
> -		       "(%d); failed with %d / %d instead", ESRCH, ret, errno);
> -		exit_val = 1;
> +	ret = kill(-1, SIGUSR1);
> +
> +	if (ret != -1 || errno != ESRCH) {
> +		tst_res(TFAIL, "kill() didn't fail with ESRCH");
> +		return 0;
>  	}
> -	exit(exit_val);
> -}
>  
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> +	tst_res(TPASS, "Can't kill processes from child namespace");
> +
> +	return 0;
>  }
>  
> -int main(void)
> +static void run(void)
>  {
> -	int status;
> -	pid_t pid;
> -
> -	setup();
> -
> -	pid = getpid();
> -
> -	/* Container creation on PID namespace */
> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn, NULL));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TBROK | TTERRNO, NULL, "clone failed");
> -	}
> -
> -	sleep(1);
> -	if (wait(&status) < 0)
> -		tst_resm(TWARN, "parent: waitpid() failed.");
> +	int ret;
>  
> -	if (WIFEXITED(status) && WEXITSTATUS(status) != 0)
> -		tst_resm(TBROK, "container was terminated abnormally");
> -
> -	tst_exit();
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, 0);

tst_clone

> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_root = 1,
> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
