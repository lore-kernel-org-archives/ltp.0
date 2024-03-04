Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7787AC5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 19:50:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7B553D025B
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 20:50:18 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F16C3CE03A
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 20:50:02 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 50C6D1400DA5
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 20:50:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B587433EC4;
 Mon,  4 Mar 2024 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709581799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3RdV1uoDDwkPHNfD7T9Bq1K9XZRL+Rvnj6vA2yjt/w=;
 b=1OJzm/OMWq/pdFhBFJ0QCdjuBT+DqO8x7xXKjjx3kx101tL5nqjY9TMyp1OGqs6AyeHlBg
 6qMYuk3zhwWblBzsl2cdoRoiBRNIahN5PtpWtRMls42fH++0YCLqGBnVTdmWT7YHXmAEh7
 ApxfwSg6uVJCKiIIbL3vq8F916w4NN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709581799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3RdV1uoDDwkPHNfD7T9Bq1K9XZRL+Rvnj6vA2yjt/w=;
 b=oflbDeSS0x3PIqtin7uV8dbyx1krNxEp3DCrOpzmOgzIuqxTAo4p/LvpyQClYDQz16xY5i
 4KcTgs5xEoDuetDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709581799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3RdV1uoDDwkPHNfD7T9Bq1K9XZRL+Rvnj6vA2yjt/w=;
 b=1OJzm/OMWq/pdFhBFJ0QCdjuBT+DqO8x7xXKjjx3kx101tL5nqjY9TMyp1OGqs6AyeHlBg
 6qMYuk3zhwWblBzsl2cdoRoiBRNIahN5PtpWtRMls42fH++0YCLqGBnVTdmWT7YHXmAEh7
 ApxfwSg6uVJCKiIIbL3vq8F916w4NN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709581799;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3RdV1uoDDwkPHNfD7T9Bq1K9XZRL+Rvnj6vA2yjt/w=;
 b=oflbDeSS0x3PIqtin7uV8dbyx1krNxEp3DCrOpzmOgzIuqxTAo4p/LvpyQClYDQz16xY5i
 4KcTgs5xEoDuetDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2C1213A58;
 Mon,  4 Mar 2024 19:49:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Nk0AJ+cl5mXRNAAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 04 Mar 2024 19:49:59 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 04 Mar 2024 20:49:59 +0100
Message-ID: <2291379.OWHZQNyeAm@localhost>
Organization: SUSE
In-Reply-To: <20240227084244.33662-2-xuyang2018.jy@fujitsu.com>
References: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
 <20240227084244.33662-2-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] mremap03: Convert to new API
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

Hi Yang Xu,
some comments below.

