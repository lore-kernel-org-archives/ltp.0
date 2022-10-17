Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC083C43217
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 12:36:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16C973CAFF8
	for <ltp@archiver.kernel.org>; Mon, 17 Oct 2022 14:36:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 483483C4CCC
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:36:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 953102005D2
 for <ltp@lists.linux.it>; Mon, 17 Oct 2022 14:36:22 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CDFBB20607;
 Mon, 17 Oct 2022 12:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666010181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vrsNap5cJwQEe4djF1taADrYZdEVOhH9m85l6DjNfH8=;
 b=hRUnfL9sd/eSEQaa0CGfpWq7YABlVBRDAGN57O1dStYYV/JiW3dbJMLDiJskdkMuc4hCWF
 LfPuPEcVDrw1ddeXBHdDOlrc4aafrHuvm2Kr1jEGzIID/9XdSirynxL3CEDO/uj0wSF2Dv
 J9ReI9KRHs/Gqg4ttw/W03Jg6v6tG48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666010181;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vrsNap5cJwQEe4djF1taADrYZdEVOhH9m85l6DjNfH8=;
 b=KroYN/aYBWWWz4NzSJuTobPWwn6q6+HUZZ94aPtNjr4g8Fdu6a61gW26SpODZ6ZJ4QMNA1
 JAVptAK+5Ys/5dAg==
Received: from g78 (unknown [10.100.228.202])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C84922C141;
 Mon, 17 Oct 2022 12:36:20 +0000 (UTC)
References: <1663204902-4185-1-git-send-email-liaohj.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Liao Huangjie <liaohj.jy@fujitsu.com>
Date: Mon, 17 Oct 2022 13:08:08 +0100
In-reply-to: <1663204902-4185-1-git-send-email-liaohj.jy@fujitsu.com>
Message-ID: <87h702oce4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fork01:Convert into new api
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

Liao Huangjie <liaohj.jy@fujitsu.com> writes:

> From: Huangjie Liao <liaohj.jy@fujitsu.com>
>
> Signed-off-by: Huangjie Liao <liaohj.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/fork/fork01.c | 253 ++++++------------------
>  1 file changed, 55 insertions(+), 198 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/fork/fork01.c b/testcases/kernel/syscalls/fork/fork01.c
> index 00d7c45c4..8ba712805 100644
> --- a/testcases/kernel/syscalls/fork/fork01.c
> +++ b/testcases/kernel/syscalls/fork/fork01.c
> @@ -1,91 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + * Author: Kathy Olmsted
> + * Co-Pilot: Steve Shaw
> + */
> +
> +/*\
> + *[Description]
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - * http://www.sgi.com
> - *
> - * For further information regarding this notice, see:
> - *
> - * http://oss.sgi.com/projects/GenInfo/NoticeExplan/
> - *
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *    TEST IDENTIFIER	: fork01
> - *    EXECUTED BY	: anyone
> - *    TEST TITLE	: Basic test for fork(2)
> - *    PARENT DOCUMENT	: frktds02
> - *    TEST CASE TOTAL	: 2
> - *    WALL CLOCK TIME	: 1
> - *    CPU TYPES		: ALL
> - *    AUTHOR		: Kathy Olmsted
> - *    CO-PILOT		: Steve Shaw
> - *    DATE STARTED	: 06/17/92
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *    TEST CASES
> - *	1.) fork returns without error
> - *	2.) fork returns the pid of the child
> - *    INPUT SPECIFICATIONS
> - *	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *    OUTPUT SPECIFICATIONS
> - *    DURATION
> - *	Terminates - with frequency and infinite modes.
> - *    SIGNALS
> - *	Uses SIGUSR1 to pause before test if option set.
> - *	(See the parse_opts(3) man page).
> - *    RESOURCES
> - *	None
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - *	None
> - *    INTERCASE DEPENDENCIES
> - *	None
> - *    DETAILED DESCRIPTION
> - *	Setup:
> - *	Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *	Test:
> - *	 Loop if the proper options are given.
> - *        fork()
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *        CHILD:
> - *           determine PID
> - *           write to PID to a file and close the file
> - *           exit
> - *        PARENT:
> - *           wait for child to exit
> - *           read child PID from file
> - *           compare child PID to fork() return code and report
> - *           results
> - *
> - *	  Cleanup:
> - *           Print errno log and/or timing stats if options given
> + * This case tests fork()'s basic function.

The original descrption had more info than this. In particular:

> - *	1.) fork returns without error
> - *	2.) fork returns the pid of the child


>   */
>  
> +#define _GNU_SOURCE
>  #include <errno.h>
>  #include <string.h>
>  #include <signal.h>
> @@ -93,142 +19,73 @@
>  #include <stdlib.h>
>  #include <sys/types.h>
>  #include <sys/wait.h>
> -#include "test.h"
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "tst_test.h"
>  
>  #define	KIDEXIT	42
> -static void setup();
> -static void cleanup();
> -
>  #define LINE_SZ	20
>  #define FILENAME "childpid"
>  
> -char *TCID = "fork01";
> -int TST_TOTAL = 2;
> +static char buf[LINE_SZ];

This doesn't need to be a global var. In fact we don't need it at all
(see below).

