Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A93C4332F
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 08:42:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B33A13CE4F7
	for <ltp@archiver.kernel.org>; Tue, 14 Nov 2023 09:42:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2983CC281
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 09:42:33 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 52E70200D16
 for <ltp@lists.linux.it>; Tue, 14 Nov 2023 09:42:31 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id C75C8218E2;
 Tue, 14 Nov 2023 08:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1699951350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShZIbI8cywnTA0esGPDETPuSzFf819kw5/pgd1kkyfc=;
 b=tMAqaxCZ/T5wRmWhvw87W4A+9w26HIJIOxDsew2nYrxhhNe+TRx0TfPC+IVcXXJ/G5V8tx
 EsPN9PLJHUTe1HdNsy34vAzbNSaqBQQEwFzTTl/vrYV9rv7vgSJp+b0kiYU91rXEeLJjW+
 y/+SgO9FEvF0TeZtkIx3FF0JpMEoAH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1699951350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShZIbI8cywnTA0esGPDETPuSzFf819kw5/pgd1kkyfc=;
 b=iy1fHjde6mVvswwYuPv3ryih5QnHMeCVVGpwLarK+UJ9VuFenlIK287TtwQTn2J20MO2M1
 OpZ1+pmLf+JS/XBg==
Received: from g78 (rpalethorpe.udp.ovpn2.prg.suse.de [10.100.204.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 623D62D085;
 Tue, 14 Nov 2023 08:42:30 +0000 (UTC)
References: <20230913100803.13756-1-akumar@suse.de>
 <20230913100803.13756-2-akumar@suse.de>
 <e73de656-9075-42d5-8d0a-b6951c28d603@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Tue, 14 Nov 2023 08:37:16 +0000
Organization: Linux Private Site
In-reply-to: <e73de656-9075-42d5-8d0a-b6951c28d603@suse.com>
Message-ID: <874jhobua2.fsf@suse.de>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de; dkim=none; dmarc=none;
 spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor
 denied by domain of rpalethorpe@suse.de) smtp.mailfrom=rpalethorpe@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-1.21 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[rpalethorpe@suse.de]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLYTO_ADDR_EQ_FROM(0.00)[]; DMARC_NA(0.20)[suse.de];
 R_SPF_SOFTFAIL(0.60)[~all:c]; HAS_ORG_HEADER(0.00)[];
 TO_MATCH_ENVRCPT_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MX_GOOD(-0.01)[]; VIOLATED_DIRECT_SPF(3.50)[];
 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 R_DKIM_NA(0.20)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: C75C8218E2
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/munmap02: Refactor the test using
 new LTP API
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

> Hi!
>
> munmap01 and munmap02 looks quite similar. The refactoring is good to
> me, but maybe we can merge them into a single test using 2 different
> test cases, where the first is mapping a certain portion of the file
> and the second an another.

Yes, these should be merged. Otherwise the rewrite looks good.

>
> Regards,
> Andrea
>
> On 9/13/23 12:08, Avinesh Kumar wrote:
>> Signed-off-by: Avinesh Kumar <akumar@suse.de>
>> ---
>>   testcases/kernel/syscalls/munmap/munmap02.c | 297 ++++----------------
>>   1 file changed, 55 insertions(+), 242 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
>> index b43250512..7c7fb5b2c 100644
>> --- a/testcases/kernel/syscalls/munmap/munmap02.c
>> +++ b/testcases/kernel/syscalls/munmap/munmap02.c
>> @@ -1,270 +1,83 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>> - *
>> - *   Copyright (c) International Business Machines  Corp., 2001
>> - *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> - *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> - *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * Copyright (c) International Business Machines  Corp., 2001
>> + *  07/2001 Ported by Wayne Boyer
>> + * Copyright (c) 2023 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
>>    */
>>   -/*
>> - * Test Name: munmap02
>> - *
>> - * Test Description:
>> - *  Verify that, munmap call will succeed to unmap a mapped file or
>> - *  anonymous shared memory region from the calling process's address space
>> - *  if the region specified by the address and the length is part or all of
>> - *  the mapped region.
>> - *
>> - * Expected Result:
>> - *  munmap call should succeed to unmap a part or all of mapped region of a
>> - *  file or anonymous shared memory from the process's address space and it
>> - *  returns with a value 0,
>> - *  further reference to the unmapped region should result in a segmentation
>> - *  fault (SIGSEGV).
>> +/*\
>> + * [Description]
>>    *
>> - * Algorithm:
>> - *  Setup:
>> - *   Setup signal handling.
>> - *   Create temporary directory.
>> - *   Pause for SIGUSR1 if option specified.
>> - *
>> - *  Test:
>> - *   Loop if the proper options are given.
>> - *   Execute system call
>> - *   Check return code, if system call failed (return=-1)
>> - *   	Log the errno and Issue a FAIL message.
>> - *   Otherwise,
>> - *   	Verify the Functionality of system call
>> - *      if successful,
>> - *      	Issue Functionality-Pass message.
>> - *      Otherwise,
>> - *		Issue Functionality-Fail message.
>> - *  Cleanup:
>> - *   Print errno log and/or timing stats if options given
>> - *   Delete the temporary directory created.
>> - *
>> - * Usage:  <for command-line>
>> - *  munmap01 [-c n] [-f] [-i n] [-I x] [-P x] [-t]
>> - *     where,  -c n : Run n copies concurrently.
>> - *             -f   : Turn off functionality Testing.
>> - *	       -i n : Execute test n times.
>> - *	       -I x : Execute test for x seconds.
>> - *	       -P x : Pause for x seconds between iterations.
>> - *	       -t   : Turn on syscall timing.
>> - *
>> - * HISTORY
>> - *	07/2001 Ported by Wayne Boyer
>> - *
>> - * RESTRICTIONS:
>> - *  None.
>> + * Verify that, munmap() call succeeds to unmap a mapped file region from
>> + * the calling process's address space when the region being unmapped is
>> + * only part of the total mapped region, and any attempt to access the
>> + * unmapped memory region generates SIGSEGV signal.
>>    */
>> -#include <errno.h>
>> -#include <unistd.h>
>> -#include <fcntl.h>
>> -#include <sys/stat.h>
>> -#include <sys/mman.h>
>> -
>> -#include "test.h"
>> -#include "safe_macros.h"
>> -
>> -#define TEMPFILE	"mmapfile"
>>   -char *TCID = "munmap02";
>> -int TST_TOTAL = 1;
>> +#include "tst_test.h"
>> +#include <setjmp.h>
>>   +#define TEMPFILE "mmapfile"
>> +static char *addr1, *addr2;
>> +static int fd;
>> +static volatile int sig_flag;
>> +static sigjmp_buf env;
>>   static size_t page_sz;
>> -char *addr;			/* addr of memory mapped region */
>> -int fildes;			/* file descriptor for tempfile */
>> -unsigned int map_len;		/* length of the region to be mapped */
>> +static unsigned int map_len;
>>   -void setup();			/* Main setup function of test
>> */
>> -void cleanup();			/* cleanup function for the test */
>> -void sig_handler();		/* signal catching function */
>> -
>> -#ifndef UCLINUX
>> -
>> -int main(int ac, char **av)
>> +static void sig_handler(int sig)
>>   {
>> -	int lc;
>> -
>> -	tst_parse_opts(ac, av, NULL, NULL);
>> -
>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>> -
>> -		tst_count = 0;
>> -
>> -		setup();
>> -
>> -		/*
>> -		 * Call munmap to unmap the part of the mapped region of the
>> -		 * temporary file from the address and length that is part of
>> -		 * the mapped region.
>> -		 */
>> -		TEST(munmap(addr, map_len));
>> -
>> -		/* Check for the return value of munmap() */
>> -		if (TEST_RETURN == -1) {
>> -			tst_resm(TFAIL, "munmap() fails, errno=%d : %s",
>> -				 TEST_ERRNO, strerror(TEST_ERRNO));
>> -			continue;
>> -		}
>> -		/*
>> -		 * Check whether further reference is possible
>> -		 * to the unmapped memory region by writing
>> -		 * to the first byte of region with
>> -		 * some arbitrary number.
>> -		 */
>> -		*addr = 50;
>> -
>> -		/* This message is printed if no SIGSEGV */
>> -		tst_resm(TFAIL, "process succeeds to refer unmapped "
>> -			 "memory region");
>> -		cleanup();
>> -
>> +	if (sig == SIGSEGV) {
>> +		sig_flag = 1;
>> +		siglongjmp(env, 1);
>>   	}
>> -	tst_exit();
>> -}
>> -
>> -#else
>> -
>> -int main(void)
>> -{
>> -	tst_resm(TINFO, "munmap02 test is not available on uClinux");
>> -	tst_exit();
>>   }
>>   -#endif /* ifndef UCLINUX */
>> -
>> -/*
>> - * setup() - performs all ONE TIME setup for this test.
>> - * Setup signal handler to catch SIGSEGV.
>> - * Get system page size, create a temporary file for reading/writing,
>> - * write one byte data into it, map the open file for the specified
>> - * map length.
>> - */
>> -void setup(void)
>> +static void setup(void)
>>   {
>> +	SAFE_SIGNAL(SIGSEGV, sig_handler);
>>   -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>> -
>> -	/* call signal function to trap the signal generated */
>> -	if (signal(SIGSEGV, sig_handler) == SIG_ERR) {
>> -		tst_brkm(TBROK, cleanup, "signal fails to catch signal");
>> -	}
>> -
>> -	TEST_PAUSE;
>> -
>> -	/* Get the system page size */
>>   	page_sz = getpagesize();
>> +	map_len = page_sz * 3;
>>   -	/*
>> -	 * Get the length of the open file to be mapped into process
>> -	 * address space.
>> -	 */
>> -	map_len = 3 * page_sz;
>> -
>> -	tst_tmpdir();
>> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
>> +	SAFE_LSEEK(fd, map_len, SEEK_SET);
>> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
>> +}
>>   -	/* Creat a temporary file used for mapping */
>> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
>> -		tst_brkm(TBROK, cleanup, "open() on %s Failed, errno=%d : %s",
>> -			 TEMPFILE, errno, strerror(errno));
>> -	}
>> +static void run(void)
>> +{
>> +	addr1 = SAFE_MMAP(NULL, map_len, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
>>   -	/*
>> -	 * move the file pointer to maplength position from the beginning
>> -	 * of the file.
>> -	 */
>> -	SAFE_LSEEK(cleanup, fildes, map_len, SEEK_SET);
>> +	addr2 = (char *)((long)addr1 + page_sz);
>> +	map_len = page_sz * 2;
>>   -	/* Write one byte into temporary file */
>> -	if (write(fildes, "a", 1) != 1) {
>> -		tst_brkm(TBROK, cleanup, "write() on %s Failed, errno=%d : %s",
>> -			 TEMPFILE, errno, strerror(errno));
>> -	}
>> +	TST_EXP_PASS(munmap(addr2, map_len));
>> +	if (TST_RET == -1)
>> +		return;
>>   -	/*
>> -	 * map the open file 'TEMPFILE' from its beginning up to the maplength
>> -	 * into the calling process's address space at the system choosen
>> -	 * with read/write permissions to the the mapped region.
>> -	 */
>> -#ifdef UCLINUX
>> -	/* mmap() doesn't support MAP_SHARED on uClinux */
>> -	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
>> -		    MAP_FILE | MAP_PRIVATE, fildes, 0);
>> -#else
>> -	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
>> -		    MAP_FILE | MAP_SHARED, fildes, 0);
>> -#endif
>> +	if (sigsetjmp(env, 1) == 0)
>> +		*addr2 = 50;
>>   -	/* check for the return value of mmap system call */
>> -	if (addr == (char *)MAP_FAILED) {
>> -		tst_brkm(TBROK, cleanup, "mmap() Failed on %s, errno=%d : %s",
>> -			 TEMPFILE, errno, strerror(errno));
>> -	}
>> +	if (sig_flag == 1)
>> +		tst_res(TPASS, "Received SIGSEGV signal");
>> +	else
>> +		tst_res(TFAIL, "SIGSEGV signal not received");
>>   -	/*
>> -	 * increment the start address of the region at which the file is
>> -	 * mapped to a maplength of 3 times the system page size by the value
>> -	 * of system  page size and decrement the maplength value by the value
>> -	 * of system page size.
>> -	 */
>> -	addr = (char *)((long)addr + page_sz);
>> -	map_len = map_len - page_sz;
>> +	SAFE_MUNMAP(addr1, page_sz);
>> +	map_len = page_sz * 3;
>> +	sig_flag = 0;
>>   }
>>   -/*
>> - * void
>> - * sig_handler() - signal catching function.
>> - *   This function is used to trap the signal generated when tried to read or
>> - *   write to the memory mapped region which is already detached from the
>> - *   calling process address space.
>> - *   this function is invoked when SIGSEGV generated and it calls test
>> - *   cleanup function and exit the program.
>> - */
>> -void sig_handler(void)
>> +static void cleanup(void)
>>   {
>> -	tst_resm(TPASS, "Functionality of munmap() successful");
>> -
>> -	/* Invoke test cleanup function and exit */
>> -	cleanup();
>> -
>> -	tst_exit();
>> +	if (fd > 0)
>> +		SAFE_CLOSE(fd);
>>   }
>>   -/*
>> - * cleanup() - performs all ONE TIME cleanup for this test at
>> - *             completion or premature exit.
>> - *  Unmap the portion of the region of the file left unmapped.
>> - *  Close the temporary file.
>> - *  Remove the temporary directory.
>> - */
>> -void cleanup(void)
>> -{
>> -
>> -	/*
>> -	 * get the start address and length of the portion of
>> -	 * the mapped region of the file.
>> -	 */
>> -	addr = (char *)((long)addr - page_sz);
>> -	map_len = map_len - page_sz;
>> -
>> -	/* unmap the portion of the region of the file left unmapped */
>> -	SAFE_MUNMAP(NULL, addr, map_len);
>> -
>> -	/* Close the temporary file */
>> -	SAFE_CLOSE(NULL, fildes);
>> -
>> -	tst_rmdir();
>> -}
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.needs_tmpdir = 1
>> +};


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
