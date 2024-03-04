Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7743FC48BF6
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 20:49:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFB373D0D1E
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 21:49:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF3CB3C26B9
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 21:49:17 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0138F20076E
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 21:49:16 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDD3020647;
 Mon,  4 Mar 2024 20:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709585356; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KIuhj+rY93Q09kbq6yQPY32e87U3BrignzWa3oxWjY=;
 b=ifp3fIbsg2ijMDXC4Ryj2IJ/yULt96zAG5YgLHqbYraaQ3HQqV4xmBV29+1TV1/5HlPDtG
 3pj+cNPH+xtzrnqC4V6phypSpmKgzY7/7GAKk36ZKq6mMZnQHkyyedPOPCLiAe0JQ/l1dW
 JJs78l/4yl+tG+Rat1F6KJxTaam8Egs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709585356;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KIuhj+rY93Q09kbq6yQPY32e87U3BrignzWa3oxWjY=;
 b=TJks+1lVxD/E7nqrBqzWfs0OqyTlJFcNhJGfHSe8fQ4eaG9Z7t9qlorGq1eUCLQB4kpxMS
 YmmDv7u+dpHANNAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709585355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KIuhj+rY93Q09kbq6yQPY32e87U3BrignzWa3oxWjY=;
 b=K4TdoJdlGhDlyKX97cPBYbTSwgNkYbGoe9as358j695F/ILMD7UpBSU3bgt2P7YDvr534A
 moENvu7VY8seBLsXqoibA7d8tsluGDzNZtWeTevPDiBigI6QTonxwP21IaCc3hfa3cak6w
 9uHrCiDIOx1V/viz81kRxlLwcv2nixI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709585355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1KIuhj+rY93Q09kbq6yQPY32e87U3BrignzWa3oxWjY=;
 b=sB9dLKI3oY3TYGHQ7x26+cuoStb0GudBt1mKNUzfNxw8i1BjB7YiH5c87GL4iIctVt1ELr
 TliodhWETocLazDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD26913A5B;
 Mon,  4 Mar 2024 20:49:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rHFvLcsz5mVQRAAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 04 Mar 2024 20:49:15 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Mon, 04 Mar 2024 21:49:15 +0100
Message-ID: <23747024.KVSFj4ZYQt@localhost>
Organization: SUSE
In-Reply-To: <20240227084244.33662-3-xuyang2018.jy@fujitsu.com>
References: <20240227084244.33662-1-xuyang2018.jy@fujitsu.com>
 <20240227084244.33662-3-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] mremap04: Convert to new API
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

Hi,