On Tuesday, February 27, 2024 9:42:43 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mremap/mremap03.c | 201 ++++----------------
>  1 file changed, 39 insertions(+), 162 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/mremap03.c
> b/testcases/kernel/syscalls/mremap/mremap03.c index 02b79bc47..4e55dbda6
> 100644
> --- a/testcases/kernel/syscalls/mremap/mremap03.c
> +++ b/testcases/kernel/syscalls/mremap/mremap03.c
> @@ -1,187 +1,64 @@
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
> - * Test Name: mremap03
> - *
> - * Test Description:
> - *  Verify that,
> - *   mremap() fails when used to expand the existing virtual memory mapped
> - *   region to the requested size, if there already exists mappings that
> - *   cover the whole address space requsted or the old address specified
> was - *   not mapped.
> - *
> - * Expected Result:
> - *  mremap() should return -1 and set errno to EFAULT.
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
> - *  mremap03 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -p x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> + * Test for EFAULT error.
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
> + * - mremap fail with the old address specified was not mapped.
>   */
> -#define _GNU_SOURCE
> -#include <errno.h>
> -#include <unistd.h>
> -#include <fcntl.h>
> -#include <sys/mman.h>
> 
> -#include "test.h"
> +#define _GNU_SOURCE
> +#include "tst_test.h"
> 
> -char *TCID = "mremap03";
> -int TST_TOTAL = 1;
>  static char *bad_addr;
> -static char *addr;		/* addr of memory mapped region */
> -int memsize;			/* memory mapped size */
> -int newsize;			/* new size of virtual memory block */
> +static char *addr;
> +static int memsize;
> +static int newsize;
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
> -
> -		tst_count = 0;
> +	errno = 0;
> +	addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
> +	TST_ERR = errno;
We can simplify by using TESTPTR() macro.
> 
> -		/*
> -		 * Attempt to expand the existing mapped
> -		 * memory region (memsize) by newsize limits
> -		 * using mremap() should fail as specified old
> -		 * virtual address was not mapped.
> -		 */
> -		errno = 0;
> -		addr = mremap(bad_addr, memsize, newsize, MREMAP_MAYMOVE);
> -		TEST_ERRNO = errno;
> -
> -		/* Check for the return value of mremap() */
> -		if (addr != MAP_FAILED) {
> -			tst_resm(TFAIL,
> -				 "mremap returned invalid value, expected: -1");
> -
> -			/* Unmap the mapped memory region */
> -			if (munmap(addr, newsize) != 0) {
> -				tst_brkm(TFAIL, cleanup, "munmap fails to "
> -					 "unmap the expanded memory region, "
> -					 " error=%d", errno);
> -			}
> -			continue;
> -		}
> -
> -		/* Check for the expected errno */
> -		if (errno == EFAULT) {
> -			tst_resm(TPASS, "mremap() Fails, 'old region not "
> -				 "mapped', errno %d", TEST_ERRNO);
> -		} else {
> -			tst_resm(TFAIL, "mremap() Fails, "
> -				 "'Unexpected errno %d", TEST_ERRNO);
> -		}
> +	if (addr != MAP_FAILED) {
> +		tst_res(TFAIL | TTERRNO,
> +			"mremap returned invalid value, expected: -1");
>  	}
> 
> -	cleanup();
> -	tst_exit();
> -
> +	if (errno == EFAULT) {
> +		tst_res(TPASS | TTERRNO, "mremap() Failed, 'old region not "
> +				"mapped' - errno %d", TST_ERR);
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "mremap() Failed, "
> +				"'Unexpected errno %d", TST_ERR);
> +	}
>  }
> 
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - * Get system page size.
> - * Set the old address point some high address which is not mapped.
> - */
>  void setup(void)
missing static
>  {
> -	int page_sz;		/* system page size */
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	int page_sz;
> 
> -	/* Get the system page size */
> -	if ((page_sz = getpagesize()) < 0) {
> -		tst_brkm(TFAIL, NULL,
> -			 "getpagesize() fails to get system page size");
> -	}
> -
> -	/* Get the size of virtual memory area to be mapped */
> +	page_sz = SAFE_SYSCONF(_SC_PAGESIZE);
>  	memsize = (1000 * page_sz);
> -
> -	/* Get the New size of virtual memory block after resize */
>  	newsize = (memsize * 2);
> -
> -	/*
> -	 * Set the old virtual address point to some address
> -	 * which is not mapped.
> -	 */
> -	bad_addr = tst_get_bad_addr(cleanup);
> +	bad_addr = tst_get_bad_addr(NULL);
This would not count as a not-mapped address becasue tst_get_bad_addr()
creates a mapping with
bad_addr =  mmap(0, 1, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
which maps atleast one page.

But mremap() is still failing because we are passing a different address
range with old_size value as
memsize = (1000 * page_sz);

If we simply use "memsize = page_sz" here mremap() doesn't fail.

So I think, to use and address which is not mapped in the process's address
space, we can do a SAFE_MMAP() immediately followed by SAFE_MUNMAP() and
use that address for mremap() call.
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
> -
> +	if (addr != MAP_FAILED)
> +		SAFE_MUNMAP(addr, newsize);
>  }
> +
> +static struct tst_test test = {
> +	.test_all = verify_mremap,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
