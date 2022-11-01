Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7255CC433FE
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 10:53:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1119A3CAC43
	for <ltp@archiver.kernel.org>; Tue,  1 Nov 2022 11:53:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E5953CAC33
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:53:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0815E600776
 for <ltp@lists.linux.it>; Tue,  1 Nov 2022 11:53:11 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 500A9338F7;
 Tue,  1 Nov 2022 10:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667299991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zv5sWdozu+O7aX/7hBbCGm1YVMNzj8HFuT1xodylsU0=;
 b=WE7j8PiqckReVFKP0tCpH+GFgn0ZkKMM9EdeuguPyVpHIkLbHXsK5kWcKwJn1OZiwlnI7e
 BN41Od2U2FMOMmpyvE6ZKFjgM3kpm/GFrfT/e7pVkRdFPJb/mGetpz00PXaWSFDWDrW4nw
 NPVsGbanjVyESmcQwyt2JgHnZknNKp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667299991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zv5sWdozu+O7aX/7hBbCGm1YVMNzj8HFuT1xodylsU0=;
 b=hEBZBfaE4j+dZIZKfsWA0RtKRxhA01S6dJw5mJsZlC4A878k+ZFwLmCE/lE+qd6nHSsawo
 773sXYcmmvB7C9BA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D7F932C141;
 Tue,  1 Nov 2022 10:53:10 +0000 (UTC)
References: <20220808141632.10056-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 01 Nov 2022 10:38:33 +0000
Organization: Linux Private Site
In-reply-to: <20220808141632.10056-1-andrea.cervesato@suse.com>
Message-ID: <87cza79ca1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor pidns17 test using new LTP API
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

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/containers/pidns/pidns17.c | 189 ++++++--------------
>  1 file changed, 51 insertions(+), 138 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns17.c b/testcases/kernel/containers/pidns/pidns17.c
> index cf0c5826f..1d3dd53bb 100644
> --- a/testcases/kernel/containers/pidns/pidns17.c
> +++ b/testcases/kernel/containers/pidns/pidns17.c
> @@ -1,162 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
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
> -* File: pidns17.c
> -* *
> -* * Description:
> -* *  The pidns17.c testcase verifies inside the container, if kill(-1, SIGUSR1)
> -* *  terminates all children running inside.
> -* *
> -* * Test Assertion & Strategy:
> -* *  Create a PID namespace container.
> -* *  Spawn many children inside it.
> -* *  Invoke kill(-1, SIGUSR1) inside container and check if it terminates
> -* *  all children.
> -* *
> -* * Usage: <for command-line>
> -* *  pidns17
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
> + * Copyright (c) International Business Machines Corp., 2007
> + *               13/11/08  Gowrishankar M <gowrishankar.m@in.ibm.com>
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
>  
> -char *TCID = "pidns17";
> -int TST_TOTAL = 1;
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag and spawn many children inside the
> + * container. Then terminate all children and check if they ended up.
> + */
>  
> -int child_fn(void *);
> +#include <sys/wait.h>
> +#include "tst_test.h"
> +#include "lapi/namespaces_constants.h"
>  
> -#define CHILD_PID       1
> -#define PARENT_PID      0
> +#define CHILDREN_NUM 10
>  
> -/*
> - * child_fn() - Inside container
> - */
> -int child_fn(void *arg)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> -	int children[10], exit_val, i, status;
> -	pid_t pid, ppid;
> +	int children[CHILDREN_NUM], status;
> +	unsigned int i, counter = 0;
> +	pid_t cpid, ppid;
>  
> -	/* Set process id and parent pid */
> -	pid = getpid();
> +	cpid = getpid();
>  	ppid = getppid();
> -	if (pid != CHILD_PID || ppid != PARENT_PID) {
> -		printf("cinit: pidns was not created\n");
> -		exit(1);
> -	}
>  
> -	exit_val = 0;
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "Got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> +		return 1;
> +	}

Can use TST_EXP_EQ here as in pidns12 (or whatever I just merged).

>  
> -	/* Spawn many children */
> -	for (i = 0; i < ARRAY_SIZE(children); i++) {
> -		switch ((children[i] = fork())) {
> -		case -1:
> -			perror("fork failed");
> -			exit_val = 1;
> -			break;
> -		case 0:
> +	for (i = 0; i < CHILDREN_NUM; i++) {
> +		children[i] = SAFE_FORK();
> +		if (!children[i]) {
>  			pause();
> -			/* XXX (garrcoop): why exit with an exit code of 2? */
> -			exit(2);
> -			break;
> -		default:
> -			/* fork succeeded. */
> -			break;
> +			return 0;
>  		}
>  	}
> -	/* wait for last child to get scheduled */
> -	sleep(1);
>  
> -	if (kill(-1, SIGUSR1) == -1) {
> -		perror("cinit: kill(-1, SIGUSR1) failed");
> -		exit_val = 1;
> +	SAFE_KILL(-1, SIGUSR1);
> +
> +	for (i = 0; i < CHILDREN_NUM; i++) {
> +		SAFE_WAITPID(children[i], &status, 0);
> +
> +		if (WIFSIGNALED(status) && WTERMSIG(status) == SIGUSR1)
> +			counter++;

How do we debug this if the test fails? It would be nice to at least
know how the child died.

>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(children); i++) {
> -		if (waitpid(children[i], &status, 0) == -1) {
> -			perror("cinit: waitpid failed");
> -			kill(children[i], SIGTERM);
> -			waitpid(children[i], &status, 0);
> -			exit_val = 1;
> -		}
> -		if (!(WIFSIGNALED(status) || WTERMSIG(status) == SIGUSR1)) {
> -			/*
> -			 * XXX (garrcoop): this status reporting is overly
> -			 * noisy. Someone obviously needs to read the
> -			 * constraints documented in wait(2) a bit more
> -			 * closely -- in particular the relationship between
> -			 * WIFEXITED and WEXITSTATUS, and WIFSIGNALED and
> -			 * WTERMSIG.
> -			 */
> -			printf("cinit: found a child alive still "
> -			       "%d exit: %d, %d, signal %d, %d", i,
> -			       WIFEXITED(status), WEXITSTATUS(status),
> -			       WIFSIGNALED(status), WTERMSIG(status));

This only gets printed when the test fails, so it's not too noisy. The
message is not correct either, but it would at least print how the child
died.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
