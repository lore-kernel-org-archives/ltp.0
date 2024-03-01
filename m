Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4215C5475B
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 12:31:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 406243D0E62
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 13:31:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39F923CECFC
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 13:31:21 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 740286275B3
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 13:31:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C22920356;
 Fri,  1 Mar 2024 12:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709296279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ekn5rW8m15nDb80ndfHufpda11doLdeq/xWwfQQGOoA=;
 b=ABNdvu1ZLttMs/uGoSYjPWoinletarF7s/Fid/5QWeX1+HHheTjqLGrbwA0TKpTMQsfgfo
 8WNGVMm6ux6/vhYJ5twW2ATPcdqD9d8+oFGbBtB07RgB/c9vAS021i+T5lYEapZfIOXOOg
 HFyUI1tbZUJtH3axNIf+PsCD8N9nrGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709296279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ekn5rW8m15nDb80ndfHufpda11doLdeq/xWwfQQGOoA=;
 b=m9do6hC+bFPw22YA+VacT567UOx6bRVWKFxl/oELn1W9gRa2IDIi72dMH1hNw8YuGod84u
 DCw3hRG2Czp/JJBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709296279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ekn5rW8m15nDb80ndfHufpda11doLdeq/xWwfQQGOoA=;
 b=ABNdvu1ZLttMs/uGoSYjPWoinletarF7s/Fid/5QWeX1+HHheTjqLGrbwA0TKpTMQsfgfo
 8WNGVMm6ux6/vhYJ5twW2ATPcdqD9d8+oFGbBtB07RgB/c9vAS021i+T5lYEapZfIOXOOg
 HFyUI1tbZUJtH3axNIf+PsCD8N9nrGU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709296279;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ekn5rW8m15nDb80ndfHufpda11doLdeq/xWwfQQGOoA=;
 b=m9do6hC+bFPw22YA+VacT567UOx6bRVWKFxl/oELn1W9gRa2IDIi72dMH1hNw8YuGod84u
 DCw3hRG2Czp/JJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42D8913A59;
 Fri,  1 Mar 2024 12:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sBQIEJfK4WXVTQAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 01 Mar 2024 12:31:19 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 01 Mar 2024 13:31:19 +0100
Message-ID: <2016088.hmA9HfebgN@localhost>
Organization: SUSE
In-Reply-To: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
References: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ABNdvu1Z;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m9do6hC+
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 4C22920356
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] mremap02: Convert to new API
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

On Tuesday, February 27, 2024 9:42:42 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mremap/mremap02.c | 195 ++++----------------
>  1 file changed, 40 insertions(+), 155 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/mremap02.c
> b/testcases/kernel/syscalls/mremap/mremap02.c index 2dabc6847..9e4a67c79
> 100644
> --- a/testcases/kernel/syscalls/mremap/mremap02.c
> +++ b/testcases/kernel/syscalls/mremap/mremap02.c
> @@ -1,178 +1,63 @@
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
> + * 07/2001 Ported by Wayne Boyer
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
> aligned. */
> -#define _GNU_SOURCE
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/mman.h>
> -
> -#include "test.h"
> 
> -char *TCID = "mremap02";
> -int TST_TOTAL = 1;
> -char *addr;			/* addr of memory mapped region */
> -int memsize;			/* memory mapped size */
> -int newsize;			/* new size of virtual memory block */
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> 
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> +static char *addr;
> +static int memsize;
> +static int newsize;
> 
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
> -
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
should be - "expected: (void *)-1"
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
> +	if (addr != MAP_FAILED) {
> +		tst_res(TFAIL | TTERRNO,
> +			 "mremap returned invalid value, expected: -1");
>  	}
> 
> -	cleanup();
> -	tst_exit();
> -
> +	if (errno == EINVAL) {
> +		tst_res(TPASS | TTERRNO, "mremap() Failed, 'invalid argument "
> +			 "specified' - errno %d", TST_ERR);
I think, 'errno %d", TST_ERR)' is not required if we are using TTERRNO here.

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
> 
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	/* Get the system page size */
> -	if ((memsize = getpagesize()) < 0) {
> -		tst_brkm(TFAIL, NULL,
> -			 "getpagesize() fails to get system page size");
> -	}
> -
> -	/* Get the New size of virtual memory block after resize */
> +static void setup(void)
> +{
> +	memsize = SAFE_SYSCONF(_SC_PAGESIZE);
> +	addr = SAFE_MMAP(NULL, memsize, PROT_WRITE,
> +			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
>  	newsize = (memsize * 2);
> -
> -	/* Set the old virtual memory address */
>  	addr = (char *)(addr + (memsize - 1));
We should use a different variable and not overwrite addr so we can
successfully munmap in cleanup().
>  }
> 
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -
> -	/* Exit the program */
> +	if (addr != MAP_FAILED)
> +		SAFE_MUNMAP(addr, newsize);
we need to unmap the original mapping which we did in setup() and if the
testcase is failing (remap() somehow succeeds) then we need to munmap the
new mapping inside the main test function.

> 
>  }
> +static struct tst_test test = {
> +	.test_all = verify_mremap,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};


Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
