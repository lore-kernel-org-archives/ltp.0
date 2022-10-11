Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08BDC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 10:07:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 873003CAE98
	for <ltp@archiver.kernel.org>; Tue, 11 Oct 2022 12:07:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C6B53C075E
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 12:07:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23FC01400BDF
 for <ltp@lists.linux.it>; Tue, 11 Oct 2022 12:07:35 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 262BA21D48;
 Tue, 11 Oct 2022 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1665482855;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYqpfEiqDYyb7QDLD211lUkV8+RxD19Jf4P+8mCVheY=;
 b=CHcB8GG8vGhLeBGAXkvQzcbvIYPYt41sOQMlfjKfRgbd+keJlGqrf50/excwMdqEGm8pMR
 4qEaVL5Ql1VqovumKaQuF7kxfPIt2+6TUf0qkze44A43Ld6nViXkKiZIKVuRh3/LxXJQ+c
 SPaV9P5gD8MtenRX/+dig3sSJR0tTFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1665482855;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYqpfEiqDYyb7QDLD211lUkV8+RxD19Jf4P+8mCVheY=;
 b=ySJeL0vBLGLoMHxYLbMhtvOnz21lZJesfsP6g3Ob0/daKq4gPOL/Uat5y3BB4wyGeDCl6I
 U+Lys5biu2rMHMDA==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6B5382C141;
 Tue, 11 Oct 2022 10:07:34 +0000 (UTC)
References: <20220808074658.15319-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 11 Oct 2022 11:04:20 +0100
In-reply-to: <20220808074658.15319-1-andrea.cervesato@suse.com>
Message-ID: <87r0ze7jx7.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor pidns04 using the new LTP API
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

Sometimes it makes review easier to list what changed between V1 and
V2. Mainly because it's chance to explain if you made different changes
from what was discussed.

