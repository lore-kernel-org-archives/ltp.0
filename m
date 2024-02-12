Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AADC48297
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 15:13:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B4893CF3DE
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 16:13:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8409D3CDE06
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 16:13:05 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16DAB648702
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 16:13:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1E33721F80;
 Mon, 12 Feb 2024 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707750784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mguQoXrLnlgsy6praQ9OE/YmZr4KaVsx6uZPCoR6+o=;
 b=guRJxzJR4YHQw4mDcijLqCLo7C4DUak3Th4vR8Iu76kqtbKtzLJhGwZ+p71joZs2Yd9gd+
 fsV1r2xzTYlOOwd7UitlEwVkJyeKp/lJxhxYgecczcCrxeOC1yCq3Y71NM/DWswLhEXQg7
 KDhaShPMykGOYAn+cDQ/ZziRjjwuqVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707750784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mguQoXrLnlgsy6praQ9OE/YmZr4KaVsx6uZPCoR6+o=;
 b=Gy3Vpr4e4sAI/QzoegvcjSoQ+sUOkP4D/rGBgnlXD508Di1KG0Y3sgGwdw0TMGJdvB0CjC
 8u2IKhVzmPpy9yDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707750784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mguQoXrLnlgsy6praQ9OE/YmZr4KaVsx6uZPCoR6+o=;
 b=guRJxzJR4YHQw4mDcijLqCLo7C4DUak3Th4vR8Iu76kqtbKtzLJhGwZ+p71joZs2Yd9gd+
 fsV1r2xzTYlOOwd7UitlEwVkJyeKp/lJxhxYgecczcCrxeOC1yCq3Y71NM/DWswLhEXQg7
 KDhaShPMykGOYAn+cDQ/ZziRjjwuqVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707750784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1mguQoXrLnlgsy6praQ9OE/YmZr4KaVsx6uZPCoR6+o=;
 b=Gy3Vpr4e4sAI/QzoegvcjSoQ+sUOkP4D/rGBgnlXD508Di1KG0Y3sgGwdw0TMGJdvB0CjC
 8u2IKhVzmPpy9yDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B33413985;
 Mon, 12 Feb 2024 15:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4TfBAYA1ymW2XwAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 12 Feb 2024 15:13:04 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 12 Feb 2024 16:13:03 +0100
Message-ID: <3554995.dWV9SEqChM@localhost>
Organization: SUSE
In-Reply-To: <20240205051230.6272-1-xuyang2018.jy@fujitsu.com>
References: <20240205051230.6272-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=guRJxzJR;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gy3Vpr4e
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-7.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 DWL_DNSWL_HI(-3.50)[suse.de:dkim]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 1E33721F80
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] mremap02: Convert to new API
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

Hello Yang,