On Tuesday, February 27, 2024 9:42:44 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/mremap/Makefile   |   4 +-
>  testcases/kernel/syscalls/mremap/mremap04.c | 269 ++++----------------
>  2 files changed, 53 insertions(+), 220 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mremap/Makefile
> b/testcases/kernel/syscalls/mremap/Makefile index 190b7659d..f286dd9bf
> 100644
> --- a/testcases/kernel/syscalls/mremap/Makefile
> +++ b/testcases/kernel/syscalls/mremap/Makefile
> @@ -3,10 +3,10 @@
> 
>  top_srcdir		?= ../../../..
> 
> -LTPLIBS = ltpipc
> +LTPLIBS = ltpnewipc
> 
>  include $(top_srcdir)/include/mk/testcases.mk
> 
> -mremap04: LTPLDLIBS  = -lltpipc
> +mremap04: LTPLDLIBS  = -lltpnewipc
> 
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/mremap/mremap04.c
> b/testcases/kernel/syscalls/mremap/mremap04.c index 53902df73..8d819184e
> 100644
> --- a/testcases/kernel/syscalls/mremap/mremap04.c
> +++ b/testcases/kernel/syscalls/mremap/mremap04.c
> @@ -1,245 +1,78 @@
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
> - * Test Name: mremap04
> - *
> - * Test Description:
> - *  Verify that,
> - *   mremap() fails when used to expand the existing virtual memory mapped
> - *   region to the requested size, if the memory area cannot be expanded at
> - *   the current virtual address and MREMAP_MAYMOVE flag not set. - *
> - * Expected Result:
> - *  mremap() should return -1 and set errno to ENOMEM.
> - *
> - * Algorithm:
> - *  Setup:
> - *   Setup signal handling.
> - *   Create temporary directory.
> - *   Pause for SIGUSR1 if option specified.
> - *
> - *  Test:
> - *   Loop if the proper options are given.
> - *   Execute system call
> - *   Check return code, if system call failed (return=-1)
> - *	if errno set == expected errno
> - *		Issue sys call failed with expected return value and errno.
> - *	Otherwise,
> - *		Issue sys call failed with unexpected errno.
> - *   Otherwise,
> - *	Issue sys call returns unexpected value.
> - *
> - *  Cleanup:
> - *   Print errno log and/or timing stats if options given
> - *   Delete the temporary directory(s)/file(s) created.
> - *
> - * Usage:  <for command-line>
> - *  mremap04 [-c n] [-e] [-i n] [-I x] [-P x] [-t]
> - *     where,  -c n : Run n copies concurrently.
> - *             -e   : Turn on errno logging.
> - *	       -i n : Execute test n times.
> - *	       -I x : Execute test for x seconds.
> - *	       -p x : Pause for x seconds between iterations.
> - *	       -t   : Turn on syscall timing.
> - *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> +/*\
> + * [Description]
>   *
> - *      11/09/2001 Manoj Iyer (manjo@austin.ibm.com)
> - *      Modified.
> - *      - #include <linux/mman.h> should not be included as per man page
> for - *        mremap, #include <sys/mman.h> alone should do the job. But
> inorder - *        to include definition of MREMAP_MAYMOVE defined in
> bits/mman.h - *        (included by sys/mman.h) __USE_GNU needs to be
> defined. - *        There may be a more elegant way of doing this...
> + * Test for ENOMEM error.
>   *
> - *      26/02/2008 Renaud Lottiaux (Renaud.Lottiaux@kerlabs.com)
> - *      - Fix concurrency issue. Use a shm key from getipckey instead of
> - *        a fixed hard-coded value.
> - *
> - * RESTRICTIONS:
> - *  None.
> + * - mremap fail when the memory area cannot be expanded at the current
> virtual address + *   and MREMAP_MAYMOVE flag not set
>   */
> +
>  #define _GNU_SOURCE
> -#include <errno.h>
> -#include <unistd.h>
> -#include <sys/mman.h>
>  #include <sys/ipc.h>
>  #include <sys/shm.h>
> +#include "tst_test.h"
> +#include "libnewipc.h"
> +#include "tst_safe_sysv_ipc.h"
> 
> -#include "test.h"
> -
> -#define SHM_MODE	(SHM_R | SHM_W)	/* mode permissions of shared memory */
> +#define SHM_MODE (SHM_R | SHM_W)
> 
> -char *TCID = "mremap04";
> -int TST_TOTAL = 1;
> -char *addr;			/* addr of memory mapped region */
> -char *shmaddr;			/* pointer to shared memory segment */
> -int shmid;			/* shared memory identifier. */
> -int memsize;			/* memory mapped size */
> -int newsize;			/* new size of virtual memory block */
> +static char *addr;
> +static char *shmaddr;
> +static int shm_id;
> +static int memsize;
> +static int newsize;
> 
> -void setup();			/* Main setup function of test */
> -void cleanup();			/* cleanup function for the test */
> -
> -extern int getipckey();
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
> -
> -		/*
> -		 * Attempt to expand the existing shared
> -		 * memory region of newsize by newsize limits
> -		 * using mremap() should fail as specified
> -		 * memory area already locked and MREMAP_MAYMOVE
> -		 * flag unset.
> -		 */
> -		errno = 0;
> -		addr = mremap(shmaddr, memsize, newsize, 0);
> -		TEST_ERRNO = errno;
> -
> -		/* Check for the return value of mremap() */
> -		if (addr != MAP_FAILED) {
> -			tst_resm(TFAIL,
> -				 "mremap returned invalid value, expected: -1");
> -
> -			/* Unmap the mapped memory region */
> -			if (munmap(addr, newsize) != 0) {
> -				tst_brkm(TFAIL, cleanup, "munmap failed to "
> -					 "unmap the expanded memory region, "
> -					 "error=%d", errno);
> -			}
> -			continue;
> -		}
> +	errno = 0;
> +	addr = mremap(shmaddr, memsize, newsize, 0);
If mremap() call somehow passes, further test iterations would be broken as
there will be no mapping at shmaddr. So I think we need to move the code for
setting up shared memory mapping from setup() to main test function.

