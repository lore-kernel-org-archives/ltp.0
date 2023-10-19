Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00710CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 08:24:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC2603CD0A2
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 10:24:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65E1B3CD06A
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:24:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3CDAD601E9A
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 10:24:11 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id CADB92185E;
 Thu, 19 Oct 2023 08:24:10 +0000 (UTC)
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 6DB252C4B6;
 Thu, 19 Oct 2023 08:24:10 +0000 (UTC)
References: <20230911094043.25511-1-andrea.cervesato@suse.de>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 19 Oct 2023 08:53:23 +0100
Organization: Linux Private Site
In-reply-to: <20230911094043.25511-1-andrea.cervesato@suse.de>
Message-ID: <87edhrvx3r.fsf@suse.de>
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-0.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[]; VIOLATED_DIRECT_SPF(3.50)[];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCVD_NO_TLS_LAST(0.10)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(0.20)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FORGED_RECIPIENTS(2.00)[m:andrea.cervesato@suse.de,
 s:andrea.cervesato@suse.com]
X-Rspamd-Queue-Id: CADB92185E
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor getdtablesize01 using new LTP API
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

Andrea Cervesato <andrea.cervesato@suse.de> writes:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../syscalls/getdtablesize/getdtablesize01.c  | 146 +++++++-----------
>  1 file changed, 52 insertions(+), 94 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> index d25cac261..80321e24f 100644
> --- a/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> +++ b/testcases/kernel/syscalls/getdtablesize/getdtablesize01.c
> @@ -1,119 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) International Business Machines  Corp., 2005
>   * Copyright (c) Wipro Technologies Ltd, 2005.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + *     Prashant P Yendigeri <prashant.yendigeri@wipro.com>
> + *     Robbie Williamson <robbiew@us.ibm.com>
> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
> -/**********************************************************
> - *
> - *    TEST IDENTIFIER   : getdtablesize01
> - *
> - *    EXECUTED BY       : root / superuser
> - *
> - *    TEST TITLE        : Basic tests for getdtablesize01(2)
> - *
> - *    TEST CASE TOTAL   : 1
> - *
> - *    AUTHOR            : Prashant P Yendigeri
> - *                        <prashant.yendigeri@wipro.com>
> - *                        Robbie Williamson
> - *                        <robbiew@us.ibm.com>
> - *
> - *    DESCRIPTION
> - *      This is a Phase I test for the getdtablesize01(2) system call.
> - *      It is intended to provide a limited exposure of the system
> call.

It seems this test has been broken for a long time unless I am
mistaken. glibc does not call the actual syscall, it calls
prlimit. Which has different behaviour (see below).

> - *
> - **********************************************************/
>  
> -#include <stdio.h>
> -#include <errno.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <fcntl.h>
> -#include <sys/time.h>
> -#include <sys/resource.h>
> -#include <unistd.h>
> -#include "test.h"
> +/*\
> + * [Description]
> + *
> + * This test verifies that getdtablesize() syscall returns the right max number
> + * of files which can be opened by a process. We test this in 2 ways: firstly by
> + * comparing its return value with RLIMIT_NOFILE, secondly by opening as many
> + * files as possible and then checking when open() raises EMFILE.
> + */
>  
> -void setup();
> -void cleanup();
> +#include <stdlib.h>
> +#include "tst_test.h"
>  
> -char *TCID = "getdtablesize01";
> -int TST_TOTAL = 1;
> +#define FILENAME "rofile"
>  
> -int main(void)
> +static void run(void)
>  {
> -	int table_size, fd = 0, count = 0;
> -	int max_val_opfiles;
> +	int *fds;
> +	int overfd;
> +	int open_files;
>  	struct rlimit rlp;
>  
> -	setup();
> -	table_size = getdtablesize();
> -	getrlimit(RLIMIT_NOFILE, &rlp);
> -	max_val_opfiles = (rlim_t) rlp.rlim_cur;
> -
> -	tst_resm(TINFO,
> -		 "Maximum number of files a process can have opened is %d",
> -		 table_size);
> -	tst_resm(TINFO,
> -		 "Checking with the value returned by getrlimit...RLIMIT_NOFILE");
> -
> -	if (table_size == max_val_opfiles)
> -		tst_resm(TPASS, "got correct dtablesize, value is %d",
> -			 max_val_opfiles);
> -	else {
> -		tst_resm(TFAIL, "got incorrect table size, value is %d",
> -			 max_val_opfiles);
> -		cleanup();
> -	}
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlp);
> +
> +	TST_EXP_EQ_LI(getdtablesize(), rlp.rlim_cur);

The actual syscall may not be equal to the prlimit AFAICT (this can be
tested using the prlimit command).

The table size can be set with a system wide sysctl /proc/sys/fs/nr_open
defined in fs/file_table.c. This is used to set the initial prlimit, but
can be reduced.

> +
> +	tst_res(TINFO, "Start opening as many files as possible");
> +
> +	overfd = rlp.rlim_cur + 5;
>  
> -	tst_resm(TINFO,
> -		 "Checking Max num of files that can be opened by a process.Should be: RLIMIT_NOFILE - 1");
> -	for (;;) {
> -		fd = open("/etc/hosts", O_RDONLY);
> +	fds = (int *)SAFE_MALLOC(overfd * sizeof(int));
>  
> -		if (fd == -1)
> +	for (open_files = 0; open_files < overfd; open_files++) {
> +		TEST(open(FILENAME, O_RDONLY));
> +
> +		if (TST_RET == -1 && TST_ERR == EMFILE) {

This could also fail with ENOMEM at least. Especially in a memcg and
arch with large page sizes if there are any page sized allocations.

Perhaps on some FS there would be other limits as well, resulting in a
different error, but you can ignore that for now if you want.

> +			tst_res(TINFO, "Reached max amount of open files per process");
>  			break;
> -		count = fd;
> +		}
>  
> -#ifdef DEBUG
> -		printf("Opened file num %d\n", fd);
> -#endif
> +		fds[open_files] = TST_RET;
>  	}
>  
> -//Now the max files opened should be RLIMIT_NOFILE - 1 , why ? read getdtablesize man page
> +	--open_files;
>  
> -	if (count > 0)
> -		close(count);
> -	if (count == (max_val_opfiles - 1))
> -		tst_resm(TPASS, "%d = %d", count, (max_val_opfiles - 1));
> -	else if (fd < 0 && errno == ENFILE)
> -		tst_brkm(TCONF, cleanup, "Reached maximum number of open files for the system");
> -	else
> -		tst_resm(TFAIL, "%d != %d", count, (max_val_opfiles - 1));
> +	tst_res(TINFO, "Opened %d files", open_files);
>  
> -	cleanup();
> -	tst_exit();
> -}
> +	for (int i = 0; i <= open_files; i++)
> +		SAFE_CLOSE(fds[i]);
>  
> -void setup(void)
> -{
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> +	free(fds);
>  
> -	TEST_PAUSE;
> +	TST_EXP_EXPR(getdtablesize() >= open_files,
> +		"max amount of open files per process hasn't been overflowed");
>  }
>  
> -void cleanup(void)
> +static void setup(void)
>  {
> +	int fd;
> +
> +	fd = SAFE_CREAT(FILENAME, 0644);
> +	SAFE_CLOSE(fd);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_tmpdir = 1,

This tests the underlying file system to some extent, so we should test
all available file systems.

> +};
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
