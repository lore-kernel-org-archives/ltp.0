Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B0A4C5478C
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 13:07:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10823D1929
	for <ltp@archiver.kernel.org>; Fri,  1 Mar 2024 14:07:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38A093D02DF
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 14:06:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 94E441009BFC
 for <ltp@lists.linux.it>; Fri,  1 Mar 2024 14:06:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E432320400;
 Fri,  1 Mar 2024 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709298409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfFqx8RuooedxbApngzbvR9wKhSY1N+O295imXkE69c=;
 b=wOSBh+JBu4msFVKVgZRluNv2Kj7KwAGp/Fy9WvUf1QmLVIUgGdkSlcv+jBfIlaPLe1cBHj
 hVHzS+CFQpIjH8TEEdxmUst46bNfZ6O54HF/R1ntnib/bcLJ4ci90RtjgXxOa4H2rV6e0J
 RUFSvTqHiD0Meub0GQMpV5kwmkYSnEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709298409;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfFqx8RuooedxbApngzbvR9wKhSY1N+O295imXkE69c=;
 b=3sGwbxRUrUgR9Q58t2DVOnCXn+X10hAXDBVOGV6plXt20VCdqv42Sh3hS+tCW9i0bd9Ffd
 X4D72VzEL4O8wpBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709298408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfFqx8RuooedxbApngzbvR9wKhSY1N+O295imXkE69c=;
 b=GPYHCUsRI8dSaoAhwG9zQvNFyFYZbZmlIUsT8cTBbCwyq6xccgcAlntpRVK1F2YX82FXCQ
 Z9t9ups/hqKF0P/T3ffQHc7javSp+32HLRBwzxNuz/CvqCytBdydvbo5EFPPLrYbXTvCCI
 b2SteNxMW2K63haCcIo1361CCgL3LoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709298408;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=bfFqx8RuooedxbApngzbvR9wKhSY1N+O295imXkE69c=;
 b=OpUb8qAzMtwk4pXw5ZoVC3IXke4Z8bRrsPI34PHF7YDDQe2Sig0QKVZUHCxrWA3Q2P+EL3
 FstiIxeJPaZl6oBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D336B13A59;
 Fri,  1 Mar 2024 13:06:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rp4wM+jS4WXQVgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 01 Mar 2024 13:06:48 +0000
Message-ID: <e6dc9079-7285-4313-97ee-194e7297ba3c@suse.cz>
Date: Fri, 1 Mar 2024 14:06:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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
In-Reply-To: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; XM_UA_NO_VERSION(0.01)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
some suggestions below.

On 27. 02. 24 9:42, Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   testcases/kernel/syscalls/mremap/mremap02.c | 195 ++++----------------
>   1 file changed, 40 insertions(+), 155 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/mremap02.c b/testcases/kernel/syscalls/mremap/mremap02.c
> index 2dabc6847..9e4a67c79 100644
> --- a/testcases/kernel/syscalls/mremap/mremap02.c
> +++ b/testcases/kernel/syscalls/mremap/mremap02.c
> @@ -1,178 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
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
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2001-2024
> + * 07/2001 Ported by Wayne Boyer
>    */
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
>    *
> - * Usage:  <for command-line>
> - *  mremap02 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *	       -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -p x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> + * Test for EINVAL error.
>    *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> - *
> - *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
> - *      Modified.
> - *      - #include <linux/mman.h> should not be included as per man page for
> - *        mremap, #include <sys/mman.h> alone should do the job. But inorder
> - *        to include definition of MREMAP_MAYMOVE defined in bits/mman.h
> - *        (included by sys/mman.h) __USE_GNU needs to be defined.
> - *        There may be a more elegant way of doing this...
> - *
> - *
> - * RESTRICTIONS:
> - *  None.
> + * - mremap fail with virtual memory area previously mapped was not page aligned.
>    */
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
>   {
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

You can simply use TESTPTR(mremap(...)); here and then check TST_RET_PTR 
value. That macro will handle errno for you.

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

The expected value is MAP_FAILED. It's value might theoretically be 
different from -1.

Also, you should unmap the new mapping here, set addr = MAP_FAILED; and 
return from the function. The errno checks are pointless if the call 
succeeded.

You should also consider either using tst_brk(TBROK) here or moving the 
initial SAFE_MMAP() from setup() to the start of this function. 
Otherwise when the test runs in multiple loops (-i/-I parameters), a 
successful mremap() will break the test mapping for all further loops.

>   	}
>   
> -	cleanup();
> -	tst_exit();
> -
> +	if (errno == EINVAL) {

You want to check TST_ERR here.

> +		tst_res(TPASS | TTERRNO, "mremap() Failed, 'invalid argument "
> +			 "specified' - errno %d", TST_ERR);

tst_res() will print the error code and name automatically when you pass 
the TTERRNO flag.

> +	} else {
> +		tst_res(TFAIL | TTERRNO, "mremap() Failed, "
> +			 "'Unexpected errno %d", TST_ERR);
> +	}
>   }
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
>   	newsize = (memsize * 2);
> -
> -	/* Set the old virtual memory address */
>   	addr = (char *)(addr + (memsize - 1));

You should keep the original pointer for cleanup(). It'd be much better 
to explicitly call mremap(addr + offset, ...) in the main test function.

>   }
>   
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>   {
> -
> -	/* Exit the program */
> +	if (addr != MAP_FAILED)
> +		SAFE_MUNMAP(addr, newsize);

This should be SAFE_MUNMAP(addr, memsize); The mapping size is not 
supposed to change during the test and the next page may also be mapped 
e.g. by libc.

>   
>   }
> +static struct tst_test test = {
> +	.test_all = verify_mremap,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