>  testcases/kernel/containers/pidns/pidns04.c | 169 +++++---------------
>  1 file changed, 39 insertions(+), 130 deletions(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns04.c b/testcases/kernel/containers/pidns/pidns04.c
> index 9ac0e5aca..97f5a4b78 100644
> --- a/testcases/kernel/containers/pidns/pidns04.c
> +++ b/testcases/kernel/containers/pidns/pidns04.c
> @@ -1,150 +1,59 @@
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
> + * Copyright (c) International Business Machines Corp., 2007
> + *		08/10/08 Veerendra C <vechandr@in.ibm.com>
> + * Copyright (C) 2022 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Clone a process with CLONE_NEWPID flag and verify that is not possible to
> + * kill init process by sending SIGKILL from child namespace.
> + */
>  
> -* File: pidns04.c
> -*
> -* Description:
> -*  The pidns04.c testcase builds into the ltp framework to verify
> -*  the basic functionality of PID Namespace.
> -*
> -* Verify that:
> -* 1. When parent clone a process with flag CLONE_NEWPID, the process ID of
> -* child should be one.
> -*
> -* 2. When parent clone a process with flag CLONE_NEWPID, the parent process ID
> -* of should be zero.
> -*
> -* 3. The container init process (one), should not get killed by the SIGKILL in
> -* the childNS
> -*
> -* Total Tests:
> -*
> -* Test Name: pidns04
> -*
> -* Test Assertion & Strategy:
> -*
> -* From main() clone a new child process with passing the clone_flag as
> -* CLONE_NEWPID.
> -* The container init, should not get killed by the SIGKILL inside the child NS.
> -* Usage: <for command-line>
> -* pidns04
> -*
> -* History:
> -*
> -* FLAG DATE     	NAME	   			DESCRIPTION
> -* 08/10/08      Veerendra C <vechandr@in.ibm.com> Verifies killing of cont init.
> -*
> -*******************************************************************************/
> -#define _GNU_SOURCE 1
>  #include <sys/wait.h>
> -#include <assert.h>
> -#include <stdio.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <string.h>
> -#include <errno.h>
> -#define CLEANUP cleanup
> -#include "pidns_helper.h"
> -#include "test.h"
> +#include "tst_test.h"
> +#include "lapi/namespaces_constants.h"
>  
> -#define INIT_PID	1
> -#define CHILD_PID       1
> -#define PARENT_PID      0
> -
> -char *TCID = "pidns04";
> -int TST_TOTAL = 1;
> -int fd[2];
> -
> -/*
> - * child_fn1() - Inside container
> -*/
> -static int child_fn1(void *ttype)
> +static int child_func(LTP_ATTRIBUTE_UNUSED void *arg)
>  {
> -	int exit_val;
>  	pid_t cpid, ppid;
> +
>  	cpid = getpid();
>  	ppid = getppid();
> -	char mesg[] = "I was not killed !";
> -	/* Child process closes up read side of pipe */
> -	close(fd[0]);
> -
> -	/* Comparing the values to make sure pidns is created correctly */
> -	if ((cpid == CHILD_PID) && (ppid == PARENT_PID)) {
> -		printf("PIDNS test is running inside container\n");
> -		kill(INIT_PID, SIGKILL);
> -		/* Verifying whether the container init is not killed, "
> -		   If so writing into the pipe created in the parent NS" */
>  
> -		/* Send "mesg" through the write side of pipe */
> -		write(fd[1], mesg, (strlen(mesg) + 1));
> -		exit_val = 0;
> -	} else {
> -		printf("got unexpected result of cpid=%d ppid=%d\n",
> -		       cpid, ppid);
> -		exit_val = 1;
> +	if (cpid != 1 || ppid != 0) {
> +		tst_res(TFAIL, "got unexpected result of cpid=%d ppid=%d", cpid, ppid);
> +		return 1;
>  	}
> -	exit(exit_val);
> -}
> -
> -static void setup(void)
> -{
> -	tst_require_root();
> -	check_newpid();
> -}
>  
> -int main(void)
> -{
> -	int nbytes, status;
> -	char readbuffer[80];
> +	tst_res(TINFO, "Sending SIGKILL to container init process from child");
>  
> -	setup();
> +	SAFE_KILL(1, SIGKILL);
>  
> -	pipe(fd);
> -	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID, child_fn1, NULL));
> -	if (TEST_RETURN == -1) {
> -		tst_brkm(TFAIL | TTERRNO, CLEANUP, "clone failed");
> -	} else if (wait(&status) == -1) {
> -		tst_brkm(TFAIL | TERRNO, CLEANUP, "wait failed");
> -	}
> +	tst_res(TPASS, "Child namespace is still alive");
>  
> -	/* Parent process closes up write side of pipe */
> -	close(fd[1]);
> -	/* Read in a string from the pipe */
> -	nbytes = read(fd[0], readbuffer, sizeof(readbuffer));
> +	return 0;
> +}
>  
> -	if (0 <= nbytes) {
> -		tst_resm(TPASS, "Container init : %s", readbuffer);
> -	} else {
> -		tst_brkm(TFAIL, CLEANUP,
> -			 "Container init is killed by SIGKILL !!!");
> -	}
> +static void run(void)
> +{
> +	int ret, status;
>  
> -	if (WIFEXITED(status) && WEXITSTATUS(status) != 0) {
> -		tst_resm(TFAIL, "Container init pid exited abnormally");
> -	} else if (WIFSIGNALED(status)) {
> -		tst_resm(TFAIL, "Container init pid got killed by signal %d",
> -			 WTERMSIG(status));
> -	}
> -	CLEANUP();
> +	ret = ltp_clone_quick(CLONE_NEWPID | SIGCHLD, child_func, NULL);

tst_clone again.

> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "clone failed");
>  
> -	tst_exit();
> +	SAFE_WAITPID(ret, &status, 0);
>  
> +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGKILL) {
> +		tst_res(TFAIL, "Child killed by SIGKILL");
> +		return;
> +	}
>  }
>  
> -static void cleanup(void)
> -{
> -	close(fd[0]);
> -}
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
