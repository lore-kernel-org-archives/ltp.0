Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B7CC43217
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 15:51:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2CC873CC66D
	for <ltp@archiver.kernel.org>; Mon, 28 Nov 2022 16:51:05 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10B4F3C0162
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:50:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 096662000AB
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 16:50:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 670F621B20
 for <ltp@lists.linux.it>; Mon, 28 Nov 2022 15:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1669650655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEfaSE8+sIZdBfXHor5yeleHjmw+vpnTibFIiRxMDuo=;
 b=S2akyXrZvs+IifDh20ZKFqIOF5ObuiweSO07q5KvOYOHGv+LB90dRbxETiznW3zmnScFMC
 +96j675kmi9aCGZWebT9Bsc7IkDsYqE3obrnpjvfhmsTLK2Np96ZakXQlMwECVNrfeh0jo
 aNLeIuFK+lZ90/9T9jOAwPYqTSxLpiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1669650655;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dEfaSE8+sIZdBfXHor5yeleHjmw+vpnTibFIiRxMDuo=;
 b=A47XzmysvuC8JhXZF9RJcau8zvJz98XCDV2l0mg6iflQLhQ9AUVH4KJBBLmQD6cTAW9k7s
 jBw9ek5prilqk8Cw==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 40BBA2C143;
 Mon, 28 Nov 2022 15:50:55 +0000 (UTC)
References: <20221123142732.1399-1-akumar@suse.de>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Avinesh Kumar <akumar@suse.de>
Date: Mon, 28 Nov 2022 15:50:17 +0000
Organization: Linux Private Site
In-reply-to: <20221123142732.1399-1-akumar@suse.de>
Message-ID: <87v8mzt6w1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statfs01: Convert to new API and enable for all
 filesystems
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

Merged with minor change, thanks!

Avinesh Kumar <akumar@suse.de> writes:

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/statfs/statfs01.c | 211 +++-----------------
>  1 file changed, 29 insertions(+), 182 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/statfs/statfs01.c b/testcases/kernel/syscalls/statfs/statfs01.c
> index 65f008988..5c38a12c3 100644
> --- a/testcases/kernel/syscalls/statfs/statfs01.c
> +++ b/testcases/kernel/syscalls/statfs/statfs01.c
> @@ -1,197 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> - *
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
> + * AUTHOR : William Roske, CO-PILOT	: Dave Fenner
> + * Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>   */
> -/* $Id: statfs01.c,v 1.6 2009/11/02 13:57:19 subrata_modak Exp $ */
> -/**********************************************************
> - *
> - *    OS Test - Silicon Graphics, Inc.
> - *
> - *    TEST IDENTIFIER	: statfs01
> - *
> - *    EXECUTED BY	: anyone
> - *
> - *    TEST TITLE	: Basic test for statfs(2) mounted filesys
> - *
> - *    PARENT DOCUMENT	: usctpl01
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    WALL CLOCK TIME	: 1
> - *
> - *    CPU TYPES		: ALL
> - *
> - *    AUTHOR		: William Roske
> - *
> - *    CO-PILOT		: Dave Fenner
> - *
> - *    DATE STARTED	: 05/14/92
> - *
> - *    INITIAL RELEASE	: UNICOS 7.0
> - *
> - *    TEST CASES
> - *
> - * 	1.) statfs(2) returns...(See Description)
> - *
> - *    INPUT SPECIFICATIONS
> - * 	The standard options for system call tests are accepted.
> - *	(See the parse_opts(3) man page).
> - *
> - *    OUTPUT SPECIFICATIONS
> - *$
> - *    DURATION
> - * 	Terminates - with frequency and infinite modes.
> - *
> - *    SIGNALS
> - * 	Uses SIGUSR1 to pause before test if option set.
> - * 	(See the parse_opts(3) man page).
> - *
> - *    RESOURCES
> - * 	None
> - *
> - *    ENVIRONMENTAL NEEDS
> - *      No run-time environmental needs.
> - *
> - *    SPECIAL PROCEDURAL REQUIREMENTS
> - * 	None
> - *
> - *    INTERCASE DEPENDENCIES
> - * 	None
> - *
> - *    DETAILED DESCRIPTION
> - *	This is a Phase I test for the statfs(2) system call.  It is intended
> - *	to provide a limited exposure of the system call, for now.  It
> - *	should/will be extended when full functional tests are written for
> - *	statfs(2).
> - *
> - * 	Setup:
> - * 	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *	 Loop if the proper options are given.
> - * 	  Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *		Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> - *
> - *
> - *#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#**/
>  
> -#include <sys/types.h>
> -#include <fcntl.h>
> -#include <sys/statfs.h>
> -#include <errno.h>
> -#include <signal.h>
> -#include <string.h>
> -#include "test.h"
> -
> -void setup();
> -void cleanup();
> +/*\
> + * [Description]
> + *
> + * Verify that statfs() syscall executes successfully on all
> + * available filesystems.
> + */
>  
> -char *TCID = "statfs01";
> -int TST_TOTAL = 1;
> +#include "tst_test.h"
>  
> -char fname[255];
> -int fd;
> -struct statfs stats;
> +#define MNT_POINT "mntpoint"
> +#define TEMP_FILE MNT_POINT"/testfile"
> +#define TEXT "dummy text"
>  
> -int main(int ac, char **av)
> +static void setup(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> -
> -		/* Call fstatfs(2) */
> -		TEST(statfs(fname, &stats));
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "statfs(%s, ..) failed",
> -				 fname);
> -		} else {
> -			tst_resm(TPASS, "statfs(%s, ..) returned %ld",
> -				 fname, TEST_RETURN);
> -		}
> -
> -	}
> -
> -	cleanup();
> -	tst_exit();
> +	int fd;
>  
> +	fd = SAFE_OPEN(TEMP_FILE, O_RDWR | O_CREAT, 0700);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, TEXT, strlen(TEXT));
> +	SAFE_CLOSE(fd);
>  }
>  
> -/***************************************************************
> - * setup() - performs all ONE TIME setup for this test.
> - ***************************************************************/
> -void setup(void)
> +static void run(void)
>  {
> +	struct statfs buf;
>  
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	sprintf(fname, "tfile_%d", getpid());
> -	if ((fd = open(fname, O_RDWR | O_CREAT, 0700)) == -1) {
> -		tst_brkm(TBROK, cleanup,
> -			 "open(%s, O_RDWR|O_CREAT,0700) Failed, errno=%d : %s",
> -			 fname, errno, strerror(errno));
> -	}
> -	/* write the TCID to the file */
> -	if (write(fd, TCID, strlen(TCID)) == -1) {
> -		tst_brkm(TBROK, cleanup,
> -			 "write(fd, TCID, strlen(TCID))Failed, errno=%d : %s",
> -			 errno, strerror(errno));
> -	}
> -	close(fd);
> -
> +	TST_EXP_PASS(statfs(TEMP_FILE, &buf));
>  }
>  
> -/***************************************************************
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - ***************************************************************/
> -void cleanup(void)
> -{
> -
> -	tst_rmdir();
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNT_POINT,
> +	.all_filesystems = 1
> +};
> -- 
> 2.38.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