On Monday, February 5, 2024 6:12:28 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mremap/mremap02.c | 186 ++++----------------
>  1 file changed, 37 insertions(+), 149 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/mremap02.c
> b/testcases/kernel/syscalls/mremap/mremap02.c index 2dabc6847..ff46462d9
> 100644
> --- a/testcases/kernel/syscalls/mremap/mremap02.c
> +++ b/testcases/kernel/syscalls/mremap/mremap02.c
> @@ -1,162 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *
> - *   Copyright (c) International Business Machines  Corp., 2001
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA + * Copyright (c) International Business Machines  Corp.,
> 2001
> + * Copyright (c) Linux Test Project, 2001-2024
>   */
> 
> -/*
> - * Test Name: mremap02
> - *
> - * Test Description:
> - *  Verify that,
> - *   mremap() fails when used to expand the existing virtual memory mapped
> - *   region to the requested size, if the virtual memory area previously
> - *   mapped was not page aligned or invalid argument specified.
> - *
> - * Expected Result:
> - *  mremap() should return -1 and set errno to EINVAL.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *	if errno set == expected errno
> - *		Issue sys call fails with expected return value and errno.
> - *	Otherwise,
> - *		Issue sys call fails with unexpected errno.
> - *   Otherwise,
> - *	Issue sys call returns unexpected value.
> - *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> +/*\
> + * [Description]
>   *
> - * Usage:  <for command-line>
> - *  mremap02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *	       -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -p x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> + * Test for EINVAL error.
>   *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
We need to keep the original author details.
> - *
> - *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
> - *      Modified.
> - *      - #include <linux/mman.h> should not be included as per man page
> for - *        mremap, #include <sys/mman.h> alone should do the job. But
> inorder - *        to include definition of MREMAP_MAYMOVE defined in
> bits/mman.h - *        (included by sys/mman.h) __USE_GNU needs to be
> defined. - *        There may be a more elegant way of doing this...
> - *
> - *
> - * RESTRICTIONS:
> - *  None.
> + * - mremap fail with virtual memory area previously mapped was not page
> aligned + *   or invalid argument specified.
this description isn't clear which EINVAL scenario we want to test here.
 
>   */
> +
>  #define _GNU_SOURCE
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
>  #include <sys/mman.h>
> +#include "tst_test.h"
> 
> -#include "test.h"
> -
> -char *TCID = "mremap02";
> -int TST_TOTAL = 1;
> -char *addr;			/* addr of memory mapped region */
> -int memsize;			/* memory mapped size */
> -int newsize;			/* new size of virtual memory block */
> +static char *addr;			/* addr of memory mapped region */
> +static int memsize;			/* memory mapped size */
> +static int newsize;			/* new size of virtual memory block */
we can get rid of obvious comments from here and everywhere below.
> 
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -int main(int ac, char **av)
> +static void verify_mremap(void)
>  {
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +	errno = 0;
> +	addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
> +	TST_ERR = errno;
> 
> -		tst_count = 0;
> +	/* Check for the return value of mremap() */
> +	if (addr != MAP_FAILED) {
> +		tst_res(TFAIL | TTERRNO,
> +			 "mremap returned invalid value, expected: -1");
> 
> -		/*
> -		 * Attempt to expand the existing mapped
> -		 * memory region (memsize) by newsize limits using
> -		 * mremap() should fail as old virtual address is not
> -		 * page aligned.
> -		 */
> -		errno = 0;
> -		addr = mremap(addr, memsize, newsize, MREMAP_MAYMOVE);
> -		TEST_ERRNO = errno;
> -
> -		/* Check for the return value of mremap() */
> -		if (addr != MAP_FAILED) {
> -			tst_resm(TFAIL,
> -				 "mremap returned invalid value, expected: -1");
> -
> -			/* Unmap the mapped memory region */
> -			if (munmap(addr, newsize) != 0) {
> -				tst_brkm(TBROK, cleanup, "munmap fails to "
> -					 "unmap the expanded memory region, "
> -					 "error=%d", errno);
> -			}
> -			continue;
> -		}
> -
> -		if (errno == EINVAL) {
> -			tst_resm(TPASS, "mremap() Failed, 'invalid argument "
> -				 "specified' - errno %d", TEST_ERRNO);
> -		} else {
> -			tst_resm(TFAIL, "mremap() Failed, "
> -				 "'Unexpected errno %d", TEST_ERRNO);
> -		}
> +		/* Unmap the mapped memory region */
> +		SAFE_MUNMAP(addr, newsize);
>  	}
> 
> -	cleanup();
> -	tst_exit();
> -
> +	if (errno == EINVAL) {
> +		tst_res(TPASS | TTERRNO, "mremap() Failed, 'invalid argument "
> +			 "specified' - errno %d", TST_ERR);
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "mremap() Failed, "
> +			 "'Unexpected errno %d", TST_ERR);
> +	}
>  }
> 
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - * Get system page size, Set the size of virtual memory area and the
> - * new size after resize, Set the virtual memory address such that it
> - * is not aligned.
> - */
> -void setup(void)
> -{
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> 
> +static void setup(void)
> +{
>  	/* Get the system page size */
>  	if ((memsize = getpagesize()) < 0) {
> -		tst_brkm(TFAIL, NULL,
> -			 "getpagesize() fails to get system page size");
> +		tst_brk(TBROK | TTERRNO, "getpagesize() fails to get system page size");
>  	}
maybe we should use -
SAFE_SYSCONF(_SC_PAGESIZE)

> 
>  	/* Get the New size of virtual memory block after resize */
> @@ -166,13 +60,7 @@ void setup(void)
>  	addr = (char *)(addr + (memsize - 1));
looks like we are trying to have an old_address which is not page  aligned,
but first of all, shouldn't old_address have an existing mapping for to be
used in mremap() call.

>  }
> 
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -
> -	/* Exit the program */
> -
> -}
> +static struct tst_test test = {
> +	.test_all = verify_mremap,
> +	.setup = setup,
> +};

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