> +	TST_ERR = errno;
We can use TESTPRT() macro.
> 
> -		if (TEST_ERRNO == ENOMEM) {
> -			tst_resm(TPASS, "mremap() failed, "
> -				 "'MREMAP_MAYMOVE flag unset', "
> -				 "errno %d", TEST_ERRNO);
> -		} else {
> -			tst_resm(TFAIL, "mremap() failed, "
> -				 "Unexpected errno %d", TEST_ERRNO);
> -		}
> +	if (addr != MAP_FAILED) {
> +		tst_res(TFAIL | TTERRNO,
> +			 "mremap returned invalid value, expected: -1");
we should return here if mremap() was successful.
>  	}
> 
> -	cleanup();
> -	tst_exit();
> -
> +	if (TST_ERR == ENOMEM) {
> +		tst_res(TPASS | TTERRNO, "mremap() failed, "
> +			 "'MREMAP_MAYMOVE flag unset', "
> +			 "errno %d", TST_ERR);
tst_res() with TTERRNO will take care of printing the errno.
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "mremap() failed, "
> +			 "Unexpected errno %d", TST_ERR);
> +	}
>  }
> 
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - * Get system page size, Set the size of virtual memory area and the
> - * newsize after resize,
> - * Create a named shared memory segment SHMKEY of newsize and mode SHM_MODE
> - * by using shmget() which returns a shared memory identifier associated -
> * with the created shared memory segment.
> - * Call shmat() to attach the shared memory segment to the data segment of
> the - * calling process. The segment is attached at the first available
> address as - * selected by the system.
> - */
> -void setup(void)
> +static void setup(void)
>  {
>  	key_t shmkey;
> 
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> -
> -	tst_tmpdir();
> -
> -	/* Get the system page size */
> -	if ((memsize = getpagesize()) < 0) {
> -		tst_brkm(TBROK, NULL,
> -			 "getpagesize() failed to get system page size");
> -	}
> -
> -	/* Get the New size of virtual memory block after resize */
> +	memsize = SAFE_SYSCONF(_SC_PAGESIZE);
>  	newsize = (memsize * 2);
> -
> -	/* get an IPC resource key */
> -	shmkey = getipckey();
> -
> -	/*
> -	 * Create a shared memory segment represented by SHMKEY of
> -	 * specified size 'newsize' and mode permissions 'SHM_MODE'.
> -	 */
> -	shmid = shmget(shmkey, newsize, IPC_CREAT | SHM_MODE);
> -	if (shmid == -1) {
> -		tst_brkm(TBROK, NULL, "shmget() Failed to create a shared "
> -			 "memory, error:%d", errno);
> -	}
> -
> -	/*
> -	 * Attach  the shared memory segment associated with the shared
> -	 * memory identifier specified by "shmid" to the data segment of
> -	 * the calling process at the first available address as selected
> -	 * by the system.
> -	 */
> -	shmaddr = shmat(shmid, NULL, 0);
> -	if (shmaddr == (void *)-1) {
> -		tst_brkm(TBROK, cleanup, "shmat() Failed to attach shared "
> -			 "memory, error:%d", errno);
> -	}
> +	shmkey = GETIPCKEY();
> +	shm_id = SAFE_SHMGET(shmkey, newsize, IPC_CREAT | SHM_MODE);
> +	shmaddr = SAFE_SHMAT(shm_id, NULL, 0);
>  }
> 
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *             completion or premature exit.
> - *	       Detach the shared memory segment and remove the shared memory
> - *	       identifier associated with the shared memory.
> - */
> -void cleanup(void)
> +static void cleanup(void)
>  {
> +	SAFE_SHMDT(shmaddr);
> +	SAFE_SHMCTL(shm_id, IPC_RMID, 0);
> 
> -	/*
> -	 * Detach the shared memory segment attached to
> -	 * the calling process's data segment
> -	 */
> -	if (shmdt(shmaddr) < 0) {
> -		tst_brkm(TFAIL, NULL, "shmdt() Failed to detach shared "
> -			 "memory, error:%d", errno);
> -	}
> -
> -	/*
> -	 * Remove the shared memory identifier associated with
> -	 * the shared memory segment and destroy the shared memory
> -	 * segment.
> -	 */
> -	if (shmctl(shmid, IPC_RMID, 0) < 0) {
> -		tst_brkm(TFAIL, NULL, "shmctl() Failed to remove shared "
> -			 "memory, error:%d", errno);
> -	}
> -
> -	tst_rmdir();
> -
> -	/* Exit the program */
> -
> +	if (addr != MAP_FAILED)
> +		SAFE_MUNMAP(addr, newsize);
we need to do the resetting in main test function if mremap() was successful
so that test can run correctly when called in multiple loops.
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_tmpdir = 1,
> +	.test_all = verify_mremap,
> +};

Regards,
Avinesh





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