>  
> -/*
> - * child_pid - the child side of the test
> - *             determine the PID and write to a file
> - */
> -static void child_pid(void)
> +static void do_child(void)
>  {
> +	int fd;
>  
> -	int fildes;
> -	char tmp_line[LINE_SZ];
> -
> -	fildes = creat(FILENAME, 0700);
> -	sprintf(tmp_line, "%d\n", getpid());
> -	write(fildes, tmp_line, LINE_SZ);
> -	close(fildes);
> -
> +	fd = creat(FILENAME, 0700);
> +	sprintf(buf, "%d\n", getpid());
> +	SAFE_WRITE(1, fd, buf, LINE_SZ);
> +	SAFE_CLOSE(fd);
>  }

This whole function can be replaced with SAFE_FILE_PRINTF i.e
SAFE_FILE_PRINTF(FILENAME, "%d", getpid());

>  
> -/*
> - * parent_pid - the parent side of the test
> - *              read the value determined by the child
> - *              compare and report results
> - */
> -static void parent_pid(void)
> +static void check_child_pid(int pid)
>  {
> +	int fd;
> +	pid_t child_pid;
>  
> -	int fildes;
> -	char tmp_line[LINE_SZ];
> -	pid_t child_id;
> +	fd = SAFE_OPEN(FILENAME, O_RDWR);
> +	SAFE_READ(1, fd, buf, LINE_SZ);

This can be replaced with SAFE_FILE_SCANF(FILENAME, "%d", &child_pid);

>  
> -	fildes = open(FILENAME, O_RDWR);
> -	if (fildes == -1) {
> -		tst_brkm(TBROK, cleanup,
> -			 "parent open failed. errno: %d (%s)\n",
> -			 errno, strerror(errno));
> +	child_pid = atoi(buf);
> +	if (child_pid != pid) {
> +		tst_res(TFAIL, "child reported a pid of %d. parent received %d from fork()",
> +				child_pid, pid);

This can be replaced with TST_EXP_EQ_LI(child_pid, pid).

>  	} else {
> -		if (read(fildes, tmp_line, LINE_SZ) == 0) {
> -			tst_brkm(TBROK, cleanup,
> -				 "fork(): parent failed to read PID from file errno: %d (%s)",
> -				 errno, strerror(errno));
> -		} else {
> -			child_id = atoi(tmp_line);
> -			if (TEST_RETURN != child_id) {
> -				tst_resm(TFAIL,
> -					 "child reported a pid of %d. parent received %ld from fork()",
> -					 child_id, TEST_RETURN);
> -			} else {
> -				tst_resm(TPASS,
> -					 "child pid and fork() return agree: %d",
> -					 child_id);
> -			}
> -		}
> -		close(fildes);
> -	}
> -}
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -	int fails;
> -	int kid_status, wait_status;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -		fails = 0;
> -
> -		TEST(fork());
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL, "fork() Failed, errno=%d : %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			tst_resm(TBROK, "unable to continue");
> -		}
> -		if (TEST_RETURN == 0) {
> -			/* child */
> -			child_pid();
> -			exit(KIDEXIT);
> -		} else {
> -			/* parent */
> -			tst_resm(TPASS, "fork() returned %ld",
> -				 TEST_RETURN);
> -			/* wait for the child to complete */
> -			wait_status = waitpid(TEST_RETURN, &kid_status, 0);
> -
> -			if (wait_status == TEST_RETURN) {
> -				if (kid_status != KIDEXIT << 8) {
> -					tst_resm(TBROK,
> -						 "incorrect child status returned on wait(): %d",
> -						 kid_status);
> -					fails++;
> -				}
> -			} else {
> -				tst_resm(TBROK,
> -					 "wait() for child status failed with %d errno: %d : %s",
> -					 wait_status, errno,
> -					 strerror(errno));
> -				fails++;
> -			}
> -			if (fails == 0) {
> -				/* verification tests */
> -				parent_pid();
> -			}
> -		}		/* TEST_RETURN */
> +		tst_res(TPASS, "child pid and fork() return agree: %d", pid);
>  	}
>  
> -	cleanup();
> -	tst_exit();
> +	SAFE_CLOSE(fd);
>  }
>  
> -static void setup(void)
> +static void verify_fork(void)
>  {
> +	int kid_status, term_pid, pid;
>  
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -}
> +	pid = SAFE_FORK();
> +	if (!pid) {
> +		do_child();
> +		exit(KIDEXIT);
> +	}
>  
> -static void cleanup(void)
> -{
> +	term_pid = SAFE_WAITPID(pid, &kid_status, 0);
> +	if (term_pid == pid) {
> +		if (kid_status != KIDEXIT << 8)
> +			tst_res(TFAIL, "incorrect child status returned %d", kid_status);
> +		else
> +			tst_res(TPASS, "correct child status returned
> %d", kid_status);

The original test is not strictly correct. We should check if the child
exited with WIFEXITED and use the WEXITSTATUS macro to get the exit
status.

>  
> -	tst_rmdir();
> +		check_child_pid(pid);
> +	} else {
> +		tst_res(TFAIL, "waitpid() returns %d instead of  expected pid %d", term_pid, pid);
> +	}
>  
> +	tst_reap_children();
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,

It doesn't need root.

> +	.forks_child = 1,
> +	.test_all = verify_fork,
> +};
> -- 
> 2.27.0


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
